Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C266C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FD620645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YePMupU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FD620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIJODq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:03:46 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:33734
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727261AbeIJODp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdrBL6R+Hffn3Hy2qYl5dQIYD4ky2grc96u20aFOg2Q=;
 b=YePMupU3QakdnlORkNG9bha6YHrl4tpK5eHHn/QlXnpbHMN6Dl2CwS7T2IEZNNBWNBZiPmH7C1Zv/o+9Qtg9nU7yFRgsOcVEQz7dT0IIq/qe5X/Q0XERY/yl/qhhflMN+VF+ZqST3E0Neu7rrE7itPpPwzfY03C4p9esOe1whU0=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2770.eurprd04.prod.outlook.com (10.175.41.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 09:09:59 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766%9]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 09:09:59 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Scott Wood <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@lists.linux-foundation.org" 
        <linux-pm@lists.linux-foundation.org>
Subject: RE: [PATCH 3/3] soc: fsl: add RCPM driver
Thread-Topic: [PATCH 3/3] soc: fsl: add RCPM driver
Thread-Index: AQHUQN58GshJMZ1zr02GefLWKtgWa6TlT/sAgAPzryA=
Date:   Mon, 10 Sep 2018 09:09:59 +0000
Message-ID: <AM5PR0402MB28652A2D74A891BC35B1B680F1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
         <20180831035219.31619-3-ran.wang_1@nxp.com>
 <86101ce0f4201d05510e57d74cafe8c665b8e5d4.camel@buserror.net>
In-Reply-To: <86101ce0f4201d05510e57d74cafe8c665b8e5d4.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2770;6:fWB7VBEetitB3ojElumNHK8Z6NVWaiZ9ml+cYEF8+zP0PACgMVu0/pzOJeTJ8njzgjVRip4FyArP1JvWCPRyyGUtCgbXx8C6GPlSoXHEH+QKaSil7rCj3WZ7f2uAuRbQPKNjCwOO/CTwf+1chenb3xM4FZ86Peq8r8UOCxoKyLQTKRmPGWAlIW+vsHcW2fzwR7vEJALarN/kjFFuA9qZMwoQ5QLlJHIiH6BoaH4pwPZnJ5lR4Aa4eFAPOudGH65nJuU59gLe+JJqNwepwHUZ+kGBS9IfVkju9HWCv3X9tZtrz6HTLhzjz64Qs/X4eUnWzS58uXmexXeJJpTF39Q0vcUoAGHykizvMkm2RVxCWN/xDUIVRMug6FTyRpa5DvXC2CekOn6I80NkDxFI9jWOwqaZFbcDMRMsCw8O9xdc2S3dzJ0V9PC6WkL9qRj+CH/tfu4vENhKjDzQ8qtBQsduqA==;5:qm44qLC3RWdUnQzkBSLV3N9ZpG1BnIurpeoYOrtljufyommmYnYFxisKEsszOMhSCa7OmWB/bmovHZTG3mpp4BiPig1cATIFblAB/fkAWmIUFDKD41b4ZTE83mj6rjiOhiJzo58mzyfnqHRTnaSbrPO5Qr3EiIyGZ969VfFAon4=;7:wM/PBCOZC7RoacPxzDq6f4y/GKXr1ZHFzR2ebCpc+isBVJf3QB7ZQzyi6G187zVo20uVXDLZoQ7Wnef0mO0/ydNCLuDu0aHIrThQIf7NRPU9xx5RfELfp8+ef1pHNMMcxow6EH3APq7+DGoh1SrES5HJhOv4pm7AACd5uCDlqtnUsC+YWXVjNxiiZfP8R4w9jZQVbIMEIlhWjO0DxpX9NzubKMTLC+UViQS74bSFhU0i79HLeAsT1ohz3pxYpcdI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 92ef8fe6-b206-44c5-8e6e-08d616fd2f1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2770;
x-ms-traffictypediagnostic: AM5PR0402MB2770:
x-microsoft-antispam-prvs: <AM5PR0402MB2770EA6D9840106D41D30EB6F1050@AM5PR0402MB2770.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM5PR0402MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2770;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(68736007)(6246003)(2900100001)(25786009)(6506007)(102836004)(53546011)(86362001)(9686003)(14444005)(55016002)(256004)(6436002)(5660300001)(229853002)(106356001)(53936002)(99286004)(74316002)(186003)(33656002)(478600001)(105586002)(305945005)(26005)(110136005)(6116002)(316002)(11346002)(54906003)(3846002)(2906002)(97736004)(7696005)(7736002)(5250100002)(446003)(8676002)(14454004)(66066001)(81166006)(476003)(81156014)(8936002)(76176011)(4326008)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2770;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HxmQCousxyCFMFioP3hDkGLMb76Vm9ie6p7nyc86y+GpfzL+OCfk/4UjMhaf5I/1kYiWw2DX9RlvxSPDbA5ldy2xC8F0dPiCmTFeD5xPhn1WYm6C+Xaem23sXejo9y/5aStpfN3xncNJjixSJerRxLTNsDKI+mz9wA/UAQqCJqGY8LwBKa++D1FVB0NiaxvoawJ6Q383p+dduW/Z/GqMMiChnRTeB0+uV05JwiF8/B3ZwuV46rDeWTCgilohDRG0Eqz7QyH8yXTknMqQs7NFe/pjh4NpFFiWbp895WyAbtnJ9FYoRi0z3AuZaGQy/KiXcGQ/6Nx0nlQmqtS2OqEj2QO3HWX3Wg/6CHzuTfdwWfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ef8fe6-b206-44c5-8e6e-08d616fd2f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 09:09:59.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2NvdHQsDQoNCk9uIDIwMTgvOS84IDE4OjE2LCBTY290dCBXb29kIHdyb3RlOg0KPiANCj4g
T24gRnJpLCAyMDE4LTA4LTMxIGF0IDExOjUyICswODAwLCBSYW4gV2FuZyB3cm90ZToNCj4gPiBU
aGUgTlhQJ3MgUW9ySVEgUHJvY2Vzc29ycyBiYXNlZCBvbiBBUk0gQ29yZSBoYXZlIFJDUE0gbW9k
dWxlIChSdW4NCj4gPiBDb250cm9sIGFuZCBQb3dlciBNYW5hZ2VtZW50KSwgd2hpY2ggcGVyZm9y
bXMgYWxsIGRldmljZS1sZXZlbCB0YXNrcw0KPiA+IGFzc29jaWF0ZWQgd2l0aCBwb3dlciBtYW5h
Z2VtZW50IHN1Y2ggYXMgd2FrZXVwIHNvdXJjZSBjb250cm9sLg0KPiA+DQo+ID4gVGhpcyBkcml2
ZXIgZGVwZW5kcyBvbiBGU0wgcGxhdGZvcm0gUE0gZHJpdmVyIGZyYW1ld29yayB3aGljaCBoZWxw
IHRvDQo+ID4gaXNvbGF0ZSB1c2VyIGFuZCBQTSBzZXJ2aWNlIHByb3ZpZGVyIChzdWNoIGFzIFJD
UE0gZHJpdmVyKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5odWkgWmhhbyA8Y2hlbmh1
aS56aGFvQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWluZyBaaGFuZyA8eWluZy56aGFu
ZzIyNDU1QG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcgPHJhbi53YW5nXzFA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvZnNsL0tjb25maWcgICB8ICAgIDYg
KysNCj4gPiAgZHJpdmVycy9zb2MvZnNsL01ha2VmaWxlICB8ICAgIDEgKw0KPiA+ICBkcml2ZXJz
L3NvYy9mc2wvbHMtcmNwbS5jIHwgIDE1Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE2MCBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgZHJpdmVycy9zb2Mv
ZnNsL2xzLXJjcG0uYw0KPiANCj4gSXMgdGhlcmUgYSByZWFzb24gd2h5IHRoaXMgaXMgTFMtc3Bl
Y2lmaWMsIG9yIGNvdWxkIGl0IGJlIHVzZWQgd2l0aCBQUEMgUkNQTQ0KPiBibG9ja3M/DQoNClRo
ZXkgaGF2ZSBkaWZmZXJlbnQgU1cgYXJjaCBkZXNpZ24gb24gbG93IHBvd2VyIG9wZXJhdGlvbjog
UFBDIFJDUE0NCmRyaXZlciBoYXMgdGFrZW4gY2FyZSBvZiBtb3N0IHRoaW5ncyBvZiBzdXNwZW5k
IGVudGVyICYgZXhpdC4gQW5kIExTIFJDUE0gZHJpdmVyDQp3aWxsIG9ubHkgaGFuZGxlIHdha2V1
cCBzb3VyY2UgY29uZmlndXJlIGFuZCBsZWZ0IHJlc3Qgd29yayB0byBzeXN0ZW0gZmlybXdhcmUN
CnRvIGRvLiBTbyB5b3UgbWlnaHQgYmUgYXdhcmUgdGhhdCBMUyBSQ1BNIHdpbGwgb25seSBnZXQg
Y2FsbCB3aGVuZXZlciBwbGF0X3BtDQpkcml2ZXIgQVBJIGlzIGNhbGxlZCByYXRoZXIgdGhhbiBz
eXN0ZW0gc3VzcGVuZCBiZWdpbiB3aGVyZS4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvZnNsL0tjb25maWcgYi9kcml2ZXJzL3NvYy9mc2wvS2NvbmZpZyBpbmRleA0KPiA+IDY1
MTc0MTIuLjg4MjMzMGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL0tjb25maWcN
Cj4gPiArKysgYi9kcml2ZXJzL3NvYy9mc2wvS2NvbmZpZw0KPiA+IEBAIC0zMCwzICszMCw5IEBA
IGNvbmZpZyBGU0xfUExBVF9QTQ0KPiA+ICAJICBoYXZlIHRvIGtub3cgdGhlIGltcGxlbWVudCBk
ZXRhaWxzIG9mIHdha2V1cCBmdW5jdGlvbiBpdCByZXF1aXJlLg0KPiA+ICAJICBCZXNpZGVzLCBp
dCBpcyBhbHNvIGVhc3kgZm9yIHNlcnZpY2Ugc2lkZSB0byB1cGdyYWRlIGl0cyBsb2dpYw0KPiA+
IHdoZW4NCj4gPiAgCSAgZGVzaWduIGNoYW5nZWQgYW5kIHJlbWFpbiB1c2VyIHNpZGUgdW5jaGFu
Z2VkLg0KPiA+ICsNCj4gPiArY29uZmlnIExTX1JDUE0NCj4gPiArCWJvb2wgIkZyZWVzY2FsZSBS
Q1BNIHN1cHBvcnQiDQo+ID4gKwlkZXBlbmRzIG9uIChGU0xfUExBVF9QTSkNCj4gDQo+IFdoeSBp
cyB0aGlzIHBhcmVudGhlc2l6ZWQ/DQoNCkJlY2F1c2Ugd2UnZCBsaWtlIHRvIGRlY291cGxlIFJD
UE0gZHJpdmVyIGFuZCBpdHMgdXNlci4NCkJlbmVmaXQgaXMgdGhhdCB3aWxsIGFsbG93IHVzZXIg
ZG9lc24ndCBoYXZlIHRvIGtub3cgd2hvIHdpbGwgc2VydmUgaXQgZm9yIHNvbWUgUE0NCmZlYXR1
cmVzIChzdWNoIGFzIHdha2UgdXAgc291cmNlIGNvbnRyb2wpLCBhbmQgcHJvdmlkZSBzb21lIGtp
bmQgb2YgZmxleGliaWxpdHkgd2hlbg0KZWl0aGVyIFJDTVAgb3IgdXNlciBkcml2ZXIgZXZvbHZl
IGluIHRoZSBmdXR1cmUuIFNvIEkgYWRkIGEgcGxhdF9wbSBkcml2ZXIgdG8gcHJldmVudA0Kd2Fr
ZSB1cCBJUCBrbm93aW5nIGFueSBpbmZvcm1hdGlvbiBvZiBSQ1BNLg0KDQpSZWdhcmRzLA0KUmFu
DQoNCj4gDQo+IC1TY290dA0KDQo=
