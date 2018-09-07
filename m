Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C932083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="flR1Cb4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C932083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeIGFUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:07 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729684AbeIGFTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1rl5s/7aWwFPwi0hldCh0UoOLJ+ZyIrCjUxsBqyXh0=;
 b=flR1Cb4HPJqkPfpPLjk5U8xyXQsqPNI3bq20qMPxiFF3TTNsh1cabCZOdDiOtAeIYJ8PkcJELb+s4FP7u7pgR3vjBzC8FuEOqUaMdC4uc5MWzEzrPwQCTm5XKQPODOgZICnIyVT5HwpAO9oRepDipILeAGOfkTq4U63NwkhshUA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TWljaGFlbCBNw7xsbGVy?= <michael@fds-team.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 43/43] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Topic: [PATCH AUTOSEL 4.9 43/43] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Index: AQHURkMkdLwosed8AUGhG1psQaCgsQ==
Date:   Fri, 7 Sep 2018 00:38:48 +0000
Message-ID: <20180907003816.57852-43-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:KaniOtUELdLbLPhdBn1l6duYMskjzkcQDMhFyBvrled494KLgKDK1X3UpaG5IkKT3c9X4dTAQutuy02X6O/8KtKimYMY1N/+55OOIkWLMaAiSVi9G9pEG68RZsiC3JFr/evsCUTYMkb+oS9iw4mS/Kvl6PRwb3wKi5OrhQxAubWrj9XoNX2WZ6RiiT8cIt7yXlSBWdjuK4z6OgFrn/EuyQm57/2htLJi3mtKf1FNJ4zoaA7pRb9Tt3pz0a/RiLmrVQTEqcd8XWsciw3OB2dVgGR8GeB8UrZRlGMCTIIwrGgcK/hnNQWEWu31mSgSDKrTFLXP77pZ3ctxOv8U7hEAs6TbGVJj6VamShb5QLK7O7/ZYCO8DSbZhjHwnxeFqvjVec8J5aQ5vLiHAAxzmhqgNHTqh8uo4OuN5sDvRMOAA9RFpDVqcKsmKkjms+lmPghjIai42uH4e+5yk+nLdtYTLA==;5:RKgGYHUk86B6Oi/0Mx+3gLb/R7xuyNHjH6k6eMcT3+ioaiEc2jpHfvCvJcryg3lXZluXFdFKV3adsJUmpiqqN+FD59GnoNYNGDXy5/X6GfP8pnb1qUJtxTxQTNFuSypq9xPLgdoRCXphiWs3FSM5UGBNbKW88SjVdJKsr0hJf5c=;7:cyLr/QElpAUY7siVCn6aFwKbR+VqcF9xsGASByGEgzl9FbWSKgWcS0l5vsJwJF7XOd3q8ikoyC26OPxEn3EGDUtcyMDjwtyytg+lq526FpIks8CMPvdoInDzeYeF75jqVpzNrYVVP1vHIUhfXvVST3omdkTlfY9t07iSYg/ujnYKsfHV3NZ48aV4tNr4WyH1hWvf9/CunROchnaA6WxKkr/H7RrsBorVx+lGRjkrOfeSU/NoWebaeM5RRgB8vgIr
x-ms-office365-filtering-correlation-id: 277b3e28-7ac5-499f-ebd4-08d6145aa3d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694F5C1261F918C8125E2DBFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FtASPxyJg3Xs5ItHNPEBpg+gyWF3oSr5rePXBz7mEX7yPX0MTvBKPJ5eMDcZ8trhZRVTBVbroGmX8XaOuGa+vbWtHEWZOI0d6zDB9LNwhkVoNeACXTd/eNMI4bQWwoK6ILrq7ldX9k8HXYrpO1oqwuOXjpGGyK1Mm4SNQ4VqfP0sqK6EGJi6wzR05FEIm/rzhThuaUbQuyue1Q86A/m1t5ZxDhh1iJrjUc+xSpCe1TUjba9HcRSckr67qlvLwSGH0lBAg7ls5dwmtXj/4uvH8s5WLQV6g1N90mdqkCGdAY/NoaMm3K7OV9pQM3JT9+Hfi7+lsdJCaQGnJU81U/Yz0JNbaRUAQw2BQCYhlWbmTaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAEB38332962D245B9438C89C80396A7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277b3e28-7ac5-499f-ebd4-08d6145aa3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:48.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
cHRvL3NhaGFyYS5jDQppbmRleCAwYzQ5OTU2ZWUwY2UuLjRkMGVjN2JiM2JjOSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY3J5cHRvL3NhaGFyYS5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9zYWhhcmEu
Yw0KQEAgLTEzNTIsNyArMTM1Miw3IEBAIHN0YXRpYyBpbnQgc2FoYXJhX3JlZ2lzdGVyX2FsZ3Mo
c3RydWN0IHNhaGFyYV9kZXYgKmRldikNCiANCiBlcnJfc2hhX3YzX2FsZ3M6DQogCWZvciAoaiA9
IDA7IGogPCBrOyBqKyspDQotCQljcnlwdG9fdW5yZWdpc3Rlcl9haGFzaCgmc2hhX3Y0X2FsZ3Nb
al0pOw0KKwkJY3J5cHRvX3VucmVnaXN0ZXJfYWhhc2goJnNoYV92M19hbGdzW2pdKTsNCiANCiBl
cnJfYWVzX2FsZ3M6DQogCWZvciAoaiA9IDA7IGogPCBpOyBqKyspDQpAQCAtMTM2OCw3ICsxMzY4
LDcgQEAgc3RhdGljIHZvaWQgc2FoYXJhX3VucmVnaXN0ZXJfYWxncyhzdHJ1Y3Qgc2FoYXJhX2Rl
diAqZGV2KQ0KIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhZXNfYWxncyk7IGkrKykNCiAJ
CWNyeXB0b191bnJlZ2lzdGVyX2FsZygmYWVzX2FsZ3NbaV0pOw0KIA0KLQlmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRShzaGFfdjRfYWxncyk7IGkrKykNCisJZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoc2hhX3YzX2FsZ3MpOyBpKyspDQogCQljcnlwdG9fdW5yZWdpc3Rlcl9haGFzaCgmc2hh
X3YzX2FsZ3NbaV0pOw0KIA0KIAlpZiAoZGV2LT52ZXJzaW9uID4gU0FIQVJBX1ZFUlNJT05fMykN
Ci0tIA0KMi4xNy4xDQo=
