Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246740-2-15723076178705815964
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
    1523246739; b=TCB8F520wEl4/WlIyvetYLbIXislwNI6tt84AYFQ6eX7V7VmK1
    k+8hA6HXQJ13XXKq9cP1EqIY36O/Dw/hu/vf56oS0v1T7ixDa6rX3NyOUSs8RTrS
    i+23Gmav10WQe6ikpFB8aGorelg5S0DskSB7vVsKTWmJeGlplr45X/auNoa7dCiY
    ElIPzGKKcpZ2AWR//dn6bemZVJP1BQWKqdRApPtyPj+U4mcWWzrFMICyVXgL7Xo3
    8uSwX2g4gCc3IXWUTmpk0pb7GB40eQt3x1HsSkC4wwIDu+cGwF5FGH98x7LA3q2l
    rTjpM6G/pvvzElp2SvA0mtqE4hKp+ankqgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246739; bh=+jxJy+qrhW
    yLJPmZwjAYqgVQBtT43mLyGJA+EaoIRYc=; b=joFNa5mzUNvvRuoKrFqlX3csSt
    SEyINiMDLZObCBSfinJYoBvtf9q180XR5yr9oLUiIG0V1ttTbEK5ZGLLPwRzxsqm
    1EykeUmlkxAGfz++ZXGBjOc3eFjA1yHNafFqvb18uFiC+URixo+4QG1avLrYNSl/
    8Nk1N2HfVQGvSzrS30nfpDn5s1Ec27tQ9eSPsanTrWXf+bf6zOYSSo/sALmpjFvP
    28YMuM/uzans3nxzI5nLBlSH7dL/E1m/Gp9IneCg0OxrfNDHXDbYnz4uSei8LoYP
    ZTZ9IcLBaU2AKUAwKdgjmd0W+LBC2Y7ey9Cxkteb/+qmWMm+EZUv3B4iUvog==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JSzWZsq4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JSzWZsq4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8wYcV1Fchy52Ox/uM34SUzdF7vxc/cyljRPiu+vB+C6Ac7CIiLLO9GiHHutf+NEefX4h8ntx7mmcxMUIjJne8YbdFqq8Hz1+beuK4ZT2NLHElI+k2U
    iCDu+hnaqVRlcF3RJS1gCcEHMw4rJAh8UGJTUaaLq9meHQhguSGkV/2WrXWOB2eQUopIBRX/n7usyOIRd9FXtbcGwIaFQDnKv73Kf/HGbeCKKYW9HQjhbOJw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mK_AVkanAAAA:8 a=IpJZQVW2AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=rQreX23rgRp_aJzVNc0A:9 a=sofDSk97rIlfnkgn:21
    a=8HZHfZrcMj6uy6s2:21 a=wPNLvfGTeEIA:10 a=3gWm3jAn84ENXaBijsEo:22
    a=IawgGOuG5U0WyFbmm1f5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeDIEFa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:05:30 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753181AbeDIARx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 042/189] net: stmmac: dwmac-meson8b:
 propagate rate changes to the parent clock
Thread-Topic: [PATCH AUTOSEL for 4.15 042/189] net: stmmac: dwmac-meson8b:
 propagate rate changes to the parent clock
Thread-Index: AQHTz5gf54fZTJy6J02HPB5zSKPGAQ==
Date: Mon, 9 Apr 2018 00:17:19 +0000
Message-ID: <20180409001637.162453-42-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:lGZtlzBFyMVneTtTIWaB0wKGQyvFOZHuhQzYS/ipY8efUATxSDU+ZhMFW5IbHORkFb+d5ZbACpKyaaqbPVGX4PJ40JBDILQ/g92vBEn6TXoh8a5Evm6fgjUw7ky8BTvDHwo/EzIqacLMBXvtBvh/0q8QWRahJ8+LKl0YV/cRpRQcdikr6sy378lWFTdV4CNKf8jVcKVF7k3chtT4f7QFUPVuSQJ22M4bxvhZl4hQ3ZWCnTcB3JUX/SybfbFFdCv3;20:JOWQ5ul6absvuIzUgxWqgAZc19GYbD7ZnLbOlsWWAOvwi8U8XWU7aQ2L/EZ8xCYszIHSBw/bmp5do3wRN/4pcyS8+aITuX/nMoOOxqAZbuTwwKlCkurtJOJt7lzwTSmNXfoOYkCa7USu+ivykvvG+6E7WoR+VAMhVUQzYU09joA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0c4b2e8-f68d-4ad5-6d47-08d59daf5253
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10482E505532B728C688D474FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Zn12XBfBJLc63fIsc5eSHszv0m4gPBH7r56IrNpowVynjM8WwpjEyg3a9IBYbNLReRuubEIPHAYD1WupOyeav9eLrTrR7+p6jKK6YtGX3ebWtkMTwPsLS0H9Ct+WCt4ZAg3Ohtlh+xUoOlj0qV/tv1Yia10RO4v51MMCaGSop8wipp6a+bkmWk0e40AKjFmuondV0/3MvB1GxCit2wK6J82wpxY5lwnEHvvqD95FOj8vyMUyi7RTZYkUCY+N6rgo8eWwemGxqcLWf7lq9hUWfrAKGo+LbAvOXE5j9gsyxRkD98j1mH22iu5L4yOUhB4uuEjG4i5zfHd6UHF8BefuOJ7vF+I7DjYBnwDTKT/bGDXhW9Wc35+e5mXwNwvB+O6MhLTYTjaI6YPRn9F+HPidwWpSLlkC1L8DHmXWwE29cbk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4b2e8-f68d-4ad5-6d47-08d59daf5253
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:19.2762
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
