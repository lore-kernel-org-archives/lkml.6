Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98BC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98BC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGRIVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:21:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2049 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbeGRIVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:21:35 -0400
X-Greylist: delayed 953 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2018 04:21:35 EDT
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 76C859B0BBCB1;
        Wed, 18 Jul 2018 08:29:12 +0100 (IST)
Received: from FRAEMA706-CHM.china.huawei.com (10.206.14.55) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Wed, 18 Jul 2018 08:29:14 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.135]) by
 FRAEMA706-CHM.china.huawei.com ([169.254.6.142]) with mapi id 14.03.0399.000;
 Wed, 18 Jul 2018 09:29:05 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        linyunsheng <linyunsheng@huawei.com>
Subject: RE: [PATCH net-next 7/9] net: hns3: Fix for reset_level default
 assignment probelm
Thread-Topic: [PATCH net-next 7/9] net: hns3: Fix for reset_level default
 assignment probelm
Thread-Index: AQHUHRrqePGkT7CxBUK6L+G4spATt6STB7YAgAGPxoA=
Date:   Wed, 18 Jul 2018 07:29:05 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BE1BE05@FRAEML521-MBX.china.huawei.com>
References: <20180716153627.476-1-salil.mehta@huawei.com>
 <20180716153627.476-8-salil.mehta@huawei.com>
 <5b83ce92-a9bd-df76-4566-f5b2e1cce86e@cogentembedded.com>
In-Reply-To: <5b83ce92-a9bd-df76-4566-f5b2e1cce86e@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG5ldGRl
di1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpuZXRkZXYtDQo+IG93bmVyQHZnZXIua2Vy
bmVsLm9yZ10gT24gQmVoYWxmIE9mIFNlcmdlaSBTaHR5bHlvdg0KPiBTZW50OiBUdWVzZGF5LCBK
dWx5IDE3LCAyMDE4IDEwOjM3IEFNDQo+IFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVh
d2VpLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQNCj4gQ2M6IFpodWFuZ3l1emVuZyAoWWlzZW4p
IDx5aXNlbi56aHVhbmdAaHVhd2VpLmNvbT47IGxpcGVuZyAoWSkNCj4gPGxpcGVuZzMyMUBodWF3
ZWkuY29tPjsgbWVodGEuc2FsaWxAb3Buc3JjLm5ldDsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+Ow0KPiBsaW55dW5zaGVuZyA8bGlueXVuc2hlbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBuZXQtbmV4dCA3LzldIG5ldDogaG5zMzogRml4IGZvciByZXNldF9sZXZl
bA0KPiBkZWZhdWx0IGFzc2lnbm1lbnQgcHJvYmVsbQ0KPiANCj4gSGVsbG8hDQo+IA0KPiBPbiA3
LzE2LzIwMTggNjozNiBQTSwgU2FsaWwgTWVodGEgd3JvdGU6DQo+IA0KPiA+IEZyb206IFl1bnNo
ZW5nIExpbiA8bGlueXVuc2hlbmdAaHVhd2VpLmNvbT4NCj4gPg0KPiA+IGhhbmRsZS0+cmVzZXRf
bGV2ZWwgaXMgYXNzaWduZWQgdG8gSE5BRTNfTk9ORV9SRVNFVCB3aGVuIGNsaWVudCBpcw0KPiA+
IGluaXRpYWxpemVkLCBpZiBhIHR4IHRpbWVvdXQgaGFwcGVucyByaWdodCBhZnRlciBpbml0aWFs
aXphdGlvbiwNCj4gPiB0aGVuIGhhbmRsZS0+cmVzZXRfbGV2ZWwgaXMgbm90IHJlc2V0dGVkIHRv
IEhOQUUzX0ZVTkNfUkVTRVQgaW4NCj4gDQo+ICAgICBzL3Jlc2V0dGVkL3Jlc2V0Ly4NCg0KVGhh
bmtzIGZvciBsb29raW5nIHRocm91Z2guIFdpbGwgdGFrZSBjYXJlIGluIGZ1dHVyZSBzdWJtaXNz
aW9ucy4NCg0KQmVzdCByZWdhcmRzDQpTYWxpbA0KPiANCj4gPiBoY2xnZV9yZXNldF9ldmVudCwg
d2hpY2ggd2lsbCBjYXVzZSByZXNldCBldmVudCBub3QgcHJvcGVybHkNCj4gPiBoYW5kbGVkIHBy
b2JsZW0uDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIGl0IGJ5IHNldHRpbmcgaGFuZGxlLT5y
ZXNldF9sZXZlbCBwcm9wZXJseSB3aGVuDQo+ID4gY2xpZW50IGlzIGluaXRpYWxpemVkLg0KPiA+
DQo+ID4gRml4ZXM6IDZkNGMzOTgxYThkOCAoIm5ldDogaG5zMzogQ2hhbmdlcyB0byBtYWtlIGVu
ZXQgd2F0Y2hkb2cNCj4gdGltZW91dCBmdW5jIGNvbW1vbiBmb3IgUEYvVkYiKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFl1bnNoZW5nIExpbiA8bGlueXVuc2hlbmdAaHVhd2VpLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIExpIDxsaXBlbmczMjFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gWy4uLl0NCj4gDQo+
IE1CUiwgU2VyZ2VpDQo=
