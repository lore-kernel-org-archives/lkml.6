Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC3EECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E19420856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5D57MH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E19420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeGUPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:37:21 -0400
Received: from mail-he1eur01on0061.outbound.protection.outlook.com ([104.47.0.61]:35332
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbeGUPhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hxriEw3Nsm8QJbdb82VQswFzOgFvCu1gaBaQ9GqFUE=;
 b=j5D57MH+dbpeSQ+5N0MMJ6E4M3GhYuiu+uJWJ09tyCxfxZCi1egUCItlXI4u0/Yx/20pVSgR8izBeJLfZRVfdT3JtW/sv9I7p1FiZ+S95QfmJ/NKB0uIuTQ58wKrMH11Oibd1T2z6cpcCGtYjx9lS8v6h7FcHx7HG48JrX9gYk8=
Received: from AM5PR0401MB2660.eurprd04.prod.outlook.com (10.169.245.151) by
 AM5PR0401MB2628.eurprd04.prod.outlook.com (10.169.245.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Sat, 21 Jul 2018 14:44:15 +0000
Received: from AM5PR0401MB2660.eurprd04.prod.outlook.com
 ([fe80::1409:d2c7:1a1d:c23f]) by AM5PR0401MB2660.eurprd04.prod.outlook.com
 ([fe80::1409:d2c7:1a1d:c23f%5]) with mapi id 15.20.0973.018; Sat, 21 Jul 2018
 14:44:15 +0000
From:   Udit Agarwal <udit.agarwal@nxp.com>
To:     =?utf-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sahil Malhotra <sahil.malhotra@nxp.com>,
        Ruchika Gupta <ruchika.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Subject: RE: [PATCH 1/2] security/keys/secure_key: Adds the secure key support
 based on CAAM.
Thread-Topic: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
Thread-Index: AQHUH+0bPh9PV6wYhESslN19K1K/AKSXytUAgAHvvVA=
Date:   Sat, 21 Jul 2018 14:44:15 +0000
Message-ID: <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
 <1532076042.3511.203.camel@pengutronix.de>
In-Reply-To: <1532076042.3511.203.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=udit.agarwal@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2628;6:2EjdfF9+BfwMz+T4TH34LXN8Cy/WLEumI4zRRHG7TY1P0DT9hBhVfV/Rfz5Zz7mdRDtTv+eVLTeoCpWD+6aXWtMLN6j3BKQcAhPCE+RaQfFMfRdMJe1Y8leAFm+AaQs+A3IGLnfP6yowYE03OtbHXs5m0XwYgMfkF24edYx7USleqCRIXKxghBurCFhwSCGCXPo8a24eSKhUN4d8a/QJvVBGHwxQv/EwYmK8pbszb29m+/aB/RjKJYGfVKgKZ6QcyWo0WaQGRqRli4Kx92XStUNO+ZMv1m+dEGsirNErj4kCHS3V7M9nwPz1/ZWwhfah0zRxMwQAQPRZ2HLghD32kShOTjJM4Z1CMpV02Uuz8nyKfPQSjtZwWnU168RPf6zSgfylE3vnbf5rcq4wUlyWxAnoo887XR/9lunNrArwWmNgiipwG8SK+wUclFxn2vl6mmcZDALPqj6V7yztQ7G6ZA==;5:5p8JyglkLUmWWAVbkKyFWh6pszvygp6OBBP1uFXPajjvvxSPBVkdUZE+gOxRX46pfVe1YwEDZ0okS5R6PHiIWJsmSc3ZJd9AdQ2tgGmiBYQtNzsPnHAS32/waxr1Ilgp5cWPBsBuWKhhEncLdRZVnjKtB0tAoj/S73Nx1SHBwLY=;7:oTlwyma4lD/8Mevrfp92CGHc5FiUrElYYmb1ccPJWyFBs9HnZk5sS86uRCK6DAF/iD+dpeXNmT/2asLJQBWlLcM1YS41KYB5MMNIZvFDqjvybI6g4+tqLJwFZrj5LIG0hVGryQAN+dnQwDOOMxGHF5astal17g1C7thnindVbEhaGa6no/DTemLpfmnxF/NUUWG2+WxGl4UkAN6OUci/sszu8otpL1dslRGhl5MVtXorxdMhqNsYoKvC/rrWRCe5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ca52993c-2d07-4323-c060-08d5ef186ea8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2628;
x-ms-traffictypediagnostic: AM5PR0401MB2628:
x-microsoft-antispam-prvs: <AM5PR0401MB2628BED63465CF8E179F272F9E500@AM5PR0401MB2628.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(9452136761055)(189930954265078)(185117386973197)(45079756050767)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2628;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2628;
x-forefront-prvs: 074040B844
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(13464003)(86362001)(7696005)(33656002)(44832011)(6246003)(68736007)(575784001)(97736004)(486006)(15650500001)(106356001)(7736002)(476003)(478600001)(105586002)(2906002)(5250100002)(45080400002)(5660300001)(81156014)(81166006)(8676002)(66066001)(305945005)(2201001)(256004)(14444005)(25786009)(74316002)(6436002)(316002)(229853002)(6306002)(55016002)(54906003)(102836004)(9686003)(6506007)(966005)(8936002)(110136005)(99286004)(4326008)(14454004)(53546011)(55236004)(53936002)(11346002)(446003)(186003)(76176011)(26005)(2900100001)(2501003)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2628;H:AM5PR0401MB2660.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8fnDjdhIxAPWABUwcqH8ZKjKgSk4gRU1JtEYfj+yXn0mK0doBW5SRQw8826Iwuo35Eck7xZzuEIhqdw7dM9Hm42sPgWvOnN0nSdlkKmCFmyFjpdIPSgm1UHe96pgj+YDzJnj5ilMMnoWRf5q+QD422IMW6/4QKhVyPN0n4nQl2AWZCLpjxJyGyNVdTAEaBw367w5V5IKY9hlBqsbexZpaT1agqKRPAoOBDE0E6CfLPEVZZkbw+WGNhbWNCj3WDpaJoWewDxKcH6qQ7YDh5OrTVeTRnSWBNLgzmceWfVhQP2Zwv1YheHAf52ygsmlo5Fm2yqQKV+X6zpR6GqaxKXyzxyqqYRqHw6EVg092TW++zk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca52993c-2d07-4323-c060-08d5ef186ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2018 14:44:15.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0aGUgZG9jdW1lbnRhdGlvbiBjaGFuZ2VzIGFuZCBm
ZWVkYmFjay4NCg0KQmVsb3cgYXJlIHRoZSBhbnN3ZXJzIHRvIHRoZSBxdWVzdGlvbnM6DQoNCjEu
IEN1cnJlbnRseSB0aGUgc2VjdXJlIGtleSBwYXRjaCBzZXJpZXMgaGFzIGJlZW4gYWRkZWQgIHRv
IHN1cHBvcnQgb25seSBkYXRhIGJsb2JzLg0KSXQgaXMgbm90IHN1cHBvcnRpbmcga2V5IGJsb2Jz
IGFzIG9mIG5vdywgd2UgaGF2ZSB0aG91Z2h0IG9mIGFkZGluZyB0aGF0IHN1cHBvcnQgaW4gZnV0
dXJlLg0KDQoyLiBZZXMgc2VjdXJlIGtleXMgY291bGQgYWxzbyBiZSBpbXBsZW1lbnRlZCB1c2lu
ZyBPUFRFRS4gSSB3aWxsIGNoYW5nZSB0aGUgDQpkb2N1bWVudGF0aW9uIGluIG5leHQgcGF0Y2gg
dmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KVWRpdCBBZ2Fyd2FsDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gTMO8YmJlIFttYWlsdG86amx1QHBlbmd1dHJv
bml4LmRlXQ0KPiBTZW50OiBGcmlkYXksIEp1bHkgMjAsIDIwMTggMjoxMSBQTQ0KPiBUbzogVWRp
dCBBZ2Fyd2FsIDx1ZGl0LmFnYXJ3YWxAbnhwLmNvbT47IGRob3dlbGxzQHJlZGhhdC5jb207DQo+
IHpvaGFyQGxpbnV4LnZuZXQuaWJtLmNvbTsgam1vcnJpc0BuYW1laS5vcmc7IHNlcmdlQGhhbGx5
bi5jb207IGxpbnV4LQ0KPiBpbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBrZXlyaW5nc0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LXNlY3VyaXR5LQ0KPiBtb2R1bGVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBTYWhpbCBNYWxob3RyYSA8c2FoaWwu
bWFsaG90cmFAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHNlY3VyaXR5L2tl
eXMvc2VjdXJlX2tleTogQWRkcyB0aGUgc2VjdXJlIGtleSBzdXBwb3J0IGJhc2VkIG9uDQo+IENB
QU0uDQo+IA0KPiBPbiBGcmksIDIwMTgtMDctMjAgYXQgMTE6MTYgKzA1MzAsIFVkaXQgQWdhcndh
bCB3cm90ZToNCj4gPiArPT09PT09PT09PQ0KPiA+ICtTZWN1cmUgS2V5DQo+ID4gKz09PT09PT09
PT0NCj4gPiArDQo+ID4gK1NlY3VyZSBrZXkgaXMgdGhlIG5ldyB0eXBlIGFkZGVkIHRvIGtlcm5l
bCBrZXkgcmluZyBzZXJ2aWNlLg0KPiA+ICtTZWN1cmUga2V5IGlzIGEgc3ltbWV0cmljIHR5cGUg
a2V5IG9mIG1pbmltdW0gbGVuZ3RoIDMyIGJ5dGVzIGFuZA0KPiA+ICt3aXRoIG1heGltdW0gcG9z
c2libGUgbGVuZ3RoIHRvIGJlIDEyOCBieXRlcy4gSXQgaXMgcHJvZHVjZWQgaW4NCj4gPiAra2Vy
bmVsIHVzaW5nIHRoZSBDQUFNIGNyeXB0byBlbmdpbmUuIFVzZXJzcGFjZSBjYW4gb25seSBzZWUg
dGhlIGJsb2INCj4gPiArZm9yIHRoZSBjb3JyZXNwb25kaW5nIGtleS4gQWxsIHRoZSBibG9icyBh
cmUgZGlzcGxheWVkIG9yIGxvYWRlZCBpbg0KPiA+ICtoZXggYXNjaWkuDQo+ID4gKw0KPiA+ICtT
ZWN1cmUga2V5IGNhbiBvbmx5IGJlIGNyZWF0ZWQgb24gcGxhdGZvcm1zIHdoaWNoIHN1cHBvcnRz
IENBQU0NCj4gPiAraGFyZHdhcmUgYmxvY2suIFNlY3VyZSBrZXkgY2FuIGFsc28gYmUgdXNlZCBh
cyBhIG1hc3RlciBrZXkgdG8gY3JlYXRlDQo+ID4gK3RoZSBlbmNyeXB0ZWQga2V5cyBhbG9uZyB3
aXRoIHRoZSBleGlzdGluZyBrZXkgdHlwZXMgaW4ga2VybmVsLg0KPiA+ICsNCj4gPiArU2VjdXJl
IGtleSB1c2VzIENBQU0gaGFyZHdhcmUgdG8gZ2VuZXJhdGUgdGhlIGtleSBhbmQgYmxvYmlmeSBp
dHMNCj4gPiArY29udGVudCBmb3IgdXNlcnNwYWNlLiBHZW5lcmF0ZWQgYmxvYnMgYXJlIHRpZWQg
dXAgd2l0aCB0aGUgaGFyZHdhcmUNCj4gPiArc2VjcmV0IGtleSBzdG9yZWQgaW4gQ0FBTSwgaGVu
Y2UgdGhlIHNhbWUgYmxvYiB3aWxsIG5vdCBiZSBhYmxlIHRvDQo+ID4gK2RlLWJsb2JpZnkgd2l0
aCB0aGUgZGlmZmVyZW50IHNlY3JldCBrZXkgb24gYW5vdGhlciBtYWNoaW5lLg0KPiANCj4gVGhh
bmtzIGZvciB3b3JraW5nIG9uIHRoaXMsIHNvIGZhciB3ZSd2ZSBiZWVuIHVzaW5nIHRoaXMgZnVu
Y3Rpb25hbGl0eSB2aWEgYSBjdXN0b20gc3lzZnMNCj4gaW50ZXJmYWNlLiBQcm9wZXIgaW50ZWdy
YXRpb24gaW50byB0aGUga2V5cmluZyBmcmFtZXdvcmsgd291bGQgYmUgdmVyeSBuaWNlIQ0KPiAN
Cj4gU29tZSBxdWVzdGlvbnMgd2hpY2ggbWlnaHQgaW5mbHVlbmNlIHRoZSB1c2Vyc3BhY2UgYXBp
IGRlc2lnbjoNCj4gDQo+IC0gSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIENBQU0ga2V5IGJsb2Jz
IGNvbnRhaW4gZmxhZ3Mgd2hpY2ggc3BlY2lmeSBpZiB0aGUga2V5IGNhbiBiZQ0KPiBleHBvcnRl
ZCBmcm9tIHRoZSBDQUFNIGFmdGVyIHVud3JhcHBpbmcgb3Igbm90ICh0aGVuIGl0IHN0YXlzIGlu
IG9uZSBvZiB0aGUgaW50ZXJuYWwga2V5DQo+IHJlZ2lzdGVycykuIFdoaWNoIG1vZGUgZG8geW91
IHVzZT8NCj4gDQo+IC0gSWYgdGhhdCdzIG5vdCBhbHJlYWR5IHN1cHBvcnRlZCBieSB0aGlzIHNl
cmllcywgZG8geW91IGludGVuZCB0byBtYWtlIHNlY3VyZSBrZXlzIChpbiB0aGUNCj4gbm9uLWV4
cG9ydGFibGUtbW9kZSkgdXNhYmxlIGZvciBlbmNyeXB0aW9uLyBkZWNyeXB0aW9uLCBzbyB0aGV5
IGNvdWxkIGJlIHVzZWQgZm9yIGRtLQ0KPiBjcnlwdD8gSWYgc28sIHlvdSdkIHByb2JhYmx5IG5l
ZWQgc29tZSByZXNvdXJjZSBtYW5hZ2VtZW50IGluIHRoZSBDQUFNIGRyaXZlciwgYXMgdGhlDQo+
IG51bWJlciBvZiBrZXkgcmVnaXN0ZXJzIGlzIGxpbWl0ZWQuDQo+IA0KPiAtIFNlY3VyZSBrZXlz
IGNvdWxkIGFsc28gYmUgaW1wbGVtZW50ZWQgdXNpbmcgT1AtVEVFIGZvciBleGFtcGxlLCBzbyB0
aGUNCj4gZG9jdW1lbnRhdGlvbiBzaG91bGRuJ3QgYmUgQ0FBTS1zcGVjaWZpYyBhbmQgb25seSB1
c2UgaXQgYXMgYW4gZXhhbXBsZS4NCj4gDQo+IEFyZSB0aGVyZSBjb3JyZXNwb25kaW5nIGNoYW5n
ZXMgdG8gdGhlIENBQU0gZHJpdmVyIG5lZWRlZCB0byB0ZXN0IHRoaXM/DQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEphbg0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBJbmR1c3RyaWFsIExp
bnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfA0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucGVuZ3V0cm9u
aXgNCj4gLmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0N1ZGl0LmFnYXJ3YWwlNDBueHAuY29tJTdD
MDFkMTIwODc0OGRhNGEyYWUzMjMwOA0KPiBkNWVlMWM4MTg5JTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNjY3NjcyODU2NzcxODQNCj4gOTMmYW1wO3NkYXRh
PXJSeFpUbGMlMkJicnZEOVZHTDZmV2x4UyUyQmNMV0l0MFJxRXYxVlQwekNMRXM0JTNEJmFtcDsN
Cj4gcmVzZXJ2ZWQ9MCAgfA0KPiBQZWluZXIgU3RyLiA2LTgsIDMxMTM3IEhpbGRlc2hlaW0sIEdl
cm1hbnkgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxk
ZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUg
fA0K
