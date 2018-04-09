Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246741-2-8126664361593736142
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
    1523246740; b=pKZNVwfAeX+5GOREI5TYQt/j0oGMRdB4jmAR32vpX2/5ricxsy
    wuo6jaIsD+m09wGzaO48xpK6eDIjTEMbvkgV4yFWM6q2CW028aLU/bVMDjGn/75e
    rngA0cMm9kZ2IQqIsS+3mid0vYwNyup87br8RNzhCQQsRkTQeu2TtsKj5BTTvrzW
    2B/snSDKAAb9hClSLo2r2tL1F3Q/AHd+9cWyHcAnqmST9PfxgNQ9vIN0qZxEORIk
    W2NakTGSP5B6RuxFK2DyNnpd33kN/xNH27wdu86FTkqKfuyiSFsuCB8IMT2eN946
    evduLE3Y1qNZG821VYMiGT6lohCksDxnkvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246740; bh=7vGJyvlg2I
    yPTgyxMAAUHB2ad3yhHZdGUbIE1eGIjag=; b=ew9mBFKMYk6uK0HEOxlsttzufI
    3oYsWuzLRmfTplOF43QtR2iDNYwFxVHiJ1CIoJf37qDe6aNgIsZFDXEEiUBiBAli
    ICwSdWNZQihzBO1OkKUzTNr+XiQ8cLXnh8WuztDYT0nf3NeKh1zxlj0LGDK8IUWJ
    N/9ZaubSkGuDXvZcVIxZNyj9ZrkAkqAC6n4OEs0XZjlm7+b9p8xr0JFISQ+x4jWH
    ZTbIPjjU24nWcOiv/RScCVmhSn+xrdZoCbakPzgKOVvagwx/0IRT1df5fdpiFzl9
    5uhQ1xgQp5mTj9bBed6l0UWqcDcuW9z///l8MQnM5f+LDi6CYu+yTgELNz0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R+Z4HbIr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R+Z4HbIr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAmjMAaNdxGd71R4yB24+teR0Ka8meVTdBSt9wS392wr8BTbK117ZpB1gCl0e+4R1Zq0mHmKqCFk4th0lJWeU7Kr8veFyuwhGsMQnz5EF79xSR1n7AjF
    4j9xZLF1dnN8vCwLHPQIDf/+dH337+igOZ3pdRl1CoRrey87Gt7YvSssZZDgcnOjlVGxphrgEoP0Hs4y7UvlVG+OU4Bu8v+ZmFjgqyyvO4tyGXCyTiWMyAW2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mK_AVkanAAAA:8 a=wLoXeaFTAAAA:8 a=IpJZQVW2AAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=AJ2rPE6bBxiu49gAXV0A:9 a=wPNLvfGTeEIA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=z7qd7FD03Fuld11IDmZ3:22 a=IawgGOuG5U0WyFbmm1f5:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeDIEFb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:05:31 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:5451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753267AbeDIARx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 041/189] net: stmmac: dwmac-meson8b: fix
 setting the RGMII TX clock on Meson8b
Thread-Topic: [PATCH AUTOSEL for 4.15 041/189] net: stmmac: dwmac-meson8b: fix
 setting the RGMII TX clock on Meson8b
Thread-Index: AQHTz5ge+R64mO9lMUu+tjR2+A6yeA==
Date: Mon, 9 Apr 2018 00:17:18 +0000
Message-ID: <20180409001637.162453-41-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:YhNOfCCmPJsfgRuF7lQCqQVAmjozL3La4rtroB+nDURlpU61wdBUN6ch4hgu44239LhMcyiadLjwRgY70vdMfo2R5q70BkyzZ99RPbO9M+apF2S8vY0XCA8P7P4xl4hAtiqZElBht04jcXCeWArqartBqlQDLxYJo0wWiW6pwOwKmOqzx9JkzE3cPZLhLdMZP6y6AQAsApnqhkUDSy8+CAOJoqDlker6UupC0cmeKC6IG2oPMec3hEozJMj+mfXM;20:PTTgYoAmdtCaMipu6Htie7Il8ZasGLAGHOgliaINnvGRkzGgdEZHhrs3A8Ih3WTv1KLGU1stYkzQzmFZTcovF07DmRl5hogNzAn+CM5MmSad/qSIjhI/f1mXky4vEBcUcayZuG5NBV/nmNhBCg2oBYdhuyOb60/N1xLYQSIoeik=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71e567cb-6aef-4c3a-c148-08d59daf5204
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048D396E763A61AFE2F8902FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: KxUew6tprHxfBcu5rOLWfFEPpYHm9H3Z7HLnb7iqA8gQN1jDcMGEBXbDK7iKM8syfoeTcI/TyVVqfRuAA7uGs5PhkT7VEjeaeh/mEfvqLFyoz4yrK6DSDAnwH/ScF46yaXpdiw0jMw9/vEUFF8uDS9Z/xIrfrfq2XcNUfztvwC6WltU9jz6PwVmVC2IYZX4O7PYCoMNcKKp6i8L9EuVYGDlDlIjYPHSZ12L4Vh4faSHPjSzX2bJw1xjVX7zOmOwc/yO3fS81AzABAdGZoar9PKzfNqbgR4J8RII8lnklu2XigRz4cajlvvlnfD1OTUFEFfypGnxi9oUE50c+elmi/DgUf6dBV+SdrofgcpJfMdojvzBQIxIx6qagAbAShdmY6/RfhDhwCilN8axcEc5RamdmT4wNws0P9JkxLgt8Jv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e567cb-6aef-4c3a-c148-08d59daf5204
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:18.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 433c6cab9d298687c097f6ee82e49157044dc7c6 ]

Meson8b only supports MPLL2 as clock input. The rate of the MPLL2 clock
set by Odroid-C1's u-boot is close to (but not exactly) 500MHz. The
exact rate is 500002394Hz, which is calculated in
drivers/clk/meson/clk-mpll.c using the following formula:
DIV_ROUND_UP_ULL((u64)parent_rate * SDM_DEN, (SDM_DEN * n2) + sdm)
Odroid-C1's u-boot configures MPLL2 with the following values:
- SDM_DEN =3D 16384
- SDM =3D 1638
- N2 =3D 5

The 250MHz clock (m250_div) inside dwmac-meson8b driver is derived from
the MPLL2 clock. Due to MPLL2 running slightly faster than 500MHz the
common clock framework chooses a divider which is too big to generate
the 250MHz clock (a divider of 2 would be needed, but this is rounded up
to a divider of 3). This breaks the RTL8211F RGMII PHY on Odroid-C1
because it requires a (close to) 125MHz RGMII TX clock (on Gbit speeds,
the IP block internally divides that down to 25MHz on 100Mbit/s
connections and 2.5MHz on 10Mbit/s connections - we don't need any
special configuration for that).

Round the divider to the closest value to prevent this issue on Meson8b.
This means we'll now end up with a clock rate for the RGMII TX clock of
125001197Hz (=3D 125MHz plus 1197Hz), which is close-enough to 125MHz.
This has no effect on the Meson GX SoCs since there fclk_div2 is used as
input clock, which has a rate of 1000MHz (and thus is divisible cleanly
to 250MHz and 125MHz).

Fixes: 566e8251625304 ("net: stmmac: add a glue driver for the Amlogic Meso=
n 8b / GXBB DWMAC")
Reported-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 4404650b32c5..157e12e15f28 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -144,7 +144,9 @@ static int meson8b_init_clk(struct meson8b_dwmac *dwmac=
)
 	dwmac->m250_div.shift =3D PRG_ETH0_CLK_M250_DIV_SHIFT;
 	dwmac->m250_div.width =3D PRG_ETH0_CLK_M250_DIV_WIDTH;
 	dwmac->m250_div.hw.init =3D &init;
-	dwmac->m250_div.flags =3D CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
+	dwmac->m250_div.flags =3D CLK_DIVIDER_ONE_BASED |
+				CLK_DIVIDER_ALLOW_ZERO |
+				CLK_DIVIDER_ROUND_CLOSEST;
=20
 	dwmac->m250_div_clk =3D devm_clk_register(dev, &dwmac->m250_div.hw);
 	if (WARN_ON(IS_ERR(dwmac->m250_div_clk)))
--=20
2.15.1
