Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118614-5-6105661837726696270
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
    t=1520118614; b=vY2AwKl/61meYw8A1ya8N7l26/lcpMCKD7c1HSYjOde/K9z
    bdLummTIX+POaAr7rXtkwNYvHSzvdICzyLsjfK+M4ag/Vf4fA1yjbEWlhPr2B4Xy
    r1sbUG82fsJrM4ykqdCXXX8AB04Bd2+qsaFcK419XFkjgnCqJRPMtvT1/CCxkWVb
    +K4mRha7Ce9DdwxB2OsyuHRl5msJtXesK3/i3FqYmbgaCXbdQf5UwzLqmdQmw4a/
    95V1r0Dpz3nIMQsSMW0X4dGLyv4igpNxfK1lFcutjINf+rsHRE60FrGKO6I0SYLj
    4t0cdP5MtN00Z7nQcGT+H0sOx8pWgffACv99DeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118614; bh=UFpcpP
    o38lIGXer03nGN5h7By7RlQoNmlw2DBgYWnQ4=; b=Winv71VL72W/xcCMBitDlf
    oF/y4/UgQ7TrtFznEmo4ImV38HS1JkdGmkb6AH+zYmrjf/9z2Nbbv2koq2TSMo3r
    FxWUq1q08MVPFCZrEsV9civvC9qP1Bn/5CArdayR51tEmMIbN9hTzV8asgXcMaxg
    gvGEWfIUTXOVTnesKHgUon9vjE+2asSvYXkfH85RsHxQyAvrkXnHWVJ6eP1oMjkx
    Vne94WKvtJ6f5CHw243Qqg7zVcXPzec4IYz3Ybo70uxQAg8L+lNadtR3SzmidLO4
    eUOuOBcTy6YBuf5kv5gYqndCg0Y337Gbx8TovvERB7Sbq+pt9L2uikjLktNWU6/Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gykxsUGc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gykxsUGc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbeCCWj5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:57 -0500
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:45422
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935129AbeCCWjz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Kochetkov <al.kochet@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 062/115] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Topic: [PATCH AUTOSEL for 4.4 062/115] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Index: AQHTsz9c9rCK0LKlmUeCcl6XCZULlQ==
Date: Sat, 3 Mar 2018 22:31:24 +0000
Message-ID: <20180303223010.27106-62-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:6wch9kw0t5a32dZsjbLZyojbwOTAoxf5HNukbDPeWKgqdf6GqaVxlPoSJTnb7hW73s2ylBpv1GgXiqWyVzae0H1+i5obVMH1RmyiG6njiy4i619aFp6R+MWeXRHwLyigU4XrlDsVYKD+RrNxAS8pfw9nROzkRPlpmATHTpShXUGcOmDK+We8OfjFnVxgUYUL45TtUBTikkB2ZnElNmuapuNRAG8+68Mqc7VtaDQu1JZVWWDEO2kqUTlzxqKxiA4V
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a4725d5-64a1-4db8-7cff-08d58157ae4b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113A5E44FCBE621D49C9E43FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(39060400002)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: P5+cG/EiN57LYL54gMDpAAGbtpNdXaJNaBo8nY3vkG4vpl4I9I9WuUaJ8sivKREmqaMr03GDivrON19d8Y1sM91ksWBC9aY7ve8dZa7XfHK3yQFSf1mCrx/7JTMTjH45Fanhzt4xWcn+VA39+axr92NCN2vaHdIKNhhHe4ox3v8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4725d5-64a1-4db8-7cff-08d58157ae4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:24.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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
index 6399942f1840..0e5142b6e914 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -513,6 +513,7 @@
=20
 &global_timer {
 	interrupts =3D <GIC_PPI 11 0xf04>;
+	status =3D "disabled";
 };
=20
 &local_timer {
--=20
2.14.1
