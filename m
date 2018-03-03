Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124005-2-2107270130304873326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124004; b=YKQs/0tzKCCpExQNCF/7axsk/tgrytoFImf4jjZVqm+R3v3
    pT4pl/5J0QQnlNXu2/uenR80fAKEz97tNfsJ7kkEcV/TeXaoH5HiT0KAAEidUeVF
    tlxSURpE0EAq6rJC6En/tDF8hacen9s6xGs1FLFyP+t4WwUPr7k+UZODaHnE8Ucj
    YJaCQMYueyb5KGKB3+gOgHe2biBrC2dJuM3j+Qq6PmP1EEslvP0b+wpDdAjIgyMJ
    um55Na7od3QQ8RlHojB9ppQ0bCuqW1iCblbrLmAI3XwZ+MHwgGiNuKK2x62UUwNn
    +zdCN/2MSKZHwoP6vK+w7w/KlU3k3/4ifhJDP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124004; bh=Ju2uiM
    HaIe0yjVE1ATeBKFPz5j2vCfYT9q/7IxF7JX0=; b=Rm44M6pja54Bt/xnzSaDrS
    eu0g8owK6ED9S+nSp9GnD8ObkPG2DWhe8kK0FowRHX7nB2v7waVXgV1cd/jm26gO
    H0pR3D04zXpJJOu2qix3/VijGxUjLZiuHuxPKyomym2nlUVja++AvkAo0fsZfzAE
    XR6jlNTL4egtfsZ52stvK15Rm64NelEA5LhGlnB/IyWp6GHlYylGdbC+DXlxn47a
    7NDjlR07aLgx94W97vYdvFMSDRbZjTkriQPsjCyjpBkPcDMFCCJkHv96QVygEzQd
    hPGEs7xJgeIpRylZwbgbea007SU6/x6XoWRdQsTg5bwoJ+T5gng6LqrrSVjwKoPQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DD57E+CV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DD57E+CV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeCDAje (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:39:34 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932676AbeCCW0Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 059/102] drm/sun4i: Fix format mask in DE2
 driver
Thread-Topic: [PATCH AUTOSEL for 4.15 059/102] drm/sun4i: Fix format mask in
 DE2 driver
Thread-Index: AQHTsz5ttFiDiB4070qtZh1gy/eqfw==
Date: Sat, 3 Mar 2018 22:24:43 +0000
Message-ID: <20180303222318.26006-59-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:XJMsl3KCkdksoxJKKePExjscr8tqxTKswiacJZZ4ZS62vH69M33Cgw61+UlHHjtFwAXoH0ZH9lCzRpfcjyUb7txW3Ia8lHA5AH/cUnCcUbvTw9RWwz54OyvzQsxSLv1j39kxO9KBEaiXGPYQjD3qUE7qCm4nmaBQwomrKNPy52N7GwwwBjzJ0tkAdcZrKriPFBLdEEaFA+33CVbTFGxvIU+fsK5aI2CDUGN6wS1mT6hJz2eHubmhwOg3NhjeNBvW/GfN7opiUtNZTAp/j1Ih320gwueK6100XoMcPwEbNaF+xDYqCDols0/IF4ohQm/KAyzwv9lsWfWl9VQDZbj3uOEQYqNxWc0AGsqHon9qZFqDfd9XmKN8jhgCZjFNi4lA;5:SvaxhGWQbXhHw3JPtcGMUBj+mdQbCVwFDTdPPdlHmkyi/Jhl6I0C+XA1bxd0p/8cDQVYmvwMS/iIvFnokoVhIuX5g7opoSKUTk9UtnFu7gYIPzMI1DvgMktBQAAUJQ5GamgxatANaPwH8IKnfD90TumDZHJrLAD9nJjUQEjm1do=;24:atiaBkzfjO8zwNzy7QArOSB1e5zn/ry4D0w0bjN1DRr6ET9WRcJIl5DqLiz47AQrzaepisz9EpcadMISUpXYwIFSzlc6DHTmumvsSxmcxBc=;7:7qAwOIRU5yG+1AZ0W/gv79g8Mvkp+GExiftc1q3SvKUX2HKzjziTO1b0ObIk8gv6Qdxch0lqWM4E8/e0QliCo7Imgbm0v3UUnMh8x7QFDPA29bMKHW+C2qVXoXeVEzsWXikEhmon4a3TmTbqTu6nj6KHk/7JtF2q0/gvcy+m7fyAyUh12ZWrV1YQ/3mmwr/CUCYv4sH4TUnSVzSr5Ht7G2FdHNU3kKA2bfrgaYVPkmUyiI/zHf3P5v1w+8ETccOl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96824167-7ad8-4dba-6a4a-08d58155c7d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970118B21E0A2051D01213EFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(575784001)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(6306002)(81156014)(305945005)(81166006)(7736002)(8676002)(966005)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: NeKLYhgS4Nqy8iPXIggt8o3wnP86N8TOksAd3uZOGhvulZU4EPvxz9CKVCHvxjz+2fcZ6UMcL4ftpknk5IUOLLCtm5ZRkECa5iak7VTjywdAW3ssZbK0PXisdjfB/5N6Hn39Oc7qSa/R5OFGOucN10ZYzU0Rm3CuHsk2TRJ90zo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96824167-7ad8-4dba-6a4a-08d58155c7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:43.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit a2407f4bd1f3001d6b46f6d32eb1cc98a60f5a43 ]

Format mask is one bit too short. Fix it.

Fixes: 9d75b8c0b999 (drm/sun4i: add support for Allwinner DE2 mixers)

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171201060550.10392-2-=
jernej.skrabec@siol.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/su=
n8i_mixer.h
index 4785ac090b8c..c142fbb8661e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -80,7 +80,7 @@
=20
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
--=20
2.14.1
