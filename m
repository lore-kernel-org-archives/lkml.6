Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1597C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C46F21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfBTAHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:07:21 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:56342 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728703AbfBTAHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:07:20 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1K0639Z017347;
        Wed, 20 Feb 2019 00:07:18 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qrqmwsyk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 00:07:18 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 4A5CB62;
        Wed, 20 Feb 2019 00:07:17 +0000 (UTC)
Received: from G9W8677.americas.hpqcorp.net (16.220.49.24) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 20 Feb 2019 00:06:50 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G9W8677.americas.hpqcorp.net (2002:10dc:3118::10dc:3118) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 20 Feb 2019 00:06:50 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 00:06:49 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.137) by
 TU4PR8401MB0734.NAMPRD84.PROD.OUTLOOK.COM (10.169.45.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 00:06:41 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f5e1:9059:8c64:1c71]) by TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f5e1:9059:8c64:1c71%2]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 00:06:41 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.rusocki@intel.com" <krzysztof.rusocki@intel.com>,
        "erwin.tsaur@oracle.com" <erwin.tsaur@oracle.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 0/6] nfit/ars: Improve polling and short-ARS execution
Thread-Topic: [PATCH v2 0/6] nfit/ars: Improve polling and short-ARS execution
Thread-Index: AQHUxWiOf0lIddPKYUGTPGFy5Nx5HKXn1SSA
Date:   Wed, 20 Feb 2019 00:06:40 +0000
Message-ID: <c22589614fa279421b77163aeddeea99fa23be05.camel@hpe.com>
References: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.203.227.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e350edb-0162-4b70-baee-08d696c74a66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0734;
x-ms-traffictypediagnostic: TU4PR8401MB0734:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtUVTRQUjg0MDFNQjA3MzQ7MjM6N0JFNjN6NmdCTkZXOE0zWnVOZk9kOXVX?=
 =?utf-8?B?eFVibWt2cTVXZmVER3YwSnVrOTZpanlFRmkwcm5OemZCYlJVc3VVNTBJKzBK?=
 =?utf-8?B?WmlOVmVwTDFxWlR4cDZVMERKWCszSEl6ZHJsZ01vdGllTDlhRkg3U2NWWWxp?=
 =?utf-8?B?Qm52NElaY09walhDMEZZZktRNmtVWEhISnowa2Q5UEZaZENuZjE3Q0I0bm1Q?=
 =?utf-8?B?eHhpWFNxeDBCK2RpaEJxb0N0Z2E3RnpRWVJKVkk3SEd1N2pGQWNLWDRRNkx6?=
 =?utf-8?B?Nkh6R3Bza3VpQVlnUm80MEx5ZUdjUTVJQS8vM2xVbEszQ0lRYXJHenJVNHc2?=
 =?utf-8?B?bXp6MHpMMXFvYlJCY3YrSjY4aUtXWjAvSVEzRUJhMzhEUlNVSjRURDNlYTND?=
 =?utf-8?B?SU9vSnYwbnVkMjZxNWtpc1dUZDZ0aDJ6U01LRWdqZ2tIN3hlR2tsYno2RXE5?=
 =?utf-8?B?YTUvNVkvemJwQW1LTDZYSTQzbFNxb0pYR3RhakdDcndNNnJtbkhiZ0NVaW4x?=
 =?utf-8?B?ODV2WWhFNjlUemtjM3lOZlpCTS9TSDJhcWxVTDE2R1pmMVE0T1E5aFdjVE9k?=
 =?utf-8?B?LzVtTiszK2hNOG5NcXRjTGZPbDdaTkZCL0VxOUV2bmIxekFhWjFEK1FNa1lm?=
 =?utf-8?B?Z0J0L0FrMGRJQ1dqeUdmTG1YZjV0Q3RGTjFSdzEvVS9HcXhtQXdhMGxDRlVu?=
 =?utf-8?B?bUdKMzdIMHUwc1Z4UkFrSjlWcFZnejJQZFlkb1Q1NWE0RXgzUHFiUkZRa0Ni?=
 =?utf-8?B?eFYrNk1CTjZDRzZGaXRYU2xud1pXOEhXK2ZVVUl2S1ZCTks4QndkblRVSlJj?=
 =?utf-8?B?Z243cENYNllsM2Q0SWNPeXYydWxjSWV5MEdhSnFFcHRKZEtLQWVyU2tlSitt?=
 =?utf-8?B?K09WU3U2czFzYzZVVnFLOVJkMStaUW9seW9RSkphajk3YzhqZXpJNU01b3U5?=
 =?utf-8?B?VGZ6ZXU3VVMrM0ppUFlGUUR0RDd3OGNDZUl2WTZyMEh1aGhoWHhXK1hWZk5t?=
 =?utf-8?B?aTVzUG0vUGZ4VDlsQVRwU3hEaTZxeElSemZhZjdsNk9xbTYwL0JHcGR6ZlVD?=
 =?utf-8?B?ekY5R0Y1Nk5DZ1JDY2lLQnBBS1lvN2NWd0ZVTGZ0ZmtpZmhvcytLWW1taVRr?=
 =?utf-8?B?VjdFRGhyWTBpTVRldEFjem56MU1tUkhzTjBYN3hZQTRtRCtsTUx4VnBZdlo5?=
 =?utf-8?B?bVhLajJTekpsU0VIU1EwR1lXcHYrU2szTzllTUVPSUMxTVl4K1VUZkVkMlFu?=
 =?utf-8?B?SUlUZDJKSnViTmUzc0xyRzVDeVNVQ3lnZ1NkVGI0TzlZMEJWYzI1Qm1RbURu?=
 =?utf-8?B?eUVUN0M3T0N2R0llSjNBLzEvRUc5M3UzaG9rY0pZNE5XZXFBMGRISW1IMFYz?=
 =?utf-8?B?aXBqVkhFYXZBSTlBYm1KSjdzV3poRDgzRnZZcnRRZkFNZTVBSTVTZU1zVjBN?=
 =?utf-8?B?cFRrTG5YVnJ6S2wxaWQvSU9XdUVhbm1tZnhxeWxVT2w1b3RoSTd1dFlRRzVO?=
 =?utf-8?B?d2tpT3ZUUGgvMEpVMThtcGttOTQzaWJCMzhSNHRlU3h4MzdydGVPTWxhclUx?=
 =?utf-8?B?M2FIVjAwajhLci9WU3NxcG10WEJTMHl3L2E2SGJ4bUE3YnRtWWpVL0gwd0du?=
 =?utf-8?B?blhFUzNFMFNzMHplbjRsMEJHRHI4NkUwRHZ3Tk9ld3pkWU90Ni9qUjNxcGJi?=
 =?utf-8?Q?a3iVD/GUu9DlenPLLzEg=3D?=
x-microsoft-antispam-prvs: <TU4PR8401MB073484870272EADA489B8DC2827D0@TU4PR8401MB0734.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(110136005)(8676002)(14454004)(478600001)(6246003)(68736007)(476003)(966005)(2616005)(66066001)(81166006)(81156014)(486006)(6116002)(446003)(7736002)(2906002)(54906003)(305945005)(8936002)(3846002)(105586002)(316002)(186003)(26005)(97736004)(11346002)(118296001)(106356001)(4326008)(25786009)(229853002)(99286004)(36756003)(6506007)(6436002)(256004)(76176011)(2501003)(86362001)(6306002)(6512007)(102836004)(5660300002)(71200400001)(71190400001)(53936002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0734;H:TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WNMUaPF7vK0OLtul2UF2Z3pFBApQ01PkIPohLEoqCCUr7EoVev0p5CRH991XqxK3AYa0hvRncFI+SqiPG3i0hrD0qPi4d8UMYrstSgkaKx2BWG2CM+Ja4+FqhbQx+lmctIbFP/bdRzv3f8GqRWjisgkh+Wyi/Gdt5rfUDfYqt+2wy782J/eHo928xpWc4IrmmoLMciH2u/h2Gth1CgnGQ2QAiNscLDGZB9oDUrQGLz15E9ery8XkX4tj5bdSDmaHWm7UJWj75OvuSAFK86WvxN87zW4WO7tzdntW2PAtoc2cSaS50TqwfVSWuh2LYfHfn3cywcxLbZgOBkL3iIi3/k3cJI9DZ9ja/15OgAirDORni0O/VRmYqbWjcMdv5bXZqUI6GQD5ChOWc9FHSzU0W2c3Y2W8CksaOAMRATmHpp8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F0D99A0D997CE40AC55572585945C39@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e350edb-0162-4b70-baee-08d696c74a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 00:06:40.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0734
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTAyLTE1IGF0IDExOjQzIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IENoYW5nZXMgc2luY2UgdjE6IFsxXQ0KPiAqIEZpeCB0aGUgcm9vdCBwb2xsIGludGVydmFsIHN1
cHBvcnQgdG8gYXZvaWQgYSBpbmZpbml0ZSBsb29wIGNvbmRpdGlvbg0KPiAgIHdoZW4gdGhlIHBv
bGxpbmcgaXMgZmFzdGVyIHRoYW4gdGhlIEFSUyBjb21wbGV0aW9uLg0KPiAqIE1vdmUgdGhlIGlu
dHJvZHVjdGlvbiBvZiBzY3J1Yl9mbGFncyBlYXJsaWVyIGluIHRoZSBzZXJpZXMgYW5kDQo+ICAg
aW50cm9kdWNlIEFSU19QT0xMIHRvIGZpeCB0aGUgYWJvdmUgaXNzdWUuDQo+IA0KPiBbMV06IGh0
dHBzOi8vbGlzdHMuMDEub3JnL3BpcGVybWFpbC9saW51eC1udmRpbW0vMjAxOS1GZWJydWFyeS8w
MTk5NjQuaHRtbA0KPiANCj4gLS0tDQo+IA0KPiBIZXJlIGlzIGEgc21hbGwgcGlsZSBvZiB1cGRh
dGVzIHRvIGJldHRlciBjb29yZGluYXRlIHRoZSBMaW51eCBBUlMgc3RhdGUNCj4gbWFjaGluZSB3
aXRoIHBsYXRmb3JtLUJJT1MgaW1wbGVtZW50YXRpb25zLiBTcGVjaWZpY2FsbHksIHRha2UgYWR2
YW50YWdlDQo+IG9mIG9wcG9ydHVuaXRpZXMgdG8gcnVuIHNob3J0LUFSUyB3aGVuZXZlciB0aGUg
QVJTIGludGVyZmFjZSBpcyBmb3VuZCB0bw0KPiBiZSBpZGxlIGF0IGluaXQsIGFsd2F5cyBydW4g
c2hvcnQtQVJTIGV2ZW4gaWYgbm9faW5pdF9hcnMgaXMgc3BlY2lmaWVkLA0KPiBhbGxvdyByb290
IHRvIHJlc2V0IHRoZSBleHBvbmVudGlhbCBiYWNrb2ZmIHBvbGxpbmcgaW50ZXJ2YWwgZm9yIEFS
Uw0KPiBjb21wbGV0aW9uLCBhbmQgcHJvdGVjdCB0aGUga2VybmVsIGFnYWluc3QgdGhlIGNvbnN1
bXB0aW9uIG9mIHN0YWxlIEFSUw0KPiByZXN1bHRzLg0KPiANCj4gLS0tDQo+IA0KPiBEYW4gV2ls
bGlhbXMgKDYpOg0KPiAgICAgICBuZml0L2FyczogQXR0ZW1wdCBhIHNob3J0LUFSUyB3aGVuZXZl
ciB0aGUgQVJTIHN0YXRlIGlzIGlkbGUgYXQgYm9vdA0KPiAgICAgICBuZml0L2FyczogQXR0ZW1w
dCBzaG9ydC1BUlMgZXZlbiBpbiB0aGUgbm9faW5pdF9hcnMgY2FzZQ0KPiAgICAgICBuZml0L2Fy
czogUmVtb3ZlIGFyc19zdGFydF9mbGFncw0KPiAgICAgICBuZml0L2FyczogSW50cm9kdWNlIHNj
cnViX2ZsYWdzDQo+ICAgICAgIG5maXQvYXJzOiBBbGxvdyByb290IHRvIGJ1c3ktcG9sbCB0aGUg
QVJTIHN0YXRlIG1hY2hpbmUNCj4gICAgICAgbmZpdC9hcnM6IEF2b2lkIHN0YWxlIEFSUyByZXN1
bHRzDQo+IA0KPiANCj4gIGRyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyB8ICAgNzAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9hY3BpL25m
aXQvbmZpdC5oIHwgICAxMSArKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlv
bnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQpUaGUgY2hhbmdlcyBsb29rIGdvb2QgdG8gbWUuICBG
b3IgdGhlIHNlcmllczoNCg0KUmV2aWV3ZWQtYnk6IFRvc2hpIEthbmkgPHRvc2hpLmthbmlAaHBl
LmNvbT4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
