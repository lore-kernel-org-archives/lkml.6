Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485225-2-11180057381080382964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485224; b=BGPoY8YBs/cxLStp1XFnl4B891jmaSjykD0lq2kGVR7npxe
    S4tD/29gLRQR5WbORyNSwS/D2z9d4wOfntj1EMDtdA+7sNYZrL+3q510rKIyi3rZ
    At8PBglXOCM2LR7Ci7broEeAcRWI3JEGe9tGZ2ELCnldQw1zWhTETzq0b1famrMX
    mWrvdDEp8xSu+IF7bzBmyoOXfquErkd1ZM4AA4odDOjpswfqAVfgkK9kksS2pcB3
    3GCmpsMrFVZmN3O2iS9+lmWT+I1u2roww5oMj+y4bXpH1Yfa769AQAG8cW38sGX/
    2uPcHyOJ7Hqu4+UCA6WRIlV7Lox2QKoQa/JNaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485224; bh=qhLSqG
    9OEn2hlcYAY4U9J9zSCup3uSmeqfa+D2aW22Q=; b=wb061v6SGLGO+CNx95H2UW
    L7AkM1vILNT1Fk6hfhO41xDLfTWWGLsNfOkx1EltbSGYZ1jroEBmFxFek7lY5T17
    d1JU/QfAJ7a8OOeOzTYHLXRQs1k1BnkC8T+KW6Rj2hEbSSD5USZsN57ZG0t0FAnF
    dDMayqZyNLK7wQL+z1Ne/FwrBUzWMOxViyesU5q+cj4scxH7Kltv/B479lNHllOM
    CWvDaJCoM96S4X4EsRuAG97UgNhY6+UPNaKxQEmSPLxBnY0xesIsY4i0Y+HHHZP5
    fqAuY2NLiOstTh7hWRLQeGUALvJOBfa5xr4SBBC7//e1tTu88JxD/qeiGCs3REVw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NG6U+gMs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NG6U+gMs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeCHFAV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:21 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751111AbeCHFAH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Senthilnathan Veppur <senthilnathanx.veppur@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 012/190] ALSA: hda: Add Geminilake id to
 SKL_PLUS
Thread-Topic: [PATCH AUTOSEL for 4.9 012/190] ALSA: hda: Add Geminilake id to
 SKL_PLUS
Thread-Index: AQHTtpooWkuiamVu6UKLrfhZwqi68w==
Date: Thu, 8 Mar 2018 04:58:54 +0000
Message-ID: <20180308045810.8041-12-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:2mAPJS9bNjpOb3rNSxnLulX/eKtnR8lziWw0u+BUi2inUCBf+GdGo/J+6sNgHF4eb0mH8UUx89uQrCzFoUc7vO0KrU7NT9UMixtdpyM0gVbDGMCdpHkzXsDNWNGKgRginOoY78wVmaJy8NnPyRGm6Z8ZBraK0fTNkHd6vJcsWcJNUakFxvh73zmAwtGLQAS2CvjWsguSqiH8MnsxcCKZQbB9Iqu/7rs6P4uS4MZKG5mlgkm9RNd5lMFj4LDoKTr4;20:JzX7sC8w2IbkoYdDuS1//kWbvEHnc0OoljP6XwSn0hqYhoSopSFxqJ2V092An33IGzF1M3GPw78k/ckCTgMbduYyESu2xdW1CNlVsxRrQ3I+BKy06CZepnD39uLHGdC9d7PI9GawnQBg4RlqexS641GoQslQGy3sG+pQidlRJco=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8dc8a3dc-2357-4c6e-d7ac-08d584b16fce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920DD5CF88BB07D0602C128FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bvqt57tGj4CO8sL8Za6SLjwXOs9gWWABzd2zjRfc8zdEUXGwEm6rOtb3bHDe9MRhYa3BhCwopIHvmuF4pztdFlK7t87ff4gCgPITO1zUcTjemjU2mw0fBYTJByWq4FQsDoZ6ARoCj2gf8uLexEnzIZcflOSCftibn4muBiLIIlCwOJBHTJQHsrxoDX2K6uQxvxMuf9hcQyzQVVgbI3vyqZURrWsehb6QehKcOedgzltp6N5/buvgkmSO5C6YuRmOUJdmthcynwko1ptzUdNw8nMs6B3lK+p1i5vDRTSp8zkYga60n6HZuEXQ1qGVyAeQLqyy/lPtGNOHBPBqTXFMdg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc8a3dc-2357-4c6e-d7ac-08d584b16fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:54.7082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

[ Upstream commit 12ee4022f67f8854061b46e5c0a7ad6258ab66c2 ]

Geminilake is Skylake family platform. So add it's id to skl_plus check.

Fixes: 126cfa2f5e15 ("ALSA: hda: Add Geminilake HDMI codec ID")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 293f3f213776..c9b2dff38c3c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -369,8 +369,10 @@ enum {
 #define IS_KBL_LP(pci) ((pci)->vendor =3D=3D 0x8086 && (pci)->device =3D=
=3D 0x9d71)
 #define IS_KBL_H(pci) ((pci)->vendor =3D=3D 0x8086 && (pci)->device =3D=3D=
 0xa2f0)
 #define IS_BXT(pci) ((pci)->vendor =3D=3D 0x8086 && (pci)->device =3D=3D 0=
x5a98)
+#define IS_GLK(pci) ((pci)->vendor =3D=3D 0x8086 && (pci)->device =3D=3D 0=
x3198)
 #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) ||=
 \
-			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)
+			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
+			IS_GLK(pci)
=20
 static char *driver_short_names[] =3D {
 	[AZX_DRIVER_ICH] =3D "HDA Intel",
--=20
2.14.1
