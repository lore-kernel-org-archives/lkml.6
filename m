Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116923-2-162310115659648008
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
    t=1520116922; b=HFuOpUpyboYmo/G3hO4PYWFK7C8aHo4IdNG7KyTF/JqortC
    /Rjo9jHTD66T+fmAU7GZ2Ji5RByJ93rUbwdSA5ePToqOYpYk1uz8kkJsJqw9iL7J
    PSY+2UyU2Yv+nXhmKA3/FYpQgwSSTJULzmYplyVpnUOuhRTnfniremszYyRUCRuz
    EUOr+CMWKQCgmJXV7nynYAmb5I4fxAIhj+RBZ91QiLVNNYECmVcO4NSIUhZwKQ+A
    BGCvhq06Sx6Gy5D50udiU0Qsh3EvIcLlb0UE2zUVmKaDhjPSKvGz4Clq0GhSQ3eh
    A3MS4z3lbH3xdYbpJTirJbLlzRU/E3rRN0z6L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116922; bh=MQ1tYv
    Cm1yNiLYUIatd1ZwNgi9+8vxGidAGWobooNUE=; b=QPppdyoosWDM6ib0kFf4sv
    idBTUEPTB/LWzCKu7hWIk9ft0nmoBLyTFjUoMWMk9ZaeBpRpHYlS7+568dLIH3k8
    PD7B8/o7Rv90BRvry5PvFIUAonG4CLpHtuKqkEbaXoI8lk+4AH26eIugP8EHzoX2
    HHVezkm26d6Ri5bmDciacxNo9kepAkgtZVyjce8oBSR4/aik4/tTTFUxWk2QzidF
    +EWJ7toIijt5nRQgntRd9+FW2MoGMvEz+vU/vA3O4mNz2CdzM5AMyGqeZBvC1b4q
    M0hcX0nmscTHLFOnLTYTFn/s+VM54LZmvxddkhk7h0Ymmky8zpuvXsiyrJ2XadEA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hoCge2zC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hoCge2zC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeCCWlx (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:53 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934705AbeCCWlp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Kochetkov <al.kochet@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 34/63] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Topic: [PATCH AUTOSEL for 3.18 34/63] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Index: AQHTsz+nPNnd+hGnDkao1Tuarkhp1g==
Date: Sat, 3 Mar 2018 22:33:30 +0000
Message-ID: <20180303223228.27323-34-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:L9XNHkKrF12rB5ABx56CnU5qYwwqmpnXft/dA07fFF6kUTiDyKwXBL6x+tzaSYuh5G+z46PSIEe0l01kabDnrLn2crzDiNAZo+HJLmGncy/RriYIAzzgc4sk4u6mOktu9h/MNgMufZ+gFXisce4fxopNf0f860ach1Bec0SrJtET+UTVbh5UvmHKLXywLi0X2a5l8l03hVWNSLHV9fVezZZyDXIcM1/+XRMZCg3YADuwpvqaHr7VgU/L3Rc8P909
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66bb15c5-4b3a-4a68-715a-08d58157f040
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06CD76A02689FE2B062CE8FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(39060400002)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hR6OVgWdW7IROl+sQjfrtNh+N8PFMhKYXKUMykjLCUvTvo/Z8KaM0Gwrs496vJH83u9f98sXCiorFuwhKsewkPWVTLGgzTpJqchlgzqL1qAG7j1LiAIR9/a9QUvUVnUqynT2uI9E4mvkiMuJqDeJip8bvjl67tnNWih9haj/hCo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bb15c5-4b3a-4a68-715a-08d58157f040
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:30.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index ddaada788b45..72b0b4cb538f 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -404,6 +404,7 @@
=20
 &global_timer {
 	interrupts =3D <GIC_PPI 11 0xf04>;
+	status =3D "disabled";
 };
=20
 &local_timer {
--=20
2.14.1
