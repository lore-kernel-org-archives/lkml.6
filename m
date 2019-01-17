Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A232C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDDC20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bvxEfCB8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Odzrz0YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfAQSxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:53:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfAQSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:53:30 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HIqUG8017635;
        Thu, 17 Jan 2019 10:53:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yLP7Apidqkzu3ylYLpuMWp3mlWey6XCuRLVDVczUoyM=;
 b=bvxEfCB8olt1a77Plr9k6g8HxiqBZLGB49gUcEhiJrKtOxHc0KvQn4FK7++XM9kzPNCI
 11wD0UhjsayqUOCNnoGvP1QnLpo7ExwZgJ3kh1CkfnsFUdJnoiS8p6O8UeTBOt40/oik
 Sgh8wSotwG38IhG79m2xzqvBpAdgwQrLFgs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q2xbg08x8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 10:53:07 -0800
Received: from frc-mbx08.TheFacebook.com (2620:10d:c0a1:f82::32) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 10:53:07 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx08.TheFacebook.com (2620:10d:c0a1:f82::32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 10:53:06 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 17 Jan 2019 10:53:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLP7Apidqkzu3ylYLpuMWp3mlWey6XCuRLVDVczUoyM=;
 b=Odzrz0YRbBDjM1L3GNS9UGqkHDnBaT90rM2YhDu4URMgBUWNbCoLOc7W9RbD8pOPPizWFI4CMKMGKzJjlzOLlFHh/A/boEBQa+jyUB3J031GefaQwFnclcCJbMryIawo2V98ZrWPY6KPvR2PmLA3wN5B2rlItnDn9K4Wqme0uk0=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1415.namprd15.prod.outlook.com (10.172.160.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Thu, 17 Jan 2019 18:53:05 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1516.019; Thu, 17 Jan
 2019 18:53:05 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Thread-Topic: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Thread-Index: AQHUrecp120UxlsdUUK9uZiXf1PR66Wy/McAgABNDwA=
Date:   Thu, 17 Jan 2019 18:53:05 +0000
Message-ID: <23690A66-50E2-4DED-8324-C03CB717B604@fb.com>
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
 <CACPK8XdCVvUaCFsMXdEkc9KG0TQCGpYV55u-X7pY7vBLLHuQtw@mail.gmail.com>
In-Reply-To: <CACPK8XdCVvUaCFsMXdEkc9KG0TQCGpYV55u-X7pY7vBLLHuQtw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:8f98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1415;20:Tnn70DC0Qzh8C1uV2b+tFqcwXFtdCNjeNnXzDDTg2GS9JEVpqnxZaPpSY4NwTcZ0V3bf+P6L/jX1TapfBs9nWwHEwSUOGxnb5lHK0NnSowX6l85bIPZcCLi60F+H5AQebOCKg3BcVqRKBIbuNDe3g/Wr3C8z+Ryj6oNogNW4j3I=
x-ms-office365-filtering-correlation-id: 6ef2f928-f660-4057-c2c5-08d67cad040e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1415;
x-ms-traffictypediagnostic: CY4PR15MB1415:
x-microsoft-antispam-prvs: <CY4PR15MB14155A30FBC0D306863BAFB8DD830@CY4PR15MB1415.namprd15.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(396003)(346002)(136003)(199004)(189003)(83716004)(53936002)(6436002)(6506007)(446003)(86362001)(8936002)(6486002)(97736004)(6246003)(305945005)(76176011)(81166006)(81156014)(316002)(8676002)(106356001)(82746002)(102836004)(71190400001)(229853002)(71200400001)(33656002)(14454004)(6512007)(7736002)(486006)(54906003)(6116002)(110136005)(4326008)(186003)(68736007)(105586002)(478600001)(36756003)(256004)(14444005)(5660300001)(2906002)(476003)(25786009)(46003)(99286004)(11346002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1415;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TUAMO4jbfMJocNRv2ZgbUDTJu2ibZ0JTCk9N4xSifcFE1km7Y+KpErTWDfr9OHo19uZ6+F620ZbvXE4nYca5ixnUR2pZCgKual/yU2UoV3nOXAHsobqMqO8OPLd5RERL7e+A6pHAov6IvVuRb2Jis/VqO1ANYzGZwDM+ILr4frKjQiaD6me+hjFBKPw2zTw4EThi2GeapqFpZN9QyPmB7XAOn/ZINVAOw4hVA07dptORjcIZ38WBnW6dZ1mQY0AwN6xP/kxbMs+Mnz62Z2QiJ9EHhY/vTpOG9TVCF5qwC1unS4eGMIF4RqyNfOCziDu3zl6qQ/OafQPEipGJdvYmyZGFfqUU1kDJIU2J7t+yvsI+pW5YyUe14+VHcF74oc7wY3azovLpg3pnXMXULMUa5pF5FE6AvB+O5k6CdAeAVLo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7AA94985D65624E85C869FBA66A4166@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef2f928-f660-4057-c2c5-08d67cad040e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 18:53:05.7195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1415
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEvMTYvMTksIDEwOjE3IFBNLCAiSm9lbCBTdGFubGV5IiA8am9lbEBqbXMuaWQu
YXU+IHdyb3RlOg0KDQogICAgT24gVGh1LCAxNyBKYW4gMjAxOSBhdCAwOTowMiwgVmlqYXkgS2hl
bWthIDx2aWpheWtoZW1rYUBmYi5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+IE1ha2lpbmcgbWVt
b3J5LXJlZ2lvbiBhbmQgZmxhc2ggYXMgb3B0aW9uYWwgcGFyYW1ldGVyIGluIGRldmljZQ0KICAg
ID4gdHJlZSBpZiB1c2VyIG5lZWRzIHRvIHVzZSB0aGVzZSBwYXJhbWV0ZXIgdGhyb3VnaCBpb2N0
bCB0aGVuDQogICAgPiBuZWVkIHRvIGRlZmluZSBpbiBkZXZpY2V0cmVlLg0KICAgID4NCiAgICA+
IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgIA0K
ICAgIFRoYW5rcyEgVGhpcyBsb29rcyBva2F5IHRvIG1lLiBJIHRlc3RlZCBpdCBvbiBvbmUgb2Yg
b3VyIHN5c3RlbXMgd2hpY2gNCiAgICB1c2VzIGJvdGggZmxhc2ggYW5kIHJlc2VydmVkIG1lbW9y
eSBhbmQgaXQgd2FzIGZpbmUuDQogICAgDQogICAgUmV2aWV3ZWQtYnk6IEpvZWwgU3RhbmxleSA8
am9lbEBqbXMuaWQuYXU+DQogICAgDQogICAgQ2FuIHlvdSBhbHNvIHNlbmQgYSBwYXRjaCB0byB1
cGRhdGUgdGhlIGJpbmRpbmdzIGF0DQogICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9hc3BlZWQtbHBjLnR4dCA/IEkgdGhpbmsgdGhlDQogICAgb25seSBjaGFuZ2UgeW91
IG5lZWQgdG8gbWFrZSBpcyB0byBtb3ZlIHRoZSBtZW1vcnkgcmVnaW9uIGFuZCBmbGFzaA0KICAg
IHByb3BlcnRpZXMgdG8gb3B0aW9uYWwgKGluc3RlYWQgb2YgcmVxdWlyZWQpLg0KDQpTdXJlIEkg
d2lsbCBkbyB0aGlzLg0KICAgIA0KICAgIENoZWVycywNCiAgICANCiAgICBKb2VsDQogICAgDQog
ICAgPiAtLS0NCiAgICA+ICBkcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMgfCA1OCArKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDM2
IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KICAgID4NCiAgICA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMgYi9kcml2ZXJzL21pc2MvYXNwZWVkLWxw
Yy1jdHJsLmMNCiAgICA+IGluZGV4IGEwMjRmODA0MjI1OS4uMzMyMjEwZTA2ZTk4IDEwMDY0NA0K
ICAgID4gLS0tIGEvZHJpdmVycy9taXNjL2FzcGVlZC1scGMtY3RybC5jDQogICAgPiArKysgYi9k
cml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMNCiAgICA+IEBAIC02OCw2ICs2OCw3IEBAIHN0
YXRpYyBsb25nIGFzcGVlZF9scGNfY3RybF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWdu
ZWQgaW50IGNtZCwNCiAgICA+ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHBhcmFtKQ0K
ICAgID4gIHsNCiAgICA+ICAgICAgICAgc3RydWN0IGFzcGVlZF9scGNfY3RybCAqbHBjX2N0cmwg
PSBmaWxlX2FzcGVlZF9scGNfY3RybChmaWxlKTsNCiAgICA+ICsgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KICAgID4gICAgICAgICB2b2lkIF9fdXNlciAq
cCA9ICh2b2lkIF9fdXNlciAqKXBhcmFtOw0KICAgID4gICAgICAgICBzdHJ1Y3QgYXNwZWVkX2xw
Y19jdHJsX21hcHBpbmcgbWFwOw0KICAgID4gICAgICAgICB1MzIgYWRkcjsNCiAgICA+IEBAIC05
MCw2ICs5MSwxMiBAQCBzdGF0aWMgbG9uZyBhc3BlZWRfbHBjX2N0cmxfaW9jdGwoc3RydWN0IGZp
bGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsDQogICAgPiAgICAgICAgICAgICAgICAgaWYgKG1h
cC53aW5kb3dfaWQgIT0gMCkNCiAgICA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KICAgID4NCiAgICA+ICsgICAgICAgICAgICAgICAvKiBJZiBtZW1vcnktcmVnaW9u
IGlzIG5vdCBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgKi8NCiAgICA+ICsgICAgICAgICAgICAg
ICBpZiAoIWxwY19jdHJsLT5tZW1fc2l6ZSkgew0KICAgID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsICJEaWRuJ3QgZmluZCByZXNlcnZlZCBtZW1vcnlcbiIpOw0KICAgID4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPiArICAgICAgICAg
ICAgICAgfQ0KICAgID4gKw0KICAgID4gICAgICAgICAgICAgICAgIG1hcC5zaXplID0gbHBjX2N0
cmwtPm1lbV9zaXplOw0KICAgID4NCiAgICA+ICAgICAgICAgICAgICAgICByZXR1cm4gY29weV90
b191c2VyKHAsICZtYXAsIHNpemVvZihtYXApKSA/IC1FRkFVTFQgOiAwOw0KICAgID4gQEAgLTEy
Niw5ICsxMzMsMTggQEAgc3RhdGljIGxvbmcgYXNwZWVkX2xwY19jdHJsX2lvY3RsKHN0cnVjdCBm
aWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KICAgID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPg0KICAgID4gICAgICAgICAgICAgICAgIGlmIChtYXAu
d2luZG93X3R5cGUgPT0gQVNQRUVEX0xQQ19DVFJMX1dJTkRPV19GTEFTSCkgew0KICAgID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKCFscGNfY3RybC0+cG5vcl9zaXplKSB7DQogICAgPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRGlkbid0IGZpbmQg
aG9zdCBwbm9yIGZsYXNoXG4iKTsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICB9DQogICAg
PiAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gbHBjX2N0cmwtPnBub3JfYmFzZTsNCiAg
ICA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemUgPSBscGNfY3RybC0+cG5vcl9zaXplOw0K
ICAgID4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAobWFwLndpbmRvd190eXBlID09IEFTUEVF
RF9MUENfQ1RSTF9XSU5ET1dfTUVNT1JZKSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAg
ICAvKiBJZiBtZW1vcnktcmVnaW9uIGlzIG5vdCBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgKi8N
CiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghbHBjX2N0cmwtPm1lbV9zaXplKSB7
DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRGlk
bid0IGZpbmQgcmVzZXJ2ZWQgbWVtb3J5XG4iKTsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAg
ICB9DQogICAgPiAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gbHBjX2N0cmwtPm1lbV9i
YXNlOw0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZSA9IGxwY19jdHJsLT5tZW1f
c2l6ZTsNCiAgICA+ICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KICAgID4gQEAgLTE5NiwxNyAr
MjEyLDE3IEBAIHN0YXRpYyBpbnQgYXNwZWVkX2xwY19jdHJsX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQogICAgPiAgICAgICAgIGlmICghbHBjX2N0cmwpDQogICAgPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQogICAgPg0KICAgID4gKyAgICAgICAvKiBJZiBm
bGFzaCBpcyBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgdGhlbiBzdG9yZSAqLw0KICAgID4gICAg
ICAgICBub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJmbGFzaCIsIDApOw0K
ICAgID4gICAgICAgICBpZiAoIW5vZGUpIHsNCiAgICA+IC0gICAgICAgICAgICAgICBkZXZfZXJy
KGRldiwgIkRpZG4ndCBmaW5kIGhvc3QgcG5vciBmbGFzaCBub2RlXG4iKTsNCiAgICA+IC0gICAg
ICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCiAgICA+IC0gICAgICAgfQ0KICAgID4gLQ0KICAg
ID4gLSAgICAgICByYyA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2Uobm9kZSwgMSwgJnJlc20pOw0K
ICAgID4gLSAgICAgICBvZl9ub2RlX3B1dChub2RlKTsNCiAgICA+IC0gICAgICAgaWYgKHJjKSB7
DQogICAgPiAtICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJDb3VsZG4ndCBhZGRyZXNzIHRv
IHJlc291cmNlIGZvciBmbGFzaFxuIik7DQogICAgPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJj
Ow0KICAgID4gKyAgICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAiRGlkbid0IGZpbmQgaG9zdCBw
bm9yIGZsYXNoIG5vZGVcbiIpOw0KICAgID4gKyAgICAgICB9IGVsc2Ugew0KICAgID4gKyAgICAg
ICAgICAgICAgIHJjID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShub2RlLCAxLCAmcmVzbSk7DQog
ICAgPiArICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobm9kZSk7DQogICAgPiArICAgICAgICAg
ICAgICAgaWYgKHJjKSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgIkNvdWxkbid0IGFkZHJlc3MgdG8gcmVzb3VyY2UgZm9yIGZsYXNoXG4iKTsNCiAgICA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByYzsNCiAgICA+ICsgICAgICAgICAgICAgICB9
DQogICAgPiAgICAgICAgIH0NCiAgICA+DQogICAgPiAgICAgICAgIGxwY19jdHJsLT5wbm9yX3Np
emUgPSByZXNvdXJjZV9zaXplKCZyZXNtKTsNCiAgICA+IEBAIC0yMTQsMjIgKzIzMCwyMiBAQCBz
dGF0aWMgaW50IGFzcGVlZF9scGNfY3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KICAgID4NCiAgICA+ICAgICAgICAgZGV2X3NldF9kcnZkYXRhKCZwZGV2LT5kZXYsIGxw
Y19jdHJsKTsNCiAgICA+DQogICAgPiArICAgICAgIC8qIElmIG1lbW9yeS1yZWdpb24gaXMgZGVz
Y3JpYmVkIGluIGRldmljZSB0cmVlIHRoZW4gc3RvcmUgKi8NCiAgICA+ICAgICAgICAgbm9kZSA9
IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5vZl9ub2RlLCAibWVtb3J5LXJlZ2lvbiIsIDApOw0KICAg
ID4gICAgICAgICBpZiAoIW5vZGUpIHsNCiAgICA+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgIkRpZG4ndCBmaW5kIHJlc2VydmVkIG1lbW9yeVxuIik7DQogICAgPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQogICAgPiAtICAgICAgIH0NCiAgICA+ICsgICAgICAgICAgICAg
ICBkZXZfZGJnKGRldiwgIkRpZG4ndCBmaW5kIHJlc2VydmVkIG1lbW9yeVxuIik7DQogICAgPiAr
ICAgICAgIH0gZWxzZSB7DQogICAgPiArICAgICAgICAgICAgICAgcmMgPSBvZl9hZGRyZXNzX3Rv
X3Jlc291cmNlKG5vZGUsIDAsICZyZXNtKTsNCiAgICA+ICsgICAgICAgICAgICAgICBvZl9ub2Rl
X3B1dChub2RlKTsNCiAgICA+ICsgICAgICAgICAgICAgICBpZiAocmMpIHsNCiAgICA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiQ291bGRuJ3QgYWRkcmVzcyB0byByZXNv
dXJjZSBmb3IgcmVzZXJ2ZWQgbWVtb3J5XG4iKTsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KICAgID4gKyAgICAgICAgICAgICAgIH0NCiAgICA+DQogICAg
PiAtICAgICAgIHJjID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShub2RlLCAwLCAmcmVzbSk7DQog
ICAgPiAtICAgICAgIG9mX25vZGVfcHV0KG5vZGUpOw0KICAgID4gLSAgICAgICBpZiAocmMpIHsN
CiAgICA+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkNvdWxkbid0IGFkZHJlc3MgdG8g
cmVzb3VyY2UgZm9yIHJlc2VydmVkIG1lbW9yeVxuIik7DQogICAgPiAtICAgICAgICAgICAgICAg
cmV0dXJuIC1FTk9NRU07DQogICAgPiArICAgICAgICAgICAgICAgbHBjX2N0cmwtPm1lbV9zaXpl
ID0gcmVzb3VyY2Vfc2l6ZSgmcmVzbSk7DQogICAgPiArICAgICAgICAgICAgICAgbHBjX2N0cmwt
Pm1lbV9iYXNlID0gcmVzbS5zdGFydDsNCiAgICA+ICAgICAgICAgfQ0KICAgID4NCiAgICA+IC0g
ICAgICAgbHBjX2N0cmwtPm1lbV9zaXplID0gcmVzb3VyY2Vfc2l6ZSgmcmVzbSk7DQogICAgPiAt
ICAgICAgIGxwY19jdHJsLT5tZW1fYmFzZSA9IHJlc20uc3RhcnQ7DQogICAgPiAtDQogICAgPiAg
ICAgICAgIGxwY19jdHJsLT5yZWdtYXAgPSBzeXNjb25fbm9kZV90b19yZWdtYXAoDQogICAgPiAg
ICAgICAgICAgICAgICAgICAgICAgICBwZGV2LT5kZXYucGFyZW50LT5vZl9ub2RlKTsNCiAgICA+
ICAgICAgICAgaWYgKElTX0VSUihscGNfY3RybC0+cmVnbWFwKSkgew0KICAgID4gQEAgLTI1OCw4
ICsyNzQsNiBAQCBzdGF0aWMgaW50IGFzcGVlZF9scGNfY3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KICAgID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KICAgID4g
ICAgICAgICB9DQogICAgPg0KICAgID4gLSAgICAgICBkZXZfaW5mbyhkZXYsICJMb2FkZWQgYXQg
JXByXG4iLCAmcmVzbSk7DQogICAgPiAtDQogICAgPiAgICAgICAgIHJldHVybiAwOw0KICAgID4N
CiAgICA+ICBlcnI6DQogICAgPiAtLQ0KICAgID4gMi4xNy4xDQogICAgPg0KICAgIA0KDQo=
