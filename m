Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A53EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4842082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="JgyZGFD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4842082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeLDLRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:17:05 -0500
Received: from mail-eopbgr70101.outbound.protection.outlook.com ([40.107.7.101]:23137
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbeLDLRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U23HrgZYfgwFldQCul5iMtVIw/UcsArHia9l6tPkeno=;
 b=JgyZGFD4NycnTPseoUE945U4ZzcCuFjLjNJvjFL9+1mAQqGHCzv+YSO8IHiisDuI3jNI4biAHSa9kazKCMldSsj2eKAIHOQXmKujcziGODG/xY9AUoiI+/pznXUHYc27ncDROl8Z0S5CPIszRCVVHv7UhJ1H9zn8Ksm0SGVhmq4=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB3885.eurprd02.prod.outlook.com (52.134.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 11:16:59 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1361.022; Tue, 4 Dec 2018
 11:16:59 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Topic: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Index: AQHUiV04FT84eXxBo0+Q2gJyFszP86VucwAA
Date:   Tue, 4 Dec 2018 11:16:59 +0000
Message-ID: <549eba3a-28b9-e4b0-f680-8fb51b160879@axentia.se>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0362.eurprd05.prod.outlook.com
 (2603:10a6:7:94::21) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB3885;6:fnM/FcjGBQ8diEA3E4jKD3AmTUQTFvs0utzxlxKHgCOvQCJIVYLfZDWbaGFxE/A3/vKBc2hMWTDlam5rtEJ1sS1l1BMo7FHabwnpHNDA5uEhw3sbhATtxJDYhNhXG6t1lqWaxV28hvqfxB7nEeO2SMGBh5HGXs42XLJb6erhk5Kts9RuWeN4cFITquBW8sV38wC+zLAupFM6wlf9u1r2slrn2yKbdnNNEjNxqTb3QFJHboP6wLCR/mnbQfuRJw+yMMxyWyEvWjTQoJlSOOVBv8n0qEkwGfUbV5R6hz59ywmtLiQKqGEWi7YYz9+1VWzEbiDnqCo296RVW+zMUGcpjoMDGHHRnT+StXVmSbG3qAaux43P1IYIE8fuODQubakyFZk5RFTgQscvh3O5iNMfjebW8//FgKxLVVLgNStmMHEVizLOZw1lUEXBB7x6JocSglpSrg07T0uSiv1ZlpZeGw==;5:Uo8KV6xZ7GSJivMufrMXz9w4Rh6A08sxQREcTGITa0AmvTxKb57wI7RffCp8p2e5mwedIjGkbpZf0mrBagh58yLTHbrGYprLpIxB4D2s8yQldU0dTSH9FwXSFV80Oa82wKiaNAVnWJB0UVvu2U6p552WPK0Dx5gIV0Tr4mP2nls=;7:6wkZzhPIk0glE3X1DVDgpVQqWi9LjWj0XvIUp7/n5/LDFYkxnwWH9swC+SkqeOzDLluYRDwKHsuFta6QupfRBAV8cHYw03cZiVkaueBg6Elh0KKx23mbn27CgvqZ00GporQr+DhJINRuqQkUUI+Uwg==
x-ms-office365-filtering-correlation-id: abb6498b-64ce-4c95-3dcf-08d659da01c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3885;
x-ms-traffictypediagnostic: VI1PR02MB3885:
x-microsoft-antispam-prvs: <VI1PR02MB3885433A43ECA36E39AB966ABCAF0@VI1PR02MB3885.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB3885;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB3885;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39830400003)(376002)(189003)(199004)(58126008)(110136005)(54906003)(64126003)(66066001)(65806001)(86362001)(65956001)(508600001)(25786009)(102836004)(7736002)(229853002)(305945005)(2906002)(476003)(31696002)(26005)(5660300001)(186003)(68736007)(446003)(106356001)(6436002)(11346002)(2616005)(52116002)(76176011)(256004)(105586002)(74482002)(81156014)(4326008)(6116002)(3846002)(486006)(99286004)(97736004)(31686004)(53936002)(6486002)(386003)(36756003)(53546011)(6506007)(65826007)(6512007)(71190400001)(71200400001)(14444005)(6246003)(81166006)(14454004)(8936002)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3885;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zbj0Osaz2bvvd7dTc/1DDAas34Ja0RRVWMho+akNLYNO8Yf9AkbFkp80VXpCE781GGKToREiWoxhI0lG8F8vo38moc112URnJ5HKb7PbvKLlMOCWLFi3Cd6OON0p86bvSGRH+M78BwspQaVHrO+dhCcXTclqhuTHMubBDy9+V3JHi0a3YEPsgtZdT+lmmWfjJ2j3zpRDWJXBEGuyv1NBXrBu/atpvTRtCuREMGOAvCXA4lrFlidZbL7AzDGr1PeAxsaSNdeS0sf6K5rbpsyJgzqYv1FApd92Tiw6thyEbN+RoK6pcDy9GzhCIx7G+gfV7arylDNp97Npomr9Pq+5cs5i1D4bkntMaXc0JCSVFJQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <33C85D541A38A744B654A952F1331D3F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: abb6498b-64ce-4c95-3dcf-08d659da01c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 11:16:59.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNClRoaXMgcGF0Y2ggbG9va3MgbGlrZSBhIGdvb2QgaWRlYS4gSG93ZXZlciwgYSBuaXRw
aWNrIGJlbG93Lg0KDQpPbiAyMDE4LTEyLTAxIDExOjAxLCBOaWNob2xhcyBNYyBHdWlyZSB3cm90
ZToNCj4gZGV2bV9rc3RyZHVwKCkgbWF5IHJldHVybiBOVUxMIGlmIGludGVybmFsIGFsbG9jYXRp
b24gZmFpbGVkLg0KPiBUaHVzIHVzaW5nICBuYW1lLCB2YWx1ZSAgaXMgdW5zYWZlIHdpdGhvdXQg
YmVpbmcgY2hlY2tlZC4gQXMNCj4gaTJjX2RlbXV4X3BpbmN0cmxfcHJvYmUoKSBjYW4gcmV0dXJu
IC1FTk9NRU0gaW4gb3RoZXIgY2FzZXMNCj4gYSBkZXZfZXJyKCkgbWVzc2FnZSBpcyBpbmNsdWRl
ZCB0byBtYWtlIHRoZSBmYWlsdXJlIGxvY2F0aW9uDQo+IGNsZWFyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTmljaG9sYXMgTWMgR3VpcmUgPGhvZnJhdEBvc2FkbC5vcmc+DQo+IEZpeGVzOiBlMzU0
NzhlYWMwMzAgKCJpMmM6IG11eDogZGVtdXgtcGluY3RybDogcnVuIHByb3Blcmx5IHdpdGggbXVs
dGlwbGUgaW5zdGFuY2VzIikNCj4gLS0tDQo+IA0KPiBQcm9ibGVtIGxvY2F0ZWQgd2l0aCBleHBl
cmltZW50YWwgY29jY2luZWxsZSBzY3JpcHQNCj4gDQo+IFE6IFRoZSB1c2Ugb2YgZGV2bV9rc3Ry
ZHVwKCkgc2VlbXMgYSBiaXQgb2RkIHdoaWxlIHRlY2huaWNhbGx5IG5vdCB3cm9uZywNCj4gICAg
cGVyc29uYWxseSBJIHRoaW5rIGRldm1fa2FzcHJpbnRmKCkgd291bGQgYmUgbW9yZSBzdWl0YWJs
ZSBoZXJlLg0KPiANCj4gUGF0Y2ggd2FzIGNvbXBpbGUgdGVzdGVkIHdpdGg6IG11bHRpX3Y3X2Rl
ZmNvbmZpZyANCj4gKGltcGxpZXMgSTJDX0RFTVVYX1BJTkNUUkw9eSkNCj4gDQo+IFBhdGNoIGlz
IGFnYWluc3QgNC4yMC1yYzQgKGxvY2FsdmVyc2lvbi1uZXh0IGlzIG5leHQtMjAxODExMzApDQo+
IA0KPiAgZHJpdmVycy9pMmMvbXV4ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYyB8IDYgKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pMmMvbXV4ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYyBiL2RyaXZlcnMvaTJjL211eGVzL2ky
Yy1kZW11eC1waW5jdHJsLmMNCj4gaW5kZXggMDM1MDMyZS4uYzQ2Njk5OSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pMmMvbXV4ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYw0KPiArKysgYi9kcml2ZXJz
L2kyYy9tdXhlcy9pMmMtZGVtdXgtcGluY3RybC5jDQo+IEBAIC0yNDQsNiArMjQ0LDEyIEBAIHN0
YXRpYyBpbnQgaTJjX2RlbXV4X3BpbmN0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIA0KPiAgCQlwcm9wc1tpXS5uYW1lID0gZGV2bV9rc3RyZHVwKCZwZGV2LT5kZXYs
ICJzdGF0dXMiLCBHRlBfS0VSTkVMKTsNCj4gIAkJcHJvcHNbaV0udmFsdWUgPSBkZXZtX2tzdHJk
dXAoJnBkZXYtPmRldiwgIm9rIiwgR0ZQX0tFUk5FTCk7DQo+ICsJCWlmICghcHJvcHNbaV0ubmFt
ZSB8fCAhcHJvcHNbaV0udmFsdWUpIHsNCj4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwNCj4gKwkJ
CQkiY2hhbiAlZCBuYW1lLCB2YWx1ZSBhbGxvY2F0aW9uIGZhaWxlZFxuIiwgaSk7DQoNClBsZWFz
ZSBkcm9wIHRoaXMgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSBtZXNzYWdlLiBZb3Ugc2hvdWxk
IGdldCBzdWNoIGENCm1lc3NhZ2UgZnJvbSBkZXZtX2tzdHJkdXAuDQoNCkNoZWVycywNClBldGVy
DQoNCj4gKwkJCWVyciA9IC1FTk9NRU07DQo+ICsJCQlnb3RvIGVycl9yb2xsYmFjazsNCj4gKwkJ
fQ0KPiAgCQlwcm9wc1tpXS5sZW5ndGggPSAzOw0KPiAgDQo+ICAJCW9mX2NoYW5nZXNldF9pbml0
KCZwcml2LT5jaGFuW2ldLmNoZ3NldCk7DQo+IA0KDQo=
