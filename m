Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF9FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769B420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ge8oweIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769B420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeIBRTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:06 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:55552
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXoIdBr6h/hxPuvD00TYZc8UmugjfbT9auQilVIopfA=;
 b=ge8oweITo4QUur1x9ZPKdDx7GNcxoapPTIuAsc3PkuJTK+2AlnllrP0ytCXDMufBWTJViOQbBPw39+r/cR7ofoNPonMTuAwIXjbZvM2JJV00NqI39ZUIUvSXlFAtxSEH7pnwuHRB7bQX4MwHKEYgESMmF47iX8d3Hzua4t/nxWk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 004/131] ALSA: hda/realtek - Add mute LED quirk
 for HP Spectre x360
Thread-Topic: [PATCH AUTOSEL 4.18 004/131] ALSA: hda/realtek - Add mute LED
 quirk for HP Spectre x360
Thread-Index: AQHUQr1IUZG6PXJ51UenraXg4bmWVg==
Date:   Sun, 2 Sep 2018 13:03:03 +0000
Message-ID: <20180902064601.183036-4-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:5DRLQQ2TxH9jMaiza5/C2Lkziirq++LsJM+jWQgzx6Q2sxZmVwvY2gqV3tCIo0E4FPoNLVtJzJG7UtfXfigo5cb2aOaZuMitF6XM/cdMR4J38RBO+HdQzZwyrjeoyviWsWI719G1cdfwbfb3xjgkoxqw+B9d+0SB8YJSRzyl7BOozSDMVw/qDg6f0/jifvNFwAGFJHhejsbxpAoV3TAtL44sWOuFihVM0O6v5viFLX0J6UT+tuRYQbwcvor6WdjzvKtdTvDfqVvVecUdpUp4xQJd7PIGBvy83f6rnJ5nW70MRW/lH2u4cLOGLWrKFI40MUvLjhK7gYIunU3nv2mq0+mAJM2bzPgwWSifgzEWZa6bHyUR9YFpfyi7Qb0oxBPScSvCgLdnIBkS0zyxOJbscH5p9mCj9wnshN5Q/ote9Ubs04Z2gpEltBTONggBJhYf5A4X7PPaewpUsnY31fqYgA==;5:7talBTl35/Xu5869mg8iEOhzRGQB4/jzt3dGXgBgag21RUZwsuOuea3sm51AqNtaoJ8YWhEX/6K9/hITq5dhEqm0hEKSbei8R/c1q7R+Pc1KBjwwFWStpwftBB4sCLgdQ5ukqGYCAOxEhj+WkYdiMCDVeIaKJh/VzNNesGEO39M=;7:YylzzxEVJyFQLQtPjMC3w2tHa1huUuZD8aARaWntsiPjT0SspADQdrM69apyKuxA9JGH/iFyc3kcgE5qVS3WEp+Kg7rdBZIeJS/r+cZTjXjjGoxWjaTBhWCFkE88nYODNjIZCJqrkn3WpqvKxmnT41GUfkS8geEC1gC5DPb1+MTEto2zkmqDPa8Ys8mx51JxY+l28CbVdi48bBq4DN2iOLGwV9szhdppAb2NN+UfAS8X2ENmIwJLRBcwv84RTYp7
x-ms-office365-filtering-correlation-id: b9027436-81e8-40fb-f33e-08d610d46ae7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08370A5D1857F804C43C13E5FB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(39060400002)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r+2cE+RkFoGBH4RPnipFa/4dySsG1j98wPVjbR6cNgsLp/QegCtZ8Ck5+ItaEpeW/GnHpynT9t5tJIVmgvuDNy0mukgcvalET2VcXOfsHVhKxjfQgidirtSsDnH/jX+8EV856XVpx0u+SGLo/G0lF9jnQesnBIrvf8uM/3FkoazcR7IqU7pQBzuGuezS9l2cPn/adLysoCqEcJHgq4SI6hz9zzTGc4a9OK1uC6OWHVkUJW2JUH47fWygESudIQpzBfNVyAX0aRslsTO4VYgsiOw2D5yN+i4dFzoxf8h/OSmKvQ0CVNMYwwPf+gxwqLROORBHQSxvEJE69o1TWwxvPGY9HjS78/pVErx+GwRBlnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9027436-81e8-40fb-f33e-08d610d46ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:03.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

[ Upstream commit 56e40eb6d656194e55ce2012fee9d5a496270aaa ]

This device has the same issues as the HP x360 wrt the MUTE LED and
the front speakers not working. This patch fixes the MUTE LED issue,
but doesn't touch the HDA verbs. The fix for the x360 does not work
on the Spectre.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6af3e1c2b93..d14b05f68d6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6530,6 +6530,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED=
_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BO=
OST),
--=20
2.17.1
