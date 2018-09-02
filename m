Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3AEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D94220652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o8eP4mpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeIBRbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:31 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730048AbeIBRba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBx1hdJXEybgf3fJE3dGtTlTsC2IGV3nPU6DVZqL0Y0=;
 b=o8eP4mpybyl+9yb21ZdnrYmB1arnCudpWcIJQye0UWEQ8966txuFBkQJtFinJ+l66BNGxPbLeaYZTbLzzQUZK8rtrVS17cA4yLEQ+veR45wiIw9O8m1YdsfeoFBxiAnrSmCVjtF4Og8t0BEvI2EWm3c/veEX7apiY0HBE7FsYRQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 57/62] ALSA: au88x0: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.9 57/62] ALSA: au88x0: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr778LiF0ZQ2skO0/6UpJptNEw==
Date:   Sun, 2 Sep 2018 13:15:12 +0000
Message-ID: <20180902131411.183978-47-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:xoeP8GfyyIhHGqvrXkfxuBl5owdvhFAyMIzSIRnjW0/QLCVmMoXhldlzkER6ktlI8Q/YH44Jg1CFot1zAZvisxNRJBeuyea1gU3MxOXnhjnl71hnkqf5gk2NSp6LgSAtDqjilfMQEFQ/3uH7BKLfxuKbthdw8SscOP1PXO3+YLFhj1fobe9riRQvPIgE/vviC2DZdmoklyt9+0FJNMLk2Zs4bTiwqiy75uwsSj0TdQhM06Vshfw6SSF7IVXL88H/ELwAf6QSsr4VOWNwEJtSLn68qI5L3SAtMiNteHx07GxDqMBesqpyVHjrRSBXMSo5TDNy+RhiyydGJyTyAkxFM/wZgZVzxjB/sC56NIkPyksmCP9fX+Gpj8lzXzbRw418lhoID8kLAEHLhJCMyt3gJN6gghMKOAJaI2JrW/yXp3YxEoJ6JWaYbF8ewvOiTmTDC41pzjMQjr5dNM2dG86WSg==;5:jqm+8VLZozpWZjr/1f23K9TVaKSBSegOpEHv55RgqqX68OX9/vR4vGKMb9P5uJtVeqBpIWOUWwKhB0wVboKfoDyoamB+nP5NBcEetd3AhD4+ZjCRZiLKDwT5lSAS37fo7DiUBMwcXYxG3czm2nNT3jeAaz71rriDZCHNvmQDOeo=;7:XxbcvJMi4E/Yf+9pgwifoZkDI+sO71YVbtKjSE/brjHTmRLL1Whf0VEP9VWiJEQn2pSSwI/V9cgzDtKxfbgC0m47JJoA+0kJwD5x9X+WKHv/SZYPTGFdtNfG5yejAx8YiG1WKFbzYZSujnpuLCgqDfVTrjmaG47l6/qLvYMhUOtMm+4nnL90yiK5nBmYCiE2QOfuuiOMnDh5ar2QJ9c3/R/76xkefE6YyZNWi60Sg4S7oafJIOD+Vei6Im9CN+Bk
x-ms-office365-filtering-correlation-id: 606c40dd-7761-4197-c905-08d610d62a00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184224AB729E62C8B7D65FEFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O2Jf5/e8XPW7hYYvREwBCD/cYjLqE66YJk+62w5qAtS6z7ORUEW0j4BWzaR0dVO09RdGjF9yF26fWk8U/NSzFzxFh2A6rbSipeq+cy4TH+J0Od9xEsZ7R1bO3rdhm+2xg4iLPifUEOOuOtL0JGiDB1dDEtI2BvvX6ad5v00JxT+JVs7iA4rEHz6lBMx9vwNTpQxWk+0MfsIb/o728swegXym5VxQu92lfxEua+KYgrEourCk1I2bdXl9MVDZjW/DOVQk8oYGrwUdn+IcYHJgqAHDqLV6wp8ndyDE4Z88TMzaVZaeqyg0khkvG2yTLIABZBO0IxvLQ4jwNiBXB3bhgPWe0Nn+n25k+9YAIDTX+SM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606c40dd-7761-4197-c905-08d610d62a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:12.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index c308a4f70550..d3dabbd9b1f4 100644
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
