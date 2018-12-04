Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A81C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BE62082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="VCG+q3Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BE62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeLDPDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:03:51 -0500
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:14888
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726459AbeLDPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbSHLYsZgwOsV/ONdvuh9wDnhnHwEhuGWmh3MO5FwBo=;
 b=VCG+q3DfcVwVZrMSginjGeTTtA+inaIAZujC4WrA9rRCzusrn0ldyr32Fkm9254q9tdCuAg75tXkYX0jjlnhZMF+fGEfKnLQu2hltoSNGUkOVvC+hrQOjKwgBNVZTHlN7iCYaUNfciuVNehmRGbMQIkhgsvlhiuCqTSufXYMTVQ=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB3961.eurprd04.prod.outlook.com (52.134.107.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Tue, 4 Dec 2018 15:03:38 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 15:03:38 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio signal
 polarity
Thread-Topic: [PATCH 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio signal
 polarity
Thread-Index: AQHUi+KJzGJC4e1HO0aaWQb3uyYgIA==
Date:   Tue, 4 Dec 2018 15:03:38 +0000
Message-ID: <1543935806-94880-4-git-send-email-michal.vokac@ysoft.com>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:203:90::21) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB3961;6:X8FtMiUMslOangGSNI/mqJEUUIIR3/N4rpcda6tYp3hZ+ytGk4ETde0nVYC32i91SdPEyjaNcnIOyV+2YGdtV45hNn9E/YyFopwaLFiNAx64w6XBgCUi4JbtOemudii8TQ37yzTXs+x3b1kI7qv8RF0AzMhq2Vlx21GprpTKr3wSsJr30Xakobus8YNDHIZFu+zzLORx+5mOWN07Z43vEM7yEjrrUsePbe0G9CIn2D5K4LCPMZAFAfEy4i2ufrJDV1JUVoz00SdbGC/uRyz23Zcdm3leT4iRzbPrWv6d/hcNpiENGZ+JaPH4nISfB2HGqIDVbln/bvaJ2+y3gmImxxDbA7WoDE0QZBMh8IdQk9ukkiM7sOSGOWd8OxIZ3hcHYU+9vOJAY2MFe0LJ2yk68ctxDQVN+s9OmulBEjYOnMx8sBv86QYMkKfnv6TKMDjPxdVKrfV9qgzV1T/J+SQcZA==;5:aYxpZAc8Poi76wT38OkR645GeYv7Ib/qnUk3AKCDnAGdsqju/IscrOhhNFRMWyLp5D9SGeY0OhncgvOZXmogfjpwiTBrs8Du4afy4T3c7JrLcc2mWQwshcLskRQEtEWP1vvbQWkoYRgg1jkKuR1i05jtcByaYxOaVUJP7oPGQd8=;7:XSmLA64M2xE5zyv1PK3cbSrbpeizcXUSo7vd+l5nU1EIK3WWsV1uOgvmyJJw+jAa6iYT6rIVZbvpZJZshQ0qIW8/pFHpt4HqP98xKHfaMt24J7P+lihFslm5hVHZWnOoBO0LMHID2eS+rT/mG7Swig==
x-ms-office365-filtering-correlation-id: 3334c08a-849b-4898-980d-08d659f9abec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB3961;
x-ms-traffictypediagnostic: DB7PR04MB3961:
x-microsoft-antispam-prvs: <DB7PR04MB396145CF8E0CE58A2C86019F9EAF0@DB7PR04MB3961.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB3961;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB3961;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39850400004)(376002)(366004)(199004)(189003)(6506007)(305945005)(386003)(2906002)(105586002)(186003)(2616005)(14454004)(446003)(81156014)(8676002)(86362001)(11346002)(106356001)(4326008)(6512007)(486006)(102836004)(6436002)(256004)(14444005)(99286004)(476003)(81166006)(7736002)(6486002)(66066001)(478600001)(71190400001)(71200400001)(26005)(97736004)(25786009)(316002)(52116002)(5660300001)(54906003)(110136005)(8936002)(6116002)(85182001)(76176011)(72206003)(36756003)(107886003)(3846002)(53936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3961;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XuxYZD+0EXxjxBg3qnvr6QnV1ZjpOODyx/dnsz2ccTE8DELPTp0FVR7TIIwKpHig3v117J2oQBa6DhZbuq1zdDCr1ua3GxDtHGeZEHD2uxuonkvjp1YXlRInDt8lLOa8lNkzHVnW/+fRlVgKbpi9WJnGwJtHIbaQyMYUC/ZtG6yI6AFp4arvekQ4l8nFrh4k24MV+x9HtrAPgd67JXy01YOD3uQGfy0BxgBHzkzmY5yY2vfXrZ1BF95j+av4R+Aby5hmMApTzhvUA2k7CU6gtbwwm5Pbzc9FYcHzdq99Qvm6ue636tbreAcNZNTT1/hduAsU7VaR9CA6FKDQPsUMW9duHOGFELrJcdR585OEzfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AEC70A3473AB748836A0F1C4C24A202@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3334c08a-849b-4898-980d-08d659f9abec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 15:03:38.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlc2V0IHNpZ25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkg
YWN0aXZlLWxvdy4NCkFkYXB0IHRoZSBEVCB0byByZWZsZWN0IHRoZSByZWFsIHdvcmxkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0t
LQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cyB8IDMgKystDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14MjgtY2ZhMTAwMzYuZHRzDQppbmRleCA4MzM3Y2EyLi5kNmVjYTMxIDEwMDY0NA0KLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRzDQorKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMNCkBAIC0xMSw2ICsxMSw3IEBADQogDQogL2R0cy12MS87
DQogI2luY2x1ZGUgImlteDI4LmR0c2kiDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bp
by5oPg0KIA0KIC8gew0KIAltb2RlbCA9ICJDcnlzdGFsZm9udHogQ0ZBLTEwMDM2IEJvYXJkIjsN
CkBAIC05NSw3ICs5Niw3IEBADQogCQkJCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KIAkJ
CQkJcGluY3RybC0wID0gPCZzc2QxMzA2X2NmYTEwMDM2PjsNCiAJCQkJCXJlZyA9IDwweDNjPjsN
Ci0JCQkJCXJlc2V0LWdwaW9zID0gPCZncGlvMiA3IDA+Ow0KKwkJCQkJcmVzZXQtZ3Bpb3MgPSA8
JmdwaW8yIDcgR1BJT19BQ1RJVkVfTE9XPjsNCiAJCQkJCXNvbG9tb24saGVpZ2h0ID0gPDMyPjsN
CiAJCQkJCXNvbG9tb24sd2lkdGggPSA8MTI4PjsNCiAJCQkJCXNvbG9tb24scGFnZS1vZmZzZXQg
PSA8MD47DQotLSANCjIuMS40DQoNCg==
