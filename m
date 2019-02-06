Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5B5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F62520B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="mDJgQykq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfBFLvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:51:55 -0500
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:18540
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfBFLvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peUvpn4N52/9KLNufv1SmvLN0gy2ijEuEc3SBKKUc6A=;
 b=mDJgQykqdcMk2JBNuJFvpdqBHybIa/4uRoQ8MKEkqkKyOkFuhkR6/aTXJzYEMuLRKuH9l5W12/qBTWofwtvRlWkYhfrT/F0paRPerS9EJ/RYQYMfxuVpPGbBD+QrzbD0M8oJ+zLp3utZComfrb6FnefXT0BU/J+RaBlfbUuyTLY=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3577.eurprd07.prod.outlook.com (52.133.6.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 11:51:50 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.006; Wed, 6 Feb 2019
 11:51:50 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 4.4 "rcu: Force boolean subscript for expedited stall warnings"
Thread-Topic: 4.4 "rcu: Force boolean subscript for expedited stall warnings"
Thread-Index: AQHUvhJYdBiWAvquH0CQVvYSd9u3pw==
Date:   Wed, 6 Feb 2019 11:51:50 +0000
Message-ID: <25bfaa1ef3f24272b7351f409e69f2f6a05f11c8.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3577;6:nku7Zs82pO50V4OOHtgL6he/T7JE8rbf0w51EUFkU4iV7WZeJIsWkvb5XxNxWEZL0h1CXs23VJvEAyKr8R1OzWSYwJW3WHBauDM/YIbYd12r843wk6CxB6fmiyk5Vx8B1mPskn19C6aZXGmJUEsYmfRtbA30gcAvmf3gUxJG04FtGoU7uRTfFMKoQEcU+H/j4HND/Z1nfTXeIZQWhzTOEpHtaIaeNijimEgBL6urZVSAbE0RTx8kUH90xUW8xJTuZr1fMj6v4blVxYqrTrUSDLTnmSIwZ18LonB8Yi7N9CzXlHkpL7y7sZJoY8n7R+mksmwVWZizqJG+KcZHe+qqWmDPHuI1VjP0P15Z7QEaT8xdfGfXlRh5/oQKxm5coE6vNS9hm+0PJw5gI/0OG1UYkTNeuqUGV2m8tqxTGG8O1HkK9VhWGddrZ30yYymUmiYjWyr4OXsbCNTZkD7Ub5d6Sw==;5:1GQ/wCYGeNwwO9xvU/qaLg4xVkACxnBhpGM2OLRIipKEgq3S1NA+t7w0JIqzzcvndD+H8EXg31tfGoFxerudqZFqUzy7vvSlIDQkUhQ/gYUTXKPseumQOzucW+K285y/QpKzOzZqdNbAKX8kicOsmKA1O1s9uqMZE68u+yyR1UrQ5IS1v2JvfUzSBFdwQWddiafwVnosGCQuRetvY/0hxg==;7:Vh/TD7pi5NMggj5PJGLuZAbik/DvQYvOwBxGgyFSSNoXhKvlcroByAj+7QvYnRHi12/LBzGl0tUBBX0Egm7bh73RH1Z9IptilqPGMR4N/NIYo3tFEtkl0eki4OVSU38BRYb8gS4NMB9ZZJR4HvB1YA==
x-ms-office365-filtering-correlation-id: 23e0ead2-86ea-4d04-25d8-08d68c297b13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3577;
x-ms-traffictypediagnostic: HE1PR0702MB3577:
x-microsoft-antispam-prvs: <HE1PR0702MB3577CA0DBE099949E4479A2CB46F0@HE1PR0702MB3577.eurprd07.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(256004)(86362001)(7736002)(6116002)(68736007)(1730700003)(478600001)(3846002)(6916009)(305945005)(71200400001)(118296001)(71190400001)(106356001)(2351001)(14454004)(66066001)(81166006)(81156014)(53936002)(99286004)(6512007)(8936002)(6486002)(2501003)(2906002)(316002)(558084003)(105586002)(2616005)(476003)(450100002)(25786009)(486006)(6506007)(186003)(102836004)(26005)(5640700003)(36756003)(4326008)(8676002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3577;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +trFkBZbIFmuyXXIAVM/F3hYxC/f5YK72bfDyIUWXALnYOzjATdA7f4+rwTBIlBztwZ+GOE60qo4I0l3hqpcBjELXAyohoZ3CZCVw8ciG1jiLUTVEmXDQ0Rq9gRybmqcUED0GVmo/7fR/S9M038uBWivtoVqfQtlXQ64IoNk0Sb/Den96hllDC2vF5ej9sYEg6GtfhBnyc91krXTsMu+tqSAEcdipnoRPlM8hcCg2rDmnMispwuXQIHi6axGTbW6Khi4l7O+TZ9G3qI+uLQL50SUcyDfPDyb/Tykwll9HaX3354qaMTJojVHHxDpQq7eL6kbPhNZJ2QNiTQTfGrho83KB6MEzNlPmvyWqMrEcUJthLdNclh6OdI1yoBVjsDgn+m69XMM9CGq1vg0CGw4aUCApt9osLWHo07qI4ctAX4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD09EC832370F746B754CD406D5BDB39@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0ead2-86ea-4d04-25d8-08d68c297b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:51:50.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkNhbiB5b3UgcGljayB0aGlzIHRpbnkgb25lLWxpbmVyIHBhdGNoIHRvIDQuNC55Pw0K
Rml4ZXMgdW5leHBlY3RlZCBudWxsIGJ5dGUgaW4gUkNVICJleHBlZGl0ZWQgc3RhbGwiIG1lc3Nh
Z2UuDQoNCg0KY29tbWl0IGVjMzgzM2VkMDJhZTZlZjJhOTMzZWNlOWRlN2NiYWIwYzY0YzY5OWUN
CkF1dGhvcjogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BsaW51eC52bmV0LmlibS5jb20+DQpE
YXRlOiAgIE1vbiBKYW4gMTEgMTY6Mjk6MjkgMjAxNiAtMDgwMA0KDQogICAgcmN1OiBGb3JjZSBi
b29sZWFuIHN1YnNjcmlwdCBmb3IgZXhwZWRpdGVkIHN0YWxsIHdhcm5pbmdzDQoNCg0KLVRvbW1p
DQoNCg==
