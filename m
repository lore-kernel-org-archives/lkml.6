Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120101-2-9667303027230755581
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120100; b=uGKMXufAWAs4KP266RarxEda7NP3/JqdHcrmLeEouHHDhCh
    Z+48znglsm11/m8PYSw00OgR55DpW1ILMiRw2yI1xwWWOsulrWgE4tzTRoq/nZSw
    rDLooDX8PQg++EMl8pWZhjK+ho+O5fyEYMJFOxBxgBfAC3qKX60MdET22HhQH5YA
    W81B3u376UOVNBrcf6sFdf1xz/UDqlyVBYmQgepgPZnp8zc2P+lIy6zF6D96Z4b1
    CsKqLyRy9ZzSt+TYmQeNHPD/EAg4VFonbI8o/cvOejB3SfT/dNoL4a4GCSApHb//
    1oKm5tVQfskcVOLQR8ikf4qWiet/H6c8HkphpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120100; bh=qhLSqG
    9OEn2hlcYAY4U9J9zSCup3uSmeqfa+D2aW22Q=; b=Ihb7IPcCsfR7AVUbUAwGCw
    6bKnhSqJhgDpJrL2FIrH8KiYTFI7fMt/AAjzh47ey/jqawFHaSJLMEsDZa3lXf0X
    5Rtpkjqom+ZQFPV23Q7mOY2Xj9Exq4WP5O/7lrJufycVC2trAiPvVCddrWu/G0QS
    sCdoNzc4jgmbq8Bhco3Q7zZoSyjfSPSJqmdO6nWZIDnc6RG63fesapuWUY90LvnT
    MocfUfIAToe4t4nic4or4umZvp++iBsr5q1EqayyEhZEZ2fJlWqpP4itpoheZLy4
    IEgHFo7yv4oqHdUcbAzpLhKXTgqYT44TpClep5mMs4vSAHVeecra7BY++IZ13gtQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KinyJGPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KinyJGPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934461AbeCCWfz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:55 -0500
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:8222
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934432AbeCCWfx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Senthilnathan Veppur <senthilnathanx.veppur@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 158/219] ALSA: hda: Add Geminilake id to
 SKL_PLUS
Thread-Topic: [PATCH AUTOSEL for 4.9 158/219] ALSA: hda: Add Geminilake id to
 SKL_PLUS
Thread-Index: AQHTsz8Xcy8T914IkE+zekQYQPzprQ==
Date: Sat, 3 Mar 2018 22:29:28 +0000
Message-ID: <20180303222716.26640-158-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:LkFz5vSlFqxMHTJZo78vuPCTX56FE3dW+QIieOtCCbYYq7zYVZZYEUFQIWCdO8RUGD7q6ZUBLI2plSGnkEypR+9fZSiuRmGSGtLxu3BmMRB1rZtmSVz2F69JEHzI9yHwDm12vm0jDkQL/fQ252aYy+p9NY5jDiSETOdgasKtqZuoUb+Wlc7tqDhXqbTwER56mB/x2ZBBE8Hb/6UQIDuevPU3DBMAz2Na8LgKS9gB89TQ+XTGaMHRFYCe/+6YxY3o
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c603922-6fa1-4124-35d8-08d5815719f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10344F4B431539F80C847BD9FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(575784001)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: VjWFEzF+hUzRZEBXcFDz5eGdYN6muLa+j2neWLSn1xF3pNlD8qLmY0W0sd8pbg3EKGR363LvdwpNfB0cpbrHSsB+j/f4DP2mF3AbBps2bzqaeyW7L+4u0HH2D49TyppETCUhv6IAsCQ6KMi2jAHD6ixzNPQLb6Oyowb7gMCY47s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c603922-6fa1-4124-35d8-08d5815719f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:28.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
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
