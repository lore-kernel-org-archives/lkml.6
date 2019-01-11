Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC6D20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="U49Cp62k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbfAKPTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:19:18 -0500
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:61900
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387562AbfAKPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUOnBhYJMQ7pORitcJBaN8XwRERN1bvAFiYiqt6oPWA=;
 b=U49Cp62kO0gckEPuWUO8z20GkP0t2FFD1a9fePkkEPMEDPCbz7HP1XIKJSksRxZA4V9K622jeIrbreAeSYoJNcRI2FSJL1IJ2V8TGORutPjKN4PaCiyiRqDhQoRdFi4GWfJ6zDGC0tXAGT8PhTwwH/Uv8lqZvmGgprRNiNP9N3I=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3735.eurprd02.prod.outlook.com (52.134.113.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 15:19:00 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:19:00 +0000
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
Subject: [PATCH v4 2/5] dt-bindings: display: bridge: lvds-transmitter:
 cleanup example
Thread-Topic: [PATCH v4 2/5] dt-bindings: display: bridge: lvds-transmitter:
 cleanup example
Thread-Index: AQHUqcD68keahuwQd0GsfPVB1wR5mA==
Date:   Fri, 11 Jan 2019 15:19:00 +0000
Message-ID: <20190111151843.11114-3-peda@axentia.se>
References: <20190111151843.11114-1-peda@axentia.se>
In-Reply-To: <20190111151843.11114-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3735;6:6zr0jQDXVK92jEJuP9RJKJbbnoYCOFxKjnOQp2Y1BKpZZ1yqEvspDHesYpTTLDbHxSjls/0aBfoQPl/pEfWKjmjpnCJjpP7FlmxiwX/RhAVJg99GHoVBCbHLXDMpygEaJ3sOi6uLLUefhmK4xhIjjvBUsDULl+D6yHSI/95GZyqeEyEtaC3Wd9+lxIRTNMJJyNbWI0jMdqBc8dM44+VMZYjrMpNU/TxW/SapkzSxxlvKPFGInmXTcuVVjFTih+u8pd0aADVUkUYb/MUSzV1Cs4jw+89xi/Uc7IqGUWGPI2pN83vK06qfF+xXSyffSRav+ndoV74arlGcznctOd+7DHuZidfGgdKbdtrxldaEthx6wVtCY/tJYtEFMZWL0+lL7wqoaR1RHVXojoc58isvxUN1oIiADmANG3+EXNF9DPyQAdmC6QRgvi5QDtfXaPhsLLX820wBmxgAdIMfeJEscg==;5:uw2qpdZVZkpf1fVNA2nKokC/oh98yDHP5gVZ0jfar6BvS34elMfRUthitPyFejMZkSPcL3sYzeRLHDspZaJ6WnlmUo9sJ/VsD1QOcl5ICK1BSgIs+Z88WpsJ63QExpi/p7yGoGDEOUWz4J+RPxs3WoJ1QyeO0rIgS2G3OGR1LPaCSw2AmCPJ39fVsET71CYDNcHfF1g/Igu+AgsStilmww==;7:ZX/shmbdCRihabcNFdC5VS6youYY2L0Qg6y9aj4v6iEDbGU3qldrYkUAtXNw5gYjFLtY1qtSNrYKe+s/u4utAx4l8ZGnEG4mHXJZmPtWTYtem5Q6bSuO4mg46UZE9szNjSjsmMvb67BVOoPSJSwobw==
x-ms-office365-filtering-correlation-id: d53a18bd-18cd-44e9-2af4-08d677d81cdf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3735;
x-ms-traffictypediagnostic: AM6PR02MB3735:
x-microsoft-antispam-prvs: <AM6PR02MB3735D27D88E52CBEEB8F4F07BC850@AM6PR02MB3735.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39830400003)(189003)(199004)(2501003)(1076003)(14454004)(99286004)(54906003)(508600001)(5640700003)(68736007)(6436002)(97736004)(2906002)(71190400001)(2351001)(106356001)(6486002)(316002)(105586002)(71200400001)(86362001)(386003)(6506007)(102836004)(66066001)(6116002)(52116002)(76176011)(3846002)(6512007)(53936002)(2616005)(11346002)(476003)(446003)(74482002)(8676002)(81156014)(81166006)(186003)(486006)(256004)(26005)(50226002)(8936002)(305945005)(7736002)(5660300001)(6916009)(25786009)(4326008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3735;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3AbQo0G/7YL/K2jMK5Jk7Lxcdw2alsry1jouslqiLhZPUYK8WQ1CwdCXUcVTQzJlabdpI8Pl0am21CHnAG6/D1vbS3FHQfsp+DKhxktcYV0IX5ymN4JY1xcIXu6O7T7CFPrskJX4Ud5GllPRi62A2XP/sEM0misoQeDx5UA8XQPP/5fc3MLUF/aTU+eNsDoUNAliNsnuaryIbVtJtY7KeYWyhION0JILymReLC1WNMebmnDgY5QZhNfUppOWCfSN6xGCWZc6KIX1b3uIoJX2hLFG4CB1+T9KBkxSs6kXASilDqyYojk/np3Y/XcLW0FiOVlA7sn8CugxKYvNQOrVhJ5Dw/tY5H6N33KEstSHymR15Y+XuSWCKzdyL7k29ccyg5wWPlEMC7azdAVSpakinnhZR1kbbAaLLFMVScHJrzA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d53a18bd-18cd-44e9-2af4-08d677d81cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:18:59.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3735
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
index bc6960741cb5..60091db5dfa5 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -42,8 +42,6 @@ Example
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

