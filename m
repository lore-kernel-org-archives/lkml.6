Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124581-2-13197030375412580433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124581; b=aCPmgGnjmDq4IRnJVBYMMWu2/aVDBCIMfGs3ZFaFpXN8/EH
    d8mPuUd6GW37DTx60CuLupWYYArcevPvhcNCgHXj7znMmWbRGmmkucMiirBVbjOJ
    C6R50CKUVg5knbP4ssPbmVO4trzvrzI/o9J61iVZc9AnOAE/zrk11oA7wkcfw/RH
    n59BhLKj8oB+eVcqHok+NsXjN3GZpTUA7E4KMkpnHEOlSMIWNgjNEYw40f8O1Yfg
    eDuR+C2RAoB+5nV8GU6Tiys96hqcO1iaV1IRPBCDWUDVhf9stgynTZFhI2ztUeVv
    fWoHlcgq/zC3FZN7SJOq1O6ZeuJomxBxRTIDmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124581; bh=EV8PPg
    z52LIrRUmerfq9z2F8jm2emkc8tfj2aQmb4vo=; b=sbeSXy32JaT56ztLcrxVOF
    uthTu/abqPfAkwVXqUMheX/SARBXfKoMxMy7YN6nr8aOVL3kjZ3fcuRM7nUkEZC7
    osDEYhzjst+h28cfWx580GZtcNA2Dck/JryGhegKqDkKMSYUEKStrjJLHIBQFxQB
    RQ0k6TYZ+LY6jNgtF1xGAWPzlA1Hbds6lVhP5WY2F+6Q7b8xGMLmEsvoZybPb022
    4rGvdXZS4mhRVfvtcyTD+D10tuYlPiNzhWOAFi2CUbvgA2pMi/i/8zTtgde/hE6P
    G4DDql46A4IzVlxpJUvbr1k4UB0nNGvN/BcMXD3m4PvSOy4r8mMG1LrvctDJ4+og
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PyqcDl6r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PyqcDl6r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932288AbeCDAtg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:49:36 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:61181
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932233AbeCCWYX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 011/102] ARM: dts: koelsch: Move cec_clock to
 root node
Thread-Topic: [PATCH AUTOSEL for 4.15 011/102] ARM: dts: koelsch: Move
 cec_clock to root node
Thread-Index: AQHTsz5cWPlbuNqGc0SAtPQo2R4J6w==
Date: Sat, 3 Mar 2018 22:24:15 +0000
Message-ID: <20180303222318.26006-11-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;6:4x6OYRH3nl52FDiTdhs4uBFwR7IP+Vpp6z3XhX1k2J329sSjYc8+t5DMeB+ZqmHq7Zkb21x+FZhx75Ln+5yVeww2PWDJAebn8dTpM2ES0jSFN+ET4ZJLOMfSLBT82u+ojpzEFjfXKC90ZN1Nz8x+igK4+6xPo82sx2g27oQyCjVxp5e5IAXiG7k6DmP7Rf96cp0HYB+ON7zj+rDI2/xSy+FgbagnJMg25/YFCjwWPopNENROCaT6IfOPAvye1NiPDk2tnu+3aQITawB/Jq8WBKjEwogk/mnRgYszmmI3nLclpYcWlRceafRfS4FfrCs6MdDtusE7/VyVeMvrlZEHx/P77+KBGM7n+bkO+Hsh1t4f5u2tdVjpwA7/xld5OAKp;5:BgtiB8MGvotBOj0iQqIVpapMG9+DHSxKqSBPC/15tM8hXjef1+HI5Rxmxq6KDjI60ZcpglsNLU0KK5CiZcnUqQVdKfz4mq8HLET5Mr9JMLbib+z7ZLz9pDwcFi/s8eX/Q6+8JSUGbZXj1hIARbKESGTWQcDebtI/QgZCU+2uVEY=;24:DzEM+begvinLaiCjdpYjBcQWsHpH2YpLqU5iwcVbjyBXRRivDJF0ZuR6Yeu4MegnSMJIuUWkqRHB0l1g5WMfA1KKyWUqb0hHFOKfHYsT0Dc=;7:cIRbv9kUudXqz/PtsIrPlxbwOvML4u7IiKi2eOfSNkePs+7K/8njk8Q01/Lk6xTEjbfN5i0FkW2rkDvNT2u9spJJ+IAbSSJwTol0qqZmNS3RsjAJrTZrfofntJOzw+zsuvAxPJHrO2f5roiJgzB9DkKHt9go+Rv5sRezP7pTdBnOyTio/VUMZoxHLGt5w4GTMAhgZAY7zkEvYJXqwt/TdZpoQLTJCLMvQ0v5rTceBbASr6B+AB9NnK/a+OTydaWo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42a5418f-1430-4570-22be-08d581558245
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB08902CDA8EA6C416222B77F7FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(575784001)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: D1KAB31AInDn8m4g6GjgKxCu42G3frO148AxCl8WW8UKoWzuvwDoOW5g1X3LwNXBj0MikYoMVS2snmtW+LBUiANvX65YFKOsaqvio2ZcqvbK+LrKq4U25e7E2zG6+NjIvglVzZfoX0K9t5MRSrvzu1XzuPCyyVFT3n3iYKPiH20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a5418f-1430-4570-22be-08d581558245
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:15.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
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
index e164eda69baf..4126de417922 100644
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
@@ -640,12 +646,6 @@
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
