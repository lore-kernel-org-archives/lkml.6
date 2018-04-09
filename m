Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523247222-2-18214335315974887704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247222; b=uxvpRwgqDlqJELjqU/BmYuVPQH6SG/KTt3Xki2BKJazLWfqa8i
    pRpZZmXiT3fCdr3zZhkBRQxH2BZUpnKZhqUjavstWSAhwffC0uY9al1R3wPw3nwE
    SuJHiD7Zh1MDWCWZM4pRzaRGHEr3UPvKa/Nt3MVIwBtdXHtWTzMvf2qQp6k6K5lg
    FslbaVMkR7Lhk9fY9Z+VQ+c30UulWOmuJQo2J6ZFXXQ53KA7Xlfqi5Sd5gSjguO8
    qxwdUv9B4Dy7YMXGy/TdathMwq+tatBM/nNgi5gMZ8QxFt3NIaupEV5/7KujoKD6
    tr8RfSgYIhF8fF6bWR6GAeT2xBuYWbfKnC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247222; bh=wpoR6aEFW0
    THcWHCqIKyaixHijPUtSOlcI7d2SQ8BFs=; b=h6JD7mKMmJM19O6fjVnzshOQCU
    dI9PJfRfmcKP1nDYwigMsum1y1SHK7oHY3pDkYi44R1ZgzYqctIDmX1jKX7/2ni/
    i+p8fF3PySfWiZmdoB8R3JMzsaYM8gtI7+ChU6Tfh9TRUbc9oecLRmKPnAxKxnHr
    RMS9ccP323Feu+5YdYj9ga0i1vIB3tzpXzXBEYrMsGb2ivcfXbCekm700HoVaFuV
    oxU2WmnzbTeGb9eAG0uj56tT9ohYAo5aixbwSwgbtILBbuydtJ01toQW4salwfBL
    8vk4YXSMRuIjuBzYheYNRCtelc5VTBLtWmb2Lby5AtSRFkwaU1XTw58McVZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JgwgKLsD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JgwgKLsD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHAsmN4Oc8cMh+2v/w/tkBrQ5i9RspS3Tc/HyocPEoT7Lk6mDLuxz3cai1gUICNSDxjY6kYQU0Tg7TpWHcyDhgFad7nkQprIwLJChRdWjy+okZVcOKKt
    EVfsMwVpTe5WIF05vE2VbigP2CPfRYy8Oy3AoRfKGeopRyx5us56LiRbtw8mckfV7nduFtyKx+nbdR2zULEf/thSRyyDOLnobYSWGKwwGQ5ey3oXNLW5zQrB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hD80L64hAAAA:8 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8
    a=mcZFpYgTAuSn6IqRhOEA:9 a=wPNLvfGTeEIA:10 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDIENV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:13:21 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751919AbeDIAQu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 005/189] hwmon: (ina2xx) Fix access to
 uninitialized mutex
Thread-Topic: [PATCH AUTOSEL for 4.15 005/189] hwmon: (ina2xx) Fix access to
 uninitialized mutex
Thread-Index: AQHTz5gM+LNEjWCJgk+hNtVQwGKr6g==
Date: Mon, 9 Apr 2018 00:16:47 +0000
Message-ID: <20180409001637.162453-5-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:1r64KLPY4TikLiONMCmPhSmVwg5EKVZPdGpUJR8+QKEhncXpjjXqad0jT7NGdL2GEQ614veJW9qv9IH/K1MqOlcu36Sw/OD6G7mDbUlST4Wle09immVy58RRv8PyxH2rCss6IjCqmUSBIcgfofcMxMiStyIU6uN+nMIP2T85LsBSxbDrWOdYq+kH9/YKTk0ktvUfN6AG/Rru/AuM0/dfaEKsOe/Nhc78ZCzM0xPWj1AWVkDsBoyLOSOd/78kgrXA;20:+bvBHvpVwWl/4u0WUD++g5IuZP/cAKhQKjPk7gXZQnzpuNe2ck2oa1gzwJrBkh2nBIkKUrs6t2MyJnKZEpYJgZVwLvrfqvFFJYYzeDpc2dsnGqDcVdmmoxKIOx0+A1+OE5+kNgifGFyVooRuD9K7OAM39sjVO4ffnXsNjEXy2eQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 52b8e0e1-2fd6-4421-1dfd-08d59daf2f1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09684844ADB79D4EFA77B200FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(5890100001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(575784001)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uL3z+2etXrbx8xfar2naHFRKpYSihHo7iSRda+M3xgMsmRsUC4vGSaOHIFfRKIWKgKCOUl3nt+x7wcL1PPzgcO8obQ2j0bBxHPEEnZDiZBsUJ1PnpSxOl71K12hKvni+AmWWFNgrStYhZ/Y2583XfMkwcmLG0fTD2yHTS2gG2KwJ0/j2+Rqn0WFFYpiU4PzQdbykEaIZvtmlEoaFXv9CzEu6lNmUb84nWuZrz+EwF/X8YOVezAtR7LIDOpfkaSssVgVbSJWeQGG69nryv2ge+L2jJi0i4u+RZRdPz76UECklhbMLLI4MOWG8llVCwajz6Q6twK2dnDiIWN7iaGGyS0dB9GRg7O25gKyFoCCg9t7EgyydQ9qDzNETXvz9XUWh6UMWbXMFGDUOuWTO3vTYyUlTQN0fcc54rL9c3l4p5tM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b8e0e1-2fd6-4421-1dfd-08d59daf2f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:47.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 0c4c5860e9983eb3da7a3d73ca987643c3ed034b ]

Initialize data->config_lock mutex before it is used by the driver code.

This fixes following warning on Odroid XU3 boards:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc7-next-20180115-00001-gb=
75575dee3f2 #107
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111504>] (unwind_backtrace) from [<c010dbec>] (show_stack+0x10/0x14)
[<c010dbec>] (show_stack) from [<c09b3f74>] (dump_stack+0x90/0xc8)
[<c09b3f74>] (dump_stack) from [<c0179528>] (register_lock_class+0x1c0/0x59=
c)
[<c0179528>] (register_lock_class) from [<c017bd1c>] (__lock_acquire+0x78/0=
x1850)
[<c017bd1c>] (__lock_acquire) from [<c017de30>] (lock_acquire+0xc8/0x2b8)
[<c017de30>] (lock_acquire) from [<c09ca59c>] (__mutex_lock+0x60/0xa0c)
[<c09ca59c>] (__mutex_lock) from [<c09cafd0>] (mutex_lock_nested+0x1c/0x24)
[<c09cafd0>] (mutex_lock_nested) from [<c068b0d0>] (ina2xx_set_shunt+0x70/0=
xb0)
[<c068b0d0>] (ina2xx_set_shunt) from [<c068b218>] (ina2xx_probe+0x88/0x1b0)
[<c068b218>] (ina2xx_probe) from [<c0673d90>] (i2c_device_probe+0x1e0/0x2d0=
)
[<c0673d90>] (i2c_device_probe) from [<c053a268>] (driver_probe_device+0x2b=
8/0x4a0)
[<c053a268>] (driver_probe_device) from [<c053a54c>] (__driver_attach+0xfc/=
0x120)
[<c053a54c>] (__driver_attach) from [<c05384cc>] (bus_for_each_dev+0x58/0x7=
c)
[<c05384cc>] (bus_for_each_dev) from [<c0539590>] (bus_add_driver+0x174/0x2=
50)
[<c0539590>] (bus_add_driver) from [<c053b5e0>] (driver_register+0x78/0xf4)
[<c053b5e0>] (driver_register) from [<c0675ef0>] (i2c_register_driver+0x38/=
0xa8)
[<c0675ef0>] (i2c_register_driver) from [<c0102b40>] (do_one_initcall+0x48/=
0x18c)
[<c0102b40>] (do_one_initcall) from [<c0e00df0>] (kernel_init_freeable+0x11=
0/0x1d4)
[<c0e00df0>] (kernel_init_freeable) from [<c09c8120>] (kernel_init+0x8/0x11=
4)
[<c09c8120>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

Fixes: 5d389b125186 ("hwmon: (ina2xx) Make calibration register value fixed=
")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/ina2xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 62e38fa8cda2..a55823b52b2f 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -438,6 +438,7 @@ static int ina2xx_probe(struct i2c_client *client,
=20
 	/* set the device type */
 	data->config =3D &ina2xx_config[chip];
+	mutex_init(&data->config_lock);
=20
 	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
 		struct ina2xx_platform_data *pdata =3D dev_get_platdata(dev);
@@ -467,8 +468,6 @@ static int ina2xx_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
=20
-	mutex_init(&data->config_lock);
-
 	data->groups[group++] =3D &ina2xx_group;
 	if (id->driver_data =3D=3D ina226)
 		data->groups[group++] =3D &ina226_group;
--=20
2.15.1
