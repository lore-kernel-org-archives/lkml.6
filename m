Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488122-2-15449813584945510517
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
    t=1520488122; b=OyjjVaHDQOMaeiDmgCUg3HkVUVlPI2XCRNnhp4G7wrswMfb
    OnLTITr0dZgU/UPnmGfYCSS3iMOkGOEJMEfO4MDJTJmF4Fe4isRwS3VVmtA9KjLO
    WEckSJuLfGbBS6iXIgcCJ2k2t2Nmza/WrsIeO0tBmhSsNRkeI9677vsp3vHEpWEd
    YwV1jRVPa8jwFz9AIVf/4coDG1fLY0PMh7XxY5X/l2bM1HyLSP7dmPLkP95JqN5Z
    c51x4yeZjsqhMcaQcLSLtTW1tAxqhOSfGgshTBb3e8fmVikaxOOeKU7tWCdlhqiU
    KNwLSJOJd4+ywmXh+xk+D6LEoymuiLY4uxAQL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488122; bh=+/ifom
    rOA5PLjQVf7hMaZNcuxTCYxYG75w+5VHzEwGQ=; b=Kl31WkkLiZf7GUF7DVXdMk
    AMTBm8Iu0BL3dOTGaiu6n6sKWdqetx7MX6bXReZCXNSX6PTihTeCIQFEPILZOTpu
    jR639hIpg94nzXsJjtEy/wMqgEllq7KJJNnLuirVSz7UC7yXeYFS57c61bG71Hie
    gkZ0HWKGlnEpH4BhBfEQhVEd5Mcc77LPp7kARQEr+HPILGVQEbrVIxfWY2vZ3R98
    6ZrOsqlvnBSXl3PvJWUKcf6LsHM7qL3z0/gYyJXFl8fWRuJk/HubYclvmB7B2K1R
    +b2wjTRqrfRMZcqsgTrW5+q64ZI9FcOu4g7giyN8zLgQHG57ZLNAuMfejOvvH7PQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aa2bZMot x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aa2bZMot x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935570AbeCHFFC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:02 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935211AbeCHFFA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 181/190] pinctrl: rockchip: enable clock when
 reading pin direction register
Thread-Topic: [PATCH AUTOSEL for 4.9 181/190] pinctrl: rockchip: enable clock
 when reading pin direction register
Thread-Index: AQHTtppXwHyKo0tzXEi1KoQXV1PH6w==
Date: Thu, 8 Mar 2018 05:00:12 +0000
Message-ID: <20180308045810.8041-181-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:45dGclmyOv4wWUtr3YZHh78pTC4UQ/X1lV9bkhPxA3bK+CAQwOKo+v++1FBjAYZu6ZEOMI/3NgxRT1lExD46/kfq9C6XNZRjSkqYUaGj3UrbvnP4ZK9KrPpGWP1xSuDuXQBmfT45eagh4FL5kH3mQF3v1grif1jFflftCecrLK3jlnlD3JjNIaPLAjpW8Blu1XaY/41c0WWJif+rddNqZlkqZZnRrOGiHmxiKIhatoaMkLc53ju/fNprGklyuW8e;20:FGpSr/Mo3vcZY2qgv/opMb8Ule2hu4fjpXOG/R2fdWtlOeigroWsNF8ceJ6NhegJ1gUJOB8K0ZiCV5X7tSgFtoZjsHMtV8D4TxU7NOXsgFpl3nSTkCYM5PX6WpW215EbWSfHG90hMjUX+pa+U6UDjDCNLW04u+6J19u3M3Ksg7c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f4c92ed-d1d9-43bf-a6bb-08d584b223b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09813518D1698145F85978C8FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 80I1/e6zprr3s6Q+pC5OXkU3rjDEpOEwEwghpDhy8ATlnIKuexYaZFDconhOyptdORMNPkpvCMCKCZYcm30mp0Rg9y4duQcdHCs9bzD3OJmfgr4Y3vD5f9iZymMyF6v110iGBxvLy6x/QJDdQgycFqcUtQn03QFv9t6QvvqgMAwwHZ2OBUMjylYPaeRyMb33HjKnwatc/t9XE7fn+omCkiid8ehXo5SmXCKm07bI1r9LVSR/F4Agav5TzQr+6HDrZCgZXxOGofEVEOZE4MGlNBHtO2rs5fUonKIiI+Cuf4xdB51QLed7tuueFAgiwyJnWvKFcNnOR0bTwBKPfoXMiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4c92ed-d1d9-43bf-a6bb-08d584b223b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:12.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index 49bf7dcb7ed8..f826793e972c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1278,8 +1278,16 @@ static int rockchip_gpio_get_direction(struct gpio_c=
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
