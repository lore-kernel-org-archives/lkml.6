Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 417EBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE606204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YKu1z4J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE606204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935468AbeFMMtw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:49:52 -0400
Received: from mail-he1eur01on0052.outbound.protection.outlook.com ([104.47.0.52]:56544
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935296AbeFMMtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsQx0zAxNV0SVwi8FpIfcSv6eQnpWrFJKjIC9xYqEVo=;
 b=YKu1z4J5w+qb5eA28QDHv9xB1a5EtouqdTtY0HfLN6w897+tfDR4APteYswhJuNPmg9NITYouic3uIL7o63gFAJD0NB62hQi2zDSIGOrdV+g4BmJy+orBJGDQ7ojlgBp5U9s/VYRUGIvk5d4XWXDAzIe6o9CaHqhvzu4W/MYF08=
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com (10.175.33.150) by
 HE1PR0802MB2348.eurprd08.prod.outlook.com (10.172.129.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 12:49:46 +0000
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686]) by HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686%8]) with mapi id 15.20.0841.021; Wed, 13 Jun 2018
 12:49:46 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     Rob Herring <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "Mark Rutland" <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Thread-Topic: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Thread-Index: AQHT+arYmPkMSE9u6k6dSv01/4gsi6RdKfkAgADZT4CAADNm5Q==
Date:   Wed, 13 Jun 2018 12:49:46 +0000
Message-ID: <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>,<a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
In-Reply-To: <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [2605:6000:101a:40d7:787b:7279:1919:3070]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0802MB2348;7:httV5nVMpKQ9M4eOOpwqL6onqy/eJx9tOQ/XEnATZUJhRuqRfTDq48rlbNSD3iaQRC5o1M3o3pWJFEpU+kHKk6gxK7X+Vc940flfA2dg2TGeTB5I0fzcuhg76Su9PEEVPAd/sHqAfnzOVKMXMCFns6Bks9g2gOvukhmPEBpvLgF+HZJN9pxwfy69c2jdrNnoKRUkUrsKYbkSdf0nEvGZg9gE8RT9Vx+z3bt2TE1HoYl0Nf49HsRwYIhSKQ5ooxyr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e92b698-e8d0-4c75-56bc-08d5d12c24b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0802MB2348;
x-ms-traffictypediagnostic: HE1PR0802MB2348:
x-microsoft-antispam-prvs: <HE1PR0802MB234803E28B6474567CF4BB31EE7E0@HE1PR0802MB2348.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0802MB2348;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2348;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(199004)(189003)(40434004)(36756003)(8936002)(305945005)(14454004)(6486002)(8676002)(5660300001)(53936002)(478600001)(7736002)(6636002)(6116002)(6246003)(2906002)(39060400002)(86362001)(6862004)(97736004)(83716003)(4326008)(229853002)(3660700001)(82746002)(3280700002)(81166006)(81156014)(5250100002)(53546011)(59450400001)(76176011)(11346002)(5890100001)(33656002)(102836004)(99286004)(6436002)(68736007)(46003)(25786009)(486006)(6512007)(72206003)(5003630100001)(446003)(476003)(106356001)(2616005)(105586002)(2900100001)(316002)(54906003)(37006003)(93886005)(6506007)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2348;H:HE1PR0802MB2412.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kwsGtVjHvQuu3VIyi1v90By5RdjqqzVzXv9rTUqe5sqg7SfErUAI/dsEaqYQQtoSzaNE1yIpXgDR/ILwI3dKxMFPpp2I4LW45BcAnxCRuaKoJk9R8DaTl7e/lTLcearvhbOZLvyZLEDOc7uDad4pNs9nGPYawaSHi8C/d3+4rh7CKgK51tQOQee2lqedo/RC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e92b698-e8d0-4c75-56bc-08d5d12c24b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 12:49:46.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3V6dWtpLA0KDQpXaHkgbm90IHVzZSDigJx1bml04oCdPw0KDQpJIGJlbGlldmUgd2UgaGFkIHRo
aXMgZGlzY3Vzc2lvbiB5ZWFycyBhZ28gYWJvdXQgbnVtYmVyaW5nIHNlcmlhbCBwb3J0cyBhbmQg
c2RoY2kgKGkuZS4gaG93IGRvIHlvdSBrbm93IGl04oCZcyBVQVJUMCBvciBVQVJUMSBmcm9tIGp1
c3QgdGhlIGFkZHJlc3M/IFNvbWUgU29D4oCZcyBkb27igJl0IGFkZHJlc3Mgc2VxdWVudGlhbGx5
ICpvciogaW4gYSBmb3J3YXJkIGRpcmVjdGlvbikgLSBJIGJlbGlldmUgaXTigJlzIG5vdCBleGFj
dGx5IGNvZGlmaWVkIGluIGVQQVBSLCBub3QgYW0gSSBzdXJlIHdoZXJlIGl0IG1heSBiZSBvdGhl
cndpc2UsIGJ1dCBpdCBleGlzdHMuDQoNCkkgYWdyZWUgd2l0aCBSb2Igb24gdGhlIHNsYXZlLW1v
ZGUgbm9uc2Vuc2UsIHRoaXMgaXMgYW4gU1BJIGNvbnRyb2xsZXIgY29uY2VwdCB3ZWlyZGx5IHN0
dWZmZWQgaW50byBhIGRpcmVjdGVkIGdyYXBoIHdoaWNoIGltcGxpY2l0bHkgdGVsbHMgeW91IHRo
ZSBkYXRhIGRpcmVjdGlvbiAtIGl04oCZcyBhIHJvb3RlZCB0cmVlIChqdXN0IGxpa2UgRFQhKS4N
Cg0KRm9yIHRoZSBjYXNlIG9mIGEgZnVubmVsIGVhY2ggZGV2aWNlIHN1cHBseWluZyB0cmFjZSBz
aG91bGQgZW5kIHVwIGludG8gYW4gaW5wdXQgbm9kZSAtIG51bWJlcmVkIHdpdGggYSB1bml0IC0g
YW5kIGFsbCB0aG9zZSBub2RlcyBzaG91bGQgcG9pbnQgdG8gdGhlIG91dHB1dCBub2RlIGFzIGVu
ZHBvaW50cy4gRGVzY3JpYmluZyB0aGUgaGFyZHdhcmUgYXMgYSBibGFjayBib3ggaXMgcHJvYmFi
bHkgbGVzcyBvZiBhIGdvb2QgaWRlYSB0aGFuIHNob3dpbmcgdGhhdCBpdOKAmXMgYSBmdW5uZWws
IG9yIHJlcGxpY2F0b3IgYnkgc2hvd2luZyB0aGUgaW50ZXJuYWwgcGF0aHMuIFlvdSB3b3VsZG7i
gJl0IG5lZWQgdG8g4oCcbnVtYmVy4oCdIHBvcnRzIHdpdGggYSB1bml0IGV4Y2VwdCB3aGVyZSB0
aGUgSFcgbmVlZHMgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZW0sIGFuZCB5b3UgZG9u4oCZ
dCBuZWVkIHJlZyBvciBhIG5vZGUgYWRkcmVzcyB0byBkbyBpdC4NCg0KSWYgeW91IHJlYWxseSBu
ZWVkIHRvIHBhcnNlIGZ1bGwgZ3JhcGhzIGluIGJvdGggZGlyZWN0aW9ucyAoZmluZCByb290LCBm
aW5kIGxlYWYpIHRoZW4gY291bGQgd2Ugc2ltcGx5IGludHJvZHVjZSBwcm9wZXJ0aWVzIHdoaWNo
IGxpc3QgdGhlIHBoYW5kbGVzIG9mIGFsbCB1cGxpbmsgc291cmNlcywgYXMgbGlua2VkIGxpc3Rz
IHBvaW50IHRvIHRoZSBsaXN0IGhlYWQ/DQoNClRoaXMgZ2l2ZXMgYSB3YXkgdG8gdmFsaWRhdGUg
dGhhdCB0aGUgZ3JhcGggc3RhcnRzIGFuZCBlbmRzIHRoZSB3YXkgd2UgZXhwZWN0LCBhbmQgYWxz
byBhbGxvd3MgZXZlcnkgcG9ydCB0byBiZSBhc3NvY2lhdGVkIHdpdGggYmVpbmcgYSByZXF1aXJl
ZCBwYXRoIGJldHdlZW4gYW55IHR3byBkZXZpY2VzIHdpdGhvdXQgcGFyc2luZyB0aGUgKndob2xl
KiBncmFwaCAoYWx0aG91Z2ggeW91IHN0aWxsIG5lZWQgdG8gZG8gdGhhdCB0byBmaW5kIHRoZSBy
b3V0ZSB0byBzaW5rcykuDQoNClRhLA0KTWF0dA0KDQpTZW50IGZyb20gbXkgaVBob25lDQoNCj4g
T24gSnVuIDEzLCAyMDE4LCBhdCAwNDo0NSwgU3V6dWtpIEsgUG91bG9zZSA8U3V6dWtpLlBvdWxv
c2VAYXJtLmNvbT4gd3JvdGU6DQo+DQo+IEhpIFJvYiwNCj4NCj4+IE9uIDEyLzA2LzE4IDIxOjQ4
LCBSb2IgSGVycmluZyB3cm90ZToNCj4+PiBPbiBGcmksIEp1biAwMSwgMjAxOCBhdCAwMjoxNjow
NVBNICswMTAwLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOg0KPj4+IFRoZSBjb3Jlc2lnaHQgZHJp
dmVycyByZWxpZWQgb24gZGVmYXVsdCBiaW5kaW5ncyBmb3IgZ3JhcGgNCj4+PiBpbiBEVCwgd2hp
bGUgcmV1c2luZyB0aGUgInJlZyIgZmllbGQgb2YgdGhlICJwb3J0cyIgdG8gaW5kaWNhdGUNCj4+
PiB0aGUgYWN0dWFsIGhhcmR3YXJlIHBvcnQgbnVtYmVyIGZvciB0aGUgY29ubmVjdGlvbnMuIEhv
d2V2ZXIsDQo+Pj4gd2l0aCB0aGUgcnVsZXMgZ2V0dGluZyBzdHJpY3RlciB3LnIudCB0byB0aGUg
YWRkcmVzcyBtaXNtYXRjaA0KPj4+IHdpdGggdGhlIGxhYmVsLCBpdCBpcyBubyBsb25nZXIgcG9z
c2libGUgdG8gdXNlIHRoZSBwb3J0IGFkZHJlc3MNCj4+PiBmaWVsZCBmb3IgdGhlIGhhcmR3YXJl
IHBvcnQgbnVtYmVyLiBIZW5jZSwgd2UgYWRkIGFuIGV4cGxpY2l0DQo+Pj4gcHJvcGVydHkgdG8g
ZGVub3RlIHRoZSBoYXJkd2FyZSBwb3J0IG51bWJlciwgImNvcmVzaWdodCxod2lkIg0KPj4+IHdo
aWNoIG11c3QgYmUgc3BlY2lmaWVkIGZvciBlYWNoICJlbmRwb2ludCIuDQo+Pj4NCj4+PiBDYzog
TWF0aGlldSBQb2lyaWVyIDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4+PiBDYzogU3Vk
ZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4+PiBDYzogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1
a2kucG91bG9zZUBhcm0uY29tPg0KPj4+IC0tLQ0KPj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vY29yZXNpZ2h0LnR4dCAgICAgICAgICB8IDI2ICsrKysrKysrKy0tLQ0KPj4+ICBkcml2
ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvb2ZfY29yZXNpZ2h0LmMgICAgICAgICB8IDQ2ICsrKysr
KysrKysrKysrKystLS0tLS0NCj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCsp
LCAxOCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2NvcmVzaWdodC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2NvcmVzaWdodC50eHQNCj4+PiBpbmRleCBiZDM2ZTQwLi4zODU1
ODFhIDEwMDY0NA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vY29yZXNpZ2h0LnR4dA0KPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vY29yZXNpZ2h0LnR4dA0KPj4+IEBAIC0xMDQsNyArMTA0LDExIEBAIHByb3BlcnRp
ZXMgdG8gdW5pcXVlbHkgaWRlbnRpZnkgdGhlIGNvbm5lY3Rpb24gZGV0YWlscy4NCj4+PiAgICAg
ICJzbGF2ZS1tb2RlIg0KPj4+ICAgICAqIEhhcmR3YXJlIFBvcnQgbnVtYmVyIGF0IHRoZSBjb21w
b25lbnQ6DQo+Pj4gLSAgICAgLSAgVGhlIGhhcmR3YXJlIHBvcnQgbnVtYmVyIGlzIGFzc3VtZWQg
dG8gYmUgdGhlIGFkZHJlc3Mgb2YgdGhlICJwb3J0IiBjb21wb25lbnQuDQo+Pj4gKyAgIC0gKE9i
c29sZXRlKSBUaGUgaGFyZHdhcmUgcG9ydCBudW1iZXIgaXMgYXNzdW1lZCB0byBiZSB0aGUgYWRk
cmVzcyBvZiB0aGUgInBvcnQiIGNvbXBvbmVudC4NCj4+PiArICAgLSBFYWNoICJlbmRwb2ludCIg
bXVzdCBkZWZpbmUgdGhlIGhhcmR3YXJlIHBvcnQgb2YgdGhlIGxvY2FsIGVuZCBvZiB0aGUNCj4+
PiArICAgICBjb25uZWN0aW9uIHVzaW5nIHRoZSBmb2xsb3dpbmcgcHJvcGVydHk6DQo+Pj4gKyAg
ICAiY29yZXNpZ2h0LGh3aWQiIC0gMzJiaXQgaW50ZWdlciwgaGFyZHdhcmUgcG9ydCBudW1iZXIg
YXQgdGhlIGxvY2FsIGVuZC4NCj4+ICJjb3Jlc2lnaHQiIGlzIG5vdCBhIHZlbmRvciBhbmQgcHJv
cGVydGllcyBhcmUgaW4gdGhlIGZvcm0NCj4+IFs8dmVuZG9yPixdPHByb3AtbmFtZT4uDQo+DQo+
IE9LLiBUaGUgaXNzdWUgaGVyZSBpcyB0aGF0IGEgY29yZXNpZ2h0IGNvbXBvbmVudCBjb3VsZCBi
ZSBhbiBBcm0gSVAgb3INCj4gYSBjdXN0b20gcGFydG5lciBJUC4gU28sIHRoZSB2ZW5kb3IgY291
bGQgYmUgZWl0aGVyIGFybSBvciB0aGUgcGFydG5lciBpZC4NCj4gSG93ZXZlciwgdGhpcyBwcm9w
ZXJ0eSBpcyBraW5kIG9mIGEgZ2VuZXJpYyBvbmUgZm9yIHRoZSBDb3Jlc2lnaHQgZmFtaWx5LA0K
PiB3aGljaCBpcyB3aHkgd2Ugb3B0ZWQgZm9yICJjb3Jlc2lnaHQiLiBXaGF0IGlzIHRoZSBndWlk
ZWxpbmUgZm9yIHN1Y2gNCj4gY2FzZXMgPw0KPg0KPiBPciBpbiBvdGhlciB3b3JkcyBJIHNlZSB0
aGUgZm9sbG93aW5nIHBvc3NpYmxlIG9wdGlvbnMgOg0KPg0KPiAxKSBjb3Jlc2lnaHQsaHdpZCAg
ICAtIGNvcmVzaWdodCBnZW5lcmljDQo+IDIpIGFybSxjb3Jlc2lnaHQtaHdpZCAgICAtIGFybSB2
ZW5kb3IsIGhvd2V2ZXIgdGhlIGRldmljZSBjb3VsZCBiZSBmcm9tIGFueSB2ZW5kb3IuDQo+IDMp
IGh3aWQgICAgICAgICAgICAtIEdlbmVyaWMNCj4gNCkgbm9uZSBvZiB0aGUgYWJvdmUsIHNvbWV0
aGluZyBjb21wbGV0ZWx5IGRpZmZlcmVudC4NCj4NCj4gV2hhdCBkbyB5b3UgcmVjb21tZW5kIGZy
b20gdGhlIGFib3ZlID8NCj4NCj4+PiArDQo+Pj4gICAgICBFeGFtcGxlOg0KPj4+IEBAIC0xMjAs
NiArMTI0LDcgQEAgRXhhbXBsZToNCj4+PiAgICAgICAgICAgICAgZXRiX2luX3BvcnQ6IGVuZHBv
aW50QDAgew0KPj4gVGhlcmUgc2hvdWxkbid0IGJlIGEgdW5pdCBhZGRyZXNzIGhlcmUgYmVjYXVz
ZSB0aGVyZSBpcyBubyByZWcgcHJvcGVydHkuDQo+Pj4gICAgICAgICAgICAgICAgICBzbGF2ZS1t
b2RlOw0KPj4+ICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZyZXBsaWNhdG9y
X291dF9wb3J0MD47DQo+Pj4gKyAgICAgICAgICAgICAgICBjb3Jlc2lnaHQsaHdpZCA9IDwwPjsN
Cj4+IEl0IGRvZXNuJ3QgbWFrZSBzZW5zZSBmb3IgdGhlc2UgdG8gYmUgaW4gdGhlIGVuZHBvaW50
LiBJZiB5b3UgaGFkDQo+PiBtdWx0aXBsZSBlbmRwb2ludHMsIHRoZW4geW91IHdvdWxkIGhhdmUg
dG8gZHVwbGljYXRlIGl0LiAicG9ydHMiIGFyZQ0KPj4gYSBzaW5nbGUgZGF0YSBzdHJlYW0uICJl
bmRwb2ludHMiIGFyZSBjb25uZWN0aW9ucyB0byB0aGF0IHN0cmVhbS4gU28gaWYNCj4+IHlvdSBo
YXZlIGEgbXV4ZWQgKGlucHV0KSBvciBmYW5vdXQvMS10by1tYW55IChvdXRwdXQpIGNvbm5lY3Rp
b24sIHRoZW4NCj4+IHlvdSBoYXZlIG11bHRpcGxlIGVuZHBvaW50cy4NCj4NCj4gV2UgZG8gaGF2
ZSBtYW55LXRvLTEgaW5wdXQgKGUuZywgZnVubmVscykgYW5kIDEtdG8tbWFueSBvdXRwdXRzDQo+
IChlLmcgcmVwbGljYXRvcnMpLiBIb3dldmVyLCB3ZSBoYXZlIChzbyBmYXIpIHVzZWQgb25seSBv
bmUgZW5kcG9pbnQgcGVyDQo+IHBvcnQuDQo+DQo+IEFsc28gd2UgY291bGQgcG90ZW50aWFsbHkg
aGF2ZSBtdWx0aXBsZSBkYXRhIHN0cmVhbXMgZmxvd2luZyB0aHJvdWdoDQo+IHRoZSBwb3J0cywg
d2hpY2ggZ2V0cyBmaWx0ZXJlZCB0byBkaWZmZXJlbnQgcG9ydHMgaW4gMS10by1tYW55IGNvbXBv
bmVudHMNCj4gKHJlYWQgcHJvZ3JhbW1hYmxlLXJlcGxpY2F0b3IpLg0KPg0KPiBTbyB0aGUgcG9p
bnQgaXMgd2UgaGF2ZSBhIHNoYXJlZCBwYXRoIHdoaWNoIGNhcnJpZXMgZGlmZmVyZW50IGRhdGEN
Cj4gc3RyZWFtcyB3aXRoIG11eC9kZW11eCBjb21wb25lbnRzLiBJIGFtIG9wZW4gZm9yIHN1Z2dl
c3Rpb25zIGJhc2VkIG9uDQo+IHRoZSBhYm92ZSBmYWN0cy4NCj4NCj4+IFRoZSBzYW1lIGFwcGxp
ZWQgdG8gdGhlIHNsYXZlLW1vZGUgcHJvcGVydHksIGJ1dCB0aGF0IHNoaXAgaGFzIHNhaWxlZC4N
Cj4+IE5vIHJlYXNvbiB0byBjb250aW51ZSB0aGF0IHRob3VnaC4NCj4+PiAgICAgICAgICAgICAg
fTsNCj4+PiAgICAgICAgICB9Ow0KPj4+ICAgICAgfTsNCj4+PiBAQCAtMTM0LDYgKzEzOSw3IEBA
IEV4YW1wbGU6DQo+Pj4gICAgICAgICAgICAgIHRwaXVfaW5fcG9ydDogZW5kcG9pbnRAMCB7DQo+
Pj4gICAgICAgICAgICAgICAgICBzbGF2ZS1tb2RlOw0KPj4+ICAgICAgICAgICAgICAgICAgcmVt
b3RlLWVuZHBvaW50ID0gPCZyZXBsaWNhdG9yX291dF9wb3J0MT47DQo+Pj4gKyAgICAgICAgICAg
ICAgICBjb3Jlc2lnaHQsaHdpZCA9IDwwPjsNCj4+PiAgICAgICAgICAgICAgfTsNCj4+PiAgICAg
ICAgICB9Ow0KPj4+ICAgICAgfTsNCj4+PiBAQCAtMTU0LDYgKzE2MCw3IEBAIEV4YW1wbGU6DQo+
Pj4gICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+Pj4gICAgICAgICAgICAgICAgICByZXBs
aWNhdG9yX291dF9wb3J0MDogZW5kcG9pbnQgew0KPj4+ICAgICAgICAgICAgICAgICAgICAgIHJl
bW90ZS1lbmRwb2ludCA9IDwmZXRiX2luX3BvcnQ+Ow0KPj4+ICsgICAgICAgICAgICAgICAgICAg
IGNvcmVzaWdodCxod2lkID0gPDA+Ow0KPj4+ICAgICAgICAgICAgICAgICAgfTsNCj4+PiAgICAg
ICAgICAgICAgfTsNCj4+PiAgQEAgLTE2MSwxNSArMTY4LDE3IEBAIEV4YW1wbGU6DQo+Pj4gICAg
ICAgICAgICAgICAgICByZWcgPSA8MT47DQo+Pj4gICAgICAgICAgICAgICAgICByZXBsaWNhdG9y
X291dF9wb3J0MTogZW5kcG9pbnQgew0KPj4+ICAgICAgICAgICAgICAgICAgICAgIHJlbW90ZS1l
bmRwb2ludCA9IDwmdHBpdV9pbl9wb3J0PjsNCj4+PiArICAgICAgICAgICAgICAgICAgICBjb3Jl
c2lnaHQsaHdpZCA9IDwxPjsNCj4+PiAgICAgICAgICAgICAgICAgIH07DQo+Pj4gICAgICAgICAg
ICAgIH07DQo+Pj4gICAgICAgICAgICAgICAgLyogcmVwbGljYXRvciBpbnB1dCBwb3J0ICovDQo+
Pj4gICAgICAgICAgICAgIHBvcnRAMiB7DQo+Pj4gLSAgICAgICAgICAgICAgICByZWcgPSA8MD47
DQo+Pj4gKyAgICAgICAgICAgICAgICByZWcgPSA8MT47DQo+PiBUaGlzIHdpbGwgc3RpbGwgZ2V0
IGZsYWdnZWQgYXMgYW4gZXJyb3IuIHJlZyBtdXN0IGJlIDIgaGVyZS4NCj4NCj4gU29ycnksIHRo
YXRzIGEgbWlzdGFrZS4gSSB3aWxsIGZpeCBpdC4NCj4NCj4gQ2hlZXJzDQo+IFN1enVraQ0KSU1Q
T1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
aW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVy
IHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5m
b3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
