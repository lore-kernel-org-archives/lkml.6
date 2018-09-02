Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71A12077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZNr1p9tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71A12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeIBRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:45:51 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:24667
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728553AbeIBRVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m6SeT7vZR9H3QKoadeJk8UKYV6gjTMFQC/G/+tz9Zw=;
 b=ZNr1p9tUYx4iKSyoqAZZIV6/mSDkcOv2ocFrQK7SeSQatV3fpjSiMJyN0t0O6E+MHlMym8z+rgbtwPk9ydPKxEKsueiIXzPWG7hrKM1HGcv1J5Vqce2V84iES1LHlptpYusKVgJzvkrvo0I3iXWBV9y7eyCiX4UbcE2Vihv1f0w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 113/131] ALSA: riptide: Properly endian notations
Thread-Topic: [PATCH AUTOSEL 4.18 113/131] ALSA: riptide: Properly endian
 notations
Thread-Index: AQHUQr2cvjJHEg7nkEitCwakLRWwsg==
Date:   Sun, 2 Sep 2018 13:05:24 +0000
Message-ID: <20180902064601.183036-113-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:qTXbcHTo3KcOzq5px+FRtSRGXW0zvHasluPp4OBQZ0Zxqcn2qfOO0cshy6EmbjpMR7bBZKxq2sFYgx3iE39epMVDRGjOxrsb2Sg/cJP9Avq+NnX4jngWSqqM0VHy43iRAVXmY7e99tXWXi1Rrs/rYM3S58mGDqOT2gUc3bQlvhVd2SdsqWGiG+5Sv4p4BDWrKBJkFZ5IfrMi28WrMRJdFaerjIz2B1uGWT9D6KaFieUv4UvVqy+aFeGZ0fVJrgECGGKIiBEIRexKSdGj549BLkqRzIuF6iJ5u5yNzbA6M9Cnu2ro7N2P9GpW6iy2FfWfiF7tBi5eWRfzcLypGjApR0yaP4idG0awZdGlp9rfLf5b8n8jFbocfCOwFFD4g8hNEABEuy9ICybLzsTn1IFCdRnTVxsC51Cmf7dO7r+ZPHebWISyFRPKa/M+IxXnkmKQAGqQerH03/m3WDNHA/VixA==;5:z9zg3Y/qYtsx27RWpd/xe1bOUXdQVmqtT2TyHt4bEP4mxIeVFLm7D/SiAmuiWPGJDDU3T4Q936DtaJZMdbl4909HdPvwP2ZxuhMhohiifSxw6VVlh4LN9BS90cEPDZ7K+OO7zmTVICCX2QoxymgR2wbsrjtxWEVahhPUqbkLhcM=;7:igl1Q7Bre40FE4IIjRLfb2MUcWpmjX/Er3hBzkk4tZrfK2hfNXrK7NSpLMBckWPsQH9x1e/bLNNGHn4aYpL0tMmKHvN8lORexi9C9vxq0Ra9nvgk9njdo3jx0poAsdX9tHtOvhwLzsSO5hY046y2MLrz/crnpdjwQve0j1o8q3A5JCbgGM2gP0njsa/wXtsVINB2ncH3dc0wJEXlLHMrvOWQvnZpjKPixoHUopTknaqpJUYn5Vir8kUl1BXf0rql
x-ms-office365-filtering-correlation-id: 39b86bae-b420-4ff2-8e30-08d610d4c857
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06299CE9E418FCB687FD1CA3FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JZXBF1gearC8P2tXy2CCjllAzNL8sRpaL2v4DUwJCDYMoLD+SqRJULhpnLYdxJulsbQNcTdfti4KB/OLEDKUYomMkx6jBlCWh2ZDVlAFXqfOYGFnlBg05sLgF4LfKzTH27Ab3b3t/0o6PwNyrf1GN9J/UHTD8xp1K/r/TA3mQ8aIIMVT1zyBdkuuJNkAzfHEVPlnUFrNYrwacNELhP8zB2g3zuhaS42A4d1qfnllwDc6GmHRbDuDO4ojjSqoYscs+EOqMotPZx7alexVohaE5OiZy4O3zP+AbM+Dhg6RXVBSmtOsuDUobUqU7EmMW9tsUis3ZmU4yLykJC0u7j/leOb9mPvHy9keZzDDWsHTWAY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b86bae-b420-4ff2-8e30-08d610d4c857
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:24.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit be05e3de3a933156d472127f659d4473c461dcc5 ]

The SG descriptor of Riptide contains the little-endian values, hence
we need to define with __le32 properly.  This fixes sparse warnings
like:
  sound/pci/riptide/riptide.c:1112:40: warning: cast to restricted __le32

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/riptide/riptide.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 44f3b48d47b1..39a96a873951 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -470,10 +470,10 @@ struct snd_riptide {
 };
=20
 struct sgd {			/* scatter gather desriptor */
-	u32 dwNextLink;
-	u32 dwSegPtrPhys;
-	u32 dwSegLen;
-	u32 dwStat_Ctl;
+	__le32 dwNextLink;
+	__le32 dwSegPtrPhys;
+	__le32 dwSegLen;
+	__le32 dwStat_Ctl;
 };
=20
 struct pcmhw {			/* pcm descriptor */
--=20
2.17.1
