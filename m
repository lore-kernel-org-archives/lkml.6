Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E7C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F19C2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e6PaRm8B";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jBVYjOQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeKGJmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:42:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43406 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbeKGJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:42:46 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA708qj2030419;
        Tue, 6 Nov 2018 16:14:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3KVrX5JeYRJjncfddEyhTfKK7oER0n7MU5/KXpWZX6A=;
 b=e6PaRm8Bf2aWg3GeSUarOvQkmYusz1Q8yWZFdZjM+sNEMRJ6oDrRlmBJJtmKg4urlGm9
 w6ExWi65bSuOZZVL1Msfr2CZz55BFaHioG/FaaKezEI6GwLJKH4HDOEi0imtMKxwsUSC
 IguAo2+sOhMfhGetw8dx2WPSR4S6Hd0HHPY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkkqg09y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 16:14:15 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 16:14:14 -0800
Received: from FRC-CHUB13.TheFacebook.com (2620:10d:c021:18::32) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 16:14:14 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Nov 2018 19:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KVrX5JeYRJjncfddEyhTfKK7oER0n7MU5/KXpWZX6A=;
 b=jBVYjOQKlzaFlrDTZI0wtIB2Q/qimCZB7bmo30HLoqwRlazaotow1gOJ4n0dzaHfe4t/iaqLi5sXn3oArXS+Y/80mnwOZKCTqpakobds8P1XFZlQl/Tt0RdF01zBn/QVBZajgZhJiVJOPgj6HN5rjvuSQDlVMa2hJNC2dOKN+Uk=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2392.namprd15.prod.outlook.com (52.135.198.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 7 Nov 2018 00:13:56 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 00:13:56 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     David Miller <davem@davemloft.net>
CC:     Song Liu <songliubraving@fb.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUdhL1gT1g6kXc4U+H9DJqSIZu3qVDSleAgAAXY4CAAAMiAIAAAiiAgAAKXoA=
Date:   Wed, 7 Nov 2018 00:13:56 +0000
Message-ID: <39fe6abc-5c3e-bac3-0c0b-cf68bea23ab0@fb.com>
References: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
 <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
 <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
 <20181106.153647.1701013551426767213.davem@davemloft.net>
In-Reply-To: <20181106.153647.1701013551426767213.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:62d8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2392;20:wOK3PaVoOvmQqU9U0NEXYdlR0FpohzIAZJerW1nrgDFX8ho+PKihkVfazKOEDEKXC261Zp/KMGp8cXHWCSWcD9rDjRJCG4wIGxOONi1PZ8gK2h3JUCeUEEbIMK0b3KXPOD5QYNcOQcqFtN0Q+idvMga8wJ135F0CyOXXzBVts9w=
x-ms-office365-filtering-correlation-id: 48ecffdf-eca3-402a-98aa-08d64445e847
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2392;
x-ms-traffictypediagnostic: BYAPR15MB2392:
x-microsoft-antispam-prvs: <BYAPR15MB23928377DC5D7AC4905A7220D7C40@BYAPR15MB2392.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2392;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2392;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(6486002)(81156014)(53936002)(229853002)(6916009)(6116002)(316002)(6436002)(36756003)(81166006)(8676002)(6246003)(6512007)(8936002)(2906002)(97736004)(99286004)(54906003)(39060400002)(5660300001)(305945005)(7736002)(93886005)(106356001)(186003)(46003)(105586002)(52116002)(14454004)(53546011)(6506007)(386003)(68736007)(76176011)(256004)(478600001)(2616005)(102836004)(2900100001)(86362001)(11346002)(446003)(476003)(486006)(31696002)(71190400001)(31686004)(4326008)(25786009)(71200400001)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2392;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YdKUTkuHh8esfMdwFEUg3INHsyeiH+p9+S3AudoVkMKIuLyVaNCTQafwWVF1TWx+d9tvsRadirNTk9BDEaygrcgqmGILRnMPDYV7FGcSUimvSNqLrgfvYtcX362dtGC4Yi8EK3V4EjPECouygjkQUuQRyW01Fzl+/oMf4KdgrSRMMvrwPnCdHZpPe35j9cOm+hGOdwLHRjroTiJOMd1qXB0XLCfpojq/F1i0jzuqERzXO8RUpKmTm5A1hGbpqHCkZpFj0e4TW0kgJ6q+APkDH5wlD/hcaukwnOTOjvM7E3XgdLVmSb5+bkRNnzjLnu8rUm9AznKwrMjYqwUd7/hK/Fr74dfd5VQnwjMrTHTVoxE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F2F4D50ED54244AA3E8765E7C7B727E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ecffdf-eca3-402a-98aa-08d64445e847
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 00:13:56.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2392
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNi8xOCAzOjM2IFBNLCBEYXZpZCBNaWxsZXIgd3JvdGU6DQo+IEZyb206IEFsZXhlaSBT
dGFyb3ZvaXRvdiA8YXN0QGZiLmNvbT4NCj4gRGF0ZTogVHVlLCA2IE5vdiAyMDE4IDIzOjI5OjA3
ICswMDAwDQo+IA0KPj4gSSB0aGluayBjb25jZXJucyB3aXRoIHBlcmYgb3ZlcmhlYWQgZnJvbSBj
b2xsZWN0aW5nIGJwZiBldmVudHMNCj4+IGFyZSB1bmZvdW5kZWQuDQo+PiBJIHdvdWxkIHByZWZl
ciBmb3IgdGhpcyBmbGFnIHRvIGJlIG9uIGJ5IGRlZmF1bHQuDQo+IA0KPiBJIHdpbGwgc2l0IGlu
IHVzZXJzcGFjZSBsb29waW5nIG92ZXIgYnBmIGxvYWQvdW5sb2FkIGFuZCBzZWUgaG93IHRoZQ0K
PiBwZXJzb24gdHJ5aW5nIHRvIG1vbml0b3Igc29tZXRoaW5nIGVsc2Ugd2l0aCBwZXJmIGZlZWxz
IGFib3V0IHRoYXQuDQo+IA0KPiBSZWFsbHksIGl0IGlzIGluYXBwcm9wcmlhdGUgdG8gdHVybiB0
aGlzIG9uIGJ5IGRlZmF1bHQsIEkgY29tcGxldGVseQ0KPiBhZ3JlZSB3aXRoIERhdmlkIEFoZXJu
Lg0KPiANCj4gSXQncyBoYXJkIGVub3VnaCwgX0FTIElTXywgZm9yIG1lIHRvIGZpZ2h0IGJhY2sg
YWxsIG9mIHRoZSBibG9hdCB0aGF0DQo+IGlzIGluIHBlcmYgcmlnaHQgbm93IGFuZCBnZXQgaXQg
YmFjayB0byBiZWluZyBhYmxlIHRvIGhhbmRsZSBzaW1wbGUNCj4gZnVsbCB3b3JrbG9hZHMgd2l0
aG91dCBkcm9wcGluZyBldmVudHMuLg0KDQpJdCdzIGEgc2VwYXJhdGUgcGVyZiB0aHJlYWQgYW5k
IHNlcGFyYXRlIGV2ZW50IHdpdGggaXRzIG93biBlcG9sbC4NCkkgZG9uJ3Qgc2VlIGhvdyBpdCBj
YW4gYWZmZWN0IG1haW4gZXZlbnQgY29sbGVjdGlvbi4NCkxldCdzIHB1dCBpdCB0aGlzIHdheS4g
SWYgaXQgZG9lcyBhZmZlY3Qgc29tZWhvdywgdGhlbiB5ZXMsDQppdCBzaG91bGQgbm90IGJlIG9u
LiBJZiBpdCBpcyBub3QsIHRoZXJlIGlzIG5vIGRvd25zaWRlIHRvIGtlZXAgaXQgb24uDQpUeXBp
Y2FsIHVzZXIgZXhwZWN0cyB0byB0eXBlICdwZXJmIHJlY29yZCcgYW5kIHNlZSBldmVyeXRoaW5n
IHRoYXQNCmlzIGhhcHBlbmluZyBvbiB0aGUgc3lzdGVtLiBSaWdodCBub3cgc2hvcnQgbGl2ZWQg
YnBmIHByb2dyYW1zDQp3aWxsIG5vdCBiZSBzZWVuLiBIb3cgdXNlciBzdXBwb3NlIHRvIGV2ZW4g
a25vdyB3aGVuIHRvIHVzZSB0aGUgZmxhZz8NClRoZSBvbmx5IG9wdGlvbiBpcyB0byBhbHdheXMg
cGFzcyB0aGUgZmxhZyAnanVzdCBpbiBjYXNlJw0Kd2hpY2ggaXMgdW5uZWNlc3NhcnkgYnVyZGVu
Lg0KVGhlIHByb2JsZW0gb2YgZHJvcHBlZCBldmVudHMgaXMgY2VydGFpbmx5IHZhbGlkLCBidXQg
aXQncw0KYSBzZXBhcmF0ZSBpc3N1ZS4gVGhlIGFpbyBzdHVmZiB0aGF0IEFsZXhleSBCdWRhbmtv
diBpcyB3b3JraW5nIG9uDQpzdXBwb3NlIHRvIGFkZHJlc3MgdGhhdC4NCg==
