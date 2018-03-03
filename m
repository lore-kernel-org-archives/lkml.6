Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118093-2-9146717379743738291
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
    t=1520118093; b=WPCsQC7IpM14UvWxaXexsf8z7sncOtUHRyv6v6Te81XR6mV
    sX0fAYK0g78pjBUGiyC0V62NIXxoLBXnFdUY1dzK8pugSypLe+nylYjOEZ4o4UpC
    5rkWUCdKjUF6nzeuLqMkaLD+9wMxDiY85Vd21DVOKQJn/2SRAAlCgBASyMAbY9Xq
    kZo/uJ0oMRvCrY3CWBA49O/FKUznYnvFB421eWqRFYto4oDR+grE6Aqt90fgpOth
    Fm3Omgj/Xu5nkA5AetnqTm0nWI55ZH3/eRJfDkbPXzpDamTOQCvAfkICyVL8YiRE
    Rk6XoHq5Y8sUh7YFc8OHF4CUd5ulZ491hZUQY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118093; bh=GHURMO
    hLjPTUlfUtfFPydmDlG/eNl+8syiWRy+xT9gU=; b=BoQgfyALEGaU2FHZ81ggBD
    P0BvJzL9kUeqH9Xxq0NgicxEmiEGN/nqW/15gZffEL1n7PQz72kiZ0TSI6xX4K5I
    AI77CRpAX7Y3cGl38MeSUIlCRhipVXBKOiJ+ueWPE/A3vQRd34xVAT8oDOdpaC84
    drRqHj+Ba9WnWFvU5ZLK38zvAcz2eRpDrBRcfkv+AkVuSnMA0Q+OxeYEmAWZF6D5
    H12JxH1hDHGOEqaWv2YzdqjMJ8Bk90fLqA5f+nC8vyAawwM3Gx7hRjmzsqDNtWIh
    Idc4ASyt9W9Z4B2s0fllGEsbT5PZxYrxQzHyhzPDFT3dqabpbgF8tWbSXCi3tgnQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xee2FoLk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xee2FoLk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933046AbeCCXBN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:01:13 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934572AbeCCWkt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 099/115] clk: qcom: msm8916: fix mnd_width for
 codec_digcodec
Thread-Topic: [PATCH AUTOSEL for 4.4 099/115] clk: qcom: msm8916: fix
 mnd_width for codec_digcodec
Thread-Index: AQHTsz9rls7IzqYQhEqzz3wCa/uXfg==
Date: Sat, 3 Mar 2018 22:31:48 +0000
Message-ID: <20180303223010.27106-99-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;6:I0MpHJ8nAfUbaeXZPan+Nf4CqYJCX+F/fIH/idAH8LP1tHdpQ44czrmHXOy0f1c/S6iAYRQuz3ufRcnOApbI+l0wx9VBNLSP19ifAEdPT+3XOtV+YMV+2aPPhYXNpT1SvRqzWD7CcbQqj3xu0FVLQLhfl5x4tpOjVvb8+crW/Z3XYl/rSWomhNGoB6k3RlPHAY+p6XuP76IB7Ji8ZzRwLV1GjAVVkJCBsEWz5FiMwCPP2JVx6k9RhQL2YBaP1fdS6S2ZJdativHBriI0LxFmIFxMYZmzWsYkKwpxupLu0KWQExRmTUYSps7u1vGcDTMjcCKI2DPkuBQbWOkMEuHen8HhHNm6yo0cP/jCU1V5q6EOHmNYdXC5MGFhsdUiG+ar;5:pE7h79d1GjOiP/6K6qnfylkf4paKa2VXe3S218+9UWxaBcKF/nlmjlP0egfe8DizAr+ZL+fBLI0dNzS8Alo/arC3WciV7tZFA/VJvccQdcLZQnt8sZqaUymLQI3+6KBjAp39Ze+r0nA+DaGSHcY6uadcui+94+SN5uf4GGvzTlY=;24:lMre/jhnaXFXxto3mTvYp8KB+I5iEUAmyDKk9U7tW29PoktIzTUB4Mtzz56TrypmNLRJPvSl+DzccV45XBjSkAZpa95Yuy03AkJhR/5XSkY=;7:XRqWlfAM1k/pkxRr2dn9aEGj4nNbnR1neKQ14L/v0ENJpYGOZW+O8VAQ4VEyzLrWxe0tKKqdnuPnj00AUjU1JJIF0tc1EnbM3RYdzAdTaYtgp6O4qKfPCO/5OxPg94LXGm85s4yN97vxcoRlfcDOLntLZfqRAoCLU0MPFrOoRHuccMOQJEGA0OGPHECD7BjQil+8kl8vJxbOes67TqKaU/BnOzO2XM0YLLmdCWnb8RZ6/XeVrQ1S6xtwpbpGwloq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48a1c0ea-7b7e-474a-17a2-08d58157ce23
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09398E3790C1F3CA6400A882FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZN5EbwfTXAa4/wJ3CZUwM5RbFgrvNLE/7vdYdbBUa3bgag+ezaKmIkJEGz0yO9cbA8z7gTwYrTv8h2t35SehQlHe9+OJrBEq9rmQ2G/fA6ZPDpTOV6S/dD/OdrjoHICMzvbvj81dwq8Sx360Nt1wwNCYMj/lPOGA/+fQU4jl09M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a1c0ea-7b7e-474a-17a2-08d58157ce23
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:48.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit d8e488e8242ecf129eebc440c92d800a99ca109d ]

This patch fixes missing mnd_width for codec_digital clk, this is now set t=
o
8 inline with datasheet.

Fixes: 3966fab8b6ab ("clk: qcom: Add MSM8916 Global Clock Controller suppor=
t")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/qcom/gcc-msm8916.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.=
c
index 2e7f03d50f4e..95a4dd290f35 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -1437,6 +1437,7 @@ static const struct freq_tbl ftbl_codec_clk[] =3D {
=20
 static struct clk_rcg2 codec_digcodec_clk_src =3D {
 	.cmd_rcgr =3D 0x1c09c,
+	.mnd_width =3D 8,
 	.hid_width =3D 5,
 	.parent_map =3D gcc_xo_gpll1_emclk_sleep_map,
 	.freq_tbl =3D ftbl_codec_clk,
--=20
2.14.1
