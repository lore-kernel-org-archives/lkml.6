Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244024-2-419158844063902438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244023; b=ZHkqN+SDE4DHqxVrW1BpR3K0mLzKWpJhLaqbuQzfZLIeCRzM8l
    iJOD2kkBMfsc3a8hWpsLQXOahO6Ieub/r80ykiK8VXyfP4VAmC/6JPTSoMbBqLAU
    ib+/B6A8r2bK3O5rT0QxKupw4gjgZqw3oeYrBs0dSsOWI0NzHS7kmY1qX1lo74Yk
    a2XS8Xg/f9KhWdbT17Ot9ZX6/yXTZ1072hR31QeILD57joMcQbpi2fCS9uZVHhNK
    OwZ/RktrMYvG0AZD052EnnGmI4qryEKY8xVadzJFRM3xqbcv1+ZQWY60v1s30RlB
    z2Qx+vUF78Me+CMVgJ7tQXWQ5rBi012meD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244023; bh=+jxJy+qrhW
    yLJPmZwjAYqgVQBtT43mLyGJA+EaoIRYc=; b=o/IUQ0QHmKagaS6KazTKKa5I2j
    OPpPGHMcsrPNvfgZGQ/pJq3JRR3tl3lbJGbCKGTDXK2IuDAxawi7kKH0+YQ8x4Py
    xD1mBM4isHQEWPauX45U0YHg64ygoEv0uutRT3/sy/t8/qN+SjCipURResfpnwwx
    Td/7vAtQkyzJ4KVnaiXI8qtECuAxYtxM/ewqT8J9iPqjUVnwA6ILPsBlEU+d2z9O
    r+3Un37Snp2Cc/43R680hketJX1uwPbbA9UYGqohDqbbhXBRyAW54wwUfnxeTEw9
    ylECeBpt5njbquk9xjCGwcfsbso8WaTW2Q5TR2V+TTgNJpmUukSQMskMI0wA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SWd173FD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SWd173FD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6rVETMU3riX6ip1NpKdB2d6gWWPCz0GYkc8D6677Rc99iKNcBM5TegTDv7ExD4N7Tbw7K5KAhy8mfxzgd8GbJYoeMz1bt07KC4QXfAjaJKy3vAWdww
    Tm7ntQjQSbIUGD7rccX6d/EAItu7yOgyJIFPf4PXthVr0LX50S7dt0EkMcfdfC3kuspLmFefqf88s6n4DXWCXA9Ul+YjR1h2RqWMAqxnSd/ecyVALLNqcp8j
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mK_AVkanAAAA:8 a=IpJZQVW2AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=rQreX23rgRp_aJzVNc0A:9 a=sofDSk97rIlfnkgn:21
    a=8HZHfZrcMj6uy6s2:21 a=wPNLvfGTeEIA:10 a=3gWm3jAn84ENXaBijsEo:22
    a=IawgGOuG5U0WyFbmm1f5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754779AbeDIAW7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:59 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754733AbeDIAWu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 037/161] net: stmmac: dwmac-meson8b:
 propagate rate changes to the parent clock
Thread-Topic: [PATCH AUTOSEL for 4.14 037/161] net: stmmac: dwmac-meson8b:
 propagate rate changes to the parent clock
Thread-Index: AQHTz5iHXpiC/8jap0qEleGPlsaGFg==
Date: Mon, 9 Apr 2018 00:20:14 +0000
Message-ID: <20180409001936.162706-37-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:Xa1H5YZKDk16k8CywU4gKxmOC3PE83scTeMl3z2Zq7pNl1vbW+mQs5L8dHL/6FCwExjtUAVtbUbhdCdfrZI6PBAaV9OLNGnO6Tb/2aqATblsSkZZ/DL+zi2dqhWF1n6OigwZ6/RyvLV8ZEEkvQ9q36C+tx6jASEQeF2IrPQxvuf1yn+I5IcnuBB2UJBh+NzvwAoxigsv5V/s6YIC/vOvPE5l+KLg4WNy7+7qaTMz+RMCyrJf2GNlNeoDTKG1Ij/x;20:modWQgJ0bfKLqqe8CzLWv8LVDJPP5RyaKizXLZ0X65+JjZUjhb7O7h8YEBoyfP9v9o97+wiZhvVbBdu3jcYDcDvEm4u48Arz88e0Od3eOjQznf/r7N8Xn2E+us+/996TeS8YhA/wAcTcB7lnBnF5bXWcVYZdBugKEtdfgdDteUA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6822dac9-6db5-4ba0-fc03-08d59db005dc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101432B81D3686696FBB2336FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0Fw8sA8cBno4dDWX77k/9BiZGnsBMS/8sz3RSPARL6mup5dAG63r0Rs5lZrS9QcCSLC17SA4AoonWKUs+G8myqdt44Rh3YS/MUI757ACcKJPFUjyn0/zKks7btaXnPYGnq+qqDL3zAz895sI/3QfQtNoNeWrX7dASfD7HBh7ADbTFeMOwlc9Z/vPdnQgCZUlHL9bZJc+PgP0ji7QaugdEmnno1Q0qKnW5wtd8YFer8LVKCDG2CwrpvysZkZdrGzpNkt73QUQFl/sQDalrEkqEPtztRrpElIVhZq4N5TVpmsCYq6ad82kUdsKLGoweu4bvBLQeeaIyzu2gFfzTGy5o4b+Nna50De6vm7bzEFWDMMB6sbG8Sr1gjT+qnM+N3u9eoHmsMn1jIsTcrC8OrHGKERHK1U+ijOQkCep/rziIBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6822dac9-6db5-4ba0-fc03-08d59db005dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:14.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit fb7d38a70e1d8ffd54f7a7464dcc4889d7e490ad ]

On Meson8b the only valid input clock is MPLL2. The bootloader
configures that to run at 500002394Hz which cannot be divided evenly
down to 125MHz using the m250_div clock. Currently the common clock
framework chooses a m250_div of 2 - with the internal fixed
"divide by 10" this results in a RGMII TX clock of 125001197Hz (120Hz
above the requested 125MHz).

Letting the common clock framework propagate the rate changes up to the
parent of m250_mux allows us to get the best possible clock rate. With
this patch the common clock framework calculates a rate of
very-close-to-250MHz (249999701Hz to be exact) for the MPLL2 clock
(which is the mux input). Dividing that by 2 (which is an internal,
fixed divider for the RGMII TX clock) gives us an RGMII TX clock of
124999850Hz (which is only 150Hz off the requested 125MHz, compared to
1197Hz based on the MPLL2 rate set by u-boot and the Amlogic GPL kernel
sources).

SoCs from the Meson GX series are not affected by this change because
the input clock is FCLK_DIV2 whose rate cannot be changed (which is fine
since it's running at 1GHz, so it's already a multiple of 250MHz and
125MHz).

Fixes: 566e8251625304 ("net: stmmac: add a glue driver for the Amlogic Meso=
n 8b / GXBB DWMAC")
Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 157e12e15f28..8be4b32544ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -116,7 +116,7 @@ static int meson8b_init_clk(struct meson8b_dwmac *dwmac=
)
 	snprintf(clk_name, sizeof(clk_name), "%s#m250_sel", dev_name(dev));
 	init.name =3D clk_name;
 	init.ops =3D &clk_mux_ops;
-	init.flags =3D 0;
+	init.flags =3D CLK_SET_RATE_PARENT;
 	init.parent_names =3D mux_parent_names;
 	init.num_parents =3D MUX_CLK_NUM_PARENTS;
=20
--=20
2.15.1
