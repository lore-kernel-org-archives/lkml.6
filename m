Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84762C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F12082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394F12082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJCHJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:09:34 -0400
Received: from mail-cys01nam02on0117.outbound.protection.outlook.com ([104.47.37.117]:2272
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeJCHJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:09:33 -0400
Received: from BY2PR0701MB2070.namprd07.prod.outlook.com (10.163.156.148) by
 BY2PR0701MB1973.namprd07.prod.outlook.com (10.163.155.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Wed, 3 Oct 2018 00:23:33 +0000
Received: from BY2PR0701MB2070.namprd07.prod.outlook.com
 ([fe80::d9db:102b:91b6:ea92]) by BY2PR0701MB2070.namprd07.prod.outlook.com
 ([fe80::d9db:102b:91b6:ea92%7]) with mapi id 15.20.1185.024; Wed, 3 Oct 2018
 00:23:33 +0000
From:   Mansour Alharthi <malharthi9@gatech.edu>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: tracing child threads with address filtering using intel_pt
Thread-Topic: tracing child threads with address filtering using intel_pt
Thread-Index: AQHUWq9Rgb8I0zUKEkSzBs1gUWwWBQ==
Date:   Wed, 3 Oct 2018 00:23:33 +0000
Message-ID: <8fc78808-db61-2f41-180a-9713178e22f6@gatech.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:301:4b::14) To BY2PR0701MB2070.namprd07.prod.outlook.com
 (2a01:111:e400:5335::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:c0:c380:8c9:b98f:24c5:198e:6987]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR0701MB1973;6:/vZZ8wlUqHHDCA4gNEo6IZBqcQ094/aEKKOFhdFycvb0rxPnvD4r1cGg1D05ts9KDCOPGVmnPYTArLcsJjUz0SmSZ4S2w6fTmb+oR3IHaKBvcnCCokabG6k8zEW8u3retlHsDZpraGP9HN0OWO0yqzDpo4IZi5ISRE05D2EnvyYXCZm02oEyezf5h9iy04ZOAG4WVoOK2SaIf8d80VX3Z6gKHCNnQfYnuAYB42aKWBIzLSxIOKjfL7EzPm9ZqaR3f/a5dCanS9CquWT1HUDpAR6Oiq7aCRRHeOIqjFUEEcc2rT6d+RkMMqk8TS0k0WDzxqxsk2c9oH3Eb3fG2N5TvmIxmJr/fnkbb4sXNDfA/2DHFglhXy4YQhn147FFZYJv8E/koml+S8bVKuG5zRqcZwLrLBTzzQzqZtd0ue0QyIBlvsQcbppLLH9+jQ/eFndOmkDLoZ1cal+k2yhkBpk6iA==;5:NyNtNJP61+Ig49mcjuKVQGcSEozhlECe/L2Zi0lEuQCTZILrJu/3QcSdgQkRI3ESSbRsQ/Z6hMxzO/AM8yeTWSpCDFUT9ti0Y8bQKbO0V9w+tOKjMyyNTcmMl22X8F6PkYPjOsLTajYi6oK9jp+2ZHZbgid1L5Di5uDBm161OZ4=;7:uBSh6nZqNcubO1oLQAS7ZFupc4eWyHIsa2Yp1WsswiHaKdRiXUvXxWaBJMrduJCcZ6er3rgFskykuEYUK0VCZQbP7XTulpXCumnD10SSshm64KC4HbQyxR3K2T2+DPdanem+8sWmQpZaSRPsa/zWOWyhBth8TxpyRgNb5VecweMZGPjdN6ipCnlhHIdHRGU839APEuQstyiblprAwhr2ionjbzVDobeElnxu2gHQx5t8yeLFqhP3wRW3xsxzsQKt
x-ms-office365-filtering-correlation-id: 1b415bf5-0c1c-4c2f-e972-08d628c673da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0701MB1973;
x-ms-traffictypediagnostic: BY2PR0701MB1973:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mansourah@gatech.edu; 
x-microsoft-antispam-prvs: <BY2PR0701MB1973D2A8EA65B5208E5B69D0CCE90@BY2PR0701MB1973.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:BY2PR0701MB1973;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0701MB1973;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(53754006)(189003)(199004)(2616005)(14454004)(75432002)(25786009)(478600001)(71190400001)(4326008)(6116002)(2900100001)(2906002)(71200400001)(6486002)(7736002)(305945005)(6436002)(97736004)(186003)(53936002)(6512007)(476003)(486006)(5660300001)(31686004)(316002)(81166006)(105586002)(386003)(6506007)(88552002)(110136005)(99286004)(46003)(81156014)(8676002)(2201001)(8936002)(5250100002)(2501003)(786003)(52116002)(31696002)(68736007)(102836004)(256004)(36756003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR0701MB1973;H:BY2PR0701MB2070.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: gatech.edu does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oAmljhFrKjhgPZVvXxFcY7zAlaMahTJ9mokeTMlFIiPaLlpoW60tTSbs6o9/9ZdRoZ8dlJmRKHs/E/QsZkxW/xPhmjWsHn9kT5eIQ2Vu1QDUY+T4VbhsGjoTaNxUOLvyVtXKPeJ96DVjYpGZkWUj7pB1BKDdDYzybHjuOkCDnk0riXQo73JmkHbVg3ciPfbhOcLKuBLD7UIjlFenjYhMj4n1zjoyIoC9XLw/1ZchgdL6ksITFYU247pnHausr62whyovVES4z8Gz4kzmXSs10C2AgXpgpJ1MXIPZG5rHb41iYnSRbso7Ub7NVSdVCCGj2hNMiCaTsdLDC6RZcTq/Epboh9HpfSF3nGQ+nG8Y7vs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3831072D8BE68344BA92359B00F6D13C@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b415bf5-0c1c-4c2f-e972-08d628c673da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 00:23:33.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0701MB1973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gYWxsLA0KDQpJIGFtIGhhdmluZyB0cm91YmxlIHRyYWNpbmcgY2hpbGQgdGhyZWFkcyB3
aGVuIHVzaW5nIGFkZHJlc3MgZmlsdGVyaW5nDQp3aXRoIGludGVsX3B0IC4uDQoNCkFzc3VtZSB0
aGlzIHRlc3QgY29kZToNCg0KdGhyZWFkX3N0YXJ0KCl7DQouLi4NCnRlc3QoKTsNCi4uLg0KfQ0K
DQp0ZXN0KCl7DQpwcmludGYoInRlc3QiKTsNCn0NCg0KbWFpbigpew0KLi4uDQpwdGhyZWFkX2Ny
ZWF0ZSguLi4uLi4sIHRocmVhZF9zdGFydCwuLi4uKTsNCn0NCg0KDQpUcmFjaW5nIHRoZSBhYm92
ZSBwcm9ncmFtIHdpdGggdGhlIGZvbGxvd2luZyBjb21tYW5kOg0KcGVyZiByZWNvcmQgLXYgLW0g
NTEyLDEwMDAwIC1lIGludGVsX3B0Ly91IC1UIC0tc3dpdGNoLWV2ZW50cyAtLWZpbHRlcg0KJ2Zp
bHRlciAqIEAgLi90ZXN0JyAtLSAuL3Rlc3QNCg0KUmV0dXJucyB6ZXJvIHRyYWNlIGZvciBjb2Rl
IGV4ZWN1dGVkIGJ5IGNoaWxkIHRocmVhZCwgaS5lLg0KdGhyZWFkX3N0YXJ0KCkgYW5kIHRlc3Qo
KSBmdW5jdGlvbnMuLg0KV2hpbGUgdHJhY2luZyB3aXRob3V0IHRoZSBmaWx0ZXIgZG9lcyBpbmNs
dWRlIHRoZSB0aHJlYWRzIHRyYWNlOg0KcGVyZiByZWNvcmQgLXYgLW0gNTEyLDEwMDAwIC1lIGlu
dGVsX3B0Ly91IC1UIC0tc3dpdGNoLWV2ZW50cyAtLSAuL3Rlc3QNCg0KSXMgdGhpcyBpbnRlbmRl
ZD8gb3IgaXMgaXQgYSBidWc/DQoNClRoYW5rcyENCk1hbnNvdXIuDQoNCg==
