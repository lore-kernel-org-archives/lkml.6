Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE5204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MXko4lcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbeIBRYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:08 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:20016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbeIBRYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m6SeT7vZR9H3QKoadeJk8UKYV6gjTMFQC/G/+tz9Zw=;
 b=MXko4lcntU4KwH7fgqNMO/4gmDOCDZNuhqzyPMuu5HuTVWwQXtCDWudtUUBCd+hqm4rzHdZGpNH0sv0v5yFXft2Mme/y375etTpC5PQxSoxJpvKOc6WI40pvSqYn2Aq0zeFP2kb/HGOp+5zhaWGvk83X2Fr5EQSJ8GRqYs17dTk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 77/89] ALSA: riptide: Properly endian notations
Thread-Topic: [PATCH AUTOSEL 4.14 77/89] ALSA: riptide: Properly endian
 notations
Thread-Index: AQHUQr3wYsVb+ri3uEeLdlYANHTwKQ==
Date:   Sun, 2 Sep 2018 13:07:44 +0000
Message-ID: <20180902064918.183387-77-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:KqesLlxNEA9Ss/P+xpWZ5ovyjZXp71IQP2YpRBfU2ivLnHLPoTsujvpEO5RFB1zgMVEFXF/tbJFhOso5ZsurOLwz4YgLr0CI43jJLReyuCEYu5vxxu+n8hcIDh4I9mSxWKKU/wr3S0uTu5TsqQBaqajilma5WX5ifeyBaQMFlmTEjBiQi6XmwCNKQDn0HFjTZl6fhTvt1yByw/f/5nth5IfP9TkGPZq7PQtW9L92O/6fgcTQqbeb6y4lkDLPWEP11qPf5tJV3QbsvvqoDXb/BNP5X6Ru8KtQPkOC7sDpQqfQRgJdbEOkQX4zYptfJ51kALTEG6jRZt3dZy1SCk1oyZN+fcyRb4RHliSQ/6EOuNTu+BWYBp2eevtPTYujYcX6xdtCvBGNPA+M+L/n0EnjS9RN7rbwtNnmctWPYhjDfs2azzP2kOXoR2yOQLesuOzrvfTAHHt4k7iXPautMZ6tOQ==;5:W6erwA2p1dCQW8od1cLn0Oa8hR8BmvwGOlCSgWh8Alm4awr+MfQk1bZU5sfiwmucJi3vMyKc8wDWEuUKcw2SsQdx9wUETeVCuAFf6jlKiJk8VbEfw3euisXnvzRzmw9JHfZATpAZg7lq/uZ2ZnNLnVRYsZawOG2GmXrtG1HS7qA=;7:qC1cu8WeEBCcGWiXeAfGh1iZFuds8rGZMtSxZGylRGkJPz/ie3jk0Nyo50iVcMynhC6xNVVsMbp5Wj11/skQGwJ/rA1d83Ltgw01081K9+TaW1KMs1VMKGNJwA49d8qob9zuWGnsHnGAbBtx1U23rQqaIjhIbDqnDX+DLAEXx2D6swzxzXfZHKWEYXDDx/S2KQGT+ETyaUE15nRkAYrI4ZHEuQFkwTpcH5Dy3BdmzsyBXxYfu6yzh/uGV3h5e8On
x-ms-office365-filtering-correlation-id: 38f43632-d7c7-4e06-f869-08d610d5236b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149F6BB587D979AA7D1DAFCFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V8GH9dOINRDhBLxRc8ahBVQrUmBcB1fXSbyWv4x+9455mwquZlALtNnQCNyK2djbx3o4ZknT2jmwHFaMvlI9OHiLIxQFF0WbXg79g3oif92LBV1rDGVSg5Iy4xJ1wOntGstudOMDDHumTyOuQY4YLsH1tls2VsG/h9ipvVq7LRbyZxHpvNOPfuS62LOwNq9/H6uwKuOWR2xqbw0NtFu2XxpLaFhTHepx131P9e27DFq39urooTJUYPkegTt9ZCmAzdu+3RvJp30fqXqtqh7guDsXDikJk+g3A2MFONSo4J/xETjKKFIGbYo54f9x+aNtjHn3DvOhPx2psseMo4axyC8Xm3TEaGGl5lIqUYUJU2s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f43632-d7c7-4e06-f869-08d610d5236b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:44.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
