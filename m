Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242683-2-1206150873118083740
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
    1523242683; b=IvUnz6hWuyT5imGQ2wkbCKDtROI1r7KvlOmYTUqOLNWrxMKHOt
    rQ/r0JVpX/jzMZokNkzGQFcj1A7MZhZ7mAS9+sfs5Niqslj7bI4M/RkwX4T7E0cM
    H9j/sFI8HBzaI2XR/UAZY3YLQoyvxhN6GDE8LXanZqo11krqxiUGugWqvscVZDYP
    6XfqtfyzVJKBaKyBH7Dpg9nGfPQUFPIFjEkgfHg0pi22IV4c0rlaP3AU5+WO+lL3
    Ak68EzMItZtMiPk5pmGaTp3PGlrWiLCd8lh9x+Nzqdhrl50nkRDPSgiLlSHodhZ9
    wIpJXXi8pN7pU6tkGalnjeZZzuQGy0I/CZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242683; bh=+/Dqa7FbR5
    j7K1LjP7egbAkmgRZyQcZi79+r1TCp51U=; b=fsmsPtxtUESgmJaIGrP/gE1wXf
    lc7SsEeG6Bb8ragxcmwqF0keVtORmWcR04v53KbAdWbICTZ74ewzxQUAiuvp1ee3
    c4gIpe4jKvCJzNunomI8xjmtE6pZnI4GczAzFjfur46cutqTPs21FCpnbs8rTv9r
    jSb0THzGsFhRRWKysJzc5W22ZYDfQXxXbJ6exKMilxmzZ/aYdfoF0z9cOOV7Wn5a
    W2yGJsdt/zwk2OOGjT3frHxyhfgWGV8d/0BniHN/bL+QC1FWqL+kjsRdn8sqvJer
    gUkWJ3BADUdhH7JXfo6Fa8u0s3I7iPFmMj7qWg0ZSl8AH26gyWtA0EdsqV7A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BBDC9nYW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BBDC9nYW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbDgnayWhx2lFcnHRaoZ0A7fYX46/ZK85BPmQZYqZvcBSFHNqrF9KlEokJiiCShOHvsTwmHhaRVLDyLxd+WvU46je9vMh9LSAXol+bZFUehcMvS9ent
    J2t6Qorbk4p3K3uTIMd5uriyjOKvmQQ0mvTFl5GVPQYPQeL6E7YStz80PwlRf3CVohNZydEQHMCKaG5dILxS5ZLGYJHYsO9sLG57vUdZVAx9toAnadN9iwOF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=K82gfHmz9ML5UqyqUwAA:9 a=wPNLvfGTeEIA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755212AbeDIAZh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:37 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755165AbeDIAZe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 124/161] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Topic: [PATCH AUTOSEL for 4.14 124/161] MIPS: TXx9: use IS_BUILTIN()
 for CONFIG_LEDS_CLASS
Thread-Index: AQHTz5i35B5sXTqRnkuygn2sm+RC/Q==
Date: Mon, 9 Apr 2018 00:21:34 +0000
Message-ID: <20180409001936.162706-124-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Vkh4GFeLFH+3IgfLgSPwMjtIqJgMzYcuYU2QztAxoYoS1oK1GQ998+12oD9AS3kvNYDPN20HlIyHcqc2mz2/UmKZ2aRXwTI+FCbetS9Izmg+X80D4slcutjvc9v1xXjTnI+vAfyRTEjcMcNMroaj0gRaVWtGCIitrZ4/qTK2F6UNaI0i8kePdjNkf0y7xaJI4ZaZx7r0daORmz4NYj+JNX9iESvRocdISZSsppA/Zvo1rj/suBa6IaMeJhUAOgR/;20:o9gfW4QeoFDxcwidt9OD6NJLTKX659FWDciB5zXeobcpJJXAeeO80lFSmJjQLMhvVWxbaJnEKsTxFIXM4Ud4ZkR2LRnc0x2X/ANtqIFxhnMuPSYZc5mvtBf1MWj9H72L3Vk1VvhvwAE8P6tBi16VTIKH+TozhhiNUSlE1HyheAM=
X-MS-Office365-Filtering-Correlation-Id: 3b3d9764-1ee6-4a05-2385-08d59db06684
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013E8E726A7E431B9E413B9FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y3eTXqwXTJ33Gc5ByTF6ZE52fLjXZcEKyBHu2CVbsh1sRnX1DutlwkKpriAwPgZebCr668PZzMGOwj5eMZ4x6a0Nx+dO4krO62RpgnvB6vZ9DV9CkwO9g9p/+5YrNUl/yjghUP+Rre/oml+pyHrhJQ49BA/WmDaMg5uH8cJ3IPyB6/4JtkCZDsNqptFQKn8ozJEmyWEdHjd3GTV/1CJz502zM4d8CUGvKiSQ6tBc/BTbfCaryXA0VWB0jY5e69zJiBs1PILKxYGPRHykkLg/GnKhTssc5WNyorlwyD4jnlme9DC1/FOVd713vlqSjxoxAXjyB3nEieGz715K2ZJ245Ozo4iLdi7zuAALv7mHfkaUsFvK/4LceOYIES2OlC4zM9FBKsDuhR2tJV1hZbJwdKzLpoFdO0Hcaco6pup6AbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d9764-1ee6-4a05-2385-08d59db06684
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:34.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 0cde5b44a30f1daaef1c34e08191239dc63271c4 ]

When commit b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
added board support for the RBTX4939, it added a call to
led_classdev_register even if the LED class is built as a module.
Built-in arch code cannot call module code directly like this. Commit
b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro") subsequently
changed the inclusion of this code to a single check that
CONFIG_LEDS_CLASS is either builtin or a module, but the same issue
remains.

This leads to MIPS allmodconfig builds failing when CONFIG_MACH_TX49XX=3Dy
is set:

arch/mips/txx9/rbtx4939/setup.o: In function `rbtx4939_led_probe':
setup.c:(.init.text+0xc0): undefined reference to `of_led_classdev_register=
'
make: *** [Makefile:999: vmlinux] Error 1

Fix this by using the IS_BUILTIN() macro instead.

Fixes: b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18544/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/txx9/rbtx4939/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setu=
p.c
index 8b937300fb7f..fd26fadc8617 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -186,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
=20
 #define RBTX4939_MAX_7SEGLEDS	8
=20
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -261,7 +261,7 @@ static inline void rbtx4939_led_setup(void)
=20
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */
--=20
2.15.1
