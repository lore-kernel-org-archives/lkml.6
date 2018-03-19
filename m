Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477783-2-10435847343611568271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477783; b=mCKVnvKqWLhqjIV5dK832dXvjGwoh+fy/WZZlYp961EPSSO
    IIhFm5eWgEtdoWMF93FPlaW+vUfcrZPYbDDnQMaFkmZNHWrgdsLGhX8wjr3y9b6q
    sQqf953ZXbQM+7Uc/EGQU3605RnRZjmb755ZTwS9Q2TZiqfA0a6mw872yQ80mJ1v
    2ZBb+uuDxe0b+g567F28AXicFuSgOBUb/pOgOnm2f9lVgbza1F52xfS+QOtoQAfz
    T8hZbcuW/itypDxbus1sVMC2yxos+qpBmifMmpSiY9Fy7IIPwUl7ztPVBLU7gKau
    q9gG3YSd0QriiAj/J4OwRF1UzUBgLumMozp9jXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477783; bh=dzts9f
    PEfU0d4IfVKTgj/1Hm8HwzRzBzKDDkvfF54jQ=; b=WQP2K2utYO9mH3KiCqMwBh
    DPKrpj7+MZnC9+E2XtME+oysIwMMAZwOkC5NK3Vd6dxRtcP/Q4UWavvFiatnZfLo
    9U/wG+e2Ps27Nix3N8X4Hh2Kg17TCbjlJ7mtf6vJIexzz6V1bZAEH3zvtlnJCOQo
    i5v+rD9rhIg5ZwU6N/UvPRUv2EBnIDWVSPA2mJsrqYBBAx5v7psERrVYPo6UAYny
    TJK6zQIiiidXfNl60lgyEBY4vjHKxCPs4J2ywBsC5iexNanpe6AHJDcDSd7rZBTL
    3VsOPuQH6FcZC8h5qtNNaSQhkgrteb2Qxb6NlV2HtzDo5f1qYhVrBXVGRZsY8kIw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dnSak6pm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduvdelnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dnSak6pm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduvdelnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967308AbeCSQm7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:42:59 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:52832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934348AbeCSQMw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 038/102] ray_cs: Avoid reading past end of
 buffer
Thread-Topic: [PATCH AUTOSEL for 3.18 038/102] ray_cs: Avoid reading past end
 of buffer
Thread-Index: AQHTv50OqmekQAi6sEiM5Thqq5CriA==
Date: Mon, 19 Mar 2018 16:12:20 +0000
Message-ID: <20180319161117.17833-38-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:hBv17Pt6Hz0cuqd1yjSQ3iKY5PBuE8XaN9fdHUDv78jzWaAo+ZMf29qhGbV4x46vivMsyGDnp20CHtMu/jeIXQ5hoGyCiAZU40Jy3RGyS6BcVT14mb2PuhVMPsbQKjmEy5Zn6a9tc3yqDHJgAW+7wzaof/nW6NI4rZrV7TJR5o5UZdqfF9qY9nEUZVHFsZ1h1FhMOYwAWd2dEb3l4UrONs0VmGz6AAuRd3blCh/KmS12u1gpoEtvEOrqs/FVy2HW;20:LLUF1oy+BAtoF7Y3LhGe8DTao5O9fzqrv5i5eNPXvHQLEEueWknbPcDIGKLZmoaotXqIfq6Io6Ug8OVU120oPjgEQo37XSUMz84rdASyul1EF2RJKOwhj2ADyeCYx8FlOkuodkt023qExhp0iauyeTS31kT5aJ6veWShX4wU6l8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38d98419-e4b9-4a1e-d51f-08d58db442fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014C506A13E3275BDFC9091FBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(39060400002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: a2qgtQn9X34ixxXZjtF9y4tI4NozQARw6XXeWoSvwn9AcIcjpnrHmr0eKVc5Jq/4ki3rh7ptEcPGFdiSRV0B2fj3uC95mSR3Pbph01+hX/Fhan6kwz7A8MzOeGXemv2fOo/g5cbcrQ4Yg1ZDaUjb3VMTT3uzwSAVqVWSP/4IOptc0NoP+s8Mvfb95tIK/pwG6Q1ObO49qw4eb/Zl/RlCzYt+G+H4AwlGwYx0lSdX8gde/sNoAB5L4DsRjs6T0hCR/5kPmYW5fOQhe9osDT+SiIU9r857oaMbSFlIy03+ko0IJv8OStW6515/OXlXuhB+R/qPng6gwQA+59qzW+r45g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d98419-e4b9-4a1e-d51f-08d58db442fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:20.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit e48d661eb13f2f83861428f001c567fdb3f317e8 ]

Using memcpy() from a buffer that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. In this case, the source was made longer, since it did not
match the destination structure size. Additionally removes a needless cast.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ray_cs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 8330fa33e50b..52a91137f49c 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -247,7 +247,10 @@ static const UCHAR b4_default_startup_parms[] =3D {
 	0x04, 0x08,		/* Noise gain, limit offset */
 	0x28, 0x28,		/* det rssi, med busy offsets */
 	7,			/* det sync thresh */
-	0, 2, 2			/* test mode, min, max */
+	0, 2, 2,		/* test mode, min, max */
+	0,			/* rx/tx delay */
+	0, 0, 0, 0, 0, 0,	/* current BSS id */
+	0			/* hop set */
 };
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D*/
@@ -598,7 +601,7 @@ static void init_startup_params(ray_dev_t *local)
 	 *    a_beacon_period =3D hops    a_beacon_period =3D KuS
 	 *//* 64ms =3D 010000 */
 	if (local->fw_ver =3D=3D 0x55) {
-		memcpy((UCHAR *) &local->sparm.b4, b4_default_startup_parms,
+		memcpy(&local->sparm.b4, b4_default_startup_parms,
 		       sizeof(struct b4_startup_params));
 		/* Translate sane kus input values to old build 4/5 format */
 		/* i =3D hop time in uS truncated to 3 bytes */
--=20
2.14.1
