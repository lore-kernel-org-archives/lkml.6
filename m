Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD94C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E912083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FcGPbLSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E912083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbeIGFUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:17 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:11360
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDk74vBDNeCnWIhmIRjSt0hpaLuQ1P2F/Z2inRYwBj8=;
 b=FcGPbLSPDzTZ3KSiBse4A2AmNT9gPlTWoPmSXs3YT8rGnfJZvpaIOR0/x6ukUOD+1ySa1Hf4otDAECfMbMn4Dgm2v9Dp6PoXd05Ms1tc+mPsFSbPqi8Onj+QCE7/9ZsKMgR2qIYbFNQtgRg/lASe1KU9xxV7nrxuDRgfVLH9f1Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TWljaGFlbCBNw7xsbGVy?= <michael@fds-team.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 30/30] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Topic: [PATCH AUTOSEL 4.4 30/30] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Index: AQHURkM2kbbawK0cb0O37zifwZRpSg==
Date:   Fri, 7 Sep 2018 00:39:18 +0000
Message-ID: <20180907003853.57942-30-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:lJ/nRRvyVKU2W4sIRrf3Hnr1EnrXxWRt6P+Izgtohm5IZ4PWGXypP7oHpTKwySVv42gz9hudhVr978JU679XrNC3KridVJ13cXt4PLXR0LVa1FBu43eBYCQhsgaXhLhxltPOYoNbs60xvAHq1DAQYqOXK7+uPV5I5/4pnURkooZnOycL2cGU5kHYNuJBnva+I/MUO1SgIjNpWkAvbuJR9N/0D1GK3hWFOunEAb5vGvASoPj+7GDl9Iu1q8x3i8w/KTFabSgYNpKnWAk/GBgV2bNU8/+7tji9alKtxIVwNYWi36KvMnw5CoqTqw7AwkYr7F6Qk+EITMrvWOeQDUSKDuOaGbuDFi06tjM5kHRf2bsNCYwEGErB3uf/fHNH0RcXMw0FXxvlAwBrzvWraNmXz6598RpPAJsy0TSXBXNTPqCo3xiWuUOUKcZ0X9CO57kk5ed6TUwiED73XaIZRXe27A==;5:k+3hA+0MEHU8ofTg2BuFh8a5BY+Ho4BgyaTatYMadytTeKvMhMUZFcpAM6qK7Ub9IKJby5u08hWNCHf6izyYAHIuXH+wCNCoXHVbVvCesgdyTb8rbnjxs+ORpRJVyUVT3ROPuJmWEVAzpDrKTTG4ya9AX1iZZHRJHxFqyBNDSbY=;7:pr+ajveM8Jm33iuEUFIydKmY1eu/GWuQw8Dug3+bykM0nEX8PP3k+qFM73l3ve+d/j9FvaqxqfNIvfiAn2OQbHAZts5tspMNCjiwWfBjBfw4P6C5EBvdosmBQGtbhuDlyDCLqyyjqEUR8VRDzLswuC48oydHwketoyAqd2wpOqmqLgsDoOBEUwjzs0aH2C8xc8zvBDReWo33rFkDQ5No3GewFWFkD2fSOoh4q5YbB1ay8yTyunznJfYu3cjhoI6j
x-ms-office365-filtering-correlation-id: ec794037-c852-4cef-f4f2-08d6145abd7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046988CAD2897B102356D274FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rYsNitx7dJjymYGN/z4YT/PvS3rOO2tgfKpcll6JJ0i7ylZzqRyfpFLH66PlZGYfiRwc0gYVbplX8BcwkYTU7NVSvFltEI4oPYj9fvA4/vwPg3ysaBCc1W1nGe2G+jzX3N1HLnA39HEj48gQTfMtVAGmIp/JpUJiMaXLsPFRWOFX4QGMnHZfaYKLEVCcM9j/v+2dPF7xSIKatXURG2zpb3UiA+UwOU2DkafvU+E9AYga+oF+WKcOMEONFP+U5Q0nQIBEMX74uD8mTbwO1+DfR5eUCzxF8q4wtAnTvKzn5Yb2taWWB1lgFQuo6Z5xWHHUAAMnJ/AjSIqqKWUkaXuZnp2uhNhYUVUzL60jOZPUK54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1633B5D40F99E145AEB65EC966B9999F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec794037-c852-4cef-f4f2-08d6145abd7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:18.9489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
cHRvL3NhaGFyYS5jDQppbmRleCBmNjhjMjRhOTgyNzcuLmRlZGZjOTZhY2M2NiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY3J5cHRvL3NhaGFyYS5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9zYWhhcmEu
Yw0KQEAgLTEzNjMsNyArMTM2Myw3IEBAIHN0YXRpYyBpbnQgc2FoYXJhX3JlZ2lzdGVyX2FsZ3Mo
c3RydWN0IHNhaGFyYV9kZXYgKmRldikNCiANCiBlcnJfc2hhX3YzX2FsZ3M6DQogCWZvciAoaiA9
IDA7IGogPCBrOyBqKyspDQotCQljcnlwdG9fdW5yZWdpc3Rlcl9haGFzaCgmc2hhX3Y0X2FsZ3Nb
al0pOw0KKwkJY3J5cHRvX3VucmVnaXN0ZXJfYWhhc2goJnNoYV92M19hbGdzW2pdKTsNCiANCiBl
cnJfYWVzX2FsZ3M6DQogCWZvciAoaiA9IDA7IGogPCBpOyBqKyspDQpAQCAtMTM3OSw3ICsxMzc5
LDcgQEAgc3RhdGljIHZvaWQgc2FoYXJhX3VucmVnaXN0ZXJfYWxncyhzdHJ1Y3Qgc2FoYXJhX2Rl
diAqZGV2KQ0KIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhZXNfYWxncyk7IGkrKykNCiAJ
CWNyeXB0b191bnJlZ2lzdGVyX2FsZygmYWVzX2FsZ3NbaV0pOw0KIA0KLQlmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRShzaGFfdjRfYWxncyk7IGkrKykNCisJZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoc2hhX3YzX2FsZ3MpOyBpKyspDQogCQljcnlwdG9fdW5yZWdpc3Rlcl9haGFzaCgmc2hh
X3YzX2FsZ3NbaV0pOw0KIA0KIAlpZiAoZGV2LT52ZXJzaW9uID4gU0FIQVJBX1ZFUlNJT05fMykN
Ci0tIA0KMi4xNy4xDQo=
