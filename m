Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486504-2-2141989838715234505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486503; b=qbG2Kj5HUeIxQER7sMexqv+BDZMhf/L33agchB9S52O7x04
    9Pxk7PUhLaopDacQhD7FLC2jLoomKea4sqfTdA27XjmPwBab7VR83AUPqB4yvVG+
    hKSqjpOGxstZLSnbOJiVyXGBMV4R9870Qg+KPzCkGFuXGOiWGhe6kdrY7P3bdve9
    KFFAlZpxBPBocHIrOIsSR03NKiBseoWZ/JWa5wmRIzKhwUGvZ22wACmqVc5QYHxo
    X07UJUvrhNebvTEoyHIb+0AD8sGP6EjcnvqzI6ihJw/D80C6Z04d8/gd+o0UByyt
    Vknh2YnU6Dst3wIIU4OBBnXCEFpU8fZmf9qAGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486503; bh=pJr0Qf
    zh3SNQFpInw1+sxNqS4bxOu8GuRTklAaQCDbM=; b=MWaxwvEQfcjhGHlPlOjs7r
    hAG04OeG57WoDvTqxVuiFSbJZccK9Cio0r0fBAIlhhXomm2X+c81YMCRGS/a9dXY
    MSvQsBPGL2VsaI+N7JyVV+W6Ca1Y/NEAq0QTs4xB3vVwFf2YDSRDch7k8JOX4hs/
    CG9iUSdEflLOP5830mYSiOgUqTGLjF1TtCY+SiBUiL67KOGp/4zSfu0JOf21Ptp5
    zW2wkgkL8FSiNltEDfpR6csJ4J6kK2lvpdSIB+TZ+s4QaUWZ3Ozu+EsKd5brhlK0
    /fCMfbqUkAGmr6PmK8P0bInevuncKK4MEYaOZc+Hyb2DoSxyNisHr9eisQLcpzyw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aIUfLpKD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aIUfLpKD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966277AbeCHFV1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:21:27 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966368AbeCHFIG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergej Sawazki <sergej@taudac.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 100/101] clk: si5351: Rename internal plls to
 avoid name collisions
Thread-Topic: [PATCH AUTOSEL for 4.4 100/101] clk: si5351: Rename internal
 plls to avoid name collisions
Thread-Index: AQHTtpqh1lzA+jRQjUyI3zKjAVQndQ==
Date: Thu, 8 Mar 2018 05:02:17 +0000
Message-ID: <20180308050023.8548-100-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:XCin1UkyM+lVSpt6Dei8UVzZYMn5cEePJMKOHOeAgYYRDhxh2ojxkBSfYKVX+5t4scFi5SuvQAwPEQpyT5SovQx6MS0x4XbsGEOtklMEF+LMvFwnbpoC7krymh0GYX7JGCJ8t+m/bRE4d8gEpgfcKAJSh6LfLZkbGL0crvLLwPAlJBhMaATw6GFKG1UCkS5vNjiQdS+9aYiOOcfMFCf+5aB2gzztBKkmfOezlSh+oh7/w2RTwOysxJhoRyUPWuSL;20:OjUYI3eIf0nemvZviCUmgqhbpVK+IySGizUaxf4dsnfRyZVnRp/5L3Rszix3GX1k1GbI4Ibg8V6nDmaICA8IcXo77PPPq8wVfR0hNeV3cbNbvQhOJ4Q0VORsM/wjez1BFszqq0TYTX5wxu742aPxLffmfMZylmjgite13CgCam0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a40665b3-8cb2-4d1c-dbf6-08d584b28dec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727AC236AE622B4C7652393FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: o8kvilhCOPUihIICbit4Airxk4QC14XtznDaADShdigGmCkDFFifAgZmG5zk3oDE+RglxMYkLXyQC40ClWcFXMmtbh90QJQaFZ5p4yfD6/FB6IZaA6gJyrjHpbVp2ZtDncUk6aE3CU7LOhcSXUZ671ARvAdXWA/1wUDsftIMYc8Fbt73zd9xmhFcuyA+lRh3ERkWkKCm7Zw5Y4iNGwLMuHEKLj6BiWfsLbV/FzBWwyjTfhDUX7Fgu5/ykkKbIFuBhD82FT/Z/0F1L9Zo7aMByQNg3mH24Nj90GTxytaDTWJS+MXUEFy75MPsNG+HtUEsFDe84YdcjCBKt/u5y+QtiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40665b3-8cb2-4d1c-dbf6-08d584b28dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:17.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sergej Sawazki <sergej@taudac.com>

[ Upstream commit cdba9a4fb0b53703959ac861e415816cb61aded4 ]

This drivers probe fails due to a clock name collision if a clock named
'plla' or 'pllb' is already registered when registering this drivers
internal plls.

Fix it by renaming internal plls to avoid name collisions.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-si5351.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index e346b223199d..a01ee9a3ed6d 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -72,7 +72,7 @@ static const char * const si5351_input_names[] =3D {
 	"xtal", "clkin"
 };
 static const char * const si5351_pll_names[] =3D {
-	"plla", "pllb", "vxco"
+	"si5351_plla", "si5351_pllb", "si5351_vxco"
 };
 static const char * const si5351_msynth_names[] =3D {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
--=20
2.14.1
