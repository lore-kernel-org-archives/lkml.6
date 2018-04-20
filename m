Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1262712-1524216141-2-2858263723979270563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='IN'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524216140; b=cfB84YLzSsfPQF3q6rSmWBKk9N6WTUxfsCsyePw0uh4YuX395b
    WNm76tQH/enVjjMrfhkkkbh/b2+I6bOdqSEDdeR7Kp4KxQkuWgH0bqdvZwGymozu
    /tKVMy3HsUcWzDyWAYAhB4ZgjZsK1EcFnYAVvfaDIPWrXChiKjuMgIbICs3DB64C
    hec3W1wwm9q6g8a7/KarQDQu5vefXqqvM4KQKieFK5g4/em0G89kGbNHbe4K3Fk4
    d4mqNwgnppAhveb05xdokiYanOVpEOOpKufhTBlseHMed+NfYFfml6hm1rfPq9NM
    HnZMMkLS1gTqVvNKzHnUtG/AD+0g12sVJBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524216140; bh=NmanRWam1W
    D7Le7EXrNg3ETk2QRna55K7lP2kHwh+nI=; b=o3HZaTT72FG1bixI6KCYzmn1bB
    DtZrHTj+l5/HwkcTCvt5qEe434CS+30W+BCoo+ktCMpQqyWBoY/Fvi/h9OCztn+r
    XrR8TmEzVb5kSYjVwt4G8UknUj9/lF8dxXvcDbxMtQVlXL8Gu9TTUFCl2msH67HS
    aHdmFJo6tan49iJ/x4u24dfLnwm61J5oSiwvXZOlwagQiR/+R6W4SyL+dvi2B7Us
    xDERFtxBbUC5X1qz4/f+haA/dKsAdROXGl7qrlmhyTT/+XaLKANbklM6KSin8GwS
    KbDMhU0+bDA7ZAIpiycxWjqVlBz5fOibOWJ7pCdEJ2nR6PUcyAvuIA0kk8ig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=dsZsh60v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=dsZsh60v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFtBsmeG4m6duf0D6HPmlX/t560JFw0KvPTQrjePW1YUCYfeAIUbCI7Z/vs40nesuarpo4U0/OU8n4Emgy5qMasLLBToIsEJeOeT8PkEVLGo04tOD9mS
    wK4t16hsic9nHqdOPhKwAXKdwHCy5Ny/hlR09J1nO2jDEmTOMzdwAsSa6sesGS0cD3T1YLw3d+mV6oRiDSGFIxT5sqfjpSLXHWKMYkSEpe0WqT0uO+xiyZit
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m-XU2MN_NUEA:10 a=-Vr38N3OkxwA:10
    a=FZ-paitokdoA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=dw2S5ISiLjYA:10 a=VwQbUJbxAAAA:8 a=BkWyz1_tYeLiHRJLhn0A:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeDTJWS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 05:22:18 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:51815
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754170AbeDTJWQ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 20 Apr 2018 05:22:16 -0400
From: Peter Chen <peter.chen@nxp.com>
To: Peter Rosin <peda@axentia.se>,
        Yossi Mansharoff <yossim@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CHIPIDEA USB HIGH SPEED DUAL ROLE CONTROLLER"
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
Thread-Topic: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
Thread-Index: AQHT1lN0/EEznR23NUSUmIox/rpIi6QI53FwgABe24CAABrpoA==
Date: Fri, 20 Apr 2018 09:22:13 +0000
Message-ID: <VI1PR04MB1455162DE3FF630262693E558BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
References: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
 <HE1PR04MB14504981D8B409CD8F9E7B7D8BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <1fd0df0a-3930-94c8-2973-2c90e0b07530@axentia.se>
In-Reply-To: <1fd0df0a-3930-94c8-2973-2c90e0b07530@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: axentia.se; dkim=none (message not signed)
 header.d=none;axentia.se; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB0941;7:+LuEKW+qEZqH2N2zLO0yuEAYk0FlkFAqRVej4qziMJAVaPhqW0lPBAsCyQlUZnNW4eEepExs5ICS1/JMODZkDZS5YYZ6i9e/I6Uu9x/9CRqJ4K83lEP1aVsT5Obz0sPbLxUISySK5XZDv1nlROTUPKl3P+Ht1SbrsKE9FWBknPBOFFsn+FKYm/uNxjf7Y64WOzpYvsRTQpksIhU4x/toRVHKkO/Jbq4IbZZwbtE4BGgZFLd1mu2Gcthn2tiuEMmS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB0941;
x-ms-traffictypediagnostic: VI1PR04MB0941:
x-microsoft-antispam-prvs: <VI1PR04MB0941ED0C0940D355C7593DFA8BB40@VI1PR04MB0941.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB0941;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0941;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(52314003)(186003)(316002)(6246003)(54906003)(4326008)(11346002)(476003)(110136005)(229853002)(86362001)(53936002)(81166006)(7696005)(446003)(25786009)(305945005)(44832011)(8936002)(6506007)(478600001)(7736002)(102836004)(26005)(59450400001)(33656002)(2906002)(8676002)(3846002)(55016002)(6306002)(5250100002)(66066001)(6116002)(3280700002)(74316002)(5660300001)(76176011)(6436002)(2900100001)(9686003)(966005)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB0941;H:VI1PR04MB1455.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: MtpXgAb+K5hFwUInaxsWhiKezRpn8nDnqN6YZ750a8fVbVO78VnVwhZtSHLx1UFr1RTSY9rgOY64dOxHc5sFMnNi9woVkSJqPYINwZ54eIanUP8k3qiqOD/+KIknGv9p6lsAYzmo5qN5ay6yaO8PQcyMQBf+XkeiIUGGhB3tRuhh7/tvHc3DJzOVvysAh3zC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 540d2b08-ecac-404a-d189-08d5a6a033a2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540d2b08-ecac-404a-d189-08d5a6a033a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 09:22:13.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0941
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

IA0KPiA+PiBAQCAtMyw2ICszLDggQEAgY29uZmlnIFVTQl9DSElQSURFQQ0KPiA+PiAgCWRlcGVu
ZHMgb24gKChVU0JfRUhDSV9IQ0QgJiYgVVNCX0dBREdFVCkgfHwgKFVTQl9FSENJX0hDRCAmJg0K
PiA+PiAhVVNCX0dBREdFVCkgfHwgKCFVU0JfRUhDSV9IQ0QgJiYgVVNCX0dBREdFVCkpICYmIEhB
U19ETUENCj4gPj4gIAlzZWxlY3QgRVhUQ09ODQo+ID4+ICAJc2VsZWN0IFJFU0VUX0NPTlRST0xM
RVINCj4gPj4gKwlzZWxlY3QgTVVMVElQTEVYRVINCj4gPj4gKwlzZWxlY3QgTVVYX0dQSU8NCj4g
Pg0KPiA+IFRoZSBhYm92ZSB0d28gY29uZmlndXJhdGlvbnMgYXJlIG9ubHkgdXNlZCBhdCB5b3Vy
IHNwZWNpZmljIHBsYXRmb3JtcywNCj4gPiBwbGVhc2UgYWRkIHRoZW0gYXQgZWl0aGVyIHlvdXIg
cGxhdGZvcm0gZGVmY29uZmlnIG9yIHRoZSByZWxhdGVkIGhhcmR3YXJlIGRyaXZlcidzDQo+IEtj
b25maWcuDQo+IA0KPiAic2VsZWN0IE1VWF9HUElPIiBpcyBpbmRlZWQgcXVlc3Rpb25hYmxlIGFu
ZCBzaG91bGQgYmUgc29tZXdoZXJlIGVsc2UgYmVjYXVzZQ0KPiB0aGlzIGRyaXZlciB3aWxsIHdv
cmsgd2l0aCBhbnkgb3RoZXIgbXV4IGFzIHdlbGwuIEl0J3Mgc2ltcGx5IHNvbWV0aGluZyBlbHNl
IHRoYXQNCj4gcmVxdWlyZXMgaXQuIElmIGl0IHdhcyB0aGUgY2FzZSB0aGF0IE1VWF9HUElPIGlz
IGluZGVlZCByZXF1aXJlZCB0aGVuIHRoZSB3aG9sZSB1c2UNCj4gb2YgdGhlIG11eCBzdWJzeXN0
ZW0gaXMgcXVlc3Rpb25hYmxlIGFuZCB0aGUgdGhpbmcgY29udHJvbGxlZCBtaWdodCBhcyB3ZWxs
IGJlDQo+IGNvbnRyb2xsZWQgZGlyZWN0bHkgd2l0aCB0aGUgR1BJTyBsaW5lLiBUaGUgbXV4IHN1
YnN5c3RlbSBpcyBnb29kIHdoZW4gYSBzaW5nbGUgbXV4DQo+ICJjb250cm9sbGVyIiBpcyBzaGFy
ZWQgYmV0d2VlbiBzZXZlcmFsIHVucmVsYXRlZCBkcml2ZXJzIHV0aWxpemluZyBkaWZmZXJlbnQg
bXV4ZXMNCj4gY29udHJvbGxlZCBieSB0aGF0IHNhbWUgbXV4ICJjb250cm9sbGVyIiAodGhpbmsg
c2V2ZXJhbCBtdXhlcyBjb250cm9sbGVkIGJ5IHRoZSBzYW1lDQo+IEdQSU8gbGluZS9saW5lcyku
IFRoZSBtdXggc3Vic3lzdGVtIGlzIGFsc28gdXNlZnVsIHdoZW4gdGhlIGRyaXZlciBkb2VzIG5v
dCB3YW50IHRvDQo+IGhhbmRsZS9rbm93IGhvdyB0aGUgc3BlY2lmaWMgbXV4IGlzIGNvbnRyb2xs
ZWQuIFRoYXQgc2FpZCwgaXQncyBvZiBjb3Vyc2Ugbm90IHdyb25nIHRvDQo+IHVzZSB0aGUgbXV4
IHN1YnN5c3RlbSBpbiBjYXNlcyBsaWtlIHRoaXMgZWl0aGVyLCBidXQgSSB0aGluayBpdCBtaWdo
dCBiZSBtdWNoIGVhc2llcg0KPiBhbmQgZGlyZWN0IHRvIGp1c3QgdHdpZGRsZSB0aGUgc2luZ2xl
IEdQSU8gbGluZSBkaXJlY3RseSBoZXJlPw0KPiANCj4gT3IgZG8geW91IGV4cGVjdCBzb21lIGZ1
dHVyZSBIVyB2YXJpYW50IHRoYXQgd2lsbCB1c2Ugc29tZSBvdGhlciBtZWFucyB0byBjb250cm9s
DQo+IHRoaXMgbXV4Pw0KPiANCg0KTm8sIHRoaXMgbXV4IGlzIG9ubHkgdXNlZCBhdCBZb3NzaSdz
IGJvYXJkcywgSSBleHBlY3QgdGhlc2UgdHdvIGNvbmZpZ3VyYXRpb25zIGlzIHVuZGVyDQpNVVgn
cyBoYXJkd2FyZSBkcml2ZXIgS2NvbmZpZyBpZiBpdCBpcyBleGlzdGVkLCBvciB1bmRlciBpdHMg
cGxhdGZvcm0gZGVmY29uZmlnLiBTb21lb25lDQpoYXMgYWxyZWFkeSBjb21wbGFpbmVkIHRvbyBt
YW55IHNlbGVjdHMgaW5jcmVhc2UgdGhlIGNvZGUgc2l6ZToNCg0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMDM0OTI5My8NCg0KPiA+PiAgCWhlbHANCj4gPj4gIAkgIFNheSBZ
IGhlcmUgaWYgeW91ciBzeXN0ZW0gaGFzIGEgZHVhbCByb2xlIGhpZ2ggc3BlZWQgVVNCDQo+ID4+
ICAJICBjb250cm9sbGVyIGJhc2VkIG9uIENoaXBJZGVhIHNpbGljb24gSVAuIEl0IHN1cHBvcnRz
Og0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2hpcGlkZWEvY29yZS5jDQo+ID4+IGIv
ZHJpdmVycy91c2IvY2hpcGlkZWEvY29yZS5jIGluZGV4DQo+ID4+IDMzYWU4N2YuLjhmYTA5OTEg
MTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NvcmUuYw0KPiA+PiArKysg
Yi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jb3JlLmMNCj4gPj4gQEAgLTYxLDYgKzYxLDcgQEANCj4g
Pj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRv
ci9jb25zdW1lci5oPiAgI2luY2x1ZGUNCj4gPj4gPGxpbnV4L3VzYi9laGNpX2RlZi5oPg0KPiA+
PiArI2luY2x1ZGUgPGxpbnV4L211eC9jb25zdW1lci5oPg0KPiA+Pg0KPiA+PiAgI2luY2x1ZGUg
ImNpLmgiDQo+ID4+ICAjaW5jbHVkZSAidWRjLmgiDQo+ID4+IEBAIC02ODcsNiArNjg4LDEwIEBA
IHN0YXRpYyBpbnQgY2lfZ2V0X3BsYXRkYXRhKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4gIAlp
ZiAob2ZfZmluZF9wcm9wZXJ0eShkZXYtPm9mX25vZGUsICJub24temVyby10dGN0cmwtdHRoYSIs
IE5VTEwpKQ0KPiA+PiAgCQlwbGF0ZGF0YS0+ZmxhZ3MgfD0gQ0lfSERSQ19TRVRfTk9OX1pFUk9f
VFRIQTsNCj4gPj4NCj4gPj4gKwlwbGF0ZGF0YS0+dXNiX3N3aXRjaCA9IGRldm1fbXV4X2NvbnRy
b2xfZ2V0X29wdGlvbmFsKGRldiwgInVzYl9zd2l0Y2giKTsNCj4gPj4gKwlpZiAoSVNfRVJSKHBs
YXRkYXRhLT51c2Jfc3dpdGNoKSkNCj4gPj4gKwkJcmV0dXJuIFBUUl9FUlIocGxhdGRhdGEtPnVz
Yl9zd2l0Y2gpOw0KPiA+PiArDQo+ID4+ICAJZXh0X2lkID0gRVJSX1BUUigtRU5PREVWKTsNCj4g
Pj4gIAlleHRfdmJ1cyA9IEVSUl9QVFIoLUVOT0RFVik7DQo+ID4+ICAJaWYgKG9mX3Byb3BlcnR5
X3JlYWRfYm9vbChkZXYtPm9mX25vZGUsICJleHRjb24iKSkgeyBkaWZmIC0tZ2l0DQo+ID4+IGEv
ZHJpdmVycy91c2IvY2hpcGlkZWEvaG9zdC5jIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvaG9zdC5j
IGluZGV4DQo+ID4+IGFmNDVhYTMyLi5kOWQyZDAwDQo+ID4+IDEwMDY0NA0KPiA+PiAtLS0gYS9k
cml2ZXJzL3VzYi9jaGlwaWRlYS9ob3N0LmMNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvY2hpcGlk
ZWEvaG9zdC5jDQo+ID4+IEBAIC0xMyw2ICsxMyw3IEBADQo+ID4+ICAjaW5jbHVkZSA8bGludXgv
dXNiL2hjZC5oPg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L3VzYi9jaGlwaWRlYS5oPg0KPiA+PiAg
I2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPiA+PiArI2luY2x1ZGUgPGxp
bnV4L211eC9jb25zdW1lci5oPg0KPiA+Pg0KPiA+PiAgI2luY2x1ZGUgIi4uL2hvc3QvZWhjaS5o
Ig0KPiA+Pg0KPiA+PiBAQCAtMTYxLDYgKzE2MiwxMCBAQCBzdGF0aWMgaW50IGhvc3Rfc3RhcnQo
c3RydWN0IGNpX2hkcmMgKmNpKQ0KPiA+PiAgCQlpZiAoY2lfb3RnX2lzX2ZzbV9tb2RlKGNpKSkg
ew0KPiA+PiAgCQkJb3RnLT5ob3N0ID0gJmhjZC0+c2VsZjsNCj4gPj4gIAkJCWhjZC0+c2VsZi5v
dGdfcG9ydCA9IDE7DQo+ID4+ICsJCX0gZWxzZSB7DQo+ID4+ICsJCQlyZXQgPSBtdXhfY29udHJv
bF9zZWxlY3QoY2ktPnBsYXRkYXRhLT51c2Jfc3dpdGNoLCAxKTsNCj4gPj4gKwkJCWlmIChyZXQp
DQo+ID4+ICsJCQkJZ290byBkaXNhYmxlX3JlZzsNCj4gPg0KPiA+IFdoYXQgd2lsbCBoYXBwZW4g
aWYgY2ktPnBsYXRkYXRhLT51c2Jfc3dpdGNoICBpcyBOVUxMPw0KPiANCj4gV2hhdCBoYXMgbm90
IGJlZW4gbWVudGlvbmVkIGluIHRoaXMgcGF0Y2ggaXMgdGhhdCBpdCBkZXBlbmRzIG9uIGFub3Ro
ZXIgcGF0Y2ggd2hpY2gNCj4gaXMgbm90IHlldCB1cHN0cmVhbS4gWW91IGNhbiBnb29nbGUgZm9y
DQo+IA0KPiBtdXg6IGFkZCBtdXhfY29udHJvbF9nZXRfb3B0aW9uYWwoKSBBUEkNCj4gDQo+IHRv
IGdldCBhbiBpZGVhIChpdCdzIGFsc28gaW4gbGludXgtbmV4dCkuIEFueXdheSwgd2l0aCB0aGF0
IHBhdGNoIHRoaXMgaXMgbm90IGEgcHJvYmxlbS4NCj4gDQoNClRoYW5rcywgSSBzZWUgaXQganVk
Z2VzIE5VTEwgcG9pbnRlciwgdGhlbiBpdCBpcyBPSy4NCg0KIA0KPiA+PiAgLyoqDQo+ID4+ICAg
KiBzdHJ1Y3QgY2lfaGRyY19jYWJsZSAtIHN0cnVjdHVyZSBmb3IgZXh0ZXJuYWwgY29ubmVjdG9y
IGNhYmxlDQo+ID4+IHN0YXRlIHRyYWNraW5nIEBAIC0NCj4gPj4gNzYsNiArNzcsNyBAQCBzdHJ1
Y3QgY2lfaGRyY19wbGF0Zm9ybV9kYXRhIHsNCj4gPj4gIAkvKiBWQlVTIGFuZCBJRCBzaWduYWwg
c3RhdGUgdHJhY2tpbmcsIHVzaW5nIGV4dGNvbiBmcmFtZXdvcmsgKi8NCj4gPj4gIAlzdHJ1Y3Qg
Y2lfaGRyY19jYWJsZQkJdmJ1c19leHRjb247DQo+ID4+ICAJc3RydWN0IGNpX2hkcmNfY2FibGUJ
CWlkX2V4dGNvbjsNCj4gPj4gKwlzdHJ1Y3QgbXV4X2NvbnRyb2wJCSp1c2Jfc3dpdGNoOw0KPiA+
PiAgCXUzMgkJCXBoeV9jbGtnYXRlX2RlbGF5X3VzOw0KPiA+DQo+ID4gSWYgQ09ORklHX1VTQl9D
SElQSURFQV9IT1NUIGlzIG5vdCBkZWZpbmVkLCBpdCBtYXkgY2F1c2UgYnVpbGQgZXJyb3INCj4g
DQo+IEhvdyBpcyB0aGF0IHJlbGF0ZWQ/IFRoZXJlIGlzIGEgZm9yd2FyZCBkZWNsYXJhdGlvbiBh
Ym92ZT8NCj4gDQoNClNvcnJ5LCBJIGRpZCBub3Qgbm90aWNlIGRyaXZlcnMvdXNiL2NoaXBpZGVh
L2NvcmUuYyBhbHNvIGluY2x1ZGVzIDxsaW51eC9tdXgvY29uc3VtZXIuaD4uDQoNClBldGVyDQo=
