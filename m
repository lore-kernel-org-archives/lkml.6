Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADB62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yv8wS6rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeIGFdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:33:25 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:48060
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727972AbeIGFPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utAxy4ETLOxlNRZYxLlOt/XHeDvV5j1NhTVYhcq8VYg=;
 b=Yv8wS6rhPBgv0/SG+fxzzCCsN2R3Bf/4qz/5RpzVAyRpQjjEqkZWDrmBJH1Lx4gQWNiDFzL1HE+KR3G0Z/ZpBJBijH83P45AYLXY/hh5llowUiBas1EEFMyCRRYOqYIN8ouya2MHrokwvQFbIKV4rbDBQqFR4Yb4OMm0+GJ20SQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TWljaGFlbCBNw7xsbGVy?= <michael@fds-team.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 84/88] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Topic: [PATCH AUTOSEL 4.18 84/88] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Index: AQHURkLdkXzkvtZ4UEy+q5qinR+c9A==
Date:   Fri, 7 Sep 2018 00:36:50 +0000
Message-ID: <20180907003547.57567-84-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:qqRJizdy1NMbxEzsFeIeocRCLdbt6VY/UJ5HkoJQ3eY8qAnxZEGc5YOAQmXFxSnuLnaR/tHKHl8vTp0io/94HCzy6YBi2f904beEVx7miu++u4V6Ah1GJLi6/1aF2Z/M3fbFu5rDPSuXu+PFaQiWMJRkVyfela9lWt6/x25dMohnEZ79uxjGpqjvZtwFDPSQCfdZzRmcsZMmc6lBN0M/orByP3SxqRzlnMaiNQZmHfJ0DbC4EAmB2FX8Q7dtzvKBIsQVEuVVrNVj5lQwyX+rrfJVdhbbRNjlaWql5In8u2J13M4kJ13UN29i4cz4njcE0Z6OpICcirrytgveDA5U1vdWiZOnVc0OKMr76467Ij9TwshAOWDAJeBTInrML/BjWE71oxvE4We8AuPsv+ECtPT1wcwqP4+jByWDNJ3buSVqKdrw84sV2GFGh7BWk1R+MWQC58MY+oQWS2ODdM37Ow==;5:Tlc9IZErttd80OsESnld+Gq/JUhLg/4tYVF1fUIMWj66YXJNrGQLF79Ld81uOqmZYUNnvEQXG2PdrFb2gMOx8jyijyotNa7QRQNsaw2g1YHIWym53msfo9vWPnvdhtEx27nCMc92uUh2Efd+vw00/K9xPGMkfWDOt9POfze99V8=;7:i0JAk87gQxh1EAywbOuFib6ngQ8lXm3WzvgM6UHRW7tCLZ6LJuKo6u9WIP3cHwT5ITuQdowM0XQ0mMql4WxiqjnmwJyCe5aLSbnJ11u5Ha7UEOkFkXW/n1PKiqQ7XZyMM/0Czk+LsG4ycq92HwS57UjftI5LqCzCcFfJiH87mkoU2LMU4CS4BdImWlRzb85k7sMP5QplE9nZKowK3st2e8C6YRPGJdub/YI2lYnQwexB3eCfUazJUvrtI5MdSVD5
x-ms-office365-filtering-correlation-id: 386bcf55-b5dc-4603-5487-08d6145a1d88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839223E04F32B39EAF4FDF7FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: d49O0X60Kw6r4qoAp5hwD2r1IVatJ2vfh0QSVtY9VkFjxcjemmDN133m2yCNM2AhT7Q0NgOv0aiURaEIOcj/yzzmZJ5D1VwgB0I/28vYyIAS7NTxCYCXjNtAtUfetEWr4TapfoARCHv2d/YtITLSi5eMdngZ3bQESvdVMIE2AhSSlWIobVc+wCHdzZdrwQT0EsVr/r6yE/X1jjVkOPgd/Akp2j7nCq8Pb85r2xSbGNMuXocFsa3DKEB5Rn7Bnvdbtvhd4F0jT/QtRUXv+QBFNjx+ylqRBAV9oDYN2iWaHMHF4rP3S4fhm+eAAU4yMT4IDthEc9yHyx+EGa/mBFjS7ng1yGtwtIZ22EbUJGBDMFk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A69CB063C35CA744AE4169CF48B26EBE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386bcf55-b5dc-4603-5487-08d6145a1d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:50.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWljaGFlbCBNw7xsbGVyIDxtaWNoYWVsQGZkcy10ZWFtLmRlPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCAwZTdkNGQ5MzJmZmMyM2Y3NWVmYjMxYThjMmFjMjM5NmMxYjgxYzU1IF0NCg0KVGhp
cyBwYXRjaCBmaXhlcyB0d28gdHlwb3MgcmVsYXRlZCB0byB1bnJlZ2lzdGVyaW5nIGFsZ29yaXRo
bXMgc3VwcG9ydGVkIGJ5DQpTQUhBUkFIIDMuIEluIHNhaGFyYV9yZWdpc3Rlcl9hbGdzIHRoZSB3
cm9uZyBhbGdvcml0aG1zIGFyZSB1bnJlZ2lzdGVyZWQNCmluIGNhc2Ugb2YgYW4gZXJyb3IuIElu
IHNhaGFyYV91bnJlZ2lzdGVyX2FsZ3MgdGhlIHdyb25nIGFycmF5IGlzIHVzZWQgdG8NCmRldGVy
bWluZSB0aGUgaXRlcmF0aW9uIGNvdW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIE3DvGxs
ZXIgPG1pY2hhZWxAZmRzLXRlYW0uZGU+DQpTaWduZWQtb2ZmLWJ5OiBIZXJiZXJ0IFh1IDxoZXJi
ZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxl
eGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2NyeXB0by9zYWhhcmEu
YyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9zYWhhcmEuYyBiL2RyaXZlcnMvY3J5
cHRvL3NhaGFyYS5jDQppbmRleCAwZjIyNDVlMWFmMmIuLjk3ZDg2ZGNhN2U4NSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY3J5cHRvL3NhaGFyYS5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9zYWhhcmEu
Yw0KQEAgLTEzNTEsNyArMTM1MSw3IEBAIHN0YXRpYyBpbnQgc2FoYXJhX3JlZ2lzdGVyX2FsZ3Mo
c3RydWN0IHNhaGFyYV9kZXYgKmRldikNCiANCiBlcnJfc2hhX3YzX2FsZ3M6DQogCWZvciAoaiA9
IDA7IGogPCBrOyBqKyspDQotCQljcnlwdG9fdW5yZWdpc3Rlcl9haGFzaCgmc2hhX3Y0X2FsZ3Nb
al0pOw0KKwkJY3J5cHRvX3VucmVnaXN0ZXJfYWhhc2goJnNoYV92M19hbGdzW2pdKTsNCiANCiBl
cnJfYWVzX2FsZ3M6DQogCWZvciAoaiA9IDA7IGogPCBpOyBqKyspDQpAQCAtMTM2Nyw3ICsxMzY3
LDcgQEAgc3RhdGljIHZvaWQgc2FoYXJhX3VucmVnaXN0ZXJfYWxncyhzdHJ1Y3Qgc2FoYXJhX2Rl
diAqZGV2KQ0KIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhZXNfYWxncyk7IGkrKykNCiAJ
CWNyeXB0b191bnJlZ2lzdGVyX2FsZygmYWVzX2FsZ3NbaV0pOw0KIA0KLQlmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRShzaGFfdjRfYWxncyk7IGkrKykNCisJZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoc2hhX3YzX2FsZ3MpOyBpKyspDQogCQljcnlwdG9fdW5yZWdpc3Rlcl9haGFzaCgmc2hh
X3YzX2FsZ3NbaV0pOw0KIA0KIAlpZiAoZGV2LT52ZXJzaW9uID4gU0FIQVJBX1ZFUlNJT05fMykN
Ci0tIA0KMi4xNy4xDQo=
