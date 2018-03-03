Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122719-2-771190803167004991
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
    t=1520122718; b=AIIoRlYCWEXJIhYvqwlEHs2CDJ8uFwkdNwMgzyeMCGtYpr6
    A3BqFvR1eE7bN95SmMwHRKW9+iFRRi/OYkEK/2+vWoe1T8qlNFFi+Y5FLfCDiIA+
    2Q4vMY7vheqy4DejndBQ1l+HyQHh1rMkw5s5M2PIckx5sbzhTYrgR0K/wpV1ZsBY
    aO6JCBnuX/41P5hO2ARfitm1QPctlP4/nhRiQI7U8OsXQoc61YBKcHv9ahtwtTlM
    Wh0U9/AGP2lh2M5Bix5yhoiy5EWE1j+RbtQFnF2lBUXp434L/GncmHD00zkDqgGC
    keQUoEmTJd4jahE1x3Bz1P3xQ1X+oryFJvxjIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122718; bh=Ju2uiM
    HaIe0yjVE1ATeBKFPz5j2vCfYT9q/7IxF7JX0=; b=OPW5aX95yYpcfie3lEqNad
    V7qUGNwKpQf1z8wX53OYWn6gkvktv1b0mSD3n20VxB1OvlrgknUn4K4ZGo+vgs75
    Qz02xvLYijNSp7dMj1EWXRy4d4vLFBgc8qZlfo/PEnEXlVZUH8Lihrj1UxdPqBkG
    8H2QsBRyYTTw1scbttie2MzRcIylbXHr+iuqgYlDGvhtZ5ktTIN2/mMLzKbX7Adq
    3rxsHpHNeEpy2GDNRXDh8Qzc8q6AxYrWH2COLjV3sSkkgOhcA7/OZb0BFWOEZm6X
    sPou+AOi+LXayVdB4KNpc3g1LkU+wkp6wlpYtFXFgMxxeoPAPCnohInB3M7R3KiQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QgFLMk73 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QgFLMk73 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932925AbeCDASC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:18:02 -0500
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:12224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933326AbeCCW3M (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 45/84] drm/sun4i: Fix format mask in DE2
 driver
Thread-Topic: [PATCH AUTOSEL for 4.14 45/84] drm/sun4i: Fix format mask in DE2
 driver
Thread-Index: AQHTsz6ql6++R5LUBEuSnqeoq/q7zw==
Date: Sat, 3 Mar 2018 22:26:25 +0000
Message-ID: <20180303222518.26271-45-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:mKIPSIOd9JCokOEhYTX4npIZ6kATqzmdBJKKxphq+1GrtOSHD1LrsvNTvRnvuvD982Nc70KotVkZzrdykTOxfN9kx+gZID2PeB8XpUNrIPvLkXOlS1kqk0PAMYIViVLg8YzY4C2opUZjKZJvbzFZ6EWrKSj2Fh4eZS1xIPuVktQ36PEOFPv7zLgF4B43xgCVrTeLm3sX7LsYXnco0oFx6xE6T2ngDukFbFUlKJSsliv7w40mV3qY9AhQzH4rv1GYMvTpcvYOMvLVaADk2NOGnLmtmn7Q0YYKoJAU3UoQm7H53jq86tCrzLwVjRV+CeAmXC1crISV4jrBhd4NzehWnShdikLbUHf94kO/VJu1W4diONAycRFTOBvft++LN5wU;5:oVH+ru1gzScsn15+eb5N5774o9z7CiiW4rToP5mgkTuoC+22T+OtudjGRSdFcE8nSqWpVWz17/beWvKPCVunvV2IklJk1ttjC/CmLP0GVUtOE5n+wPPYEhIX/h+yFqOYIehUdpdk/LonfC7YHEPpFnT/XUaSU/yHTpl9zIs89yk=;24:uBXJxSJaXHzsMn0GITqA6qt/DX6mEOtSrIwvZZ8Sbs0dHxlX0zXVnrH0phwpxGy38BpRoLolOoaZhLnWtJGt77grD+XvesfHsre0wBNsqD0=;7:FND+FVt+uuL3kS/DM/EWvThrxjuUhgtJQ2/3Rja9glbICRk28E0z//0vpiqeOzeORsuGdEYIEu1Bvf88vscmQvPV9FKeZnrEM4ar0g9dhi8a5vplR3QQsrr66gdPtPXWkkX/fBXqN+nMSHPnd/rsOm59X3YpuNxWbwnQl4/ZhoFUn+e9iqJmbFjJ0I6M8f6ZgA79Nv3Fu5brvAt/ru+QwY6I0pRDsUyDOfMJJsT7t+lve+ph1Nrv8LlzOZm3PZsM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e6ebac6-3864-45b0-d0cc-08d581562e1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970EB8B2BFD3FB26B735896FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: JGwWs3HWXhxt1Jszl48YfvlkDBNd4tchI4smgUdFDo45Snh9Em9pBEcNBPY2Ad+1tDU+9LAfNzRLSpNyqYhHMdvmKpaPqaArZ+1sAo3nmT5gQ21+w15d9s0hxCY56k7G2dZI3+88NTo9TAeqaqehOaF93vEX4LRr4bmuYT2ZQe8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ebac6-3864-45b0-d0cc-08d581562e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:25.8223
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
