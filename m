Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E12C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oq1w8LG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeLSMml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:42:41 -0500
Received: from mail-eopbgr80138.outbound.protection.outlook.com ([40.107.8.138]:60152
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727613AbeLSMml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apGt+XtV0MI7kiMokTRvCMV9IWX4fN4e2Ba7tzHE06c=;
 b=oq1w8LG1uwP2/a9X4sPZuwJcBQVzEC8XXfToyDxW552myOaTnmyqAtwYqvvD2BCE8jdxm5rtlZLjod4HhKpWYqTEfwOQhufrDayBJ74lY42Yf/ZQrIPt8e6Z0E5oMecwjHp1+BfhoXqS6IZWpEtASrjlggHkPs5mXwpItx14e6s=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2702.eurprd05.prod.outlook.com (10.172.15.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 12:42:36 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5808:701d:d1ac:9df8]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5808:701d:d1ac:9df8%5]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 12:42:36 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Topic: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Index: AQHUl5hS3YQwM2HAUkyF1f0Av+JOLQ==
Date:   Wed, 19 Dec 2018 12:42:36 +0000
Message-ID: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2702;6:ggct2AESZpc6aC8GUupy61ttqryXkEsHYmUxirTS6pUTB+n5P+UB99NWMIHlEh4g/kq2KhIxZuJsXLvliTRg91FVw6/APr7otWQRrq2eKs2DMpba/7ZKYyRu7L7uKuodjAspUDlz6PuG4FgnULI5pIS3wd7SWyhCFP0g0y+yFqhh/kyglPM1gZUFSTCi+dvTN03mMHpF2ZsTlDqMltpP1PIzSq5aZk3tGYXtp4GbLAddDTyY/4gu11O/dqmDZ6gvozJQx1qCnS0bb2/+8G9Yzf3cqauNTBa0ILdK9KTMfYe5OtuQ3i2Pw720Tm2JTvvaHV1dvk9+V2jIbWDC9QqdqMZZunhXDK4hP9QDVQGh7ZaSlB6Orl6EM2JMv7DJ4yGGWUjiPSJuy6KSy4cRgS5h8dIwpDXppwCCN4BmV+wj9Nqy/eoONRgHxC6hMR9XVkUEQZCDAI53Wn8AcWowpbKoUA==;5:siBi8NQMmxnO/W9XApUq5K3ayPPKigCoDY5WJSo/OQMgbHWdF+sLoGK+jxaMLvNWEwtAQ+dLU/Rm7UzgBiA6Ox/iqWQxOLvaMvlg9QKXpE405Cnz6z1VASAZRjdvh7Gc/8kJ6p5FzgqUhJktrdO2zlEa+IpKfgEwhzxSsFFNJZ8=;7:GlK4wGt4aUrtRNBQgS9rRN/Lg9+zfZzp9ZEmSoa2w/iKFjKtBayggNeTH0qIjayNhJeeD7zmzS5WJnXxwcTf7o0RTP5/oRlVE+S11J37CryffJ2eD/bK1mLKtUrJULvHmd7fzzmZOjEiGHIQtUpFvA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 57f82807-f763-470b-69cf-08d665af7493
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2702;
x-ms-traffictypediagnostic: VI1PR0501MB2702:
x-microsoft-antispam-prvs: <VI1PR0501MB2702C2F31A974D8709CF712BFBBE0@VI1PR0501MB2702.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2702;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2702;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39850400004)(396003)(346002)(199004)(189003)(6506007)(7736002)(71200400001)(8936002)(71190400001)(53936002)(6512007)(256004)(86362001)(4326008)(68736007)(81156014)(81166006)(8676002)(36756003)(305945005)(316002)(6486002)(186003)(106356001)(476003)(110136005)(118296001)(105586002)(486006)(2616005)(5660300001)(6436002)(66066001)(99286004)(97736004)(102836004)(44832011)(2501003)(14454004)(508600001)(6116002)(3846002)(25786009)(2906002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2702;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DN+r3yZV5t7nt0pKLbpSD/GGzT9GZb/ZRXaR4Vwv1ZJoV3wt/4/cHkbtJiqYrAQjxjw6lN9nZqu4/4yC6C/mjfR+SfxA7wVm4bNP4u/Yi9wO/VLSJr/gIzngjBX9WidyJoLbuK9pgpyUWSD25y+yIqACgZ5OomWzruH2hHaoLblEgk3StvYinZZS6ifckmuqn9VrasSyRzgL0CmfLXD4e/YqzNKHVL+9sLThRcuYpHTAezCPGviLJC2C0c8juwCE4iGzTxbDhl4qHTjHHil5dIKkjrz/1+bGPaDE5MPe1JWcGmV7V4tI3f2YWbqFsaBk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0957F275A88F98419DD656D789A17155@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f82807-f763-470b-69cf-08d665af7493
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 12:42:36.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgdGhlcmUNCg0KSSBub3RpY2VkIHRoYXQgYXQgbGVhc3QgdG9kYXkncyBhbmQgeWVzdGVyZGF5
cyAtbmV4dCB3b24ndCBidWlsZCB3aXRoDQp0aGUgaW14X3Y2X3Y3X2RlZmNvbmZpZyBnaXZpbmcg
dGhlIGZvbGxvd2luZyBlcnJvcjoNCg0KICBMRCAgICAgIGFyY2gvYXJtL2Jvb3QvY29tcHJlc3Nl
ZC92bWxpbnV4DQphcmNoL2FybS9ib290L2NvbXByZXNzZWQvaGVhZC5vOiBJbiBmdW5jdGlvbiBg
cmVzdGFydCc6DQooLnRleHQrMHhhOCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9faHlwX3N0
dWJfdmVjdG9ycycNCigudGV4dCsweGFjKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19oeXBf
c3R1Yl92ZWN0b3JzJw0KDQpIYXMgYW55Ym9keSBzZWVuIHRoYXQgYXMgd2VsbCBhbmQga25vd3Mg
d2hhdCBpcyBnb2luZyBvbj8NCg0KVGhhbmtzIQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=
