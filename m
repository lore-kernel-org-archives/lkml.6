Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FBCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697B2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QyJmipTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964827AbeGDIn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:43:56 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:37696
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934120AbeGDInw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGnOEjMy6m9pK4VdvtmEGko6wE9ZqW+BJ926GvXcK6k=;
 b=QyJmipTpLfuldKFgIG+jCjaP+g3v5V1rTqidPOvYobwaKLZbOkBqFbFDRR+j4AfFAHWDMXElRdO6lpH07mvXde5hBOoJ7R/jCL0FODzMrKPpWu66WknA7H8nStFCantoe/X5NY5sQv2Ftac2KkwuwTkYZXNP7TO52sA4wurN/q4=
Received: from AM0PR0402MB3396.eurprd04.prod.outlook.com (52.133.45.17) by
 AM0PR0402MB3891.eurprd04.prod.outlook.com (52.133.39.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Wed, 4 Jul 2018 08:43:49 +0000
Received: from AM0PR0402MB3396.eurprd04.prod.outlook.com
 ([fe80::f52e:b3b8:ad43:6877]) by AM0PR0402MB3396.eurprd04.prod.outlook.com
 ([fe80::f52e:b3b8:ad43:6877%2]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 08:43:49 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: gianfar_ethtool: remove redundant variable
 last_rule_idx
Thread-Topic: [PATCH] net: ethernet: gianfar_ethtool: remove redundant
 variable last_rule_idx
Thread-Index: AQHUE2xORLr/Ysc8ikSZ0nQqgRVo46R+vxTg
Date:   Wed, 4 Jul 2018 08:43:49 +0000
Message-ID: <AM0PR0402MB33964FCFB3C3F63A1966FBB096410@AM0PR0402MB3396.eurprd04.prod.outlook.com>
References: <20180704075455.16010-1-colin.king@canonical.com>
In-Reply-To: <20180704075455.16010-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3891;7:A/GSTSWdLJoCyZIUoge2vth62iQdtDgqvbx9hH2P/h0QmCN5Wf8Z4wpxt74EKMOgdNGA+X53qF80g9sGi6dRxGme7pOJ5HQrkJmM4ZWz/V8sqzGzclMAvDHn+m788I55DyPylA9wZmrakSuwpiP7+13GC7BMVjXnWl5swtxC1L1D/tppSy4LwS6zOrrhAFI5+D2YX38X/2FLsZQLT2if4wFkHnj2fLnG4bPixlCBX8HCKjnmqgEAIyyq53jxSTBt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94c94e90-12c0-4c3c-e59a-08d5e18a4370
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3891;
x-ms-traffictypediagnostic: AM0PR0402MB3891:
x-microsoft-antispam-prvs: <AM0PR0402MB38912E1811B39390E78AE9BC96410@AM0PR0402MB3891.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3891;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3891;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(13464003)(189003)(199004)(5250100002)(3846002)(229853002)(486006)(5660300001)(102836004)(66066001)(2900100001)(11346002)(44832011)(476003)(256004)(106356001)(26005)(6436002)(4326008)(2906002)(6506007)(14444005)(186003)(99286004)(86362001)(446003)(2501003)(81166006)(53936002)(6116002)(68736007)(8676002)(478600001)(110136005)(316002)(55016002)(8936002)(14454004)(105586002)(54906003)(33656002)(6246003)(74316002)(25786009)(7696005)(76176011)(97736004)(81156014)(7736002)(305945005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3891;H:AM0PR0402MB3396.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R3RvG5QndLl09WD2vUj7sSgmMwRCgQdwukekKdNo4HOK+YTB7DyavikmweDGzy86N9gf3Nw6W20rc9qWQVbVwt40+GAi1SZqHz/eD9QKeJ3V+RR9jxrE+9al5cSNlpy2mEBgMOI/7uTnPG4Y0NW/LTVI8TjtghFUOBpS+zCL4rJMhk5LNxRY4+hKkZjIwwkl9Yqgezmp7fh+t/sAuImNCA6+lS7RACWWO8LYK0VA0tHrxVlIb4VDEbJmJB3SQ+1BoN1ovgnfnQcqWq1q1B25L8yFyR02nyxkcdVzD/gjwO9f7vwywBjcJaYzqXFCenZUhJwnjWVU+LrGPRLewprYLF8eCXrb03pRXPJ4UB5mzjU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c94e90-12c0-4c3c-e59a-08d5e18a4370
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 08:43:49.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ29saW4gS2luZyBbbWFpbHRvOmNv
bGluLmtpbmdAY2Fub25pY2FsLmNvbV0NCj5TZW50OiBXZWRuZXNkYXksIEp1bHkgNCwgMjAxOCAx
MDo1NSBBTQ0KPlRvOiBDbGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IERh
dmlkIFMgLiBNaWxsZXINCj48ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmcNCj5DYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFtQQVRDSF0gbmV0OiBldGhlcm5ldDogZ2lhbmZh
cl9ldGh0b29sOiByZW1vdmUgcmVkdW5kYW50IHZhcmlhYmxlDQo+bGFzdF9ydWxlX2lkeA0KPg0K
PkZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+DQo+VmFy
aWFibGUgbGFzdF9ydWxlX2lkeCBpcyBiZWluZyBhc3NpZ25lZCBidXQgaXMgbmV2ZXIgdXNlZCBo
ZW5jZSBpdCBpcw0KPnJlZHVuZGFudCBhbmQgY2FuIGJlIHJlbW92ZWQuDQo+DQo+Q2xlYW5zIHVw
IGNsYW5nIHdhcm5pbmc6DQo+d2FybmluZzogdmFyaWFibGUgJ2xhc3RfcnVsZV9pZHgnIHNldCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+DQo+U2lnbmVkLW9mZi1i
eTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCkFja2VkLWJ5OiBD
bGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT4NCg==
