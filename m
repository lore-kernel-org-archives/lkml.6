Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAADC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAFF20878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HN1DGZ3u";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CKATKP7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfALAfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:35:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40268 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfALAfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:35:11 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0C0YjR1011065;
        Fri, 11 Jan 2019 16:34:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MAtdjEeuPTU0I777x0qfu2P8xmbVOHO0ODO3iQo4PjQ=;
 b=HN1DGZ3u71/NTOdB/gR3tn/q6bxdaPNKzfNRa4izscBxpjGmB0qjYeyGjZnsYqB65JnM
 fuJNp9GMVkyeNT4X2ep8ONTND4KIgHOL/UsKEXwkjbho3sWdI10gkG3AAapDWoSUPL1f
 Wa4H2V2NQH856Yms0ObFv1V7vj2F1tbH3ps= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2py2dugmcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 16:34:44 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 11 Jan 2019 16:33:10 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 11 Jan 2019 16:33:10 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 11 Jan 2019 16:33:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAtdjEeuPTU0I777x0qfu2P8xmbVOHO0ODO3iQo4PjQ=;
 b=CKATKP7cqamOp9Bn14pZfVdB/KFsEGYXmgaNTBZrhPv9W9ih6K8ynqapmNT8rCsjbhNRYMTD6udANdLKC6bhTb5Bt0n9DaqYF8VC9Q46QlgDNGzcMWhTcTficLE4T8CryuZLVstBzA51o40reqYJviVIX0zymY/swqgezgtBAXY=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1205.namprd15.prod.outlook.com (10.172.177.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Sat, 12 Jan 2019 00:33:08 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1516.016; Sat, 12 Jan
 2019 00:33:08 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
Thread-Topic: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
Thread-Index: AQHUqg5kq5zkppfjDEupYTurooq9yA==
Date:   Sat, 12 Jan 2019 00:33:08 +0000
Message-ID: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:9dd4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1205;20:DYwLn8iIFlSd7Ai86jGiPL29SPuOBM/JD3bws4Q3sQaWzX6UVgq1HK9pNv4z2YJKqQcLMoGgI42Weda8WsGQ1gyWURu/mBIeg6+QfZsyYWuPNSzG9MHqgs6VCEXdKVe3Pt2bITo1Qy7IQ9xupDR4NuPTh4vl8wfYaL9tXvUUfSk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9502ca50-4d55-4768-a068-08d6782586b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1205;
x-ms-traffictypediagnostic: CY4PR15MB1205:
x-microsoft-antispam-prvs: <CY4PR15MB120523C92F4282409175F6C5DD860@CY4PR15MB1205.namprd15.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(47680400002)(199004)(189003)(43544003)(2616005)(82746002)(81166006)(46003)(476003)(305945005)(99286004)(186003)(106356001)(33656002)(105586002)(6116002)(36756003)(53936002)(102836004)(8676002)(81156014)(53546011)(6246003)(8936002)(6512007)(6506007)(86362001)(486006)(7736002)(2201001)(4326008)(5660300001)(14454004)(25786009)(229853002)(2906002)(478600001)(71190400001)(83716004)(97736004)(71200400001)(6436002)(2501003)(316002)(256004)(6486002)(68736007)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1205;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 356DBwxERV9O4Zv4rxws5i3lLDdJWLXzs+LnyooaexjuueDJfjpUOirv9cjeajxEyFQ4T4I0U8Bpv/d8IBFj3JLeVwWYX/g7zp8LU1mvHEYGoKohMRdsuqyZTXa+XjA9cQZey8+4790WCWvdHOFZ2gO0noDG3a4vxhCzSBJ+27OYV2xaHUzM9pvSrAy4YQC5/94yitCnAVBVa+icVlT6Fc5OOd21GK70F1WszOfYFHkbPbah02x282RoGKObFMd+3Zuy8uKymPGrZ+5HU81kPAdTcWSoYdGBRQx1Xlg7uKE0GaBh3wTxu1A6UsHEHnRq5P3KTfjJLh9Pik+viDw6JbNrES46yRJ2dSx2yNVFUltrU3aY5fuzyn3KyZqfKta3z+Z9VnZmdFj6MgldqotYJo9rzjuSqNCf3st6zyYhg80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF19AE313A2D0A45AFDFB9272A9F0EA5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9502ca50-4d55-4768-a068-08d6782586b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 00:33:08.7825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1205
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lbCwNClBsZWFzZSBtZXJnZSB0aGVzZSBwYXRjaGVzIGFzIGl0IGlzIHJlcXVpcmVkIGJ5IGZh
Y2Vib29rIHBsYXRmb3JtLg0KDQpSZWdhcmRzDQotVmlqYXkNCg0K77u/T24gMS83LzE5LCAxMToy
NSBBTSwgIkxpbnV4LWFzcGVlZCBvbiBiZWhhbGYgb2YgVmlqYXkgS2hlbWthIiA8bGludXgtYXNw
ZWVkLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxpc3RzLm96bGFicy5vcmcgb24gYmVoYWxm
IG9mIHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQoNCiAgICBQbGVhc2UgbWVyZ2UgdGhlc2Ug
cGF0Y2hlcyBpbiB1cHN0cmVhbSBrZXJuZWwuDQogICAgDQogICAgUmVnYXJkcw0KICAgIC1WaWph
eQ0KICAgIA0KICAgIE9uIDEyLzIwLzE4LCAxMDowNiBBTSwgIkxpbnV4LWFzcGVlZCBvbiBiZWhh
bGYgb2YgVmlqYXkgS2hlbWthIiA8bGludXgtYXNwZWVkLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIu
Y29tQGxpc3RzLm96bGFicy5vcmcgb24gYmVoYWxmIG9mIHZpamF5a2hlbWthQGZiLmNvbT4gd3Jv
dGU6DQogICAgDQogICAgICAgIEpvZWwsIENhbiB5b3UgcGxlYXNlIHRha2UgY2FyZSBvZiB0aGVz
ZSBwYXRjaGVzIG1lcmdlLg0KICAgICAgICANCiAgICAgICAgT24gMTIvMTcvMTgsIDEyOjA0IFBN
LCAiVmlqYXkgS2hlbWthIiA8dmlqYXlraGVta2FAZmIuY29tPiB3cm90ZToNCiAgICAgICAgDQog
ICAgICAgICAgICBBZGRlZCBscGMgY3RybCBkZXZpY2UgdG8gZW5hYmxlIExQQyBjbG9jayBpbiBG
YWNlYm9vaw0KICAgICAgICAgICAgVGlvZ2FwYXNzIGRldmljZSB0cmVlLg0KICAgICAgICAgICAg
DQogICAgICAgICAgICBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZi
LmNvbT4NCiAgICAgICAgICAgIC0tLQ0KICAgICAgICAgICAgIC4uLi9ib290L2R0cy9hc3BlZWQt
Ym1jLWZhY2Vib29rLXRpb2dhcGFzcy5kdHMgIHwgMTcgKysrKysrKysrKysrKysrKysNCiAgICAg
ICAgICAgICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KICAgICAgICAgICAgDQog
ICAgICAgICAgICBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNl
Ym9vay10aW9nYXBhc3MuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9v
ay10aW9nYXBhc3MuZHRzDQogICAgICAgICAgICBpbmRleCA3M2U1OGE4MjE2MTMuLmVmNzg3NWI1
NDU2MiAxMDA2NDQNCiAgICAgICAgICAgIC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1i
bWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAgICAgICAgICAgKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgICAgICAgICBAQCAt
MjIsNiArMjIsMTcgQEANCiAgICAgICAgICAgICAJCXJlZyA9IDwweDgwMDAwMDAwIDB4MjAwMDAw
MDA+Ow0KICAgICAgICAgICAgIAl9Ow0KICAgICAgICAgICAgIA0KICAgICAgICAgICAgKwlyZXNl
cnZlZC1tZW1vcnkgew0KICAgICAgICAgICAgKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogICAg
ICAgICAgICArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCiAgICAgICAgICAgICsJCXJhbmdlczsNCiAg
ICAgICAgICAgICsNCiAgICAgICAgICAgICsJCWZsYXNoX21lbW9yeTogcmVnaW9uQDk4MDAwMDAw
IHsNCiAgICAgICAgICAgICsJCQluby1tYXA7DQogICAgICAgICAgICArCQkJcmVnID0gPDB4OTgw
MDAwMDAgMHgwMDAwMTAwMD47IC8qIDRLICovDQogICAgICAgICAgICArCQl9Ow0KICAgICAgICAg
ICAgKwl9Ow0KICAgICAgICAgICAgKw0KICAgICAgICAgICAgIAlpaW8taHdtb24gew0KICAgICAg
ICAgICAgIAkJY29tcGF0aWJsZSA9ICJpaW8taHdtb24iOw0KICAgICAgICAgICAgIAkJaW8tY2hh
bm5lbHMgPSA8JmFkYyAwPiwgPCZhZGMgMT4sIDwmYWRjIDI+LCA8JmFkYyAzPiwNCiAgICAgICAg
ICAgIEBAIC01NCw2ICs2NSwxMiBAQA0KICAgICAgICAgICAgIAl9Ow0KICAgICAgICAgICAgIH07
DQogICAgICAgICAgICAgDQogICAgICAgICAgICArJmxwY19jdHJsIHsNCiAgICAgICAgICAgICsJ
c3RhdHVzID0gIm9rYXkiOw0KICAgICAgICAgICAgKwltZW1vcnktcmVnaW9uID0gPCZmbGFzaF9t
ZW1vcnk+Ow0KICAgICAgICAgICAgKwlmbGFzaCA9IDwmc3BpMT47DQogICAgICAgICAgICArfTsN
CiAgICAgICAgICAgICsNCiAgICAgICAgICAgICAmdWFydDEgew0KICAgICAgICAgICAgIAkvLyBI
b3N0IENvbnNvbGUNCiAgICAgICAgICAgICAJc3RhdHVzID0gIm9rYXkiOw0KICAgICAgICAgICAg
LS0gDQogICAgICAgICAgICAyLjE3LjENCiAgICAgICAgICAgIA0KICAgICAgICAgICAgDQogICAg
ICAgIA0KICAgICAgICANCiAgICANCiAgICANCg0K
