Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123348-2-2178424982895335381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123348; b=XqPvAAVpF/dO9PjKgh9s6gRme9zf9m7bQ8b9BVM4jvBFKAK
    vJ3xlmaG65Za3MHXO3/9NBJHBljah6RP/l3utzdUpGg69sPVOsaGTXvP3JyusEmm
    51EWwOxuQo0gZi8IFuG9ioFCefRGiID/81vtpNQ4KVYy3yGWGo75V4GGcf1BDGXy
    7FC85HrldN4Cyy9VG9pW/x2Y6NrkHiPAYZQXk9t+MZ8wpuG/TSZH5Bv7blmValbz
    +vID7T4xnfY/7qpSjMyr6gI59sAVa9Jlz2U55l9qKd8JBDRurdMliiNdlNCXnaYI
    WYVwIQ91K0LpshSufSvdlOTLRk6n/AvmPVWHdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123348; bh=tmqIw7
    DsrLVys0DNwq4NfNmbZSbYZSl2+hFWPBYEo+A=; b=hoO4pfYWRwLpZW36Ne2vxF
    ZhMw3KtA1xhNw3Yjiy+OQ0dClECzzSSrypbtubC07439/rOJ8+P6FTsYd2r4XYgI
    FdsVryogug0KD/nJuLW3DQIU+fKSZF/OHOEVWWzn2R/w04hZmtkH2qzHIOQkJwyH
    6udb9jaKYfRkB6oYPUa529YVFv5gmvHJ1XxwFtmw24Pd7OmRnrilnBpM6CqEfnP9
    W1hhCyp4KwpcgecTPF7WV+NFqDbEItV2UQt7AHu7upH4h9AZuI9+DOpf+bizEyQv
    QF42mnJSZ+lovjACvXBJGyeYbyO+L+0wEY3i6+9sFI7Qu7joHvQXdm5HTehO85tQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QGSsMfJQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QGSsMfJQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbeCDA2w (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:28:52 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933073AbeCCW2H (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 07/84] ARM: dts: koelsch: Move cec_clock to
 root node
Thread-Topic: [PATCH AUTOSEL for 4.14 07/84] ARM: dts: koelsch: Move cec_clock
 to root node
Thread-Index: AQHTsz6d+QAUJdIAI0yffkpKhKPbeA==
Date: Sat, 3 Mar 2018 22:26:04 +0000
Message-ID: <20180303222518.26271-7-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:CgwUhlJMCkx6ZcSg0pNJYCOWaQ7U3MgYKtZfzl4z/6HewHgPzKn42d8S42kPwIazzBGfAZkHM9IOMz8jyb6wa41LkuFjmsQm9XD3vu+LlMiIltT83X/JioU3AoHiGWm1SHCP+zrEZSi7LlBtUF9iqd8QqQynv4cLzxRlDFS4r8uRoGw814BfumjgNWaSphc2WNaSwGoKpvKXZ7qkI5XWYH6qmt2bF/I3CzrWw4kILKUwp3LWcQJUSZANyV8cVR3XK8wVTA999T9BOS68fm1bopSO3G55vH2ysb3C/R3j3SHFrFMeIKkHGwxV55oiJkXa2qsXzNVUGElBg64eS7NsZS2mT5kwL6kQ/aiECUSF18Adklrut0U4otkAONPTbonD;5:HZ81v5YJX3zxEgxXP2R16LeN0b2mSDHjFxqNRlojgT44NMvsdqycNhMJLC+bdKyGS3W7hxUKDoO35TFeHRZGzy4af3kZqgnn15q1AxRTdEVmgcpXhpb3vR+KVS8g9hMoG7VzBrZgrExsZee056ltcXXFFoh9wGL3NuqPPDalFc4=;24:JfQSHAnxFM7w/SnkS08Q+mzb9lY82/XlQwKTxeTv/pf+BPtpjSB6dunT6uJ3x2Yysxw/fmXl/LOkyGMuPCPdB+uma2TZtyIfW1jExbMToyU=;7:v2YivbBRO9oxggcEu1x8P5jH7pB4DzpDq7B74GIpGumMiJqKFADCB9ApufKkDdy7uFoBK+d94JNnPnxsf1pAsBElom8FYSqq45vqlv2811x9g9W5I5cVt2FeQnoXC37KiiI3SsRwrsdjo4ewRPX+RbGgomHz1j0f7viC3Zg2wWjzAWYmQ70gInw29x1VCAgJVCCK4o3hEamKvVysCY32GXMDIe4Fc2P2+SENu0bvaC3oJfqhSmqXjtBD4A2iKRFQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cda0d7fc-c877-4b98-e477-08d58156076b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106777077B9D4E927CDCB81CFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +v38DCMsRhTRG6DpTJg9/4gCAt8EKgOw+Ruhrv2VyzKzegH138LltRMF7F5GW9HUWb9Q53vOeQfHy2taNETEYbbKcZLyyKLbiKADDbgAAb0zeN7amJQO7AYsOyppq7cBDb+s8YwBZ8OwI65QNF9as+wc67GmdWlyw08qZfnUINg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda0d7fc-c877-4b98-e477-08d58156076b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:04.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Simon Horman <horms+renesas@verge.net.au>

[ Upstream commit d72f4f03854d1225c72d682bf0e01377e7016419 ]

cec-clock is a fixed clock generator that is not controlled by i2c5 and
thus should not be a child of the i2c5 bus node. Rather, it should be
a child of the root node of the DT.

Fixes: 02a5ab18d366 ("ARM: dts: koelsch: Add CEC clock for HDMI transmitter=
")
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7=
791-koelsch.dts
index 0ce0b278e1cb..25c3a10d669c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -278,6 +278,12 @@
 		};
 	};
=20
+	cec_clock: cec-clock {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <12000000>;
+	};
+
 	hdmi-out {
 		compatible =3D "hdmi-connector";
 		type =3D "a";
@@ -642,12 +648,6 @@
 		};
 	};
=20
-	cec_clock: cec-clock {
-		compatible =3D "fixed-clock";
-		#clock-cells =3D <0>;
-		clock-frequency =3D <12000000>;
-	};
-
 	hdmi@39 {
 		compatible =3D "adi,adv7511w";
 		reg =3D <0x39>;
--=20
2.14.1
