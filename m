Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58061C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB462098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="K4Dc0jpA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DlLxzCDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB462098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJPBZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:25:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726588AbeJPBZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:25:48 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FHbUKL028569;
        Mon, 15 Oct 2018 10:39:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5Z+6jINUyivd4J2rwPSzjpOPDgic7a1H7ZgOsVyQWOk=;
 b=K4Dc0jpAvACCCk/f13vw0ksKgmyhmwWt/IUt/2j4NKeDyCxAoe79JJTApAFRWCk5Qc8N
 o/5xNH5vEZQWKbdv6NNL65WYxKS1UY3BzwlsnC9CL4wG6wQmDpYA32NKoAHj/0tZF7PS
 dWvG1nuJsfsLYPGnKFESys9uDBfzLNS5BGc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2n4vybrrtx-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 10:39:25 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 15 Oct 2018 10:38:34 -0700
Received: from PRN-CHUB03.TheFacebook.com (2620:10d:c081:35::12) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 15 Oct 2018 10:38:34 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 15 Oct 2018 10:38:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z+6jINUyivd4J2rwPSzjpOPDgic7a1H7ZgOsVyQWOk=;
 b=DlLxzCDR9YRBq0yl2+1CGD7k9o/vlApGu7Wr1lpvB8m3ThbOBDwuywJEbDU0EURvelnwXSbcy3TeuKDJK27VWnt3M+6pgXo0wsHUKNZMtoVwcpBuKL4EhA4ZtoUwpbupIUpx8O0mcDuS9A4SNiL4vFSDBiAG6X7YkYmISn0DT9A=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1128.namprd15.prod.outlook.com (10.172.175.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 17:38:12 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 17:38:12 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [Potential Spoof] Re: [PATCH net-next v4] net/ncsi: Add NCSI
 Broadcom OEM command
Thread-Topic: [Potential Spoof] Re: [PATCH net-next v4] net/ncsi: Add NCSI
 Broadcom OEM command
Thread-Index: AQHUZK3YZtwEmdwSVk+mBoCxoG79OA==
Date:   Mon, 15 Oct 2018 17:38:12 +0000
Message-ID: <E82A7C2E-6DBF-437D-B571-5376F0122176@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:2d49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1128;20:pTXGzan7KK17J4uxBN052IMSxi7HiBEt6ToMttFv26DfBBTUU2riPIq2b9UDE42yAsj6o/6CyQYE2pEadDQwbH4BFvrrRvVqLuBnEqiS76awCRObaZkVNolwDyVghehKZZEF+W3jtK2XKGMh3lEFAjPZ1GRN+K+awfWfpRHq2+k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2f5ad438-7e22-43b0-085e-08d632c4faee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1128;
x-ms-traffictypediagnostic: CY4PR15MB1128:
x-microsoft-antispam-prvs: <CY4PR15MB1128AD0C21C5AE281364A752DDFD0@CY4PR15MB1128.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(65623756079841)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:CY4PR15MB1128;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1128;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(71200400001)(256004)(25786009)(316002)(561944003)(2906002)(486006)(2501003)(102836004)(71190400001)(14444005)(81166006)(229853002)(53546011)(8676002)(5250100002)(83716004)(2900100001)(4001150100001)(2201001)(81156014)(6116002)(8936002)(6486002)(305945005)(86362001)(53936002)(33656002)(186003)(110136005)(5660300001)(99286004)(105586002)(6506007)(478600001)(36756003)(4326008)(7736002)(14454004)(68736007)(54906003)(2616005)(6436002)(476003)(6246003)(97736004)(106356001)(6512007)(46003)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1128;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QDCFwPYlSSnqKN//HbsGZLs3pH6+gr0b+m5LdiQf07cpID8jiNyBWbBFj6s/kw4TUufB0MQFlh0tHJFZ2LB0I/rpdyxDWdORwt/7NZtAqRXiWDpCZRYVqd3o3KUOmUR2F+KC3uJi4rzcEsJSxYgRSPm5tQD0Ltz5hzaU4WdTvYzAcmVNuPsgBXlgtFvnoYCptI3awEAvG8zHt0aXSrz+jH9iVeNRMdGabmzhsbnDieP3JE/KvMvanIxmWAsxhZ/DZGd7T3KWAevUKUpaEcxlv6AyKAyOS+lEjSwXCRdGlGgMfG7yzkehop9Ut/TkjgrsrSz7TVh/00cnQP7yJxFX6D7UvN7fYUzWbG/pSpgYe0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5359F3D8CE598741BDD4149964E9E207@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5ad438-7e22-43b0-085e-08d632c4faee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 17:38:12.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1128
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzE1LzE4LCAxMDoyNyBBTSwgIkxpbnV4LWFzcGVlZCBvbiBiZWhhbGYgb2Yg
VmlqYXkgS2hlbWthIiA8bGludXgtYXNwZWVkLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxp
c3RzLm96bGFicy5vcmcgb24gYmVoYWxmIG9mIHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQoN
CiAgICANCiAgICANCiAgICBPbiAxMC8xNC8xOCwgODo1MSBQTSwgIlNhbXVlbCBNZW5kb3phLUpv
bmFzIiA8c2FtQG1lbmRvemFqb25hcy5jb20+IHdyb3RlOg0KICAgIA0KICAgICAgICBPbiBNb24s
IDIwMTgtMTAtMTUgYXQgMTM6MDggKzExMDAsIFNhbXVlbCBNZW5kb3phLUpvbmFzIHdyb3RlOg0K
ICAgICAgICA+IE9uIEZyaSwgMjAxOC0xMC0xMiBhdCAxMToyMCAtMDcwMCwgVmlqYXkgS2hlbWth
IHdyb3RlOg0KICAgICAgICA+ID4gVGhpcyBwYXRjaCBhZGRzIE9FTSBCcm9hZGNvbSBjb21tYW5k
cyBhbmQgcmVzcG9uc2UgaGFuZGxpbmcuIEl0IGFsc28NCiAgICAgICAgPiA+IGRlZmluZXMgT0VN
IEdldCBNQUMgQWRkcmVzcyBoYW5kbGVyIHRvIGdldCBhbmQgY29uZmlndXJlIHRoZSBkZXZpY2Uu
DQogICAgICAgID4gPiANCiAgICAgICAgPiA+IG5jc2lfb2VtX2dtYV9oYW5kbGVyX2JjbTogVGhp
cyBoYW5kbGVyIHNlbmQgTkNTSSBicm9hZGNvbSBjb21tYW5kIGZvcg0KICAgICAgICA+ID4gZ2V0
dGluZyBtYWMgYWRkcmVzcy4NCiAgICAgICAgPiA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX2JjbTog
VGhpcyBoYW5kbGVzIHJlc3BvbnNlIHJlY2VpdmVkIGZvciBhbGwNCiAgICAgICAgPiA+IGJyb2Fk
Y29tIE9FTSBjb21tYW5kcy4NCiAgICAgICAgPiA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX2JjbV9n
bWE6IFRoaXMgaGFuZGxlcyBnZXQgbWFjIGFkZHJlc3MgcmVzcG9uc2UgYW5kDQogICAgICAgID4g
PiBzZXQgaXQgdG8gZGV2aWNlLg0KICAgICAgICA+ID4gDQogICAgICAgID4gPiBTaWduZWQtb2Zm
LWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICAgICAgPiA+IC0tLQ0K
ICAgICAgICA+ID4gIHY0OiB1cGRhdGVkIGFzIHBlciBjb21tZW50IGZyb20gU2FtLCBJIHdhcyBq
dXN0IHdvbmRlcmluZyBpZiBJIGNhbiByZW1vdmUNCiAgICAgICAgPiA+ICBOQ1NJX09FTV9DTURf
R0VUX01BQyBjb25maWcgb3B0aW9uIGFuZCBsZXQgdGhpcyBjb2RlIGJlIHZhbGlkIGFsd2F5cyBh
bmQNCiAgICAgICAgPiA+ICBpdCB3aWxsIGNvbmZpZ3VyZSBtYWMgYWRkcmVzcyBpZiB0aGVyZSBp
cyBnZXQgbWFjIGFkZHJlc3MgaGFuZGxlciBmb3IgZ2l2ZW4gDQogICAgICAgID4gPiAgbWFudWZh
Y3R1cmUgaWQuDQogICAgICAgID4gDQogICAgICAgID4gSGkgVmlqYXksDQogICAgICAgID4gDQog
ICAgICAgID4gV2UgY2FuIGxvb2sgYXQgaGFuZGxpbmcgdGhpcyBhIGRpZmZlcmVudCB3YXksIGJ1
dCBJIGRvbid0IHRoaW5rIHdlIHdhbnQNCiAgICAgICAgPiB0byB1bmNvbmRpdGlvbmFsbHkgc2V0
IHRoZSBzeXN0ZW0ncyBNQUMgYWRkcmVzcyBiYXNlZCBvbiB0aGUgT0VNIEdNQQ0KICAgICAgICA+
IGNvbW1hbmQuIElmIHRoZSB1c2VyIHdhbnRzIHRvIHNldCBhIGN1c3RvbSBNQUMgYWRkcmVzcywg
b3IgaW4gdGhlIGNhc2Ugb2YNCiAgICAgICAgPiBPcGVuQk1DIGZvciBleGFtcGxlIHdobyBoYXZl
IHRoZWlyIE1BQyBhZGRyZXNzIHNhdmVkIGluIGZsYXNoLCB0aGlzIHdpbGwNCiAgICAgICAgPiBv
dmVycmlkZSB0aGF0IHZhbHVlIHdpdGggd2hhdGV2ZXIgdGhlIE5ldHdvcmsgQ29udHJvbGxlciBo
YXMgc2F2ZWQuIEluDQogICAgICAgID4gcGFydGljdWxhciBhcyBpdCBpcyBzZXQgdXAgaXQgd2ls
bCBvdmVycmlkZSBhbnkgTUFDIGFkZHJlc3MgZXZlcnkgdGltZSBhDQogICAgICAgID4gY2hhbm5l
bCBpcyBjb25maWd1cmVkLCBzdWNoIGFzIGR1cmluZyBhIGZhaWxvdmVyIGV2ZW50Lg0KICAgICAg
ICA+IA0KICAgICAgICA+IFdlICpjb3VsZCogYWx3YXlzIHNlbmQgdGhlIEdNQSBjb21tYW5kIGlm
IGl0IGlzIGF2YWlsYWJsZSBhbmQgbW92ZSB0aGUNCiAgICAgICAgPiBkZWNpc2lvbiB3aGV0aGVy
IHRvIHVzZSB0aGUgcmVzdWx0aW5nIGFkZHJlc3Mgb3Igbm90IGludG8gdGhlIHJlc3BvbnNlDQog
ICAgICAgID4gaGFuZGxlci4gVGhhdCB3b3VsZCBzaW1wbGlmeSB0aGUgbmNzaV9jb25maWd1cmVf
Y2hhbm5lbCgpIGxvZ2ljIGEgYml0Lg0KICAgICAgICA+IEFub3RoZXIgaWRlYSBtYXkgYmUgdG8g
aGF2ZSBhIE5ldGxpbmsgY29tbWFuZCB0byB0ZWxsIE5DU0kgdG8gaWdub3JlIHRoZQ0KICAgICAg
ICA+IEdNQSByZXN1bHQ7IHRoZW4gd2UgY291bGQgZHJvcCB0aGUgY29uZmlnIG9wdGlvbiBhbmQg
dGhlIHN5c3RlbSBjYW4NCiAgICAgICAgPiBzYWZlbHkgY2hhbmdlIHRoZSBhZGRyZXNzIGlmIGRl
c2lyZWQuDQogICAgICAgID4gDQogICAgICAgID4gQW55IHRob3VnaHRzPyBJJ2xsIGFsc28gcGlu
ZyBzb21lIG9mIHRoZSBPcGVuQk1DIHBlb3BsZSBhbmQgc2VlIHdoYXQNCiAgICAgICAgPiB0aGVp
ciBleHBlY3RhdGlvbnMgYXJlLg0KICAgICAgICANCiAgICAgICAgQWZ0ZXIgYSBiaXQgb2YgYSB0
aGluayBhbmQgYW4gYXNrIGFyb3VuZCwgdG8gcXVvdGUgYSBjb2xsZWFndWU6DQogICAgICAgID4g
SSB0aGluayB3ZSdkIHdhbnQgaXQgaGFuZGxlZCAob3ZlcmFsbCkgbGlrZSBhbnkgb3RoZXIgbmV0
IGRldmljZTsgdGhlIE1BQw0KICAgICAgICA+IGFkZHJlc3MgaW4gdGhlIGRldmljZSdzIFJPTSBw
cm92aWRlcyBhIGRlZmF1bHQsIGFuZCBpcyBvdmVycmlkZGVuIGJ5IGFueXRoaW5nDQogICAgICAg
ID4gc3BlY2lmaWVkIGJ5IHVzZXJzcGFjZSANCiAgICAgICAgDQogICAgICAgIFdoaWNoIGRlc2Ny
aWJlcyB3aGF0IEkgd2FzIHRoaW5raW5nIHByZXR0eSB3ZWxsLg0KICAgICAgICBTbyBpZiB3ZSBj
YW4gaGF2ZSBpdCBzdWNoIHRoYXQgdGhlIE5DU0kgZHJpdmVyIG9ubHkgc2V0cyB0aGUgTUFDIGFk
ZHJlc3MNCiAgICAgICAgX29uY2VfLCBhbmQgdGhlbiBhZnRlciB0aGVuIGRvZXMgbm90IHVwZGF0
ZSBpdCBhZ2Fpbiwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gY2FsbA0KICAgICAgICB0aGUgT0VNIEdN
QSBjb21tYW5kIHdpdGhvdXQgaGlkaW5nIGl0IGJlaGluZCBhIGNvbmZpZyBvcHRpb24uIFNvIHRo
ZSBmaXJzdCB0aW1lDQogICAgICAgIGEgY2hhbm5lbCB3YXMgY29uZmlndXJlZCB3ZSBzdG9yZSBh
bmQgc2V0IHRoZSBNQUMgYWRkcmVzcyBnaXZlbiwgYnV0IHRoZW4gb24NCiAgICAgICAgbGF0ZXIg
Y29uZmlndXJlIGV2ZW50cyB3ZSBkb24ndCBjb250aW51ZSB0byB1cGRhdGUgaXQuIFdoYXQgZG8g
eW91IHRoaW5rPw0KICAgICAgICANCiAgICAgICAgQ2hlZXJzLA0KICAgICAgICBTYW0NCiAgICAN
CiAgICAgIEkgYWdyZWUgd2l0aCB5b3Ugc2V0dGluZyBpdCBvbmx5IG9uY2UuIEkgZ2F2ZSBhIHRo
b3VnaHQgYWJvdXQgY29uZmlnIG9wdGlvbiBhbmQgcmVhbGl6ZSB0aGF0IA0KICAgICAgd2Ugc2hv
dWxkIGFsbG93IHVzZXIgdG8gY29uZmlndXJlIGl0LiBJZiB1c2VyIHdhbnRzIHRvIHNldCBtYWMg
YWRkcmVzcyB0aHJvdWdoIGRldmljZSB0cmVlIA0KICAgICAgYW5kIG5vdCB0aHJvdWdoIFJPTSB0
aGVuIHdlIG11c3Qgbm90IG92ZXJyaWRlIG1hYyBzZXQgYnkgZGV2aWNlIHRyZWUuIFNvIG15IHBy
b3Bvc2FsIGlzIA0KICAgICAgc2V0dGluZyBvZiBtYWMgYWRkcmVzcyBpbiByZXNwb25zZSBzaG91
bGQgYmUgaGlkZGVuIHVuZGVyIGNvbmZpZyBvcHRpb24uIEdldHRpbmcgbWFjIGFkZHJlc3MgDQog
ICAgICBjYW4gc3RpbGwgZ28gd2l0aG91dCBjb25maWcgb3B0aW9uLiBZb3VyIHRob3VnaHQ/DQog
ICAgICAgIA0KICBvciBzaW1wbHkgZ3VhcmQgZm9sbG93aW5nIGJsb2NrIHVuZGVyIGNvbmZpZyBh
bmQgbm8gb3RoZXIgZnVuY3Rpb24gZGVjbGFyYXRpb24gZ3VhcmQgcmVxdWlyZWQuIA0KICBBbmQg
c2V0IHN0YXRpYyB2YXJpYWJsZSBmbGFnIGluIGZ1bmN0aW9uICIgbmNzaV9vZW1faGFuZGxlciIg
Zm9yIGNhbGxpbmcgdGhpcyBvbmx5IG9uY2UuDQoNCiAgI2lmIElTX0VOQUJMRUQoQ09ORklHX05D
U0lfT0VNX0NNRF9HRVRfTUFDKQ0KICAgIG5jYS50eXBlID0gTkNTSV9QS1RfQ01EX09FTTsNCiAg
ICBuY2EucGFja2FnZSA9IG5wLT5pZDsNCiAgICBuY2EuY2hhbm5lbCA9IG5jLT5pZDsNCiAgICBu
ZHAtPnBlbmRpbmdfcmVxX251bSA9IDE7DQogICAgcmV0ID0gbmNzaV9vZW1faGFuZGxlcigmbmNh
LCBuYy0+dmVyc2lvbi5tZl9pZCk7DQojZW5kaWYgLyogQ09ORklHX05DU0lfT0VNX0NNRF9HRVRf
TUFDICovDQoNCg==
