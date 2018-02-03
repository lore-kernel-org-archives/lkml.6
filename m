Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683482-2-10218872683014760987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683481; b=UKAX+2BVve0kfscjLi7aN972bVKWuZLnQW5FvtFIJSrip5+
    vfz0nyKF7OwNCnAC4mlhu/kMgLqJ92OJgrriml6P7PfLxtaQh6FKa87Lrrax8AQw
    lCGQAVpFbayU/ntIMVmC1ulIjkCDUa39BcvDi/IkTghmlonBbcM4sM1DUDkJOOLn
    gWtl4FuvhrJRZHOfIAyaca9DfDJ7Vhh7jSzeVrYKWAXyXdWQn1qguLoDTW0+wp3H
    uqY+w/iqpcTADk1iWLBgJX2iFC3t4gvZtF28v/ZWQ09zfhv2qSZNDUhdBYT5+qNz
    xqJmGCbE7Uo6y6Ftqv7tTenwAehxsJeDxYKb5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683481; bh=FHbIyE
    yJwqnrE/evDvejxoXVdXbl70it2jlFc0peG6s=; b=lnOEZX/rZpcQkt81CzQbLE
    sY6ammr9/9VIazIFrJ26vEVrjRASXMJWUqiLhtq+Xx5WuCSsY2kcVPOy8x0GEfA7
    Z7A2KBDCkJAO8iSOp3MVZpNBdo0O/xFPkvNZQJLJhY2igAdMklD1Y01skQ0j+jzd
    vhoAOde9QwH4uUjRb/dVOejUu7xM8EWCXmXDJkrxfD4iege6o85YEr1YKV2HI+ET
    +v+xCS5jgsNILygdj1Qrm2lomk3NVCjsM7gfxfV5QfmW+nhSnPEaC1OJh5Vqy+6S
    0OWs4+Hcn5qa+d3bFHdwB3Ph1IIySzgqamUiNlQtdTxqokLQyQRNBYMhZbFNsYMQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CsEwVX6q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CsEwVX6q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeBCSnf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:35 -0500
Received: from mail-dm3nam03on0124.outbound.protection.outlook.com ([104.47.41.124]:55488
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753193AbeBCSDA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 051/110] ARM: dts: ls1021a: fix incorrect
 clock references
Thread-Topic: [PATCH AUTOSEL for 4.14 051/110] ARM: dts: ls1021a: fix
 incorrect clock references
Thread-Index: AQHTnRju5uj24Wpr60ua9FEnfqnuGw==
Date: Sat, 3 Feb 2018 18:00:52 +0000
Message-ID: <20180203180015.29073-51-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:YCV1lxKgOvT/ECYUNhODUH90c0kQXWk4XpVYbN5ZIfaiTc4++Zjm69pwm0G0dy/7FwZKj7+ppeehxx40g9C9m0s9Q9p9BM2AxrNp77MfwlfKNyFo5guTBRbldhMxNBA9JPJn+pA9ImBEzJWW2wh5Hk1PkhhhJjIAuIy0d5MLjg3g6Y8kD8L0UFUpq2WHw1PnjWmU408Wpg934LaFEZ4+pYeYCE7QQ8cilqAClHalak6SKGySWyFrzarMkNRq5wGW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 518ea417-bce6-454d-1003-08d56b302591
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092F38A9EDD9A93810C0706FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: opMr+8WU9qBkqifYcO2qOHqio++Wnape4KOLnEnacOb+Ml34XPIjmVxQ87dbdBcBpvLQMOLq5rppNs7DN7UhHw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518ea417-bce6-454d-1003-08d56b302591
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:52.9096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 506e8a912661c97b41adc8a286b875d01323ec45 ]

dtc warns about two 'clocks' properties that have an extraneous '1'
at the end:

arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot=
/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 =
is not a phandle reference in /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing prope=
rty '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle=
 (referred from /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a:clocks[1])
Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2190000/sg=
tl5000@a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing prope=
rty '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle=
 (referred from /soc/i2c@2190000/sgtl5000@a:clocks[1])

The clocks that get referenced here are fixed-rate, so they do not
take any argument, and dtc interprets the next cell as a phandle, which
is invalid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 2 +-
 arch/arm/boot/dts/ls1021a-twr.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-=
qds.dts
index 940875316d0f..67b4de0e3439 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -215,7 +215,7 @@
 				reg =3D <0x2a>;
 				VDDA-supply =3D <&reg_3p3v>;
 				VDDIO-supply =3D <&reg_3p3v>;
-				clocks =3D <&sys_mclk 1>;
+				clocks =3D <&sys_mclk>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-=
twr.dts
index a8b148ad1dd2..44715c8ef756 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -187,7 +187,7 @@
 		reg =3D <0x0a>;
 		VDDA-supply =3D <&reg_3p3v>;
 		VDDIO-supply =3D <&reg_3p3v>;
-		clocks =3D <&sys_mclk 1>;
+		clocks =3D <&sys_mclk>;
 	};
 };
=20
--=20
2.11.0
