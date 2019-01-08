Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886ED2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="efjbNIgK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GA2tJO5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfAHUpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:45:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728723AbfAHUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:45:55 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08Kb7AN023428;
        Tue, 8 Jan 2019 12:45:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XSg3vuTFrc7QLeVh9twoJ7MBZtBF7cAQMHeTx6wOV0Q=;
 b=efjbNIgK31awvY9IMELCxmCso6APWBNUjAm0I0R8aR8SFtYsXfINQUcGrZCk5xXuO4z7
 KX6p7xKsZPjnF4gsZAZsuY3TUrnrSwnkPzHxC1dI1kZLhmDhQcNkIELwoZlQl1F7yAXz
 gpglRiyMSq3DlXSgsHO9dp/pMId5pI3PlqU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2pw1hrrbx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 12:45:24 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 12:45:23 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 12:45:22 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 8 Jan 2019 12:45:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSg3vuTFrc7QLeVh9twoJ7MBZtBF7cAQMHeTx6wOV0Q=;
 b=GA2tJO5yoMbg0f8Z5A5RcBVV0bdiL7UMXqZ/YbJRVuSy9b9tqKJhB/kItYCsexk64mtLTHzzurXsIdugJkYtSBP1WLv48VQYkh8OPDaAv7bIN2SZlZheou2KHUfoIoohUpdPnrJYENXb7ygRK3O3STmFnE6y/R+zi3hT+MGxLK4=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2231.namprd15.prod.outlook.com (52.135.196.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 8 Jan 2019 20:45:19 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::e12c:c450:3e9f:4ef6]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::e12c:c450:3e9f:4ef6%4]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 20:45:19 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHzTcneBvFiJEmnpKLooFaM96Wl8IGAgAAEeQA=
Date:   Tue, 8 Jan 2019 20:45:19 +0000
Message-ID: <dd3ca24b-4da5-b0b1-9d1c-e5ed3fe297d2@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108202915.GE30894@hirez.programming.kicks-ass.net>
In-Reply-To: <20190108202915.GE30894@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:958e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2231;20:pk35UwuCpwtvA8EeUY2Ce/+11iPCFbk0OaW4pc0a/amr1KmLSqmlD7+kOTrk82ZlQ7B0/pOgsveW5/f72ja0gAlle+Q4/D6dMBOOF4ShZFrAnRLaojpNPVm+Q/b2IkpWCKjJWDL9pkR5NeGSqk8zUbkqxqWynaRuSGWYL1dxOlc=
x-ms-office365-filtering-correlation-id: 5932dd50-b011-48cd-be42-08d675aa33d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2231;
x-ms-traffictypediagnostic: BYAPR15MB2231:
x-microsoft-antispam-prvs: <BYAPR15MB223181524FD344849633BE7BD78A0@BYAPR15MB2231.namprd15.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(478600001)(31696002)(99286004)(6246003)(316002)(31686004)(575784001)(86362001)(229853002)(105586002)(76176011)(6506007)(14454004)(6512007)(36756003)(7736002)(305945005)(4326008)(52116002)(53936002)(110136005)(54906003)(25786009)(6486002)(106356001)(6436002)(2616005)(53546011)(11346002)(446003)(6116002)(8676002)(2906002)(386003)(81166006)(81156014)(71190400001)(71200400001)(8936002)(6636002)(486006)(256004)(476003)(5660300001)(97736004)(68736007)(46003)(102836004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2231;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XgNyjwZeXIBwspQyU3Jf+4eKWCq003BE1MGbHvUTd/XhGvU8g6ELjmHNHaabAmXB7M+q1UbaH+lP1Ronw7RO8z7ra0w/o3j5i/tfOlqsOG2b6ZBCw5wYQ2+p7MzVr9Y2U3Ongu2tFkpmLxbHJcoEItxsJAKJSuzFCyVMP0cHWJkcHGYwbM+TDTW0UomlHt7U3z/eGQKvUb066Mpcum4ZTc7dfu2cIXygyqv+/Fi6o+5d2RjV9l04lidxPDkwc5BbgHQ4DHte/o+kulgBDTlwu8dDLCzYjQu/Cw++o8Kh4AAoHVXojiN8Nrc2gu8XOSUv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF1A7043D2CE3C4EB102CF4FF1A30F60@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5932dd50-b011-48cd-be42-08d675aa33d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 20:45:19.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2231
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS84LzE5IDEyOjI5IFBNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MjAsIDIwMTggYXQgMTA6Mjk6MDBBTSAtMDgwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBUaGUgZm9s
bG93aW5nIGV4YW1wbGUgc2hvd3Mga2VybmVsIHN5bWJvbHMgZm9yIGEgQlBGIHByb2dyYW0gd2l0
aCA3DQo+PiBzdWIgcHJvZ3JhbXM6DQo+Pg0KPj4gICAgICBmZmZmZmZmZmEwMjU3Y2Y5IHQgYnBm
X3Byb2dfYjA3Y2NiODkyNjdjZjI0Ml9GDQo+PiAgICAgIGZmZmZmZmZmYTAyNTkyZTEgdCBicGZf
cHJvZ18yZGNlY2MxODA3MjYyM2ZjX0YNCj4+ICAgICAgZmZmZmZmZmZhMDI1YjBlOSB0IGJwZl9w
cm9nX2JiN2E0MDVlYmFlYzVkNWNfRg0KPj4gICAgICBmZmZmZmZmZmEwMjVkZDJjIHQgYnBmX3By
b2dfYTc1NDBkNGEzOWVjMWZjN19GDQo+PiAgICAgIGZmZmZmZmZmYTAyNWZjY2EgdCBicGZfcHJv
Z18wNTc2MmQ0YWRlMGUzNzM3X0YNCj4+ICAgICAgZmZmZmZmZmZhMDI2MTA4ZiB0IGJwZl9wcm9n
X2RiNGJkMTFlMzVkZjkwZDRfRg0KPj4gICAgICBmZmZmZmZmZmEwMjYzZjAwIHQgYnBmX3Byb2df
ODlkNjRlNGFiZjBmMDEyNl9GDQo+PiAgICAgIGZmZmZmZmZmYTAyNTdjZjkgdCBicGZfcHJvZ19h
ZTMxNjI5MzIyYzRiMDE4X19kdW1teV90cmFjZXBvaQ0KPiANCj4gV2Ugc2hvdWxkIHByb2JhYmx5
IHNwZWNpZnkgc29tZXdoZXJlIHRoYXQgdGhlIG5hbWUgY2FuIGluY2x1ZGUgYQ0KPiAnW21vZHVs
ZV0nIHBhcnQganVzdCBsaWtlIG5vcm1hbCBrYWxsc3ltcy4gRXZlbiB0aG91Z2ggeW91IGRvbid0
DQo+IGN1cnJlbnRseSB1c2UgdGhhdC4NCg0KdGhlcmUgaXMgbm8gW21vZHVsZV0gZXF1aXZhbGVu
dCBpbiBicGYgbGFuZC4NClRoZSBwcm9ncyBsb2FkZWQgYnkgZGlmZmVyZW50IHVzZXJzIGNhbiBi
ZSBzaGFyZWQuDQpUaGVyZSBpcyBubyBzdHJpY3QgdHJlZSBoaWVyYXJjaHkgKGxpa2UgaW4gbW9k
dWxlcykNCndoZXJlIHRoZXJlIGlzIG9uZSByb290IGFuZCBhIGJ1bmNoIG9mIGZ1bmN0aW9uIHVu
ZGVybmVhdGguDQpJbiBicGYgYWxsIHRoZXNlIGZ1bmN0aW9ucyBmb3JtIGEgZ3JhcGggYW5kIGNh
biBjYWxsIGVhY2ggb3RoZXIuDQpTYW1lIHdpdGggbWFwcyB0aGF0IGFyZSBzaGFyZWQgYnkgZGlm
ZmVyZW50IHByb2dzIG9mIGRpZmZlcmVudCB0eXBlcy4NCkxpa2UgbmV0d29ya2luZyBwcm9nIGFu
ZCB0cmFjaW5nIHByb2cgY2FuIHNoYXJlIGNvbW1vbiBtYXAuDQo=
