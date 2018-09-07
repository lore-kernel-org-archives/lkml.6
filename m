Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143D8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E120857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cv30Rg6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54E120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeIGFRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:52 -0400
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:27712
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728153AbeIGFRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UllN3iJrtXAl8xtZhiFsSInPVGbitQOqlpK1ZXaT76k=;
 b=Cv30Rg6Xqk5auJNeOUodz9Wphv/x3t6OnNoqP1QtHNEsrNBeG3+PLvEsg4ESO8gbE6EL3OUYOYLFPl2EmVwy+fL04VqyZ4UmUGj0NoCRFGVVkfF3Y96iXqvDCfKwuVVxm7kkerdDXXLAhr9Nm/8F0cH/6wF7dwIHaCx66AlsXXE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TWljaGFlbCBNw7xsbGVy?= <michael@fds-team.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 64/67] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Topic: [PATCH AUTOSEL 4.14 64/67] crypto: sharah - Unregister correct
 algorithms for SAHARA 3
Thread-Index: AQHURkMLRCMJQvx/WU2om8Jf7FjBoA==
Date:   Fri, 7 Sep 2018 00:38:07 +0000
Message-ID: <20180907003716.57737-64-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:vUSwcBQ57p+x+JzqR1NZXHquCHLaiQWGp1aTlpbnXUVQ717yUK/EwJB4g5WvrYbMEIbEvUPbcDtwGz7iXHNHZhDSqSRuIQhVLuUcdV3ecRIYWNN5E2aIevjXGp+9nFhpdMLRby/r3sIzRwjWtSyXl8Kdtswxx0azELnZMddARv1CL/b0ilnVmHI1FdEaukH2V9gKmd8xd9GUn0DJc90DwRQyWhxyVD6NL45Zi5V9gW+zyD303wXDn+Tx047EGnaZvzKt7dZDlePg0AZhOC5gkwG9dZy1noPbnTRDY7TjfsXMtl4048JBhxgIHBECP87g99z82XhSczfpBgZxldfUM0QulI7XzXgP9scsx40eca+SdrBZr64xzAKAhRnq68NfdxE2B61yoIPuYZHhizkYSZNU5r86/mTEtBAbXQKa763P3skID6DbUVwIosHcw+EVAkh3bzl80uijWXVcRflclA==;5:8j5ACAFQlE8T6vwGA8x73kNjgOQjGzaRtQPHqkjQfzXPYfDRuQY8//HbS1Oqhqilnh6S4LznmCwhE/P06bK96M3v9ySitRk5nJt2Yh/UGLvZ8gYDZXJRknMtPZ3dY6e10apUuoyVUxTswzQBYRbNbdYpv8WvwHv3lL/wFIc4ywk=;7:YWrVWvR/X/Sg/eRmfSwkWQz8uHGE0vV+pb+1Vh31AiSJsIq0oz7GrBJ/Cavu3pzBlwXL3QCJAC98h6ao8v4ZiACOiXvzsWTBy5tCcRbBUfG/ysPnTlV75KXeODBd+B66rWB6lyr9luAZ5dwJtHw9ZYYpNLWatSkYKyobUM8Krj0tLtzOhKy9vCwqvG1f6G1TAbMDTHZ5PyRKBIka6oKMPmx+WlmiStTy77EFVxJ82Sg9xoJR4uqIhRtPwCI3oZQt
x-ms-office365-filtering-correlation-id: e10b7c9a-ef4f-42f9-6d21-08d6145a6667
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855219B6461202F145911B9FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DCCtoR3NCKW+nXrihGMJ6hmBe4DOtjsfsgXOsix7dCl9Y3ZCCkrMDU4pZHpsXrkPHBe4jOIckYNrcjnoenj9Uh5W2CYlJt6qTZUXsUMUAOLlhQCqohrMIRozlMlEzfac/ogtNwng1QFNv7ubp4L+EgFzr1V5OWwcADHUf7OSfOu3Cfnjrm0nMGUj7IhwA7DoUm3I1IoVlG7xEhpDw3hSBi7Lt4+VorqnE0JgIAxj3zULe2WReHXDLjP7tsam7jIzKpIOwe8QEgAEyUdidKJORpPSLGvPNtTMh45GNujTwf8+4PTVbed6JxXS9xM91LWNR/XHfCIeU609y70wLosqrCrAOswMY8ftKiKgNzJL9MM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <60ED521792D9E24591C5D5040DA11E45@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10b7c9a-ef4f-42f9-6d21-08d6145a6667
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:07.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
cHRvL3NhaGFyYS5jDQppbmRleCAwOGU3YmRjYWE2ZTMuLjA4NWMyMjllYWIxZCAxMDA2NDQNCi0t
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
