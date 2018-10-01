Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F82C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9786E2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gJsrl75b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9786E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeJAHPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:45 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:45056
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729769AbeJAHPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkk6/sWtjfdMYpFmIBJ0VmxI6SKXSOYyspRrJkxhoxQ=;
 b=gJsrl75bqcgWQBHIyk5kpohY6SU85qFpOobJ9UVvhp/PMplnFcScXniI3AZUInY3TlPam3cCsHZplFJgAijC87oBdCtOesQkCk3r/UsBQr6YLKEQWdNLvUUIb67cmmZfjEQAC/L+Fs7GfZVeIlwRCYwbkHEVbPHuzdhgoOet/2U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Josh Abraham <j.abraham1776@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 37/37] xen: fix GCC warning and remove duplicate
 EVTCHN_ROW/EVTCHN_COL usage
Thread-Topic: [PATCH AUTOSEL 4.14 37/37] xen: fix GCC warning and remove
 duplicate EVTCHN_ROW/EVTCHN_COL usage
Thread-Index: AQHUWR8uqdUtxo/mWE2zeHf9VDmr5g==
Date:   Mon, 1 Oct 2018 00:39:15 +0000
Message-ID: <20181001003850.147107-37-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:yCExaXgD6G65fCVajIPB20AXFNrSFgnHGoka0GzM3Sy5q9C5KDg/9r6TdF5M8G+8RFMHpnzJ//ohmkr5vqbY6MOnNlaOp9V+c6R1omtF+hgHZwxGhq18Tz1yDz0ILp+iUJtrm1xqOvJf6FQSIrl/4hhSNK04Zvfmm0AL/1vabI5WtwmPCd4N+DJOi66ULrm7Wc/GH5jCWo5zAzHeN5aDb+e9YXmOJ/ZOGddkPusTPzKWWE/oKDahGZjCi0b03TwXr5Af6EmRuxF3vFazpH8SKQjqv7CqgIjHmedjgAr272bt/D1tdwS9TXLj0sbksX31MRXk+lE2hp7amvYmMo8o1iw5EWTtRop8gIeZW5PuSQTC7TNvOiBHYRiBCZXvpNl1Wj1TF1PpNFBJNPDaRehrVKgw7ZdZIoUHEIFU6ozqt08oWaBkaT9kkhP6erIsIyZSgHCz2pzR+Vmfy1uKAxRppA==;5:CIHXn0GagR77ScBBr3XNfl4vVAsKJeFYaGffteYDet64KPqHVEE33+IZJxC0vd9Ai6+2X4VmtaWZjl53n0mUOF9lhhCCsLR5uyJG36ywO1HCgs73YJdC88utnAK9KeP+v/SUHcgB2TkFSPWZKmVY9G1nbqZc8feizqYPQnrT7lE=;7:SY71ChJhuGvEejVa0pd3RMJoPNMEON/u1+eV9vWBxdQFE7LRm6Lg8Hw4mAM4RX9PGCzi/cQfcnkvR0VSYpU1wFWsWDX0LsXY62N1KMCWmA16EKN2vyAd9EJPdVxLyOXawQzfiZpmaqC9GZq7g/QGnaKq4kZOpfJwpAocuzYzXYIBFaBICtkcfic5GAbY2V51hav+sXw32Hq22FMdc6+rkOVZtos0wFoHF9kETh566mhDRMDgO0+H+CONyk/t/mik
x-ms-office365-filtering-correlation-id: 4ed53e60-068b-4de9-eee3-08d6273677e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01200CB058E12308CA13E6A4FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(39060400002)(2906002)(486006)(6506007)(2900100001)(4326008)(6666003)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2lx5qh2DK9KmRc2YU7Rngd9dpbQ+qwWM1A1JoHtVK1QVomShGsyUT+sG4zZ8PuhQWH+OqO7S7b09H50mOCqW+/GKm0e8N6DMxozVdNCs9Lo/EFYXwjs/B3ntAJnhhmDqm+5WspDPmAj9KhvRBKAnJJjRVY70WEw5UDHwLQZoTcuEAZ1/7dVbKRsFLWQ89D+VMh6KrUrODYKMB7AqtblQZ2SpPz1fia3o5n9MLD631sPSmWlOOPeSJ47OjPo5lSrOUzGKEfIF9MUuzBJdUqux1UUeR9soCqK2X1y3cRZsiYQsITtG37zRDXjd0kxpztnowPVNCLaBuPuSQ3mV6mKzDghcwHO1r6zRFSxW9Ab6FQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23D605EED0D8749A72B9949BC9EEEC0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed53e60-068b-4de9-eee3-08d6273677e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:15.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBBYnJhaGFtIDxqLmFicmFoYW0xNzc2QGdtYWlsLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNGRjYTg2NGI1OWRkMTUwYTIyMTczMDc3NWUyZjIxZjQ5Nzc5YzEzNSBdDQoNClRo
aXMgcGF0Y2ggcmVtb3ZlcyBkdXBsaWNhdGUgbWFjcm8gdXNlYWdlIGluIGV2ZW50c19iYXNlLmMu
DQoNCkl0IGFsc28gZml4ZXMgZ2NjIHdhcm5pbmc6DQp2YXJpYWJsZSDigJhjb2zigJkgc2V0IGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCg0KU2lnbmVkLW9mZi1ieTog
Sm9zaHVhIEFicmFoYW0gPGouYWJyYWhhbTE3NzZAZ21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NClNpZ25lZC1vZmYtYnk6IEJvcmlzIE9zdHJv
dnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBM
ZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3hlbi9l
dmVudHMvZXZlbnRzX2Jhc2UuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVu
dHNfYmFzZS5jIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCmluZGV4IDA4ZTRh
ZjA0ZDZmMi4uZTZjMTkzNDczNGI3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2
ZW50c19iYXNlLmMNCisrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQpAQCAt
MTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2dGNobl90b19pcnEodW5zaWduZWQgZXZ0
Y2huLCB1bnNpZ25lZCBpcnEpDQogCQljbGVhcl9ldnRjaG5fdG9faXJxX3Jvdyhyb3cpOw0KIAl9
DQogDQotCWV2dGNobl90b19pcnFbRVZUQ0hOX1JPVyhldnRjaG4pXVtFVlRDSE5fQ09MKGV2dGNo
bildID0gaXJxOw0KKwlldnRjaG5fdG9faXJxW3Jvd11bY29sXSA9IGlycTsNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KLS0gDQoyLjE3LjENCg==
