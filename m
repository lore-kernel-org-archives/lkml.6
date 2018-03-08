Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485081-2-778865608727239383
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
    t=1520485081; b=MwmhDXnmhKXdeq9PyAbbUHYNvFUPUGKP3WYobZ25geWMUl0
    3OsVxeZ4S7KFb70o79NcOUZlB0aDo0eV5qt6vAWBysTBPEMz5hdmmKGlVLmTGb7Q
    IinExUwyJoroJdav+682r5F/XsHLL3mzantbIq2E2ctEe8rd6JIsUiy4Bp46ow65
    eOeU4MxTJEuX1fuDNG2lXJs5jo9WCCWSWGZiIVXk975QeAll1g+sbsOTKfOcG0CP
    dSjO45DbcdHSNjUiFCd2gqZSabijdFEyMTwTmY5YHAg7S4gpgH79jUYi0sAB5PJe
    /Qiq5HxH0NZChiMtnpdBj0vItOkDZCcfmfAizIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485081; bh=TQKbq1
    j08bohoChEZ+o3M+yFrmM26alDmLl6pG1+9ck=; b=mQBQdHgisDOR+vVvKLsArx
    4UWz9f49rw6Os7oVFgjsg9MJisXG7dgVcfqf7KN+pQJOep7EXvVMXboNLT6g15ET
    tzgqsKZb0WPMMxHADv5F5x30JPVBc6NMmHB2Vc9JLYUfM5l0Fqw7iIbaRby/vZA9
    /YPKwFYrTR/SZl0yuPASVVThD54WH0YhsWhqxdlB/GW5VfXlDbQokhVmQ5gcoIAG
    6R+Uo8amxOnHPEpmC1ez3XkN0sH29uGvyaHP8di56+hfe3xh0S//gyKwH+7520e5
    ss5y8ZYl0Z4dkqF19KYWviYElaCUCCmFZPxiCa7LE8qWLM3gXaDx8LpLQIPNB3wQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kLtncHxa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kLtncHxa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964955AbeCHE55 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:57 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:24768
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964945AbeCHE5y (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 61/78] pinctrl: rockchip: enable clock when
 reading pin direction register
Thread-Topic: [PATCH AUTOSEL for 4.15 61/78] pinctrl: rockchip: enable clock
 when reading pin direction register
Thread-Index: AQHTtpnRgtxsgWOALkO7ROjM+HSS1w==
Date: Thu, 8 Mar 2018 04:56:28 +0000
Message-ID: <20180308045525.7662-61-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:8HFV3rD6xntNQBtr7Ee4NL2wt5rvEUkjs0xzsrivyuBVQDW2LwG81EqyBaaTHvCbG1sSKYYW9258tAlJYeAQ3DngS36mq9r1LIUoBD+5s/I+L+8k6ORLzmlhoyZO80nVKFpSLc7hOdU3XlZDWNeFn9Q/lScuRWzXxFqnq1A1l5k8kVs+Yz8kU+l/90DZMG7AYYgJLhWYdxNBtCvZGszezjEbfxu4pEe6Rx/oDexmpZ2c5LCY0k0YaW+j6cd3o68Q;20:/numJS2BZYh3FVT9HrhOZwRQ8R50VBK9gFD5RgUo2dCXNYcdyYRbZ78wnAzKn26rPVBaDTRIF3PsNXmb8EpmIw4u62OCQ9KE6Pr3FxeLOQqzf/2NdF+B3AYCfBchX/cMauRkPsvkqG4hKN7cYIBOt+W3BKollJ3RoKYKxlKCTt4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: caf906d9-c790-4c98-f9f9-08d584b1267b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080D045F67126B1DA23788DFBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: h4rxIDaoObsLpGReGoCx8ZRv4K8cEAsCAAWKqJu8+gAfWoVMh9kBOp8BcHVEaILWkfBWpoODlGoJxfRyTC2EU7m84P7N/POu0aGh+Gz8JOltISMolcE3reoDhUYzTJrGFH/Gz/YotBb2UwP1obdY6cFIOyMP2d+jbBIQ11E//uoDRHoQbpes/6mPHkra1P89LMXvQ/XyfhhBgp4dxhoKpDOok54V7B2E4CBzZ4lxhUtwWjlCwZvw2f9GH920DGnxabl2xVfN/ajzJxQJFk2BYgO75Rxy8gOCa9skXXxJohZpx0LJVGUOIJ3i/By1oJLt2q58RmLvvNM52RF5iRQJ+A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf906d9-c790-4c98-f9f9-08d584b1267b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:28.1295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index 2ba17548ad5b..073de6a9ed34 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2014,8 +2014,16 @@ static int rockchip_gpio_get_direction(struct gpio_c=
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
