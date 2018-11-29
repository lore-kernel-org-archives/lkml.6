Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207762148E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207762148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeK2W6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:58:44 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:54494 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2W6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:58:43 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7FADD67A6F3;
        Thu, 29 Nov 2018 12:53:33 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 29 Nov
 2018 12:53:33 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 29 Nov 2018 12:53:33 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Prabhakar Kushwaha" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v6 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUhjte86vILtO4B0icsbZQtceaAqVky10AgAHHZICAAARRAA==
Date:   Thu, 29 Nov 2018 11:53:32 +0000
Message-ID: <f4c584e5-8930-bec3-0c4e-2216a89606b0@kontron.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-4-git-send-email-frieder.schrempf@kontron.de>
 <3981845c-327a-bb14-2908-47dd443971bf@kontron.de>
 <VI1PR04MB572644A2AE3214356A62478799D20@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB572644A2AE3214356A62478799D20@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5BAC62A2CABF449B9747A4369E1DC82@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7FADD67A6F3.A2E8E
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, fabio.estevam@nxp.com, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWW9nZXNoLA0KDQpPbiAyOS4xMS4xOCAxMjozOCwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90
ZToNCj4gSGkgRnJpZWRlciwNCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4g
RnJvbTogU2NocmVtcGYgRnJpZWRlciBbbWFpbHRvOmZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5k
ZV0NCj4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjgsIDIwMTggMTo1OCBQTQ0KPj4gVG86
IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5j
b207IGxpbnV4LQ0KPj4gc3BpQHZnZXIua2VybmVsLm9yZzsgTWFyZWsgVmFzdXQgPG1hcmVrLnZh
c3V0QGdtYWlsLmNvbT47IE1hcmsgQnJvd24NCj4+IDxicm9vbmllQGtlcm5lbC5vcmc+OyBIYW4g
WHUgPGhhbi54dUBueHAuY29tPg0KPj4gQ2M6IGR3bXcyQGluZnJhZGVhZC5vcmc7IGNvbXB1dGVy
c2ZvcnBlYWNlQGdtYWlsLmNvbTsgcmljaGFyZEBub2QuYXQ7DQo+PiBtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tOyBEYXZpZCBXb2xmZSA8ZGF2aWQud29sZmVAbnhwLmNvbT47IEZhYmlvDQo+PiBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBQcmFiaGFrYXIgS3VzaHdhaGENCj4+IDxw
cmFiaGFrYXIua3VzaHdhaGFAbnhwLmNvbT47IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4+IDx5b2dl
c2huYXJheWFuLmdhdXJAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAzLzldIHNw
aTogQWRkIGEgZHJpdmVyIGZvciB0aGUgRnJlZXNjYWxlL05YUCBRdWFkU1BJDQo+PiBjb250cm9s
bGVyDQo+Pg0KPj4gT24gMjcuMTEuMTggMTE6MjQsIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+
Pj4gVGhpcyBkcml2ZXIgaXMgZGVyaXZlZCBmcm9tIHRoZSBTUEkgTk9SIGRyaXZlciBhdA0KPj4+
IG10ZC9zcGktbm9yL2ZzbC1xdWFkc3BpLmMuIEl0IHVzZXMgdGhlIG5ldyBTUEkgbWVtb3J5IGlu
dGVyZmFjZSBvZiB0aGUNCj4+PiBTUEkgZnJhbWV3b3JrIHRvIGlzc3VlIGZsYXNoIG1lbW9yeSBv
cGVyYXRpb25zIHRvIHVwIHRvIGZvdXIgY29ubmVjdGVkDQo+Pj4gZmxhc2ggY2hpcHMgKDIgYnVz
ZXMgd2l0aCAyIENTIGVhY2gpLg0KPj4+DQo+Pj4gVGhlIGNvbnRyb2xsZXIgZG9lcyBub3Qgc3Vw
cG9ydCBnZW5lcmljIFNQSSBtZXNzYWdlcy4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggYWxzbyBkaXNh
YmxlcyB0aGUgYnVpbGQgb2YgdGhlICJvbGQiIGRyaXZlciBhbmQgcmV1c2VzIGl0cw0KPj4+IEtj
b25maWcgb3B0aW9uIENPTkZJR19TUElfRlNMX1FVQURTUEkgdG8gcmVwbGFjZSBpdC4NCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29u
dHJvbi5kZT4NCj4+PiAtLS0NCj4+PiAgICBkcml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcgIHwg
ICA5IC0NCj4+PiAgICBkcml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlIHwgICAxIC0NCj4+PiAg
ICBkcml2ZXJzL3NwaS9LY29uZmlnICAgICAgICAgIHwgIDExICsNCj4+PiAgICBkcml2ZXJzL3Nw
aS9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCj4+PiAgICBkcml2ZXJzL3NwaS9zcGktZnNsLXFz
cGkuYyAgIHwgOTY3DQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4+ICAgIDUgZmlsZXMgY2hhbmdlZCwgOTc5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvS2NvbmZpZyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3IvS2NvbmZpZw0KPj4+IGluZGV4IDZjYzljOTIuLmQxY2EzMDcgMTAw
NjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9LY29uZmlnDQo+Pj4gKysrIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9LY29uZmlnDQo+Pj4gQEAgLTU5LDE1ICs1OSw2IEBAIGNvbmZpZyBT
UElfQ0FERU5DRV9RVUFEU1BJDQo+Pj4gICAgCSAgZGV2aWNlIHdpdGggYSBDYWRlbmNlIFFTUEkg
Y29udHJvbGxlciBhbmQgd2FudCB0byBhY2Nlc3MgdGhlDQo+Pj4gICAgCSAgRmxhc2ggYXMgYW4g
TVREIGRldmljZS4NCj4+Pg0KPj4+IC1jb25maWcgU1BJX0ZTTF9RVUFEU1BJDQo+Pj4gLQl0cmlz
dGF0ZSAiRnJlZXNjYWxlIFF1YWQgU1BJIGNvbnRyb2xsZXIiDQo+Pj4gLQlkZXBlbmRzIG9uIEFS
Q0hfTVhDIHx8IFNPQ19MUzEwMjFBIHx8IEFSQ0hfTEFZRVJTQ0FQRSB8fA0KPj4gQ09NUElMRV9U
RVNUDQo+Pj4gLQlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPj4+IC0JaGVscA0KPj4+IC0JICBUaGlz
IGVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIFF1YWQgU1BJIGNvbnRyb2xsZXIgaW4gbWFzdGVyIG1v
ZGUuDQo+Pj4gLQkgIFRoaXMgY29udHJvbGxlciBkb2VzIG5vdCBzdXBwb3J0IGdlbmVyaWMgU1BJ
LiBJdCBvbmx5IHN1cHBvcnRzDQo+Pj4gLQkgIFNQSSBOT1IuDQo+Pj4gLQ0KPj4+ICAgIGNvbmZp
ZyBTUElfSElTSV9TRkMNCj4+PiAgICAJdHJpc3RhdGUgIkhpc2lsaWNvbiBTUEktTk9SIEZsYXNo
IENvbnRyb2xsZXIoU0ZDKSINCj4+PiAgICAJZGVwZW5kcyBvbiBBUkNIX0hJU0kgfHwgQ09NUElM
RV9URVNUIGRpZmYgLS1naXQNCj4+PiBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvTWFrZWZpbGUgYi9k
cml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlIGluZGV4DQo+Pj4gZjRjNjFkMi4uM2YxNjBjMmUz
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvTWFrZWZpbGUNCj4+PiArKysg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlDQo+Pj4gQEAgLTMsNyArMyw2IEBAIG9iai0k
KENPTkZJR19NVERfU1BJX05PUikJKz0gc3BpLW5vci5vDQo+Pj4gICAgb2JqLSQoQ09ORklHX1NQ
SV9BU1BFRURfU01DKQkrPSBhc3BlZWQtc21jLm8NCj4+PiAgICBvYmotJChDT05GSUdfU1BJX0FU
TUVMX1FVQURTUEkpCSs9IGF0bWVsLXF1YWRzcGkubw0KPj4+ICAgIG9iai0kKENPTkZJR19TUElf
Q0FERU5DRV9RVUFEU1BJKQkrPSBjYWRlbmNlLXF1YWRzcGkubw0KPj4+IC1vYmotJChDT05GSUdf
U1BJX0ZTTF9RVUFEU1BJKQkrPSBmc2wtcXVhZHNwaS5vDQo+Pj4gICAgb2JqLSQoQ09ORklHX1NQ
SV9ISVNJX1NGQykJKz0gaGlzaS1zZmMubw0KPj4+ICAgIG9iai0kKENPTkZJR19NVERfTVQ4MXh4
X05PUikgICAgKz0gbXRrLXF1YWRzcGkubw0KPj4+ICAgIG9iai0kKENPTkZJR19TUElfTlhQX1NQ
SUZJKQkrPSBueHAtc3BpZmkubw0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9LY29uZmln
IGIvZHJpdmVycy9zcGkvS2NvbmZpZyBpbmRleA0KPj4+IDdkM2E1YzkuLjhjODQxODYgMTAwNjQ0
DQo+Pj4gLS0tIGEvZHJpdmVycy9zcGkvS2NvbmZpZw0KPj4+ICsrKyBiL2RyaXZlcnMvc3BpL0tj
b25maWcNCj4+PiBAQCAtMjU5LDYgKzI1OSwxNyBAQCBjb25maWcgU1BJX0ZTTF9MUFNQSQ0KPj4+
ICAgIAloZWxwDQo+Pj4gICAgCSAgVGhpcyBlbmFibGVzIEZyZWVzY2FsZSBpLk1YIExQU1BJIGNv
bnRyb2xsZXJzIGluIG1hc3RlciBtb2RlLg0KPj4+DQo+Pj4gK2NvbmZpZyBTUElfRlNMX1FVQURT
UEkNCj4+PiArCXRyaXN0YXRlICJGcmVlc2NhbGUgUVNQSSBjb250cm9sbGVyIg0KPj4+ICsJZGVw
ZW5kcyBvbiBBUkNIX01YQyB8fCBTT0NfTFMxMDIxQSB8fCBBUkNIX0xBWUVSU0NBUEUgfHwNCj4+
IENPTVBJTEVfVEVTVA0KPj4+ICsJZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4+PiArCWhlbHANCj4+
PiArCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBRdWFkIFNQSSBjb250cm9sbGVyIGlu
IG1hc3RlciBtb2RlLg0KPj4+ICsJICBVcCB0byBmb3VyIGZsYXNoIGNoaXBzIGNhbiBiZSBjb25u
ZWN0ZWQgb24gdHdvIGJ1c2VzIHdpdGggdHdvDQo+Pj4gKwkgIGNoaXBzZWxlY3RzIGVhY2guDQo+
Pj4gKwkgIFRoaXMgY29udHJvbGxlciBkb2VzIG5vdCBzdXBwb3J0IGdlbmVyaWMgU1BJIG1lc3Nh
Z2VzLiBJdCBvbmx5DQo+Pj4gKwkgIHN1cHBvcnRzIHRoZSBoaWdoLWxldmVsIFNQSSBtZW1vcnkg
aW50ZXJmYWNlLg0KPj4+ICsNCj4gWy4uLl0NCj4+PiArc3RhdGljIHZvaWQgZnNsX3FzcGlfc2Vs
ZWN0X21lbShzdHJ1Y3QgZnNsX3FzcGkgKnEsIHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+Pj4g
K3sNCj4+PiArCXVuc2lnbmVkIGxvbmcgcmF0ZSA9IHNwaS0+bWF4X3NwZWVkX2h6Ow0KPj4+ICsJ
aW50IHJldCwgaTsNCj4+PiArCXUzMiBtYXBfYWRkcjsNCj4+DQo+PiBGb3Jnb3QgdG8gZHJvcCBz
b21lIHVudXNlZCB2YXJzIGhlcmUuIEkgd2lsbCByZW1vdmUgdGhlbSBpbiB0aGUgbmV4dA0KPj4g
dmVyc2lvbi4NCj4+DQo+IA0KPiBZZXMsIGJlbG93IGFyZSB0aGUgYnVpbGQgd2FybmluZ3MgbWVz
c2FnZXMgY29taW5nIGZvciB0aGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KPiANCj4gCWRyaXZl
cnMvc3BpL3NwaS1mc2wtcXNwaS5jOiBJbiBmdW5jdGlvbiDigJhmc2xfcXNwaV9zZWxlY3RfbWVt
4oCZOg0KPiAJZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmM6NTAwOjY6IHdhcm5pbmc6IHVudXNl
ZCB2YXJpYWJsZSDigJhtYXBfYWRkcuKAmSBbLVd1bnVzZWQtdmFyaWFibGVdDQo+IAkgIHUzMiBt
YXBfYWRkcjsNCj4gCSAgICAgIF4NCj4gCWRyaXZlcnMvc3BpL3NwaS1mc2wtcXNwaS5jOjQ5OTox
MTogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmGnigJkgWy1XdW51c2VkLXZhcmlhYmxlXQ0K
PiAJICBpbnQgcmV0LCBpOw0KPiANCj4+PiArDQo+Pj4gKwlpZiAocS0+c2VsZWN0ZWQgPT0gc3Bp
LT5jaGlwX3NlbGVjdCkNCj4gWy4uLl0NCj4gDQo+IFZlcmlmaWVkIHRoaXMgcGF0Y2ggc2VyaWVz
IG9uIExheWVyU2NhcGUtMi54IGFyY2hpdGVjdHVyZSBib2FyZHMuDQo+IExTMTA4OGFyZGIsIGlz
IGhhdmluZyB0d28gY29ubmVjdGVkIGZsYXNoIHNsYXZlIGRldmljZXMgb24gQ1MwIGFuZCBDUzEu
DQo+IA0KPiBWZXJpZmllZCB3aXRoIHNpbXBsZSBSZWFkL1dyaXRlL0VyYXNlIG9wZXJhdGlvbnMg
YWxvbmcgd2l0aCBKRkZTMiBtb3VudGluZyBhbmQgYm9vdGluZyBmcm9tIGZsYXNoIE1URCBwYXJ0
aXRpb24gZm9yIGJvdGggc2xhdmUgZGV2aWNlcy4NCg0KVGhhbmsgeW91IGZvciB0ZXN0aW5nISBE
b2VzIHRoaXMgbWVhbiBJIGNhbiBhZGQgeW91ciBUZXN0ZWQtYnkgdGFnPw0KSWYgeW91IGhhdmUg
ZG9uZSBhIHJldmlldyBvZiBhbnkgb2YgdGhlIHBhdGNoZXMgaW4gdGhpcyBzZXQsIHBsZWFzZSBh
bHNvIA0KYWRkIGEgUmV2aWV3ZWQtYnkgdGFnLg0KDQpUaGFua3MsDQpGcmllZGVy
