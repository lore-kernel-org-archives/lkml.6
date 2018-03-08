Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487664-2-15220130557460045234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487663; b=twwEGK4stJ6rve8b+XhEU0NMwoXtwpMsXwJiktdXoPeMqf0
    6jUdvW09ipFuecEgtmTPBvPua2DB7MVEUVuTUIYHTbaxiAPv94maqCD4mZoZcGvC
    ROXnPjCbsnAhmSKfe0K5w+MJQmTnymD23/m3EJ59ar2mnYrInxTfFnph5JVt/5NM
    zriJZUC7gB4CaTeZsZ1RU9ChHPuC5DafmOviJzbq1+KNHSTQMZ1zWa1obx9r55Su
    DstTmhAcA6Xmja9/UBv3670jHLizEpU6lj6DoGAcIV0U208pcRxAffN5LTNMcs4z
    J3ff2KKXawJGOD+dOvUiQmdRvTv4tjYxUJb8fSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487663; bh=e4ZyCt
    yxbFHhn7HtSWsEqQPTmGtWU91rD+nYk4T1FVk=; b=Iw9qXHp48N6CSLpFGo2oNl
    ZnkKdJq2voQbk855lzqP5W523DOUU5/GBTqxnsBC58RcBUc/KOGUZrTtC8b4VrOy
    wWyTfY7WP4MxCH7pTkWz8qVSB0r2tTyM4j5udgyLWbQesROahOz577nG6PQeCOye
    Y+tPGBhOtRYoTiZ0AQOS2mN43T9QkyHWvflNTYvoEUY1YociKprl8C7x1/GovGUe
    Zl7lKWrXhpSe8OI6/XlCZ2/CvMQ1O22OXWLNuOc8M56VnIRi++zqAMPZk+NHpdBZ
    EE96+tZ7IjJd/8iCWaSqc+3qWvpnKtMS/Nm+mARm2UMrZrGBGsudAYU34GGgFK4w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bdJP/DR0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bdJP/DR0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965897AbeCHFkR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:40:17 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:57824
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966230AbeCHFFY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 026/101] clk: ns2: Correct SDIO bits
Thread-Topic: [PATCH AUTOSEL for 4.4 026/101] clk: ns2: Correct SDIO bits
Thread-Index: AQHTtpqI4J+rmlNVJEilNlIHIdsk0g==
Date: Thu, 8 Mar 2018 05:01:35 +0000
Message-ID: <20180308050023.8548-26-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:lYdhrDp0ImotNrO4p5PTPsSfzen/8ADwZC1TMmWKvaaT4lF27SCpK5+YON/qHknkV4rTq+8IU+wC1d2DO+z9eqCHk3Kcek1pb2zv72ttr8o4QP54tLXeAjRAQWR8nuyZQwVw9Ybd84yW5wjkH2DrUsVqg9WmfN1YRzIXfx06DsY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84700afc-0a59-4940-dfba-08d584b22e27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727C49B3541BD7182C22622FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Jz7xrkjSYS0dD0vLWIK9kFms4DPi1voX/x/peolHCAyxWWQdKqDdy9YmruqBu81xMaq8UkUtNaffWT16UaMtr4DTdJP+TTuy59/PLMZwctA7i87WeVv+lVkOmTfB7wu8KRnPoK94ndItvI3f7LvaJR7wyisQ7nmgUScABmxeKdPKlXDPD00ww8UabXBrA7H+zlqofR4iWV3wobaY0mAEBjfR0IbD6MUZPmQz/rfv4LhyWZ/p1GctgR9jWonNamSU46gyLp9F9NXlMK6kdLR9zCeXjegJZR9/IJYVple9FT/yhHIAFzGDhRv+ksAC5j6T0BnxWdU6Brp9R9KHi6BU0w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84700afc-0a59-4940-dfba-08d584b22e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:35.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>

[ Upstream commit 8973aa4aecac223548366ca81818309a0f0efa6d ]

Corrected the bits for power and iso.

Signed-off-by: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: f7225a83 ("clk: ns2: add clock support for Broadcom Northstar 2 SoC"=
)
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/bcm/clk-ns2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-ns2.c b/drivers/clk/bcm/clk-ns2.c
index a564e9248814..adc14145861a 100644
--- a/drivers/clk/bcm/clk-ns2.c
+++ b/drivers/clk/bcm/clk-ns2.c
@@ -103,7 +103,7 @@ CLK_OF_DECLARE(ns2_genpll_src_clk, "brcm,ns2-genpll-scr=
",
=20
 static const struct iproc_pll_ctrl genpll_sw =3D {
 	.flags =3D IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
-	.aon =3D AON_VAL(0x0, 2, 9, 8),
+	.aon =3D AON_VAL(0x0, 1, 11, 10),
 	.reset =3D RESET_VAL(0x4, 2, 1),
 	.dig_filter =3D DF_VAL(0x0, 9, 3, 5, 4, 2, 3),
 	.ndiv_int =3D REG_VAL(0x8, 4, 10),
--=20
2.14.1
