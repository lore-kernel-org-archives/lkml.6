Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B964BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D4A21841
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KL6whYIs";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="btGb/V8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAJDH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:07:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726458AbfAJDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:07:28 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0A370AW022598;
        Wed, 9 Jan 2019 19:07:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=10DYuiS3fXQNgcHu5p4ReiIpU+twDX1+g/QGaYdHSTg=;
 b=KL6whYIsnUU1i6dvaozgScUvTeRVESYbfLmYLQrlfO25pKJWN6beH4ovTDMBV5qWOLBR
 THKfH1YoCa/o4k8pZdFFcR5Oo4xoouPczvAeSgGS9Ok8LBxrg2ryYk3UEtE+u9TWxg75
 m+qfYB0KFYQiqQI3XP0IWi31veHbZufUUd8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2pwubagfew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 19:07:00 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 19:06:59 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 19:06:58 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 9 Jan 2019 19:06:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10DYuiS3fXQNgcHu5p4ReiIpU+twDX1+g/QGaYdHSTg=;
 b=btGb/V8pEsbUToe3dv+UgaI694nuUGCouaaMsPV7Jxalpv9kvQuspxzZANKlQnexVmu7ozSf9GY8pIGjN+OCIdsEZQ/kj4huK/c3lDf7G6fps+qBXtXcw71M0VUHO7IjX6j3Hjhu/Ezva1Q9kOs6dZ1Nk3Ks56t+1LjjzUPcUj0=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2455.namprd15.prod.outlook.com (52.135.200.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 10 Jan 2019 03:06:56 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::e12c:c450:3e9f:4ef6]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::e12c:c450:3e9f:4ef6%4]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 03:06:56 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUqFCeBB31ZGcmPkuoIkc1UIwgUKWn0nAA
Date:   Thu, 10 Jan 2019 03:06:56 +0000
Message-ID: <38c544aa-92b9-978c-98ff-baccb8a750b2@fb.com>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-4-songliubraving@fb.com>
In-Reply-To: <20190109192111.130995-4-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:300:ad::23) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:3299]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2455;20:YA1esRUBtuNuLYK/yr+PsqWAEdIaEeDkOGZUx1RCxxty4Gy30LrrI5y8HQMcs50Ax23SVfCrOu8b5QqTXG+/vYeFosC1WJMdYZnQmpCal68dU+Ex5KsFCJsb3v09ASd4ovEfA3xSoRc7mSNmal0kGLZsZ5uQR20eoPCNhyW1etI=
x-ms-office365-filtering-correlation-id: 5c75098c-b31c-400a-e94a-08d676a8ad15
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2455;
x-ms-traffictypediagnostic: BYAPR15MB2455:
x-microsoft-antispam-prvs: <BYAPR15MB24558A6BE7A14BB44F0932CDD7840@BYAPR15MB2455.namprd15.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(6512007)(5660300001)(6486002)(110136005)(102836004)(386003)(6506007)(53546011)(6116002)(14454004)(105586002)(8936002)(6246003)(478600001)(53936002)(2501003)(256004)(2906002)(106356001)(54906003)(76176011)(4326008)(31686004)(36756003)(305945005)(7736002)(81166006)(81156014)(486006)(8676002)(71190400001)(71200400001)(11346002)(86362001)(2616005)(31696002)(575784001)(476003)(25786009)(229853002)(97736004)(6436002)(52116002)(2201001)(46003)(316002)(99286004)(446003)(186003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2455;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cJUqx3h4po7eDqE2Om6q5SlGhk2WE8QngrWV6FRC4UWQ64qyXxvgI3v3Qy0mv30euimRuX1r/FbHA6OjW3bnyHrotghNl26SrPMFo3m69eVD6QSGG/EC95FMRR7FqOmPDAwC/4N3F3NQFaimO7V4sZZj6kxau1s9sqvYG2IIBDfiyxEEqMWSM7M5xwc+cMexWzLMuhCqn7SUb0E54oS03vFGmgwhnhJkt19JRZ6x4suJteQqZro8x5WPbdsMw58W6ymgWqow84VED+vUYmahYxkAdEt+SnXxqWhuDo0BqXdb+1l/S5+BNkgn+WGi1ew7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4CA5182851F3E48A599101116FDAF89@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c75098c-b31c-400a-e94a-08d676a8ad15
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 03:06:56.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS85LzE5IDExOjIxIEFNLCBTb25nIExpdSB3cm90ZToNCj4gRm9yIGJldHRlciBwZXJmb3Jt
YW5jZSBhbmFseXNpcyBvZiBCUEYgcHJvZ3JhbXMsIHRoaXMgcGF0Y2ggaW50cm9kdWNlcw0KPiBQ
RVJGX1JFQ09SRF9CUEZfRVZFTlQsIGEgbmV3IHBlcmZfZXZlbnRfdHlwZSB0aGF0IGV4cG9zZXMg
QlBGIHByb2dyYW0NCj4gbG9hZC91bmxvYWQgaW5mb3JtYXRpb24gdG8gdXNlciBzcGFjZS4NCj4g
DQo+IEVhY2ggQlBGIHByb2dyYW0gbWF5IGNvbnRhaW4gdXAgdG8gQlBGX01BWF9TVUJQUk9HUyAo
MjU2KSBzdWIgcHJvZ3JhbXMuDQo+IFRoZSBmb2xsb3dpbmcgZXhhbXBsZSBzaG93cyBrZXJuZWwg
c3ltYm9scyBmb3IgYSBCUEYgcHJvZ3JhbSB3aXRoIDcNCj4gc3ViIHByb2dyYW1zOg0KPiANCj4g
ICAgICBmZmZmZmZmZmEwMjU3Y2Y5IHQgYnBmX3Byb2dfYjA3Y2NiODkyNjdjZjI0Ml9GDQo+ICAg
ICAgZmZmZmZmZmZhMDI1OTJlMSB0IGJwZl9wcm9nXzJkY2VjYzE4MDcyNjIzZmNfRg0KPiAgICAg
IGZmZmZmZmZmYTAyNWIwZTkgdCBicGZfcHJvZ19iYjdhNDA1ZWJhZWM1ZDVjX0YNCj4gICAgICBm
ZmZmZmZmZmEwMjVkZDJjIHQgYnBmX3Byb2dfYTc1NDBkNGEzOWVjMWZjN19GDQo+ICAgICAgZmZm
ZmZmZmZhMDI1ZmNjYSB0IGJwZl9wcm9nXzA1NzYyZDRhZGUwZTM3MzdfRg0KPiAgICAgIGZmZmZm
ZmZmYTAyNjEwOGYgdCBicGZfcHJvZ19kYjRiZDExZTM1ZGY5MGQ0X0YNCj4gICAgICBmZmZmZmZm
ZmEwMjYzZjAwIHQgYnBmX3Byb2dfODlkNjRlNGFiZjBmMDEyNl9GDQo+ICAgICAgZmZmZmZmZmZh
MDI1N2NmOSB0IGJwZl9wcm9nX2FlMzE2MjkzMjJjNGIwMThfX2R1bW15X3RyYWNlcG9pDQo+IA0K
PiBXaGVuIGEgYnBmIHByb2dyYW0gaXMgbG9hZGVkLCBQRVJGX1JFQ09SRF9LU1lNQk9MIGlzIGdl
bmVyYXRlZCBmb3INCj4gZWFjaCBvZiB0aGVzZSBzdWIgcHJvZ3JhbXMuIFRoZXJlZm9yZSwgUEVS
Rl9SRUNPUkRfQlBGX0VWRU5UIGlzIG5vdA0KPiBuZWVkZWQgZm9yIHNpbXBsZSBwcm9maWxpbmcu
DQo+IA0KPiBGb3IgYW5ub3RhdGlvbiwgdXNlciBzcGFjZSBuZWVkIHRvIGxpc3RlbiB0byBQRVJG
X1JFQ09SRF9CUEZfRVZFTlQNCj4gYW5kIGdhdGhlciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRo
ZXNlIChzdWIpIHByb2dyYW1zIHZpYSBzeXNfYnBmLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU29u
ZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9m
aWx0ZXIuaCAgICAgICAgICB8ICAgNyArKw0KPiAgIGluY2x1ZGUvbGludXgvcGVyZl9ldmVudC5o
ICAgICAgfCAgIDYgKysNCj4gICBpbmNsdWRlL3VhcGkvbGludXgvcGVyZl9ldmVudC5oIHwgIDI5
ICsrKysrKystDQo+ICAga2VybmVsL2JwZi9jb3JlLmMgICAgICAgICAgICAgICB8ICAgMiArLQ0K
PiAgIGtlcm5lbC9icGYvc3lzY2FsbC5jICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGtlcm5lbC9l
dmVudHMvY29yZS5jICAgICAgICAgICAgfCAxMjAgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICA2IGZpbGVzIGNoYW5nZWQsIDE2NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KDQpBY2tlZC1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz4NCg0K
VGhlIGJwZiBiaXRzIGFyZSBzbWFsbCBjb21wYXJpbmcgdG8gcGVyZiBiaXRzLCBzbyBpdCdzIHBy
b2JhYmx5DQpiZXR0ZXIgdG8gZ2V0IHRoZSB3aG9sZSB0aGluZyB2aWEgdGlwIHRyZWUgaW4gb25l
IGdvLg0KU3BsaXR0aW5nIHBlcmYgcGF0Y2hlcyBpbnRvIHBlcmYgdHJlZSBhbHNvIHNlZW1zIHVu
bmVjZXNzYXJ5Lg0KDQpQZXRlciwgQXJuYWxkbywgdGhvdWdodHM/DQo=
