Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489333-2-13534479827663912243
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
    t=1520489332; b=h7eHS98ceOgpGLNaec+sNlQRtFT2yEqbnTUXLhvm+NXm0jg
    ehJxeKo8eISqO3pDJSNXFpnCKBYiP7Gv8QbTIpvoreIiA5QetV63CwXPrzpiUAfI
    LHHy8H+4U5Wh1aRLVtmqF7kKMHlQqzBG0khVeM+t9tLBFlTMFwZOE3mhdJSbnih7
    pa3btJmyhZYKCFdhJ2sqMjNjpYfRoYfU3e2qJUTdB1RauXjJQTqFT4AG7rBBRmio
    FgkxK4PqFIDUG8NFSbXVEjUbPfSGG3oJvrHfRPzfKpfDA0p4Z31dgwjEx5rLpYCj
    lwIn3A9royYF5zNCSNHmCi90ewFp/Tap2yRarog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489332; bh=I+WzG+
    NpsCCnZKjK6YXgWvrAt8wCcMNEIoZC0TfIJak=; b=Quwk9n2jfi0WEGstTJ3fyM
    tg1S5XcMwba1rlA0P4A7PK5YgfvU43fVABI3PQgdHFz2yeWTBytq8Gmu/YrUXEj1
    6Fv3mTxbUmdOq3R0hbQs6kCa8eewLMqCx6vNviM2wiQ2eXOsG04jWTpQaZcpzA81
    p/y+gql479/H8i07rget3p3PeQAlKLB786XKXNXhZ0DUVdfAY1ttZB9PsJ7KouER
    i1XmESj+NnVhPhmwKysJ7IPxOqSkirvdSmwiH7O9AKjMQfp8hCxjXIvoF8xPnmXC
    mHBDgMhHZcJTG6b7iaKA8VSEy0PdOr94SadrN/lMv+FSICwbJeEP7VSi2fHQaZhw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kH+cjBz9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kH+cjBz9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965828AbeCHGI1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:08:27 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755365AbeCHFCN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 101/190] mfd: palmas: Reset the POWERHOLD mux
 during power off
Thread-Topic: [PATCH AUTOSEL for 4.9 101/190] mfd: palmas: Reset the POWERHOLD
 mux during power off
Thread-Index: AQHTtppB4YgTYyU9qUm40P0vSIbgnQ==
Date: Thu, 8 Mar 2018 04:59:35 +0000
Message-ID: <20180308045810.8041-101-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:VmJRO3kfZn17gIeN6KyXqtSqXKDQVycsGLbAiKgmBy4i+RLWirqqasDDliJGlRTUpRXfu3rj9w7tuhiSWGKqAvoDzTKph/GwylIrGs3EhMRvab++aJH0iUJXDhJXRdR1C00bqgn2LcdIW9WETpQSa8bBqjwg2UVeomWuY42iAnSWlPhmG92OPHwzdJ/wK9RVWYUo8xtfavtVvBhNL9ugQC7qZpve20d1/Vhh0bot80dd52R5akO+fcnxbdL2cHCa;20:Pl5Vg/q2gUVpm6MONeBBMMwPu/18X5Q3+EPrz0WUuluBjVf+atIT/ocqHV6AypgVhfuzxDPLsdy0NyElJ9dh35Z4f29fChx/yhm/a0qUYzKfJqTqootKSDZBocRC0wuDcuBv/r42G3cGGRzfExIzUwIT9z6RbSQ87YCKzQHMXr0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a59b43ef-e2b2-4188-4b0c-08d584b1c03b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997093BEED6F9ED47AB234DFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: c1sQ/03ogG6NwiuVZhTUs8OQ2xHsEQSeBnvHyHmbB3Li0EfdaG7RpaNW7orwyMotNTIif2dshP2NcsTgSBkrnKcwClWUsRz4w/fBdRUeJgb+ALpNi23q3Vovt7l+g4SLPtsNp22+NoULGGDiLI15JyI94j6aw/pejAOGRWMzTE1lpJrtSPT2iRvJ1nlHzF57tSDxjsibg1SsmCtUKCjiPXgVYcWyZs44U/s9XrzOYBk3QOMlxEOg2peTP8v4glaKeMiUvkc4SiVs0A8+Fc+7GVGnarFevLTO1E1DP5yUFVQMcYVpuL/ObKxQnPT8AZxYMCg6xWqV7PtMju/0F9+RAg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59b43ef-e2b2-4188-4b0c-08d584b1c03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:35.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]

POWERHOLD signal has higher priority  over the DEV_ON bit.
So power off will not happen if the POWERHOLD is held high.
Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
and the DEV_ON bit to take effect to power off the PMIC.

PMIC Power off happens in dire situations like thermal shutdown
so irrespective of the POWERHOLD setting go ahead and turn off
the powerhold.  Currently poweroff is broken on boards that have
powerhold enabled. This fixes poweroff on those boards.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/palmas.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 8f8bacb67a15..a6b5259ffbdd 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -430,6 +430,20 @@ static void palmas_power_off(void)
 {
 	unsigned int addr;
 	int ret, slave;
+	struct device_node *np =3D palmas_dev->dev->of_node;
+
+	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
+		addr =3D PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
+					  PALMAS_PRIMARY_SECONDARY_PAD2);
+		slave =3D PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
+
+		ret =3D regmap_update_bits(palmas_dev->regmap[slave], addr,
+				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
+		if (ret)
+			dev_err(palmas_dev->dev,
+				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
+				ret);
+	}
=20
 	if (!palmas_dev)
 		return;
--=20
2.14.1
