Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4925D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ULKIto+Q";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZFcdf98V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfAPTSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:18:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730683AbfAPTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:18:16 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0GJFs9L002561;
        Wed, 16 Jan 2019 11:17:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wPb5fKyh8s2/HHBfRx/V1e4qgz0l5exVuVV7kG/dc8M=;
 b=ULKIto+Q6Q5siHT9sA6t4zdhxNF8NvFs0tGJOAej8gx0ce3b8aZOJvWg7nNxT5ekz+PS
 WP2PQWpY8wcxqHJmolsy50PapwhNd8Ve3TrQQJS5i6ZL1i02Nhn6Zj7ZdDR0+Fq4WMED
 3e6bMwhUQeWX4KPlWvd5i6jr/XpH3ky/YZE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2q28ufrcva-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Jan 2019 11:17:51 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 16 Jan 2019 11:16:55 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 16 Jan 2019 11:16:55 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 16 Jan 2019 11:16:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPb5fKyh8s2/HHBfRx/V1e4qgz0l5exVuVV7kG/dc8M=;
 b=ZFcdf98V7ohHb4Ox1mJlDRuWjugUrmSlv4kLZZ8v+O8e34ufnDJS8HHpARue/AhqNgo97GFikZKYT62vhhYEQEaRy8aOJbHmjhtGwurdhmNVkM1mCJyX32pLC9hKFkYyGeBkFc91uJO5hi3krwJs3GbtNzGvFB6ZTMPANMQVfc8=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1832.namprd15.prod.outlook.com (10.174.54.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Wed, 16 Jan 2019 19:16:53 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1516.019; Wed, 16 Jan
 2019 19:16:53 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: make memory-region optional
Thread-Topic: [PATCH] misc: aspeed-lpc-ctrl: make memory-region optional
Thread-Index: AQHUrHTsCNqx8T1ZWEeCIOZYO7lyAKWxBwOAgAC6CQA=
Date:   Wed, 16 Jan 2019 19:16:53 +0000
Message-ID: <6C0EA492-D9D4-481F-BF8B-5EBD8B38390B@fb.com>
References: <20190115015146.2412785-1-vijaykhemka@fb.com>
 <CACPK8Xesi2tQzH1d=Ow6VucO3qo6ptosKb-WDi-Cw1vg5FXGzg@mail.gmail.com>
In-Reply-To: <CACPK8Xesi2tQzH1d=Ow6VucO3qo6ptosKb-WDi-Cw1vg5FXGzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:91a9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1832;20:ZpIdzP4vLAyDBxnItsl+UAna9BeqWc2Akp0GPPV0WC2aH6flu3NehD5tT8n+/qRMX/s2PyO8IZullLo80/vFySNW/oqDDakKCuH4LUe423NxUquCUsOV/hDlGmPz7/oFhE0Lv1wnDetki5v9zzO+NLGX90r9EM053RAUObfGULU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4a3b48c7-7575-4336-81f6-08d67be72cc6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1832;
x-ms-traffictypediagnostic: CY4PR15MB1832:
x-microsoft-antispam-prvs: <CY4PR15MB18328F2FBF1B57D313D9597EDD820@CY4PR15MB1832.namprd15.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(6436002)(316002)(476003)(446003)(11346002)(2616005)(14454004)(106356001)(97736004)(478600001)(229853002)(99286004)(6486002)(54906003)(110136005)(71200400001)(8676002)(345774005)(83716004)(6512007)(105586002)(82746002)(486006)(186003)(71190400001)(86362001)(53936002)(68736007)(561944003)(2906002)(76176011)(14444005)(305945005)(102836004)(33656002)(25786009)(4326008)(8936002)(256004)(7736002)(5660300001)(46003)(81166006)(81156014)(36756003)(6116002)(6506007)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1832;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lxiiTlO2+rHPwBIHNv7eF/AxYloPqksuGSe8zQLqLQTeM8lTfQBiVv02LncdqbdbnFt2RAbHKLrqOeONCm05QInrztQJRvHde6bkmi+UyhHvoK3sbior6r3wPc/ua/90y79vLBLQfQ7mEUU0JIDG17TnO1NzsTrTVMqNX/OiTZ/Wmku5GeF9PDyVPWkUedYgYDO4SLKlSk50XOWE9xgMS0b6jNzrt+dx3Rpir98Y2PBajDqtZIs4q8EjWU526hrsv+kLvwy7nAHeifDY/Um7BuZbXB5FtvJHzKchPaXXn6UJkw+JSGAkCyd323cInLWcQuVQSsOLPnPManJbOrYgEqFiHZ3s4MG/6sff0ecSqXPUGevsiRIEp0ZUKnPdCJbyJRR+qm5JqaKHTwdKsCAm5q2PZLROlYjtpYoHF0dSr5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED611D8778ED554B8435F0938ACED156@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b48c7-7575-4336-81f6-08d67be72cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 19:16:53.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1832
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VyZSBKb2VsLA0KSSB3aWxsIGRvIHYyIGFuZCBzdWJtaXQgZm9yIHJldmlldyB0b2RheS4NCg0K
UmVnYXJkcw0KLVZpamF5DQoNCu+7v09uIDEvMTUvMTksIDQ6MTEgUE0sICJKb2VsIFN0YW5sZXki
IDxqb2VsQGptcy5pZC5hdT4gd3JvdGU6DQoNCiAgICBIaSBWaWpheSwNCiAgICANCiAgICBPbiBU
dWUsIDE1IEphbiAyMDE5IGF0IDEyOjUxLCBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNv
bT4gd3JvdGU6DQogICAgPg0KICAgID4gTWFraWluZyBtZW1vcnktcmVnaW9uIGFzIG9wdGlvbmFs
IHBhcmFtZXRlciBpbiBkZXZpY2UgdHJlZSBpZg0KICAgID4gdXNlciBuZWVkcyB0byB1c2UgbWVt
b3J5LXJlZ2lvbiB0aGVuIGRlZmluZSBpbiBkZXZpY2V0cmVlLg0KICAgIA0KICAgIFRoYW5rIHlv
dSBmb3IgZmluZGluZyB0aGUgdGltZSB0byBkbyB0aGlzIHdvcmsuIFlvdSdyZSBub3QgdGhlIGZp
cnN0DQogICAgdG8gYmUgYmxvY2tlZCBieSB0aGlzIGxpbWl0YXRpb24sIGJ1dCB5b3UgYXJlIHRo
ZSBmaXJzdCB3aG8gZm91bmQgdGhlDQogICAgdGltZSB0byBwcm9wb3NlIGEgcGF0Y2guDQogICAg
DQogICAgSSB0aGluayB3ZSBzaG91bGQgY29tcGxldGUgdGhlIHJld29yayB0byBtYWtlIHRoZSBm
bGFzaCBkZXZpY2UNCiAgICBvcHRpb25hbCB0b28uIENhbiB5b3UgZG8gYSB2MiB3aXRoIGEgcHJv
cG9zYWwgZm9yIHRoYXQ/DQogICAgDQogICAgPg0KICAgID4gU2lnbmVkLW9mZi1ieTogVmlqYXkg
S2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiAtLS0NCiAgICA+ICBkcml2ZXJzL21p
c2MvYXNwZWVkLWxwYy1jdHJsLmMgfCAzMCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0N
CiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0p
DQogICAgPg0KICAgID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9hc3BlZWQtbHBjLWN0cmwu
YyBiL2RyaXZlcnMvbWlzYy9hc3BlZWQtbHBjLWN0cmwuYw0KICAgID4gaW5kZXggYTAyNGY4MDQy
MjU5Li4yMDUwN2YwNzY0ZmIgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL21pc2MvYXNwZWVk
LWxwYy1jdHJsLmMNCiAgICA+ICsrKyBiL2RyaXZlcnMvbWlzYy9hc3BlZWQtbHBjLWN0cmwuYw0K
ICAgID4gQEAgLTkwLDYgKzkwLDEwIEBAIHN0YXRpYyBsb25nIGFzcGVlZF9scGNfY3RybF9pb2N0
bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwNCiAgICA+ICAgICAgICAgICAg
ICAgICBpZiAobWFwLndpbmRvd19pZCAhPSAwKQ0KICAgID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPg0KICAgID4gKyAgICAgICAgICAgICAgIC8qIElmIG1l
bW9yeS1yZWdpb24gaXMgbm90IGRlc2NyaWJlZCBpbiBkZXZpY2UgdHJlZSAqLw0KICAgID4gKyAg
ICAgICAgICAgICAgIGlmICghbHBjX2N0cmwtPm1lbV9zaXplKQ0KICAgID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPiArDQogICAgPiAgICAgICAgICAgICAg
ICAgbWFwLnNpemUgPSBscGNfY3RybC0+bWVtX3NpemU7DQogICAgPg0KICAgID4gICAgICAgICAg
ICAgICAgIHJldHVybiBjb3B5X3RvX3VzZXIocCwgJm1hcCwgc2l6ZW9mKG1hcCkpID8gLUVGQVVM
VCA6IDA7DQogICAgPiBAQCAtMTI5LDYgKzEzMywxMCBAQCBzdGF0aWMgbG9uZyBhc3BlZWRfbHBj
X2N0cmxfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsDQogICAgPiAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gbHBjX2N0cmwtPnBub3JfYmFzZTsNCiAgICA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemUgPSBscGNfY3RybC0+cG5vcl9zaXplOw0KICAg
ID4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAobWFwLndpbmRvd190eXBlID09IEFTUEVFRF9M
UENfQ1RSTF9XSU5ET1dfTUVNT1JZKSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICAv
KiBJZiBtZW1vcnktcmVnaW9uIGlzIG5vdCBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgKi8NCiAg
ICA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghbHBjX2N0cmwtPm1lbV9zaXplKQ0KICAg
IA0KICAgIFNob3VsZCBpdCBwcmludCBhIG1lc3NhZ2UgaGVyZT8gSSB0aGluayBhIGRldl9kYmcg
bWFrZXMgc2Vuc2UuDQogICAgDQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KICAgID4gKw0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAg
YWRkciA9IGxwY19jdHJsLT5tZW1fYmFzZTsNCiAgICA+ICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemUgPSBscGNfY3RybC0+bWVtX3NpemU7DQogICAgPiAgICAgICAgICAgICAgICAgfSBlbHNl
IHsNCiAgICA+IEBAIC0yMTQsMjIgKzIyMiwyMCBAQCBzdGF0aWMgaW50IGFzcGVlZF9scGNfY3Ry
bF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KICAgID4NCiAgICA+ICAgICAg
ICAgZGV2X3NldF9kcnZkYXRhKCZwZGV2LT5kZXYsIGxwY19jdHJsKTsNCiAgICA+DQogICAgPiAr
ICAgICAgIC8qIElmIG1lbW9yeS1yZWdpb24gaXMgZGVzY3JpYmVkIGluIGRldmljZSB0cmVlIHRo
ZW4gc3RvcmUgKi8NCiAgICA+ICAgICAgICAgbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5v
Zl9ub2RlLCAibWVtb3J5LXJlZ2lvbiIsIDApOw0KICAgID4gLSAgICAgICBpZiAoIW5vZGUpIHsN
CiAgICA+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkRpZG4ndCBmaW5kIHJlc2VydmVk
IG1lbW9yeVxuIik7DQogICAgPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAg
PiAtICAgICAgIH0NCiAgICA+ICsgICAgICAgaWYgKG5vZGUpIHsNCiAgICANCiAgICBQcmludCBh
IGRlYnVnIG1lc3NhZ2Ugd2hlbiB3ZSBkaWRuJ3QgZmluZCB0aGUgbm9kZS4NCiAgICANCiAgICA+
ICsgICAgICAgICAgICAgICByYyA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2Uobm9kZSwgMCwgJnJl
c20pOw0KICAgID4gKyAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KG5vZGUpOw0KICAgID4gKyAg
ICAgICAgICAgICAgIGlmIChyYykgew0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2
X2VycihkZXYsICJDb3VsZG4ndCBhZGRyZXNzIHRvIHJlc291cmNlIGZvciByZXNlcnZlZCBtZW1v
cnlcbiIpOw0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQog
ICAgPiArICAgICAgICAgICAgICAgfQ0KICAgID4NCiAgICA+IC0gICAgICAgcmMgPSBvZl9hZGRy
ZXNzX3RvX3Jlc291cmNlKG5vZGUsIDAsICZyZXNtKTsNCiAgICA+IC0gICAgICAgb2Zfbm9kZV9w
dXQobm9kZSk7DQogICAgPiAtICAgICAgIGlmIChyYykgew0KICAgID4gLSAgICAgICAgICAgICAg
IGRldl9lcnIoZGV2LCAiQ291bGRuJ3QgYWRkcmVzcyB0byByZXNvdXJjZSBmb3IgcmVzZXJ2ZWQg
bWVtb3J5XG4iKTsNCiAgICA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCiAgICA+
ICsgICAgICAgICAgICAgICBscGNfY3RybC0+bWVtX3NpemUgPSByZXNvdXJjZV9zaXplKCZyZXNt
KTsNCiAgICA+ICsgICAgICAgICAgICAgICBscGNfY3RybC0+bWVtX2Jhc2UgPSByZXNtLnN0YXJ0
Ow0KICAgID4gICAgICAgICB9DQogICAgPg0KICAgID4gLSAgICAgICBscGNfY3RybC0+bWVtX3Np
emUgPSByZXNvdXJjZV9zaXplKCZyZXNtKTsNCiAgICA+IC0gICAgICAgbHBjX2N0cmwtPm1lbV9i
YXNlID0gcmVzbS5zdGFydDsNCiAgICA+IC0NCiAgICA+ICAgICAgICAgbHBjX2N0cmwtPnJlZ21h
cCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcCgNCiAgICA+ICAgICAgICAgICAgICAgICAgICAgICAg
IHBkZXYtPmRldi5wYXJlbnQtPm9mX25vZGUpOw0KICAgID4gICAgICAgICBpZiAoSVNfRVJSKGxw
Y19jdHJsLT5yZWdtYXApKSB7DQogICAgDQogICAgRG93biBiZWxvdyBoZXJlIGlzIHRoaXMgbGlu
ZToNCiAgICANCiAgICA+ICAgICAgICBkZXZfaW5mbyhkZXYsICJMb2FkZWQgYXQgJXByXG4iLCAm
cmVzbSk7DQogICAgDQogICAgQXMgcmVzbSBpcyBmaXJzdCB1c2VkIGZvciB0aGUgZmxhc2ggcmVz
b3VyY2UgYW5kIHRoZW4gdGhlIG1lbW9yeQ0KICAgIHJlZ2lvbiwgaXQgd2lsbCBkaXNwbGF5IHRo
ZSBsb2NhdGlvbiBvZiB0aGUgZmxhc2ggd2hlbiB0aGUgbWVtb3J5DQogICAgcmVnaW9uIGlzIG5v
dCBwcmVzZW50LiBUaGlzIGlzIGNvbmZ1c2luZy4gWW91IHNob3VsZCBlaXRoZXIgcHJpbnQgb3V0
DQogICAgdGhlIHJlZ2lvbnMgc2VwYXJhdGVseSwgb3IgY29uc2lkZXIgcmVtb3ZpbmcgdGhpcyBk
ZXZfaW5mbyBjb21wbGV0ZWx5Lg0KDQpZZXMgaXQgZGlkIGNvbmZ1c2UgbWUgdG9vIGFuZCBJIGFs
c28gdGhvdWdodCBvZiByZW1vdmluZyBpdC4gSSB3YXMgd2FpdGluZyBmb3IgeW91ciBvcGluaW9u
IF9fDQogICAgDQogICAgPiAtLQ0KICAgID4gMi4xNy4xDQogICAgPg0KICAgIA0KDQo=
