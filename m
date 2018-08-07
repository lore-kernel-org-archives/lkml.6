Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C59C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781EC21A60
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ATUfXOnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781EC21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbeHGDJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:09:52 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:60672
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387455AbeHGDJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jBStCgPv5m/AxrujmUS+JoBGl2TbG3M7h1xAXwBz7I=;
 b=ATUfXOnYVb4jCKMVFNsVyXo7QLCs26FiD62nnACjKIVxSMZl74KZv0Koqc670zeRBsd37xM/lRuH+CYbaIz4mDtWEyy08SBxIp0hkPPt4Py9HBdA2DUQXs/80a8HR3fpggoA0JHHYV9npxFdF5/NdQzvmRe+YFF+PH9P3AG/4Pg=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4626.namprd05.prod.outlook.com (20.177.144.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.17; Tue, 7 Aug 2018 00:58:05 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::92e:121f:171b:8b0b]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::92e:121f:171b:8b0b%5]) with mapi id 15.20.1038.013; Tue, 7 Aug 2018
 00:58:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: fix uvc_alloc_entity() allocation alignment
Thread-Topic: [PATCH] usb: fix uvc_alloc_entity() allocation alignment
Thread-Index: AQHT/EdXk94XJ+gJ602/AGch9ALmbqSzyi2AgAAQp4A=
Date:   Tue, 7 Aug 2018 00:58:05 +0000
Message-ID: <0B044CD5-B4F5-4614-B97A-E02E5C1E8A17@vmware.com>
References: <20180604134713.101064-1-namit@vmware.com>
 <15813968.YrTFj7ZbY9@avalon>
In-Reply-To: <15813968.YrTFj7ZbY9@avalon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.3.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4626;20:pcJ/rErwJuiu1mDyjaBu47ncV5hq4W6Ryc3Rz2ue1qvErML3tNZkMFxHcgZ+nnmd3H4DioKRrGWdCD+GTPr3/3zC3r5wbnAawkJXM8pHC5m/2HcB7RWxz+p2wmVDl3yInBkvsTlGzEA2mk4Xp/wOzxEXwNkT3TyIiUZulvTki6k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 120de480-47e1-43a8-4e76-08d5fc00d58e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4626;
x-ms-traffictypediagnostic: BL0PR05MB4626:
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB4626A6E029F36C5AACB629FAD0270@BL0PR05MB4626.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR05MB4626;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4626;
x-forefront-prvs: 0757EEBDCA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(76176011)(476003)(26005)(5250100002)(83716003)(4326008)(102836004)(6506007)(229853002)(6486002)(105586002)(6512007)(6246003)(186003)(6436002)(82746002)(66066001)(86362001)(106356001)(53936002)(446003)(316002)(2616005)(11346002)(25786009)(5660300001)(478600001)(8676002)(99286004)(97736004)(6916009)(6116002)(3846002)(81156014)(81166006)(54906003)(68736007)(7736002)(33656002)(14444005)(256004)(305945005)(8936002)(2906002)(486006)(14454004)(345774005)(2900100001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4626;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 91RWHdG5jlOprhOhddXq4jUttyUC4Jodx/sO8PpEENt2vZQgv99V3CnrQNxl5VM2NeYEyoSwOBtkqSfJXBLwYRGpQ7ZZaITpSAa/RRxdr5UwB5i09UF7KVmZjiKOJ5fOTnSQwVqqtA6lrJZ9DB1VWefLW1GJ1YibLNgGRQNdhQgmf+WBKcjKcrtM3/a4IV/odkhWfePvGDOr4IAL1YzWEq0k/UwaQP/lzZ13HdfUGgVTgFAEo7dtlAkdQIvNKWNDhIZqpuALHCqKb941pgZTeGDLVrDnUgWjaRpYlX9Zu7YUHAJG024D+ZfVBzBAZZI18j6QicQlRe+j/yLUsVrpMHtMTfRWXc/Nbs1a87ERTww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <41B96F3C5F277940B428884598F503D6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120de480-47e1-43a8-4e76-08d5fc00d58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2018 00:58:05.4625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNDo1OCBQTSwgTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9h
cmQuY29tPiB3cm90ZToNCg0KPiBIaSBOYWRhdiwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBh
dGNoLg0KPiANCj4gT24gTW9uZGF5LCA0IEp1bmUgMjAxOCAxNjo0NzoxMyBFRVNUIE5hZGF2IEFt
aXQgd3JvdGU6DQo+PiBUaGUgdXNlIG9mIEFMSUdOKCkgaW4gdXZjX2FsbG9jX2VudGl0eSgpIGlz
IGluY29ycmVjdCwgc2luY2UgdGhlIHNpemUgb2YNCj4+IChlbnRpdHktPnBhZHMpIGlzIG5vdCBh
IHBvd2VyIG9mIHR3by4gQXMgYSBzdG9wLWdhcCwgdW50aWwgYSBiZXR0ZXINCj4+IHNvbHV0aW9u
IGlzIGFkYXB0ZWQsIHVzZSByb3VuZHVwKCkgaW5zdGVhZC4NCj4+IA0KPj4gRm91bmQgYnkgYSBz
dGF0aWMgYXNzZXJ0aW9uLiBDb21waWxlLXRlc3RlZCBvbmx5Lg0KPj4gDQo+PiBGaXhlczogNGZm
YzJkODlmMzhhICgidXZjdmlkZW86IFJlZ2lzdGVyIHN1YmRldmljZXMgZm9yIGVhY2ggZW50aXR5
IikNCj4+IA0KPj4gQ2M6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNv
bmJvYXJkLmNvbT4NCj4+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVs
Lm9yZz4NCj4+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcNCj4+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE5hZGF2IEFtaXQg
PG5hbWl0QHZtd2FyZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNf
ZHJpdmVyLmMgfCAyICstDQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNf
ZHJpdmVyLmMNCj4+IGIvZHJpdmVycy9tZWRpYS91c2IvdXZjL3V2Y19kcml2ZXIuYyBpbmRleCAy
NDY5YjQ5YjJiMzAuLjZiOTg5ZDQxYzAzNA0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21l
ZGlhL3VzYi91dmMvdXZjX2RyaXZlci5jDQo+PiArKysgYi9kcml2ZXJzL21lZGlhL3VzYi91dmMv
dXZjX2RyaXZlci5jDQo+PiBAQCAtOTA5LDcgKzkwOSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdXZjX2Vu
dGl0eSAqdXZjX2FsbG9jX2VudGl0eSh1MTYgdHlwZSwgdTgNCj4+IGlkLCB1bnNpZ25lZCBpbnQg
c2l6ZTsNCj4+IAl1bnNpZ25lZCBpbnQgaTsNCj4+IA0KPj4gLQlleHRyYV9zaXplID0gQUxJR04o
ZXh0cmFfc2l6ZSwgc2l6ZW9mKCplbnRpdHktPnBhZHMpKTsNCj4+ICsJZXh0cmFfc2l6ZSA9IHJv
dW5kdXAoZXh0cmFfc2l6ZSwgc2l6ZW9mKCplbnRpdHktPnBhZHMpKTsNCj4+IAludW1faW5wdXRz
ID0gKHR5cGUgJiBVVkNfVEVSTV9PVVRQVVQpID8gbnVtX3BhZHMgOiBudW1fcGFkcyAtIDE7DQo+
PiAJc2l6ZSA9IHNpemVvZigqZW50aXR5KSArIGV4dHJhX3NpemUgKyBzaXplb2YoKmVudGl0eS0+
cGFkcykgKiBudW1fcGFkcw0KPj4gCSAgICAgKyBudW1faW5wdXRzOw0KPiANCj4gVGhlIHB1cnBv
c2Ugb2YgdGhpcyBhbGlnbm1lbnQgaXMgdG8gbWFrZSBzdXJlIHRoYXQgZW50aXR5LT5wYWRzIHdp
bGwgYmUgDQo+IHByb3Blcmx5IGFsaWduZWQuIEluIHRoZW9yeSB0aGUgc2l6ZSBvZiB1dmNfZW50
aXR5IHNob3VsZCBiZSB0YWtlbiBpbnRvIA0KPiBhY2NvdW50IHRvbywgYnV0IHRoZSBzdHJ1Y3R1
cmUgY29udGFpbnMgcG9pbnRlcnMsIHNvIGl0cyBzaXplIHNob3VsZCBhbHJlYWR5IA0KPiBiZSBw
cm9wZXJseSBhbGlnbmVkLiBUaGlzIHBhdGNoIHRodXMgbG9va3MgZ29vZCB0byBtZS4gV2hhdCBt
YWRlIHlvdSBzYXkgaXQncyANCj4gYSBzdG9wLWdhcCBtZWFzdXJlID8NCg0KVGhhbmtzLiBJdOKA
mXMgYmVlbiBhIHdoaWxlLiBBbnlob3csIEkgZG9u4oCZdCBrbm93IGhvdyDigJxob3TigJ0gdGhp
cyBjb2RlIGlzLCBidXQNCnJvdW5kdXAgdXNlcyBhIGRpdiBvcGVyYXRpb25zLCBzbyBpZiBpdCBp
cyDigJxob3TigJ0geW91IG1heSB3YW50IGEgZGlmZmVyZW50DQp3YXkgdG8gYWxpZ24gd2l0aCBs
b3dlciBvdmVyaGVhZC4NCg0KSSBwcmVzdW1lIGl0IGlzIG5vdOKApg0KDQpSZWdhcmRzLA0KTmFk
YXY=
