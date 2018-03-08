Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491183-2-6917874152705151310
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
    t=1520491183; b=TaMvWrv3OY2oNU4RoXD/UAwPTF+GvYuJtrf8ozS5kxy/ZKO
    Z/bDR15HfFwNiKYNyhQi5CkwbpQ8VnHY6scu0fsJkCoJTDiJQC4lZuXZ9By7wXCf
    m2q98JRKvxOXA5nYmLn5Q8JkwypxBFopzaAcRc7Fn8Z72rLpJzSuZt+07EliGtox
    qnAg6oSNRW4YS0H944gvixLzaz+Fyv/tYKWLKFxO0xS8OVncPtxHuenGU7gCrdCh
    sPkIOwMF8OqX5GXT7PBG/HHS/s5vugfBUz8etmKTKWZGBo/tjVXosoP8taoeyf28
    fGeeYoSR0DAQ2bztuedDap4wHd7AxmGHNWKgJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491183; bh=Ol9eB5
    SGB7fkHgiZAsHBazfxbQLhk/3ooy1A8lHGukE=; b=mLif3fL/2pzDXqzecv2AKg
    iB6qtzmWLwkR+BudewGmK8JjK7t22BYydpL+mnGDBXwy0kCefW1DIyl3bGRS6Gb7
    VmFX2Ud//ptS+KRvOzGH8Wmh7ABAXOahEv3BydwWn9LB2qNUjaP/g13dMGXmk2UE
    FJud8VipPo87wT6CEaH3sUasoiQrM7WsNCFwPjgqhM7iYMcSfvAbnuK5jsow8D54
    UMBveNIbC2Wv9Erp5DxD5SN2CILj0fhBitESN7K+vaPeCZ+z+YBWDM46gtru16wX
    yepb1td+gDI3LjkBsHw/xURcU4bCzSsCdawDOHvR+jKPCjjaw7C2fQ5TB94pLKnQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HZ9L7TVU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HZ9L7TVU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965375AbeCHGi6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:38:58 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965329AbeCHE7L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 51/67] pinctrl: rockchip: enable clock when
 reading pin direction register
Thread-Topic: [PATCH AUTOSEL for 4.14 51/67] pinctrl: rockchip: enable clock
 when reading pin direction register
Thread-Index: AQHTtpoE4u2lMJiWWkOklSJRgVO/6g==
Date: Thu, 8 Mar 2018 04:57:53 +0000
Message-ID: <20180308045641.7814-51-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:e3soiwB1BBChQF50NRm76sEUrx6reihwtnzgYA3DtvcaRRZGgJjm3drYbTr2Qnhasg+9dF50h9uWU9oxasLF6qe5j9R1HLBv4GYS/xg7jG4Zy1ps69DKyIFFASYJQCraBH/vXyxjshLL25zhOxlYyt+8ABY+1+Re+HX4vRpXYVVHeRwmMIAJ23GxqYLMEDaEvK3HyV9LQOG2Mdlnc3VJ4RBL4mdDBcGWqeduMEZfimb9UoZE3ZArwCJD25NLc041;20:YmQGER0fFn91Kb0a3qzQ3kpBoiEpLNEd8a6UHUjpfKeGn2GEHWKfaTWPmZvC+FMLvFvCy90X47M1vM8s4WPF7br1hSRVkXmo341qrzuUWt3MqPr6gykqvDKGavZawdV4e6B3iTdS1fJqFKQmjQ4RiXxfkPirlWxZ5//Kej9KmOY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1eca9a1f-611f-43dd-d3c5-08d584b1535f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015BA75CA6E8124537285E0FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qbFNLU6pUYCOL1eGSGy55L4FAQc+nNQC03npNsQ1Z+3jyuRn2nBYGxtmmJKhR4fXvDJvCORbNxi66Gq7BDEEsxyEQ/7ORy+57w23p9/4HBAUl/H4d6GYurF+wAmKaVSTMfCdOSREfjziHVzWIeW0ygLOkzsDVWVb3ORj7PT4ehhOPAWVhIFbGGcBrJF8j+XzZqalCBJiwQTtVpxxlKR4r5618YbPCVLc63EvdCWoJe19E5iuT2cOFno5JMdOhvHWH9pMq5xkEZAJiIUUgdtPJ4uumjzQ75coFiLJrOinTb0D+WLvS1LWKKpKwFL8MX8lYWj81T6SwpOmI/uq1+fsTg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca9a1f-611f-43dd-d3c5-08d584b1535f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:53.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 5c9d8c4f6b8168738a26bcf288516cc3a0886810 ]

We generally leave the GPIO clock disabled, unless an interrupt is
requested or we're accessing IO registers. We forgot to do this for the
->get_direction() callback, which means we can sometimes [1] get
incorrect results [2] from, e.g., /sys/kernel/debug/gpio.

Enable the clock, so we get the right results!

[1] Sometimes, because many systems have 1 or mor interrupt requested on
each GPIO bank, so they always leave their clock on.

[2] Incorrect, meaning the register returns 0, and so we interpret that
as "input".

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-r=
ockchip.c
index b5cb7858ffdc..a9bc1e01f982 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1989,8 +1989,16 @@ static int rockchip_gpio_get_direction(struct gpio_c=
hip *chip, unsigned offset)
 {
 	struct rockchip_pin_bank *bank =3D gpiochip_get_data(chip);
 	u32 data;
+	int ret;
=20
+	ret =3D clk_enable(bank->clk);
+	if (ret < 0) {
+		dev_err(bank->drvdata->dev,
+			"failed to enable clock for bank %s\n", bank->name);
+		return ret;
+	}
 	data =3D readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
+	clk_disable(bank->clk);
=20
 	return !(data & BIT(offset));
 }
--=20
2.14.1
