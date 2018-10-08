Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3DCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7EC20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tmOx7Otw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7EC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJHU5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:57:22 -0400
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:8464
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeJHU5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWZOE3ICKSbfQzXHg8zlHGNQZ4L/t3Tmo+HC95TiXNk=;
 b=tmOx7OtwIsdDBNkCka0TRa5npMWQ7yZoauDi7mlgnGkU4qQcoUNOWSTrWcmapau/4iggkdRb37A49Irj2zaCvL3ERDVOdJ+xsagT4Y7ZpnmNBC+sicZmWZX1b+xnVrJ6+DXwMAYZskMasKHjET1eVwlD8vPvAJGIZiF5AXEGS1w=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4042.namprd02.prod.outlook.com (20.176.75.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 13:45:29 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::c10a:b671:3442:ef63]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::c10a:b671:3442:ef63%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 13:45:28 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v8 02/10] edac: synopsys: Rename the static functions to a
 shorter name
Thread-Topic: [PATCH v8 02/10] edac: synopsys: Rename the static functions to
 a shorter name
Thread-Index: AQHUW/fyI6cGtrF+L0C5BnZpZI4SaqUPi7AAgAXRZyA=
Date:   Mon, 8 Oct 2018 13:45:28 +0000
Message-ID: <DM6PR02MB52274CC51BE196CF18C97834C1E60@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
 <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
 <20181004203540.GD5149@zn.tnic>
In-Reply-To: <20181004203540.GD5149@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4042;6:LrNNB+tT4fvzg8UKRXz9VniH8Zv2wK9YdvVsynOK7KY4pbOcNn0Os50my50rN5+/ra5zcYNTmn080bj3mQMGjK0ql4NPdg+Sgh8Hvroymq0vq8WCJEoWiTWjikTXvnch6sKmSlRXGQZYPpghdnYXoAjqYH2HFTBSimVtlpJYCd0syyGZhVS9ZWF+FUytelfh8DMXr/L4ni9Rtv9mBp0zcGkqw7x2gTXGaKYL5c8edyIVCDQn39RoXhhyIzwO7zCmkNYMBOQphrxn4gRKJWz3n837Xij5ORXWz08jpDIJVvjvALWqPBpbv1X84wqDpHDNPXexk1Qm73cVjnSgsTnAww/EitbZ0u05e/uYNdokuaJPo3BgYVSTcl3/AQZLn5PHqF/8hB4gtAGdybJfAJRMc7I/mkOEH7+00YzMuUtNbiNsG/biZ1ldAxrmDUDwCfUO6Fj+wufA+acXquAmf0/o5w==;5:CBOWcfuIInpB2NiGeh0yXp/3o49d0um5B7rcl4Q89p6j/odyKwzQ8sJz2BvxySsA/s5zg4NlCaaeQuqfNmM24xE9nIkllI3TXwxk1BFk0DRESHSEFIfjHCEDplgaJNp6IVP3gtBed60n9QQt4on1k9vtZBEVXFyhNm+9duM6Hs8=;7:OUiY/XoiHbqTC+mZeP+6ZlCP+u5FNTa4bsNd2bYcb3gGeHEbOjpM0IDnLMa00c3HQqUPPLaWdEl/i3FTemKxIVvk91hN+jzBogYf0szedCDpC0LvhEzldo92RbE33ByaVtRDc+3zC5n/KCHZn+W0s0UyKzv47PFwjWc+J8Gamoyd18BteZybZexyleqDWrX6QoThYdMYgYu/a682MLuGSx1+61PPy+Fl0lXjt+yWfg2qeedn9iIBww6hJeXZJNv+
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(13464003)(76176011)(81156014)(106356001)(7696005)(54906003)(81166006)(71190400001)(71200400001)(8676002)(74316002)(186003)(6916009)(72206003)(105586002)(478600001)(14454004)(966005)(6506007)(53546011)(33656002)(2906002)(102836004)(5660300001)(66066001)(26005)(305945005)(7416002)(7736002)(53936002)(99286004)(68736007)(6116002)(3846002)(11346002)(446003)(476003)(6246003)(486006)(97736004)(6436002)(229853002)(9686003)(6306002)(55016002)(1720100001)(25786009)(4326008)(316002)(86362001)(5250100002)(256004)(2900100001)(14444005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4042;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 825cff7e-1403-493f-9348-08d62d244f25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4042;
x-ms-traffictypediagnostic: DM6PR02MB4042:
x-microsoft-antispam-prvs: <DM6PR02MB40424099355D8940E3D59F66C1E60@DM6PR02MB4042.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(180628864354917)(42068640409301)(192813158149592)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(4982022)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4042;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4042;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ml0eHVKXg0woLH7+Kumdlju7MLK1/bSDwP0TjgVqwF1bThU7dYY9yzW686PayjXKJ/jUGEKa9xhgU94cNk7OmWfW8RxNVFvcYMysNDGmUYqJley2gz9INDGTgz6nJKcbsr+ssaw+N9MHN4cuPG/cfbJXrvggWkSKiZ+kWrTSF/TE4cybYM5KYv2Ipk6qbrmit3DmNnBCfg/Cdl6vq7obPVPPZYD+PqT2gaVzk/UV/80ZTWVk6qdxDbrIBmSvGmGoFIUSZTFMiqwxlmzLm/iBrpj3+S3OWqmRVtYQhHhHM/S4btVx3gbUgQyL5Vi7VPF2jkGUQObtMWUkKlRIm2CauGZkOl6tvL6799X9N+yj+7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825cff7e-1403-493f-9348-08d62d244f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 13:45:28.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGll
bjguZGVdDQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA1LCAyMDE4IDI6MDYgQU0NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2OCAwMi8xMF0gZWRhYzogc3lub3BzeXM6IFJlbmFtZSB0aGUgc3RhdGlj
IGZ1bmN0aW9ucyB0byBhDQo+IHNob3J0ZXIgbmFtZQ0KPiANCj4gT24gVGh1LCBPY3QgMDQsIDIw
MTggYXQgMDk6MDU6MjBQTSArMDUzMCwgTWFuaXNoIE5hcmFuaSB3cm90ZToNCj4gPiBSZW5hbWUg
dGhlIHN0YXRpYyBmdW5jdGlvbnMgdG8gYSBzaG9ydGVyIG5hbWUuIFNpbmNlIHRoaXMgaXMgU3lu
b3BzeXMNCj4gPiBFREFDIGRyaXZlciwgYmV0dGVyIHRvIHJlbW92ZSB1bm5lY2Vzc2FyeSAnc3lu
cHNfJyBwcmVmaXggaW4gZnVuY3Rpb24NCj4gPiBuYW1lcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8IDU2ICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+IA0KPiBPaywgbGV0J3MgZmxpcCB0aGUgcm9s
ZXMgLSBub3cgeW91IGdldCB0byByZXZpZXcgd2hhdCBJJ3ZlIGNvbW1pdHRlZDoNCg0KT2theS4g
RmV3IG1pbm9yIG5pdHMgYmVsb3cuIDopDQoNCj4gDQo+IC0tLQ0KPiBGcm9tOiBNYW5pc2ggTmFy
YW5pIDxtYW5pc2gubmFyYW5pQHhpbGlueC5jb20+DQo+IERhdGU6IFRodSwgNCBPY3QgMjAxOCAy
MTowNToyMCArMDUzMA0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBFREFDLCBzeW5vcHN5czogU2hv
cnRlbiBzdGF0aWMgZnVuY3Rpb24gbmFtZXMNCj4gDQo+IFNob3J0ZW4gc3RhdGljIGZ1bmN0aW9u
IG5hbWVzLCByZW1vdmUgdGhlIHVubmVjZXNzYXJ5ICdzeW5wc18nIHByZWZpeCBpbg0KPiBmdW5j
dGlvbiBuYW1lcy4NCj4gDQo+ICBbIGJwOiBEcm9wIHRoZSAiZWRhY18iIHByZWZpeCB0b28gYXMg
dGhhdCBwcmVmaXggaXMgcmVzZXJ2ZWQgZm9yDQo+ICAgIEVEQUMgY29yZSBmdW5jdGlvbnMuIF0N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KPiBD
QzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+DQo+IENDOiBNaWNo
YWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPiBDQzogYW1pdC5rdWNoZXJpYUBs
aW5hcm8ub3JnDQo+IENDOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDQzogbGVveWFu
Zy5saUBueHAuY29tDQo+IENDOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gQ0M6IGxpbnV4LWVkYWMgPGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnPg0KPiBDQzogbWFy
ay5ydXRsYW5kQGFybS5jb20NCj4gQ0M6IHJvYmgrZHRAa2VybmVsLm9yZw0KPiBDQzogc3VkZWVw
LmhvbGxhQGFybS5jb20NCj4gTGluazogaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzE1Mzg2Njcz
MjgtOTQ2NS0zLWdpdC1zZW5kLWVtYWlsLQ0KPiBtYW5pc2gubmFyYW5pQHhpbGlueC5jb20NCj4g
LS0tDQo+ICBkcml2ZXJzL2VkYWMvc3lub3BzeXNfZWRhYy5jIHwgNzkgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KSwgNDEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL3N5bm9w
c3lzX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gaW5kZXggMTkzNmM3
M2YxZDE1Li5mYmFmMzM1NDBjZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZWRhYy9zeW5vcHN5
c19lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYw0KPiBAQCAtMTQy
LDcgKzE0Miw3IEBAIHN0cnVjdCBzeW5wc19lZGFjX3ByaXYgew0KPiAgfTsNCj4gDQo+ICAvKioN
Cj4gLSAqIHN5bnBzX2VkYWNfZ2V0ZXJyb3JfaW5mbyAtIEdldCB0aGUgY3VycmVudCBlY2MgZXJy
b3IgaW5mbw0KPiArICogZ2V0X2Vycm9yX2luZm8gLSBHZXQgdGhlIGN1cnJlbnQgZWNjIGVycm9y
IGluZm8NCj4gICAqIEBiYXNlOglQb2ludGVyIHRvIHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIGRk
ciBtZW1vcnkgY29udHJvbGxlcg0KPiAgICogQHA6CQlQb2ludGVyIHRvIHRoZSBzeW5vcHN5cyBl
Y2Mgc3RhdHVzIHN0cnVjdHVyZQ0KPiAgICoNCj4gQEAgLTE1MCw4ICsxNTAsNyBAQCBzdHJ1Y3Qg
c3lucHNfZWRhY19wcml2IHsNCj4gICAqDQo+ICAgKiBSZXR1cm46IG9uZSBpZiB0aGVyZSBpcyBu
byBlcnJvciBvdGhlcndpc2UgcmV0dXJucyB6ZXJvDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgc3lu
cHNfZWRhY19nZXRlcnJvcl9pbmZvKHZvaWQgX19pb21lbSAqYmFzZSwNCj4gLQkJCQkgICAgc3Ry
dWN0IHN5bnBzX2VjY19zdGF0dXMgKnApDQo+ICtzdGF0aWMgaW50IGdldF9lcnJvcl9pbmZvKHZv
aWQgX19pb21lbSAqYmFzZSwgc3RydWN0IHN5bnBzX2VjY19zdGF0dXMgKnApDQo+ICB7DQo+ICAJ
dTMyIHJlZ3ZhbCwgY2xlYXJ2YWwgPSAwOw0KPiANCj4gQEAgLTE5NiwxNCArMTk1LDEzIEBAIHN0
YXRpYyBpbnQgc3lucHNfZWRhY19nZXRlcnJvcl9pbmZvKHZvaWQgX19pb21lbQ0KPiAqYmFzZSwN
Cj4gIH0NCj4gDQo+ICAvKioNCj4gLSAqIHN5bnBzX2VkYWNfaGFuZGxlX2Vycm9yIC0gSGFuZGxl
IGNvbnRyb2xsZXIgZXJyb3IgdHlwZXMgQ0UgYW5kIFVFDQo+ICsgKiBoYW5kbGVfZXJyb3IgLSBI
YW5kbGUgY29udHJvbGxlciBlcnJvciB0eXBlcyBDRSBhbmQgVUUNCj4gICAqIEBtY2k6CVBvaW50
ZXIgdG8gdGhlIGVkYWMgbWVtb3J5IGNvbnRyb2xsZXIgaW5zdGFuY2UNCj4gICAqIEBwOgkJUG9p
bnRlciB0byB0aGUgc3lub3BzeXMgZWNjIHN0YXR1cyBzdHJ1Y3R1cmUNCj4gICAqDQo+IC0gKiBI
YW5kbGVzIHRoZSBjb250cm9sbGVyIEVDQyBjb3JyZWN0YWJsZSBhbmQgdW4gY29ycmVjdGFibGUg
ZXJyb3IuDQo+ICsgKiBIYW5kbGVzIHRoZSBjb250cm9sbGVyIEVDQyBjb3JyZWN0YWJsZSBhbmQg
dW5jb3JyZWN0YWJsZSBlcnJvci4NCg0KTml0OiBUaGlzIGNhbiBiZSBtb3ZlZCB0byBDb21tZW50
cyBDb3JyZWN0aW9uIHBhdGNoDQoNCj4gICAqLw0KPiAtc3RhdGljIHZvaWQgc3lucHNfZWRhY19o
YW5kbGVfZXJyb3Ioc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KPiAtCQkJCSAgICBzdHJ1Y3Qg
c3lucHNfZWNjX3N0YXR1cyAqcCkNCj4gK3N0YXRpYyB2b2lkIGhhbmRsZV9lcnJvcihzdHJ1Y3Qg
bWVtX2N0bF9pbmZvICptY2ksIHN0cnVjdCBzeW5wc19lY2Nfc3RhdHVzDQo+ICpwKQ0KPiAgew0K
PiAgCXN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYgPSBtY2ktPnB2dF9pbmZvOw0KPiAgCXN0
cnVjdCBlY2NfZXJyb3JfaW5mbyAqcGluZjsNCj4gQEAgLTIzMiwzMCArMjMwLDMwIEBAIHN0YXRp
YyB2b2lkIHN5bnBzX2VkYWNfaGFuZGxlX2Vycm9yKHN0cnVjdA0KPiBtZW1fY3RsX2luZm8gKm1j
aSwNCj4gIH0NCj4gDQo+ICAvKioNCj4gLSAqIHN5bnBzX2VkYWNfY2hlY2sgLSBDaGVjayBjb250
cm9sbGVyIGZvciBFQ0MgZXJyb3JzDQo+ICsgKiBjaGVja19lcnJvcnMgLSBDaGVjayBjb250cm9s
bGVyIGZvciBFQ0MgZXJyb3JzDQo+ICAgKiBAbWNpOglQb2ludGVyIHRvIHRoZSBlZGFjIG1lbW9y
eSBjb250cm9sbGVyIGluc3RhbmNlDQo+ICAgKg0KPiAgICogVXNlZCB0byBjaGVjayBhbmQgcG9z
dCBFQ0MgZXJyb3JzLiBDYWxsZWQgYnkgdGhlIHBvbGxpbmcgdGhyZWFkDQo+ICAgKi8NCj4gLXN0
YXRpYyB2b2lkIHN5bnBzX2VkYWNfY2hlY2soc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKQ0KPiAr
c3RhdGljIHZvaWQgY2hlY2tfZXJyb3JzKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCj4gIHsN
Cj4gIAlzdHJ1Y3Qgc3lucHNfZWRhY19wcml2ICpwcml2ID0gbWNpLT5wdnRfaW5mbzsNCj4gIAlp
bnQgc3RhdHVzOw0KPiANCj4gLQlzdGF0dXMgPSBzeW5wc19lZGFjX2dldGVycm9yX2luZm8ocHJp
di0+YmFzZWFkZHIsICZwcml2LT5zdGF0KTsNCj4gKwlzdGF0dXMgPSBnZXRfZXJyb3JfaW5mbyhw
cml2LT5iYXNlYWRkciwgJnByaXYtPnN0YXQpOw0KPiAgCWlmIChzdGF0dXMpDQo+ICAJCXJldHVy
bjsNCj4gDQo+ICAJcHJpdi0+Y2VfY250ICs9IHByaXYtPnN0YXQuY2VfY250Ow0KPiAgCXByaXYt
PnVlX2NudCArPSBwcml2LT5zdGF0LnVlX2NudDsNCj4gLQlzeW5wc19lZGFjX2hhbmRsZV9lcnJv
cihtY2ksICZwcml2LT5zdGF0KTsNCj4gKwloYW5kbGVfZXJyb3IobWNpLCAmcHJpdi0+c3RhdCk7
DQo+IA0KPiAgCWVkYWNfZGJnKDMsICJUb3RhbCBlcnJvciBjb3VudCBDRSAlZCBVRSAlZFxuIiwN
Cj4gIAkJIHByaXYtPmNlX2NudCwgcHJpdi0+dWVfY250KTsNCj4gIH0NCj4gDQo+ICAvKioNCj4g
LSAqIHN5bnBzX2VkYWNfZ2V0X2R0eXBlIC0gUmV0dXJuIHRoZSBjb250cm9sbGVyIG1lbW9yeSB3
aWR0aA0KPiArICogZ2V0X2R0eXBlIC0gUmV0dXJuIHRoZSBjb250cm9sbGVyIG1lbW9yeSB3aWR0
aA0KPiAgICogQGJhc2U6CVBvaW50ZXIgdG8gdGhlIGRkciBtZW1vcnkgY29udHJvbGxlciBiYXNl
IGFkZHJlc3MNCj4gICAqDQo+ICAgKiBHZXQgdGhlIEVEQUMgZGV2aWNlIHR5cGUgd2lkdGggYXBw
cm9wcmlhdGUgZm9yIHRoZSBjdXJyZW50IGNvbnRyb2xsZXINCj4gQEAgLTI2Myw3ICsyNjEsNyBA
QCBzdGF0aWMgdm9pZCBzeW5wc19lZGFjX2NoZWNrKHN0cnVjdCBtZW1fY3RsX2luZm8NCj4gKm1j
aSkNCj4gICAqDQo+ICAgKiBSZXR1cm46IGEgZGV2aWNlIHR5cGUgd2lkdGggZW51bWVyYXRpb24u
DQo+ICAgKi8NCj4gLXN0YXRpYyBlbnVtIGRldl90eXBlIHN5bnBzX2VkYWNfZ2V0X2R0eXBlKGNv
bnN0IHZvaWQgX19pb21lbSAqYmFzZSkNCj4gK3N0YXRpYyBlbnVtIGRldl90eXBlIGdldF9kdHlw
ZShjb25zdCB2b2lkIF9faW9tZW0gKmJhc2UpDQo+ICB7DQo+ICAJZW51bSBkZXZfdHlwZSBkdDsN
Cj4gIAl1MzIgd2lkdGg7DQo+IEBAIC0yODYsMjAgKzI4NCwyMCBAQCBzdGF0aWMgZW51bSBkZXZf
dHlwZSBzeW5wc19lZGFjX2dldF9kdHlwZShjb25zdA0KPiB2b2lkIF9faW9tZW0gKmJhc2UpDQo+
ICB9DQo+IA0KPiAgLyoqDQo+IC0gKiBzeW5wc19lZGFjX2dldF9lY2NzdGF0ZSAtIFJldHVybiB0
aGUgY29udHJvbGxlciBlY2MgZW5hYmxlL2Rpc2FibGUgc3RhdHVzDQo+IC0gKiBAYmFzZToJUG9p
bnRlciB0byB0aGUgZGRyIG1lbW9yeSBjb250cm9sbGVyIGJhc2UgYWRkcmVzcw0KPiArICogZ2V0
X2VjY19zdGF0ZSAtIFJldHVybiB0aGUgY29udHJvbGxlciBFQ0MgZW5hYmxlL2Rpc2FibGUgc3Rh
dHVzDQoNCk5pdDogZWNjIC0tPiBFQ0MgY29ycmVjdGlvbiBjYW4gYmUgbW92ZWQgdG8gQ29tbWVu
dHMgY29ycmVjdGlvbiBwYXRjaC4gTWlub3IuIENhbiBrZWVwIGl0IGhlcmUgdG9vLiANCg0KPiAr
ICogQGJhc2U6CVBvaW50ZXIgdG8gdGhlIEREUiBtZW1vcnkgY29udHJvbGxlciBiYXNlIGFkZHJl
c3MNCg0KTml0OiBUaGlzIHNob3VsZCBiZSBtb3ZlZCB0byBDb21tZW50cyBjb3JyZWN0aW9uIHBh
dGNoLg0KDQo+ICAgKg0KPiAtICogR2V0IHRoZSBFQ0MgZW5hYmxlL2Rpc2FibGUgc3RhdHVzIGZv
ciB0aGUgY29udHJvbGxlcg0KPiArICogR2V0IHRoZSBFQ0MgZW5hYmxlL2Rpc2FibGUgc3RhdHVz
IGZvciB0aGUgY29udHJvbGxlci4NCg0KTml0OiBUaGlzIHNob3VsZCBiZSBtb3ZlZCB0byBDb21t
ZW50cyBjb3JyZWN0aW9uIHBhdGNoLg0KDQo+ICAgKg0KPiAtICogUmV0dXJuOiBhIGVjYyBzdGF0
dXMgYm9vbGVhbiBpLmUgdHJ1ZS9mYWxzZSAtIGVuYWJsZWQvZGlzYWJsZWQuDQo+ICsgKiBSZXR1
cm46IGEgRUNDIHN0YXR1cyBib29sZWFuIGkuZSB0cnVlL2ZhbHNlIC0gZW5hYmxlZC9kaXNhYmxl
ZC4NCg0KTml0OiBDYW4gbW92ZSB0byBDb21tZW50cyBjb3JyZWN0aW9uIHBhdGNoLg0KDQo+ICAg
Ki8NCg0KDQpUaGFua3MsDQpNYW5pc2gNCg==
