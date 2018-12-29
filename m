Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD81C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D452146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ozXjwbYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbeL2HID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:08:03 -0500
Received: from mail-eopbgr40105.outbound.protection.outlook.com ([40.107.4.105]:18848
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727833AbeL2HIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsIjwdZTORlBRxhvupliRoLmentv63VsFFFd7ur4d3c=;
 b=ozXjwbYHz68CHuhSRMzefyLt838mZNukjEjCLo6JpIls7uGnECgzdIteewyv885DSOfHzHScvJwTvJqCa6lnNGniy2DbYQSao+UM9e151IKY2Bx2Wt9VDTCA5jdh9oxPP+GyiltoQkfd9jHjR0zEtF73vq7qqP9sjJd1cuBFjBk=
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com (52.133.34.148) by
 AM0PR0202MB3459.eurprd02.prod.outlook.com (52.133.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 07:07:25 +0000
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422]) by AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422%5]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 07:07:25 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/5] dt-bindings: display: bridge: lvds-transmitter:
 cleanup example
Thread-Topic: [PATCH v3 2/5] dt-bindings: display: bridge: lvds-transmitter:
 cleanup example
Thread-Index: AQHUn0Um/iP7IO6lR0ueJlfs1GZeJw==
Date:   Sat, 29 Dec 2018 07:07:25 +0000
Message-ID: <20181229070649.21308-3-peda@axentia.se>
References: <20181229070649.21308-1-peda@axentia.se>
In-Reply-To: <20181229070649.21308-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To AM0PR0202MB3267.eurprd02.prod.outlook.com
 (2603:10a6:208:5::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0202MB3459;6:Ul0jcO4Zw7uhBfskOkd5gjK+GqUy3nGXXe7fKCTLknynkcxR7QyECRHXoS0Pj3EbQfqWbIONNn6eKw8E2JX/517U2NzLiafxyZNPKXHIedXmI27cVPZp9N2xjm0SVvIhW3k1L9RktktT2el9mRfGV93wvB4LidiZwJ2sS6UQz+VsbSZhGY8uEBhsC/NVBFaU+74VIal9A3kyHyITSlhtedfgUud3c23qKo/yU9ac7+FCfFwALXylMp39jMWPnvg1UHUKtJ1A9Eb67Ck2zkKW7Y4992B1pdXjfVmdYi2yYd6na0Si8kDbF00fqN+uP6ho/pqlqLUmQa+1VFqJvT+rqbKl6jZ5l2ur2A+G5ns8GmjXttrKz3/6nlYA68zZOMATh0AmreWKTi1rSMh8Sk1J+qEzNTuDvmHeNnfmkpBFlvNtzAjFXAGZWs5nOlobKbrLERcv4SHmimCud6NopteVUQ==;5:/R12PXWEnLmSfJhxZsJctKL8uK5avnrM/w9iyQCIjb3G6Pxv2KMi+ql/aUM0ufc9O47FkVxYIgvBC2MLWZ1MSFmrevgD0f2/dogD3L7iFROvCEQQk+GkuUxgiYcrZKx0zXDuz3DkdpygRFCyW7BJzz/QFTvjftrAoFM5V9D11Vo=;7:zVcGEqZyBTfyw1cLAhFoKOoZXt/6if/81Wc50F2e7ctvLnrUzAhOAevCEQ4ZGAA6jCLeH3e/4ZikEFR31fTvwLzRGx7GRWI4Cb8dzlwAC+mJYxUMo2QeTdikFTjM1U/yHY145EjeWWX6ZB8WAegXeg==
x-ms-office365-filtering-correlation-id: 9e986097-7a36-4343-dbe4-08d66d5c491e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3459;
x-ms-traffictypediagnostic: AM0PR0202MB3459:
x-microsoft-antispam-prvs: <AM0PR0202MB3459D73BCF24C1252FC24B81BCB00@AM0PR0202MB3459.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR0202MB3459;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3459;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(71200400001)(71190400001)(66066001)(6916009)(305945005)(99286004)(8676002)(81166006)(106356001)(6116002)(6436002)(81156014)(7736002)(2616005)(1076003)(86362001)(2906002)(6486002)(8936002)(476003)(74482002)(54906003)(3846002)(256004)(446003)(11346002)(486006)(68736007)(50226002)(186003)(5660300001)(316002)(36756003)(14454004)(6506007)(6512007)(508600001)(76176011)(2351001)(52116002)(97736004)(26005)(4326008)(5640700003)(386003)(25786009)(53936002)(102836004)(105586002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3459;H:AM0PR0202MB3267.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EneM4bsWQwflGvr/1vUUYoPfFDJbk9s8PTVBOypCFCnX67sn7WIkeelo8dTV2ZY/ChGFfFZBCKV1QXtRWEsknnEJax5TE2KTRauFWHO2/jhCK9qTNU/aztAMUsHios/6gavU0S4SrFpcDic+kgrLUT8Ft5bfjqbpWO1n18f4oksTmAHewCSFNz7cjys3L4vCAU97uwBcWeBibAx7OgLRUOYF3w++hakKwJf4S0tD6OUPFphZkeGYOE6i6C1/h9Qhf6bc5qpgdnqs+P92yB5n+pHG5RbYPx6FwO5/xkl35XGCHN+gyWniYS0BKkIXfx8I
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e986097-7a36-4343-dbe4-08d66d5c491e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 07:07:25.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop #address-cells and #size-cells from the root node in the
example, they are unused.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 2 =
--
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmit=
ter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter=
.txt
index fd39ad34c383..36ce07c8d8e6 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -38,8 +38,6 @@ Example
=20
 lvds-encoder {
 	compatible =3D "lvds-encoder";
-	#address-cells =3D <1>;
-	#size-cells =3D <0>;
=20
 	ports {
 		#address-cells =3D <1>;
--=20
2.11.0

