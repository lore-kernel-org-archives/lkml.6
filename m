Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120523-2-11977466915995176160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120523; b=KqMeUOkmQdg4op4OW7w5RKiG8Sx7wy0TsdKFB/pN2bmWU74
    M5U86dw9A1JP1vd1jas4L6QkK8WSQVYWxluM4jjvjtlgr4IcfRNIzA94L63RzseP
    lITXtEm62ZgaRfWDTm6IrIvq27lfM/0Zg6FdU9XVUKXV6S0sRL+2Z3yMXaUi6CIF
    w5IhtkLXDovfXaLsBuHKWtBufu1ypMrFhLdbkP8L9zFuozOjjEQgzZ4V/QLaroy5
    3coLCFWCMRKZyXglMiAwk5HXcZhmLPNMPKix4OXfDKWpza6LG40zXt9GYem1ug1O
    yK3NsE6fyTLJbGZbkainYGtdE1MIdnm+Eljw6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120523; bh=Dnvc42
    X0+LIi5DcueHKwb8ICgWH/RYHYmJW07c1gsQM=; b=dlhQPICQ7aglWeojNY++/q
    aIZpsJWeZWtfxeRXyvU0FCSTczigO72w7L4jc9nUauxmgECy583C2BWSpGSlVbSa
    VehYUZ2EMkqg9AuzaHDCk3UUuOrBk4WkorA8Np6/jEYkSY09an7SHWa3zGgpASDt
    1o/b2iVmFB0DyZWgdglfmSRCIFV9lec5MOOlUwQw7vKRrCUIr//ewcP7lGS4lN6w
    HlDLjGbJwb/UQ+vMcWHmopa4YEb7YrjXYaWGUkN1Z37F7RRcxgYS8wikalvhkkQm
    Cq00e9WHRCykXwTJFu3gE5BXD7cbUjSJKZLDPXzbTR61ak8RLVp/+3YbA86TnxhQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mgznicr7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mgznicr7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934290AbeCCWe4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:56 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933677AbeCCWev (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Kochetkov <al.kochet@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 124/219] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Topic: [PATCH AUTOSEL for 4.9 124/219] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Index: AQHTsz8L1flxeEzS70aMpxWbN8EqTQ==
Date: Sat, 3 Mar 2018 22:29:08 +0000
Message-ID: <20180303222716.26640-124-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:uQ9vGnA8WJOFjEniYe8BC/RkBhIzNm/kNK0yxASV4nZSxK3W1KRpFPe8NvFjxGc0I0nqeRu5xwmdHMPCNKm+8xbmK/0Xh0fyrXhUt8+o+l1dgck4DllFLjRd118uLsM0rlwIjNwCU5TEblmYkFvuU0thxyAhaSMNRShKX8465lKci/vVTgF+adgw0ng6MGWccPoudtBsd77D3LrJhG1L8ymek3HjMuVxVUpQa2zvsxj0OA7qUBWCNJPZRheU9w4n
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 503f8825-a325-4a89-7c86-08d58156f632
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068CC611B77F6B7C28E7F13FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(39060400002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IWHjXQvjYO/TZ1N/a+rsLkKNEXUQIdTq/0v53ecqjtYE+DeXu6Bq7sfRD5w9n4GW0M6ZxkdP0lNnCX7yjUWB3BEhCny5OEQDnDFFo8OsokIdE6gkf+BktmpxeD56NpbDjg/C+yTm7cW+pRb8qZlIDTdU+NJQGR/jyCCHhui+5HM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503f8825-a325-4a89-7c86-08d58156f632
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:08.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Kochetkov <al.kochet@gmail.com>

[ Upstream commit 500d0aa918a2ea6bb918fee8adcf27dc2912bcd1 ]

The clocksource and the sched_clock provided by the arm_global_timer
are quite unstable because their rates depend on the cpu frequency.

On the other side, the arm_global_timer has a higher rating than the
rockchip_timer, it will be selected by default by the time framework
while we want to use the stable rockchip clocksource.

Let's disable the arm_global_timer in order to have the rockchip
clocksource selected by default.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 31f81b265cef..73a200914f0b 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -530,6 +530,7 @@
=20
 &global_timer {
 	interrupts =3D <GIC_PPI 11 0xf04>;
+	status =3D "disabled";
 };
=20
 &local_timer {
--=20
2.14.1
