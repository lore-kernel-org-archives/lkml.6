Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF3C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB432077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Col0Z+/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB432077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeIBRbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:21 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:46240
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbeIBRbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b6P8LrncDDuFjggj2cVnYuzxx+q6TEvYG6zQDcd24k=;
 b=Col0Z+/C6Ufd/0IfxEsvh8h7kSbXMKQGy0+GoQ5S7h2121cRiFiaroNho2r9Cgp3S1FbXhgn8fVMpGLNGoOgYiAEE1KLqqVIEVqPvsuwvn+HXXlGaw6bm2/rJuTVC/qbT7OTcjGnqYlmW72XRmf1Kbvydx7suLsJR/QS09gJ1/U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 51/62] ALSA: riptide: Properly endian notations
Thread-Topic: [PATCH AUTOSEL 4.9 51/62] ALSA: riptide: Properly endian
 notations
Thread-Index: AQHUQr73L3zsg7ebZkGcuXu3JOBqBw==
Date:   Sun, 2 Sep 2018 13:15:06 +0000
Message-ID: <20180902131411.183978-41-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:tqOD09ageRRWrNIRPngKgyCA/mUqAgliGvq4KUe12yjtbfzYra6f6Xol/fVbrn2FO2MKbbFS4P7XvapSuVmfzVY8ii6gwMh4Wy9jAgSogGxe0pw6m5nWr8P9GxcDQRJ0/ris43thoj52rxYaevZNVDecsDF3iU2A8e/reN+c/8+u5uk63LUc1xbv7sNhDwNxLIF3G3KjanYSN/J2hMBNHaYcyT/e//ArqjuarR3axcpjuKnvAh8laNZl8koR6idKVGme46md3sMwzH8jKI6rlPOq/nbRtlyeqWWWNaCW/EC3y66IVOROicVDBxd3b+MXLp2sPepkAknNP6fCt7lGzU1pi53rGFexcqe4FegG1r2OicKuq9kGHUlZL+vMANIylHQfxYT2uR9oU+vlilW+eUKypKozAoLT8pfk6vWZNUky+svIx2Cf6JFcnFG329wMhTQj460jYrfSjnxfAciiQQ==;5:mpMYe5bsEXf11DO1hiNyVdfPq7sY9kKK/xsIJGdSHyzrO7tm1a2xrhQVQ7ew1mcFDTRRoXBwSfSP5Y7d+E8VyfcZYVd8hJpgGM/O8pqo1LkOoPC0EbhZ1GM0WwgMHqUWPFcHjq/NquK8kxAbJ7X7/4y/ckA12ghVtU8R00LNTDM=;7:9yMSaT3r1Txv30cXYsrf46lSiazk18VofRjlLNUopXZy/aosGg7enNjQD+DfzksRMgXFu+6JutlQcSLypQRVx+YfV/9Y/4Z9jNJMlknRu4iZ2p3LKGlp1J0LxI1ky4NeLaze9D0FO3WcyNiLCD1IDSEWx3Bni104gVi5NCoSbbI6kr12c0syd/0KK9QGbljBD9yqrhuLosTB4J6s6APxJj8djUXde07GMU7ZaFtSik2Z4YTeGUb9PQD+ACSTql93
x-ms-office365-filtering-correlation-id: a2ee4d72-64a3-4f7b-798e-08d610d628a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018430F68C8D59E2A6C6CA2DFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sd3k8RmflnqK4w00G59XNRpDItrst6XO1qt+NngEPcbE4R79xsanfBXqi/wlP3P1cRFG2j8hOAg0XvdEwls80Ct958wDDqOjRU7Ny1Pyv0KAlxxroX+WroeLkJwfu/hP5O/n5s93FAla9GzDyAi6NUfewPvJ/0+svJOBNQsTdI9raZbY5FXSRxPOYNd54cXFk5T6WkdEZhsXtoaPSPnl2MxdqBMcF9PPxsZU0mDWhUpgBl6lw3WicLPF7Wmgte/SlpWaaagw45U9VFZz/WtJQooe5BOBv1FTPtAUzk1w1jCy3htMfEUWCbyldhxY754t51YGsToKmrxiEC8CZi+URHpZONBlb76g/vTAYKWDbzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ee4d72-64a3-4f7b-798e-08d610d628a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:06.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index ada5f01d479c..0f9e77bc7930 100644
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
