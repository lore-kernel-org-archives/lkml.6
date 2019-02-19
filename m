Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590BE2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfBSS2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:28:48 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:47632 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbfBSS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:28:48 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JIL2v1023337;
        Tue, 19 Feb 2019 18:28:34 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qrnxt0qw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 18:28:33 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 0F9E560;
        Tue, 19 Feb 2019 18:28:33 +0000 (UTC)
Received: from G9W8675.americas.hpqcorp.net (16.220.49.22) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 19 Feb 2019 18:28:32 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8675.americas.hpqcorp.net (2002:10dc:3116::10dc:3116) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 19 Feb 2019 18:28:32 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 19 Feb 2019 18:28:31 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.137) by
 TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM (10.169.42.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 18:28:30 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f5e1:9059:8c64:1c71]) by TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f5e1:9059:8c64:1c71%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 18:28:30 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] mm: fix set but not used warning
Thread-Topic: [PATCH -next] mm: fix set but not used warning
Thread-Index: AQHUx5ARxxbKeXrWSEq+/TbHBuAm+aXnclmA
Date:   Tue, 19 Feb 2019 18:28:30 +0000
Message-ID: <7425c8905127ddd078500d4c14a2147bd00422a0.camel@hpe.com>
References: <20190218135743.131904-1-yuehaibing@huawei.com>
In-Reply-To: <20190218135743.131904-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.203.227.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b57b93-d813-4bd7-dc25-08d696980c85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0382;
x-ms-traffictypediagnostic: TU4PR8401MB0382:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtUVTRQUjg0MDFNQjAzODI7MjM6N1V4QkpTOEljb2thUEV2SldMRjFubVVT?=
 =?utf-8?B?U3FSWGtyalVrSm1oV0UwckxtMDhuaGJ1TGF4c2lTOWZRS2dGWllEczhvem4w?=
 =?utf-8?B?N0hjdmcwV0cyK2c5NTVWeUcvUDB0L3A0WlBnZ2U5ZFNrbWU1bXBiODBlZElt?=
 =?utf-8?B?VUpBVHpuZVI4aDJZcmkwSDVXNGh1YmtrUHlCZzMzMzhSM09Ia25Ba0g0YTQz?=
 =?utf-8?B?Nk94d1U0cDkwbzhVSVJ0OHkweE1JZlBPa3lkRlFtczhUeitQYVQ5S2dGUDA3?=
 =?utf-8?B?bzhuOWFTdHRydWdBb04rQ2hlSWRLQjV4Wk1Ec0dzcGJZYkxZWGdRbm9Ua3Y1?=
 =?utf-8?B?U2tuQ3dnZ2xLYjZYNktvV0ZaZjNBNmNpNjV5aGZ0cWtsTWtGaUlJODhnYTBE?=
 =?utf-8?B?MnpBbXhjaUExODVUV3crWEx6REtoN2duUnZuN0hTZmRpeE94MWNZVUx2Yk5O?=
 =?utf-8?B?aXdxUFFWdDRqR0d5WXFDcXc4NWNtYUxWem4vYzZwbEVTSldMMFloMDlXN1NS?=
 =?utf-8?B?K1h2SVBJTDJxcGwwSHFiWGlibnNLcVVpSTdzUEdkWlFIZjlRMGNRc0Q5Q0NY?=
 =?utf-8?B?cXlyM1ZjNlhYUWpxZlZCc2NVb3dUYWdERlJwaDU3SkdHRWFXc0ZzZGJEZ3lG?=
 =?utf-8?B?a2FZeEtVMllPdVlRM3hIY2pOYmljVHhEN1hRNnE3STMwM2l4UFQ3bTRmUDZh?=
 =?utf-8?B?cW0rYndxVWxoT0FPM0xSbHhuQWFXMGUzUmhSZTRCT01NN0VBSW9nbHZxRTR6?=
 =?utf-8?B?YmJqQXQyS25vVy8wWlRIa0k1S084RHRLRVFUeHBYL0F4RzBEb0lXQ2xDYnN5?=
 =?utf-8?B?clFQb2w5b0p2TUJuU3NaN2lDUXAxd2I1NFNsOWVnT3phVmV0NmVScnRyNjZt?=
 =?utf-8?B?TnhRSExieGFPaXFpRDNaYUoxL0xacExmd2VzZXJlNG95OUtFODR1OVlLajRW?=
 =?utf-8?B?RHFqTlU0TG9JRU9vbHAxTWhiM0pmSjZTOVpCZzlsdG5lSk91Tk9HdExiOXdk?=
 =?utf-8?B?ZUlEcFh5aW1QZHZmYWRZNy8veE9GWWFiazNVZWd4L0toR2x0MVpUang2MzVt?=
 =?utf-8?B?ZVczUkgxWU1RK2t3bElIVC93eWZ3L1BrWTErZEtDbFpkQTlCSUFkek9ENGxp?=
 =?utf-8?B?NGFMZUxCamp2Rm1uczJIbjVXTGJyU2RPRDB6MjF1d3FnMjVuRlBGSVN0TU9r?=
 =?utf-8?B?RnUwaks3a0FxVExPakFmMHJpU01sZHRQcTZhYlIzSjFycTZsdkp5SkJtNFNi?=
 =?utf-8?B?dnFZNEE0RnM2THM1K0RhekdXbWl2Q2ZVdG1vcENRYXorUVFhUm1YRHlEaFFq?=
 =?utf-8?B?cGZ3UXE5TEJyYXhoL1ZkM1hGQllCTjNVaTRUak1KUHBlN0FLT1hRYlAyOVJu?=
 =?utf-8?B?WWtFbnRMWWowMGJpUGxXZWFiZ20zUmxyeDlsdXpqYWVRWkg5dGRHYVJpSmN3?=
 =?utf-8?B?OFozN0R5dlltRDNrbHBUU3FMa0dtdW10QTlMbGVtbVN2d2p5dGgwbXBiSm1x?=
 =?utf-8?B?MzdjZ0ZHL2phQTZRTnM2bGJFbDVYaTRPY291SUJZa1ZNOG92OUtBY2YvMnNM?=
 =?utf-8?B?TDBocFpqRm9xR0FqV2xjWG85UWFKNS9sMXVDQVQ4V1RaZHdBTDV6LzNzcjlJ?=
 =?utf-8?B?bGZOeE9MaGh4TzE2RW8xR2RMSndCQ1FrcCtCMEd1Slo2MDJYemlBRGpZcVJ6?=
 =?utf-8?Q?+wCxH/BbXcH9WVr5WIwQ=3D?=
x-microsoft-antispam-prvs: <TU4PR8401MB0382414590AC0C08746ECD9C827C0@TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(376002)(366004)(199004)(189003)(105586002)(8676002)(81156014)(8936002)(4326008)(106356001)(36756003)(81166006)(6246003)(2501003)(26005)(3846002)(6116002)(5660300002)(14454004)(478600001)(25786009)(2616005)(118296001)(186003)(11346002)(86362001)(2201001)(476003)(446003)(486006)(68736007)(2906002)(71190400001)(7736002)(97736004)(305945005)(71200400001)(54906003)(316002)(14444005)(102836004)(53936002)(229853002)(256004)(6512007)(110136005)(6436002)(6486002)(99286004)(76176011)(6506007)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0382;H:TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bLR5MhreO/ajTCah8XGDDrqP6Yyj8/m6wFGGvEpq6JfF9jNr6t+H8axsUKMT+/WpPZm2qhq71YQpJ/3CgOh8UVuGfFs0lG3Ivjvuqn/+Z8CG2JohNaD6XPHMrA7cewe0nKxERnMJTZYXQfzMOEiBXbf6JY/+9NcjirxLTQL2i0fMwZRNwhESjlgBYtxD1bNzKIsnPtTHLOhtlu0rm41+HXJqYdQo5ALD4u0QFTq2qRrGkGtQL8ZXeuKB/fTdgpa9WP+jLU3rpYq7cFedAIMa9A/+ZhQUYvh1gYUI3Zg26XGRzWWFeAZnJUOgkSr4LWoMYpEks8ihVtFYQC5Ok8qSRGLBehVzvobvt6DOuRmswhk8Fgu5uFdIoMUeSYjn+OjSdMyG6JB9BxnRhsTZRFsp+JVxt/5VigT7sY6DobNiEwM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F47A6D1A5BBC4092F2EB6306EC482C@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b57b93-d813-4bd7-dc25-08d696980c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 18:28:30.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0382
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTE4IGF0IDEzOjU3ICswMDAwLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBG
aXhlcyBnY2MgJy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6DQo+IA0KPiBsaWIv
aW9yZW1hcC5jOiBJbiBmdW5jdGlvbiAnaW9yZW1hcF9wYWdlX3JhbmdlJzoNCj4gbGliL2lvcmVt
YXAuYzoyMDM6MTY6IHdhcm5pbmc6DQo+ICB2YXJpYWJsZSAnc3RhcnQnIHNldCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+IA0KPiBmbHVzaF9jYWNoZV92bWFwIG1h
eSBubyBuZWVkIHBhcmFtLCBzbyBhZGQgX19tYXliZV91bnVzZWQgZml4IHRoaXMgd2FybmluZy4N
Cg0KSSB0aGluayBmbHVzaF9jYWNoZV92bWFwIHNob3VsZCBoYXZlIGEgcHJvcGVyIHByb3RvdHlw
ZSB3aXRoDQpfX21heWJlX3VudXNlZCBmb3IgaXRzIGFyZ3MuICBCdXQsIHRoZXJlIGFyZSBzbyBt
YW55IGFyY2gtc3BlY2lmaWMNCmRlZmluaXRpb25zIGF0IGdsYWNlLCBhbmQgSSBhbSBub3Qgc3Vy
ZSBob3cgbWFuYWdlYWJsZSBzdWNoIGNoYW5nZSBpcywNCnRob3VnaC4uLg0KDQpUaGFua3MsDQot
VG9zaGkNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3
ZWkuY29tPg0KPiAtLS0NCj4gIGxpYi9pb3JlbWFwLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIv
aW9yZW1hcC5jIGIvbGliL2lvcmVtYXAuYw0KPiBpbmRleCAwNjMyMTM2ODU1NjMuLmQxYzdhNDg4
ZTczMSAxMDA2NDQNCj4gLS0tIGEvbGliL2lvcmVtYXAuYw0KPiArKysgYi9saWIvaW9yZW1hcC5j
DQo+IEBAIC0yMDAsNyArMjAwLDcgQEAgaW50IGlvcmVtYXBfcGFnZV9yYW5nZSh1bnNpZ25lZCBs
b25nIGFkZHIsDQo+ICAJCSAgICAgICB1bnNpZ25lZCBsb25nIGVuZCwgcGh5c19hZGRyX3QgcGh5
c19hZGRyLCBwZ3Byb3RfdCBwcm90KQ0KPiAgew0KPiAgCXBnZF90ICpwZ2Q7DQo+IC0JdW5zaWdu
ZWQgbG9uZyBzdGFydDsNCj4gKwl1bnNpZ25lZCBsb25nIF9fbWF5YmVfdW51c2VkIHN0YXJ0Ow0K
PiAgCXVuc2lnbmVkIGxvbmcgbmV4dDsNCj4gIAlpbnQgZXJyOw0KPiANCj4gDQo+IA0K
