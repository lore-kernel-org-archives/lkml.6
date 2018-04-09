Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238942-2-13769514971843660718
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
    1523238942; b=WSI+AZ3lV8EsCHMB8ACcKAI5PYi2UzFc3lBmGIDsQN/vOY2FNm
    eT5VIikbvvf+yv/aiH0TgZzfOmsuI7bU85s3QYjodejpPdEUCjkp5caqTGytpxKP
    ZdKTQxGX+6xNDq09P2qWXR0vi3EqdMTm/hMbTSNuea+02+N/q51T1YATCc3qRkOM
    jmzJyQT7ZEViVyZDn7zk3STAlq3puTHaLZUGe5MdbXmAkkZMVfCcBs5o2KB2dGe1
    BZvMydCjIoaX6856fmG4TyAr64KUvrzxnI458Gxpa8kXsBfhZ2a2roDa24ilg2YH
    P5d9jiGvie0aLds1UGzMqVQHcnI9mAIuZjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238942; bh=sXZ1FUrNpp
    E7ILxsNsc6fTTrdEbuMBnXSpc8dhsSWpA=; b=TvYM5bVBiP28/rZghJambs1NCe
    xdS3K2KRUI06nj0aT+AgUCuE6jsUxN1EPFsFZ15TICY5bAKWsyVQkjhtWlJAJO+3
    GY8vbn//VnIAvIZfVyBnxP55/apylBc+1OjF16nv355xqU9iPSH710CHYpL08Nug
    0rPGGNqQgRfPlXr1kuuxqSerN/8N6ZngHxjtZGrVOd5rida3XitD9zWoyFbLfhuw
    oYziwizCyFywDXpd5VvF1TSGIpd+BVCdagAMKKKI06h5s/ShTlmjUUH6iuXh3TPJ
    oT1WKaHlbA69YDW3Jy03hF8F0ENQjeuWnwBwypOiHlXdN9DEVZ9NeWB4Z0nw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CTNEMnd0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CTNEMnd0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE96HogKvntsl7iLR10KFuVB2BaeNB20h1J0LbvjNIaMnZ081mOYBTZBAQ3qTGT8rgPc3u5fBfjX7RakncbbS0mfkqaiZ1W8pITgLqLEEtz/6zhEXyJ9
    47KBa0/Gclf7OpnNNdulZp+RCcI5nWLNJDXcR1enNllMp2yfjHo0zXMXG/oZG28b/xufWg+Dk146yaliP+55h5IkCDOgWV/HNtLSzRPlqz6UKgF1m/S4h0zQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mK_AVkanAAAA:8 a=IpJZQVW2AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=rQreX23rgRp_aJzVNc0A:9 a=sofDSk97rIlfnkgn:21
    a=8HZHfZrcMj6uy6s2:21 a=wPNLvfGTeEIA:10 a=3gWm3jAn84ENXaBijsEo:22
    a=IawgGOuG5U0WyFbmm1f5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbeDIBzI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:55:08 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:22599
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932187AbeDIAdB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 228/293] net: stmmac: dwmac-meson8b: propagate
 rate changes to the parent clock
Thread-Topic: [PATCH AUTOSEL for 4.9 228/293] net: stmmac: dwmac-meson8b:
 propagate rate changes to the parent clock
Thread-Index: AQHTz5lQhHmj23Y9hE6x9jANk0WkIw==
Date: Mon, 9 Apr 2018 00:25:51 +0000
Message-ID: <20180409002239.163177-228-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:SL4b06IZovyk44FcOf1ud6C42gvOYwe+IuKc7IRFlv9JQHu4awWR7lbohpAk7AZ0HXz8pxwJsObsvBPlH/GHdmGG76eP9KSRA0k13WtOFVmLBBkjWAlRUTJbODodvu8zsz0n7O+Xo1FtNdwSMU4pK+fPOJ4DxJzqhWFKozkMaMixtHKQ6+ztshNXNx/wKMW8tLxkkELs/vG6tRU4FxSJ009DrFG8kuEf7ZF0+a+J+S9L87jhucZBLG6bdj1Qwclw;20:65nG8tNs50k58u+RKXHmV4a0iihpNqqvhsTTIgg6S7goA+trOkAW26HxKanvjJV3oLA7i/73ctoZbQEZD1iNrYZlw72mgClZCEIpX8+fe4WTS2KUe+kXRyCS6J7E4pw3elDYzo+WFJV/xf8aEfz6cEAJtqMNN3Vwih6ebbNUoa0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b124607-ac42-4d3c-d0db-08d59db170cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902F2169075ACABCFD2EE37FBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BJsCPGcWNkC7AjLocZReaDJ3Uo5PLmuEwl5vx5k9oDSDLAO8h4BjVQmI8wFDb8J9tg9dMJ06KbVES/57/HJiatuSHPLzpCmeh727pFZPcA9BHMEL854v1M6GNYOadlDCKlRjk6AG6qTXAfwY+FiI2VY2zV0MPIYgMAcfQn62m+VKUK/LZTxg8ojKMu+7REJt/S1GFXP7fTtERcC3UhehisRXX6FOdqRBpotEKKAreMf//dUShqXMAyqg3Jpg8avv5+buuXi5FiOTT9iEnyX+H5UHd0q+uESZOfUVpNyrEdsyZVc7e31jtijva7tLzMEylnX9c1OIUIAtbPf5P7lKQXaH00/+8KgGVWtsl3AMyLJmC1Bhksi9dVR32W03ysnFd+yiqC3avJs8z0KRKSKPWSjBhnVcmTF0lexDpGiBhj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b124607-ac42-4d3c-d0db-08d59db170cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:51.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 923033867a4d..f356a44bcb81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -118,7 +118,7 @@ static int meson8b_init_clk(struct meson8b_dwmac *dwmac=
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
