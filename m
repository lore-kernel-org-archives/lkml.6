Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D707C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lJNELBxm";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="TDMUGI6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfAKGdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:33:36 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54726 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbfAKGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:33:36 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0B6Vghu004036;
        Thu, 10 Jan 2019 22:33:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=u/vW7BH7Hg/iymwGEXgXVIcJKz0b9NtBD09Xlks+l3Q=;
 b=lJNELBxmaKDGuxSa/uu4H+GrMW/bCoq4bL4ASu+nQB4xXrSxxUSqsPcsX9ONstBXqE9N
 1isZ4GnR5hwMrIFMPSkZKG4FGHhtuf0zOS3j9tDDGIUL/ooHeRZOZH0UJPfttp9uDvwL
 2g7PEl+lYUve4yI92R+AjPdQwq8vqPfwBMmAlTb6Xi/mDa85IPLYhXS3n+ytBlE2qT0k
 CvIiJ+SaYBmlBMLncGRlPfEJtlbJFo+GeNAOOWwwwglG+jwL3Hm5/Fs4cEHWXTWgWmDj
 qPomXKK1nmblbmc8eEubr8WEgFeII0XSND+c64I7wi5SMpF6UnEQzHYiHlrNdIeqUUlZ 1Q== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pxj4m13wc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Jan 2019 22:33:20 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Jan
 2019 22:33:19 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Jan 2019 22:33:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/vW7BH7Hg/iymwGEXgXVIcJKz0b9NtBD09Xlks+l3Q=;
 b=TDMUGI6nWgGVxzoSohnRIfBiROpBImHPXp/q2TE4J/yXjzMx+JsoJuHFQKrluLqlWr95zmx7gTck0XiTrCJfKD0+d3VLLMK0RsDAZEWvAh9rYp6871CyDBGEYc63EL+ZvF4Q7H0cuks8SRBUcukCJfscIp+SCSJQfXRujpDzbok=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB1640.namprd18.prod.outlook.com (10.173.64.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 06:33:18 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::402d:1b84:1840:50ea]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::402d:1b84:1840:50ea%4]) with mapi id 15.20.1495.011; Fri, 11 Jan 2019
 06:33:18 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/41] scsi: bfa: bfa_fcs_lport: Mark expected switch
 fall-throughs
Thread-Topic: [PATCH 10/41] scsi: bfa: bfa_fcs_lport: Mark expected switch
 fall-throughs
Thread-Index: AQHUqSDS/XJDHk7nGkOFYxNpQLFFPKWpnKSQ
Date:   Fri, 11 Jan 2019 06:33:17 +0000
Message-ID: <CY4PR18MB1253EC0F2D3C0F4AE86AEA02D3850@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <5cc329185c0b92f3aad001fc1afa54996a2c1112.1543374820.git.gustavo@embeddedor.com>
 <a2a4fd41-d231-4d72-a95e-e1109c209f94@embeddedor.com>
 <fad1ad2c-1004-6064-931a-6c898ba00915@embeddedor.com>
In-Reply-To: <fad1ad2c-1004-6064-931a-6c898ba00915@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:53d:e7b:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1640;20:aYU4lNpFGqPdgIpxqmGVIxEcllFo4v0JZ9KuXwHwtPnJPh1zMZTPEesYsLo5A5+mstExC3ylrAnxZ/3o8JYvPdf/n12tOZEj/rwMKiY0xK1SDYVEl6wRbd1jxL+fe6cPtx54hOHkW7t4qUmAQYbWV6X/xR64O6HMgChEqIfN7Jc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 15f6c80f-5810-4dff-1e2d-08d6778eac63
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1640;
x-ms-traffictypediagnostic: CY4PR18MB1640:
x-microsoft-antispam-prvs: <CY4PR18MB1640D2161AA543C4846F4BD0D3850@CY4PR18MB1640.namprd18.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(13464003)(99286004)(81166006)(486006)(105586002)(86362001)(81156014)(106356001)(8676002)(316002)(93886005)(53546011)(6436002)(305945005)(478600001)(6506007)(55016002)(7696005)(476003)(76176011)(186003)(71200400001)(229853002)(71190400001)(102836004)(7736002)(54906003)(110136005)(11346002)(46003)(8936002)(2906002)(14444005)(256004)(446003)(25786009)(6246003)(5660300001)(4326008)(68736007)(9686003)(14454004)(97736004)(53936002)(33656002)(74316002)(6116002)(485434002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1640;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AOynGVpij8uSk3WJIo2JywSqumssHXyvK6UCWfGYsUKHQjw4UGi6UI24Iare4KyqhKHjNgg91Fx6ndF7MAiSiCQCTQBIMTz/eUetCzoZSD/Wtn5xCPla+Idg7Ow/Q2Ont686701wcxee0LtOVPJR9Xw3ajPUcKTVwTdvisBZ0yTV2Ct9gAXhzgdsdjFZzCKQWWTOfaBlzWuyeOjZt2z2GFPEnUJs/X7EotpmzxQhdBVnbYLuVv2WTr89fyhtvYSIWit7pAAZFVdrLPYUVVqqQ7oD0xMZdVELQXf0ue/n4B8YuDyDKgFfjhHmWfEVneUbTooPaUOeyRQzA9hcdUMR+jImejeJEoKCssWlboSg/oYOwIk7gZBH1xqAphydf/UDpWDNB7lMvl8NznQrkXFxbyVFVv4QVqqULtnXcFeh790=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f6c80f-5810-4dff-1e2d-08d6778eac63
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:33:17.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1640
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YSBb
bWFpbHRvOmd1c3Rhdm9AZW1iZWRkZWRvci5jb21dIA0KU2VudDogMTEgSmFudWFyeSAyMDE5IDAx
OjQyDQpUbzogQW5pbCBHdXJ1bXVydGh5IDxhbmlsLmd1cnVtdXJ0aHlAcWxvZ2ljLmNvbT47IFN1
ZGFyc2FuYSBLYWxsdXJ1IDxzdWRhcnNhbmEua2FsbHVydUBxbG9naWMuY29tPg0KQ2M6IEphbWVz
IEUuSi4gQm90dG9tbGV5IDxqZWpiQGxpbnV4LmlibS5jb20+OyBNYXJ0aW4gSy4gUGV0ZXJzZW4g
PG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPjsgbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMTAvNDFd
IHNjc2k6IGJmYTogYmZhX2Zjc19scG9ydDogTWFyayBleHBlY3RlZCBzd2l0Y2ggZmFsbC10aHJv
dWdocw0KDQpFeHRlcm5hbCBFbWFpbA0KDQpIaSwNCg0KRnJpZW5kbHkgcGluZyAoc2Vjb25kIG9u
ZSk6DQoNCldobyBjYW4gYWNrL3Jldmlldy90YWtlIHRoaXMgcGF0Y2gsIHBsZWFzZT8NCg0KVGhh
bmtzDQotLQ0KR3VzdGF2bw0KDQpPbiAxMi8xOS8xOCA5OjM5IEFNLCBHdXN0YXZvIEEuIFIuIFNp
bHZhIHdyb3RlOg0KPiBIaSwNCj4NCj4gRnJpZW5kbHkgcGluZzoNCj4NCj4gV2hvIGNhbiBhY2sg
b3IgcmV2aWV3IHRoaXMgcGF0Y2gsIHBsZWFzZT8NCj4NCj4gVGhhbmtzDQo+IC0tDQo+IEd1c3Rh
dm8NCj4NCj4gT24gMTEvMjcvMTggMTA6MjcgUE0sIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6
DQo+PiBJbiBwcmVwYXJhdGlvbiB0byBlbmFibGluZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLCBt
YXJrIHN3aXRjaCBjYXNlcyANCj4+IHdoZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJv
dWdoLg0KPj4NCj4+IE5vdGljZSB0aGF0LCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgSSByZXBs
YWNlZCAiISEhIGZhbGwgdGhyb3VnaCAhISEiDQo+PiB3aXRoIGEgImZhbGwgdGhyb3VnaCIgYW5u
b3RhdGlvbiwgd2hpY2ggaXMgd2hhdCBHQ0MgaXMgZXhwZWN0aW5nIHRvIA0KPj4gZmluZC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVk
b3IuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvc2NzaS9iZmEvYmZhX2Zjc19scG9ydC5jIHwg
OCArKy0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvYmZhL2JmYV9mY3NfbHBv
cnQuYyANCj4+IGIvZHJpdmVycy9zY3NpL2JmYS9iZmFfZmNzX2xwb3J0LmMNCj4+IGluZGV4IGI0
ZjJjMWQ4NzQyZS4uNjQ2ZjA5ZjY2NDQzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9zY3NpL2Jm
YS9iZmFfZmNzX2xwb3J0LmMNCj4+ICsrKyBiL2RyaXZlcnMvc2NzaS9iZmEvYmZhX2Zjc19scG9y
dC5jDQo+PiBAQCAtNjQzMCw5ICs2NDMwLDcgQEAgYmZhX2Zjc192cG9ydF9zbV9sb2dvX2Zvcl9z
dG9wKHN0cnVjdCBiZmFfZmNzX3Zwb3J0X3MgKnZwb3J0LA0KPj4gICAgICAgc3dpdGNoIChldmVu
dCkgew0KPj4gICAgICAgY2FzZSBCRkFfRkNTX1ZQT1JUX1NNX09GRkxJTkU6DQo+PiAgICAgICAg
ICAgYmZhX3NtX3NlbmRfZXZlbnQodnBvcnQtPmxwcywgQkZBX0xQU19TTV9PRkZMSU5FKTsNCj4+
IC0gICAgICAgIC8qDQo+PiAtICAgICAgICAgKiAhISEgZmFsbCB0aHJvdWdoICEhIQ0KPj4gLSAg
ICAgICAgICovDQo+PiArICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICAgICAgIGNhc2Ug
QkZBX0ZDU19WUE9SVF9TTV9SU1BfT0s6DQo+PiAgICAgICBjYXNlIEJGQV9GQ1NfVlBPUlRfU01f
UlNQX0VSUk9SOg0KPj4gQEAgLTY0NTgsOSArNjQ1Niw3IEBAIGJmYV9mY3NfdnBvcnRfc21fbG9n
byhzdHJ1Y3QgYmZhX2Zjc192cG9ydF9zICp2cG9ydCwNCj4+ICAgICAgIHN3aXRjaCAoZXZlbnQp
IHsNCj4+ICAgICAgIGNhc2UgQkZBX0ZDU19WUE9SVF9TTV9PRkZMSU5FOg0KPj4gICAgICAgICAg
IGJmYV9zbV9zZW5kX2V2ZW50KHZwb3J0LT5scHMsIEJGQV9MUFNfU01fT0ZGTElORSk7DQo+PiAt
ICAgICAgICAvKg0KPj4gLSAgICAgICAgICogISEhIGZhbGwgdGhyb3VnaCAhISENCj4+IC0gICAg
ICAgICAqLw0KPj4gKyAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+PiAgICAgICBjYXNlIEJG
QV9GQ1NfVlBPUlRfU01fUlNQX09LOg0KPj4gICAgICAgY2FzZSBCRkFfRkNTX1ZQT1JUX1NNX1JT
UF9FUlJPUjoNCj4+DQoNCkFja2VkLWJ5OiBTdWRhcnNhbmEgS2FsbHVydSA8U3VkYXJzYW5hLkth
bGx1cnVAcWxvZ2ljLmNvbT4NCg==
