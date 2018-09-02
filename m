Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B7C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4102520837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UL5Cw6oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4102520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbeIBRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:54 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729247AbeIBRcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V69MHP6Cc/Teu09LRMLq+NBmeuMxSgzWeCDC0eHX9f0=;
 b=UL5Cw6oa2N9mZW360O/xKeoFkVCOP7yQlZWhELdD/ImgkkO7lUDFBYw8+1rQEZHid8TOHB1YeX26SPqPacXOQkEdyKf3JdZfUg5tTrGs3dFC3Al4IPlmJWKelAz6wUTi+GtLCeNJEZeczJoMvncKLIXO13B3QaepCIWhENSH4p4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 43/47] ALSA: au88x0: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.4 43/47] ALSA: au88x0: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr8pAB8mEELrwkaZsrPSKhMf2Q==
Date:   Sun, 2 Sep 2018 13:16:30 +0000
Message-ID: <20180902131533.184092-43-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:lDxUVa4jxfVMXYiy+SCF3jm4xYo6+8hyHClvcYt1Gml9MVE2rEao+a3eekcAXWPgDD8pZ1zL8M1aOeW6WrAAkVgi19/Pet41prJLcJfvA+L65MzJ6adN8tUdNXZmcTxgRI5b8N3OvXN3pQONMy1PGtKvWfCDKbP6GA/1sfdu0kHVweDB3VOkWA8Yqr2DDczDmOkDAQbSTYZv9qz8G0dYgsbRWa5I7Yg5YAvHxe+f6wcqGMt9ekpFVnA7wye2v0v6+mKNgjX8m4MrcU3+eeUFacp9+d8iBSCnM4fc0mpovyh50wGLEDHfLlm5A6vwNYTZFW7yVdHlSZVV7tAI0blYun+1YEbCaRfY61dkAfI7NJGOuSQ+AJnpUwoGnn3kHUvQEfSwfCUSb/F3sAa8jv2i6bL7vp87wFcMoB93jqfoHyOcHXOBPrjiA7G3g5u8x0urHcGq9QFMLB4PLrj4LH9AyQ==;5:E9QibbHuWXBhbPp1Ip6RZJnfHOXrFXO9EuAGbcuPmEgfnvLyr1mJYtwknep7969bVb8j15dZaMZdF3Qk0c2/hQgWg9w8OFdwTIgcblrCecuds3eTkh2PTBRsG1VL4LeIT7RFhx2ip3a1yvADU4371aL26M0bNnXOkkassENckJE=;7:d83MP8EREOOTklXilb6C1yAyOCn1f+B024nQDubIYEdpXjej2QYtvF6F/IgkV3IJZHqwV8RrXse7EL8/YYWnH1cHYBTDZ2vlY4xV+LRK+T/PNU2NIF5APf2MOtsYg/U6oPgPWnx7okvBkBm80QVjf6SVkW+x4MW8lBZRuCLwKHOluQh80USgZkuoD2m7442hF19r/AkhyERtQu7245LVbVokWt0Iy2R9sby1DqyrlQhfzBCpF+sQf7hETME/8/vf
x-ms-office365-filtering-correlation-id: f473242f-972d-45d0-d6be-08d610d65f4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01678FC28E742B43BB74D192FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jxmFx6hdj+JR65bBF5KJEHS4IH6442ZQtla11E0tmVQc1nsK8iwyyLFteFczvD7oT97iCjD8z0x1MWYrMoIPfRbEV4DDbgV/yyJEFdD89JZYx53DMN83ZGtqhSZS2DUhxSDZ3DNnn5sIAIaW2wSUo4AMQa5wzDIERInWglPDIVnrSdopauEf4yvVZUSXs5QxeKWQMq0pl6FV1lKI74V2j5GKboLe4WYhK4Z8Hb82qHcq4YC62rLsyAi5GhptCsQ56PmGxdCHg+TYp5BHmTa58h4v4U5BaO/b+A35MJTQArCbTnEOb3z2eqstX/6oxNdyOSKbOyna9y+zHIa1Khw3zFIzaCNgzo7bGwmv0rXmtmw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f473242f-972d-45d0-d6be-08d610d65f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:30.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 10d3d91e3bc4e152a580bf523e4fd6bf279ae532 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of vortex_alsafmt_aspfmt() with the proper snd_pcm_format_t
type.

This fixes the sparse warning like:
  sound/pci/au88x0/au88x0_core.c:2778:14: warning: restricted snd_pcm_forma=
t_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/au88x0/au88x0.h      | 2 +-
 sound/pci/au88x0/au88x0_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index bcc648bf6478..e3e31f07d766 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -241,7 +241,7 @@ static int vortex_core_init(vortex_t * card);
 static int vortex_core_shutdown(vortex_t * card);
 static void vortex_enable_int(vortex_t * card);
 static irqreturn_t vortex_interrupt(int irq, void *dev_id);
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v);
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v);
=20
 /* Connection  stuff. */
 static void vortex_connect_default(vortex_t * vortex, int en);
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.=
c
index 065a69cf6118..f0ab264d9560 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2770,7 +2770,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
=20
 /* Alsa support. */
=20
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v)
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v)
 {
 	int fmt;
=20
--=20
2.17.1
