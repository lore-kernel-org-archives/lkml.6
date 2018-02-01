Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-636734-1517524710-2-18315472624583798854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517524710; b=OMJ5qvQn/BmXyB2kX3ldC9cJAP7H08csv0JM3G2f0dS9qXO
    wlt8wveXfCh1o7ajMsXehASgams7qRetwpXA05WXU1yijEF6I9umbSgtsOclir31
    m0j3L/RkelAqTAGvFldUnCiKso6Tn8blsIob3qQKWJPD3pMu6a39zcZaGwB4pOqf
    YoaVSdtoLD5kP2DFvLW/FwcZKrNp4snXqCacteBi40LL18/JCFbvCb0lRHxOYxNp
    RgbOxSx+n+/QszJMoQ1eO/fuOZ7V7FJLp3mfr+hUz8Hm42o0P2N+NHf19rMcXmhb
    rOAVUfEokZQYa/qLoJypwauq3xJDHi8J5LNS8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517524710; bh=4
    PV038t59VdkbjuQUYVupxFxfIT9dxRXhpVg0EqBpNs=; b=CabQ28nAJYXFyTA51
    Nv2ut66nVVXIgAgF38cmmBhSK5aPs++mKnfmfQ9V6I+MIWYrWTbhc6feZV+R2Bfd
    xRgUwvYGQA1V7M4jNSDP/NkFv7CcBvb9JcPmYDI0/HyKw92lU9q/0mjEHViwZtq+
    My33uk4NUcoL7MFuppR/vcG3jg9tBMihirfAlBjfQTkKUW0rqhWKeF5IxsRDxElu
    XWk4Ovb2nGCoZbrzglqYf+yx2DIqU9VQAK93/Z/EvnZCpC1vTtovI+DyHd+7txs+
    UHTycQHuPRsUt6itXWAqqrNtvtp4+6LDN1ST3wpp1KIUMVVAWmRuik95+A8yWBxl
    jncXw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BZ3wOibL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BZ3wOibL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Stephen Hemminger <sthemmin@microsoft.com>
To: "mgamal@redhat.com" <mgamal@redhat.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [RFC PATCH 1/2] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
Thread-Topic: [RFC PATCH 1/2] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
Thread-Index: AQHTmgCq67tXlSauZkWih5dAZ+dZoqON1fiAgADE64CAAKDZgIAA6caAgAAAjyA=
Date: Thu, 1 Feb 2018 22:38:13 +0000
Message-ID: <CY4PR21MB08379EDA84C9FFAEBC1C5B1ECCFA0@CY4PR21MB0837.namprd21.prod.outlook.com>
References: <1516700045-32142-1-git-send-email-mgamal@redhat.com>
 <1516700045-32142-2-git-send-email-mgamal@redhat.com>
 <20180130112926.53f3c166@xeon-e3> <1517397409.3452.7.camel@redhat.com>
 <20180131150137.58abee5b@xeon-e3> <1517474239.30443.2.camel@redhat.com>
 <1517524441.7076.2.camel@redhat.com>
In-Reply-To: <1517524441.7076.2.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=sthemmin@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-02-01T22:38:11.4381252Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [204.195.71.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR21MB0503;
 7:gU6TzYNaqOgoBZ2kK5z2DDvgDBlXmCXKTFc2Bw6x5LlkIQtjvHd5oCCJ58ZubC2rDUObg+N+LoX3h1s0wE0pKV9pzrqt6+sW//mb9u2SzD//5GR27IwhDpddJmLYCKpYhFQdSqBrZQdTfBtih8i9LvFx2si+Pyn5jNNqv7KhmyeYFiNVaU3sgk84uPGoM7QQ+fw+YF1UxyYyJawkc8ahf4LAyNe5iV6fBAwx2OnUTWmlgi33CQ9d8pIwCWQ8DwCJ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(189003)(199004)(377424004)(13464003)(10290500003)(6346003)(59450400001)(8936002)(229853002)(6436002)(6116002)(3846002)(81166006)(6246003)(8676002)(81156014)(25786009)(93886005)(4326008)(575784001)(86362001)(54906003)(110136005)(99286004)(74316002)(86612001)(305945005)(55016002)(3280700002)(9686003)(478600001)(5660300001)(53546011)(102836004)(7736002)(6506007)(97736004)(53936002)(76176011)(10090500001)(8990500004)(114624004)(33656002)(316002)(106356001)(14454004)(2906002)(22452003)(2950100002)(105586002)(7696005)(66066001)(3660700001)(186003)(26005)(5250100002)(2900100001)(2501003)(68736007)(217873001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0503;
 H:CY4PR21MB0837.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9fbb0bc-e570-443a-2732-08d569c47ac0
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);
 SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB05031C4F917A72EB478F1E22CCFA0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:CY4PR21MB0503; BCL:0; PCL:0; RULEID:(3232008); SRVR:CY4PR21MB0503;
x-forefront-prvs: 0570F1F193
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sthemmin@microsoft.com;
x-microsoft-antispam-message-info: 06jhgLkTPcDChy3P0WpW34yul2q5P8GVTHMJxHjhoz1yS4uThFXtvhOReIFmm3fFJcPGd4HVoilQN618rvbMxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fbb0bc-e570-443a-2732-08d569c47ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 22:38:13.4841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "otubo@redhat.com" <otubo@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VGhlcmUgYXJlIG11bHRpcGxlIGlzc3VlcyB3aXRoIHNvbWUgb2YgdGhlIHBhcmFtZXRlciBjaGFu
Z2UgcGF0aHMuDQpTdGlsbCB3b3JraW5nIG9uIGdldHRpbmcgc29tZXRoaW5nIHN0YWJsZS4gQm90
aCB1cHN0cmVhbSwgYW5kIG5ldC1uZXh0IGRvIGhhdmUgY3Jhc2ggaXNzdWVzIHVuZGVyIGNvbmN1
cnJlbnQgY2hhbmdlcy4NCg0KSSBkb24ndCB3YW50IExpbnV4IGRvaW5nIGRpZmZlcmVudCB3b3Jr
YXJvdW5kIHRoYW4gV2luZG93cyBpZiBhdCBhbGwgcG9zc2libGU7IGJlY2F1c2UgaXQgbWVhbnMg
dGhhdCBpdCB3b3VsZCByZXF1aXJlIG11Y2ggd2lkZXIgdGVzdGluZyBhZ2FpbnN0IG1hbnkgZGlm
ZmVyZW50IHZlcnNpb25zLg0KUHM6IFdTMjAwOHIyIHN0aWxsIG5lZWRzIHRvIGJlIHN1cHBvcnRl
ZC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1vaGFtbWVkIEdhbWFsIFtt
YWlsdG86bWdhbWFsQHJlZGhhdC5jb21dIA0KU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEsIDIw
MTggMjozNCBQTQ0KVG86IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZz4NCkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBvdHVib0ByZWRoYXQuY29tOyBTdGVw
aGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcgPGhh
aXlhbmd6QG1pY3Jvc29mdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZl
bEBsaW51eGRyaXZlcnByb2plY3Qub3JnOyB2a3V6bmV0c0ByZWRoYXQuY29tDQpTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCAxLzJdIGh2X25ldHZzYzogU3BsaXQgbmV0dnNjX3Jldm9rZV9idWYoKSBh
bmQgbmV0dnNjX3RlYXJkb3duX2dwYWRsKCkNCg0KT24gVGh1LCAyMDE4LTAyLTAxIGF0IDA5OjM3
ICswMTAwLCBNb2hhbW1lZCBHYW1hbCB3cm90ZToNCj4gT24gV2VkLCAyMDE4LTAxLTMxIGF0IDE1
OjAxIC0wODAwLCBTdGVwaGVuIEhlbW1pbmdlciB3cm90ZToNCj4gPiBPbiBXZWQsIDMxIEphbiAy
MDE4IDEyOjE2OjQ5ICswMTAwDQo+ID4gTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEByZWRoYXQuY29t
PiB3cm90ZToNCj4gPiANCj4gPiA+IE9uIFR1ZSwgMjAxOC0wMS0zMCBhdCAxMToyOSAtMDgwMCwg
U3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjMgSmFuIDIwMTggMTA6
MzQ6MDQgKzAxMDANCj4gPiA+ID4gTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEByZWRoYXQuY29tPiB3
cm90ZToNCj4gPiA+ID4gwqDCoA0KPiA+ID4gPiA+IFNwbGl0IGVhY2ggb2YgdGhlIGZ1bmN0aW9u
cyBpbnRvIHR3byBmb3IgZWFjaCBvZiBzZW5kL3JlY3YNCj4gPiA+ID4gPiBidWZmZXJzDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEBy
ZWRoYXQuY29tPsKgwqANCj4gPiA+ID4gDQo+ID4gPiA+IFNwbGl0dGluZyB0aGVzZSBmdW5jdGlv
bnMgaXMgbm90IG5lY2Vzc2FyecKgwqANCj4gPiA+IA0KPiA+ID4gSG93IHNvPyBXZSBuZWVkIHRv
IHNlbmQgZWFjaCBtZXNzYWdlIGluZGVwZW5kZW50bHksIGFuZCBoZW5jZSB0aGUNCj4gPiA+IHNw
bGl0DQo+ID4gPiAoc2VlIGNvdmVyIGxldHRlcikuIElzIHRoZXJlIGFub3RoZXIgd2F5Pw0KPiA+
IA0KPiA+IFRoaXMgaXMgYWxsIHRoYXQgaXMgbmVlZGVkLg0KPiA+IA0KPiA+IA0KPiA+IFN1Ympl
Y3Q6IFtQQVRDSF0gaHZfbmV0dnNjOiB3b3JrIGFyb3VuZCBmb3IgZ3BhZGwgdGVhcmRvd24gb24g
b2xkZXINCj4gPiB3aW5kb3dzDQo+ID4gwqBzZXJ2ZXINCj4gPiANCj4gPiBPbiBXUzIwMTIgdGhl
IGhvc3QgaWdub3JlcyBtZXNzYWdlcyBhZnRlciB2bWJ1cyBjaGFubmVsIGlzIGNsb3NlZC4NCj4g
PiBXb3JrYXJvdW5kIHRoaXMgYnkgZG9pbmcgd2hhdCBXaW5kb3dzIGRvZXMgYW5kIHNlbmQgdGhl
IHRlYXJkb3duDQo+ID4gYmVmb3JlIGNsb3NlIG9uIG9sZGVyIHZlcnNpb25zIG9mIE5WU1AgcHJv
dG9jb2wuDQo+ID4gDQo+ID4gUmVwb3J0ZWQtYnk6IE1vaGFtbWVkIEdhbWFsIDxtZ2FtYWxAcmVk
aGF0LmNvbT4NCj4gPiBGaXhlczogMGNmNzM3ODA4YWU3ICgiaHZfbmV0dnNjOiBuZXR2c2NfdGVh
cmRvd25fZ3BhZGwoKSBzcGxpdCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL25ldC9o
eXBlcnYvbmV0dnNjLmMgfCA5ICsrKysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9oeXBlcnYvbmV0dnNjLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYw0K
PiA+IGluZGV4IDE3ZTUyOWFmNzlkYy4uMWEzZGYwZWZmNDJmIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2h5cGVydi9u
ZXR2c2MuYw0KPiA+IEBAIC01NzQsMTAgKzU3NCwxNyBAQCB2b2lkIG5ldHZzY19kZXZpY2VfcmVt
b3ZlKHN0cnVjdCBodl9kZXZpY2UNCj4gPiAqZGV2aWNlKQ0KPiA+IMKgCcKgKi8NCj4gPiDCoAlu
ZXRkZXZfZGJnKG5kZXYsICJuZXQgZGV2aWNlIHNhZmUgdG8gcmVtb3ZlXG4iKTsNCj4gPiDCoA0K
PiA+ICsJLyogV29ya2Fyb3VuZCBmb3Igb2xkZXIgdmVyc2lvbnMgb2YgV2luZG93cyByZXF1aXJl
IHRoYXQNCj4gPiArCcKgKiBidWZmZXIgYmUgcmV2b2tlZCBiZWZvcmUgY2hhbm5lbCBpcyBkaXNh
YmxlZA0KPiA+ICsJwqAqLw0KPiA+ICsJaWYgKG5ldF9kZXZpY2UtPm52c3BfdmVyc2lvbiA8IE5W
U1BfUFJPVE9DT0xfVkVSU0lPTl80KQ0KPiA+ICsJCW5ldHZzY190ZWFyZG93bl9ncGFkbChkZXZp
Y2UsIG5ldF9kZXZpY2UpOw0KPiA+ICsNCj4gPiDCoAkvKiBOb3csIHdlIGNhbiBjbG9zZSB0aGUg
Y2hhbm5lbCBzYWZlbHkgKi8NCj4gPiDCoAl2bWJ1c19jbG9zZShkZXZpY2UtPmNoYW5uZWwpOw0K
PiA+IMKgDQo+ID4gLQluZXR2c2NfdGVhcmRvd25fZ3BhZGwoZGV2aWNlLCBuZXRfZGV2aWNlKTsN
Cj4gPiArCWlmIChuZXRfZGV2aWNlLT5udnNwX3ZlcnNpb24gPj0gTlZTUF9QUk9UT0NPTF9WRVJT
SU9OXzQpDQo+ID4gKwkJbmV0dnNjX3RlYXJkb3duX2dwYWRsKGRldmljZSwgbmV0X2RldmljZSk7
DQo+ID4gwqANCj4gPiDCoAkvKiBBbmQgZGlzc2Fzc29jaWF0ZSBOQVBJIGNvbnRleHQgZnJvbSBk
ZXZpY2UgKi8NCj4gPiDCoAlmb3IgKGkgPSAwOyBpIDwgbmV0X2RldmljZS0+bnVtX2NobjsgaSsr
KQ0KPiANCj4gSSd2ZSB0cmllZCBhIHNpbWlsYXIgd29ya2Fyb3VuZCBiZWZvcmUgYnkgY2FsbGlu
Zw0KPiBuZXR2c2NfdGVhcmRvd25fZ3BhZGwoKSBhZnRlciBuZXR2c2NfcmV2b2tlX2J1ZigpLCBi
dXQgYmVmb3JlIHNldHRpbmcNCj4gbmV0X2RldmljZV9jdHgtPm52ZGV2IHRvIE5VTEwgYW5kIGl0
IGNhdXNlZCB0aGUgZ3Vlc3QgdG8gaGFuZyB3aGVuDQo+IHRyeWluZyB0byBjaGFuZ2UgTVRVLsKg
DQo+IA0KPiBMZXQgbWUgdHJ5IHRoYXQgY2hhbmdlIGFuZCBzZWUgaWYgaXQgYmVoYXZlcyBkaWZm
ZXJlbnRseS4NCg0KSSB0ZXN0ZWQgdGhlIHBhdGNoLCBidXQgSSd2ZSBhY3R1YWxseSBzZWVuIHNv
bWUgdW5leHBlY3RlZCBiZWhhdmlvci4NCg0KRmlyc3QsIG5ldF9kZXZpY2UtPm52c3BfdmVyc2lv
biBpcyBhY3R1YWxseSBOVlNQX1BST1RPQ09MX1ZFUlNJT05fNSBvbg0KYm90aCBteSBXaW4yMDEy
IGFuZCBXaW4yMDE2IGhvc3RzIHRoYXQgSSB0ZXN0ZWQgb24sIHNvIHRoZSBjb25kaXRpb24gaXMN
Cm5ldmVyIGV4ZWN1dGVkLg0KDQpTZWNvbmQsIHdoZW4gZG9pbmcgdGhlIGNoZWNrIGluc3RlYWQg
YXMgIGlmICh2bWJ1c19wcm90b192ZXJzaW9uIDwNClZFUlNJT05fV0lOMTApLCBJIGdldCB0aGUg
c2FtZSBiZWhhdmlvciBJIGRlc2NyaWJlZCBhYm92ZSB3aGVyZSB0aGUNCmd1ZXN0IGhhbmdzIGFz
IHRoZSBrZXJuZWwgd2FpdHMgaW5kZWZpbml0ZWx5IGluIHZtYnVzX3RlYXJkb3duX2dwYWRsKCkN
CmZvciBhIGNvbXBsZXRpb24gdG8gYmUgc2lnbmFsZWQuIFRoaXMgaXMgYWN0dWFsbHkgd2hhdCBs
ZWFkIG1lIHRvDQpwcm9wb3NlIHNwbGl0dGluZyBuZXR2c2NfcmV2b2tlX2J1ZigpIGFuZCBuZXR2
c2NfdGVhcmRvd25fZ3BhZGwoKSBpbiBteQ0KaW5pdGlhbCBwYXRjaHNldCBzbyB0aGF0IHdlIGtl
ZXAgdGhlIHNhbWUgb3JkZXIgb2YgbWVzc2FnZXMgYW5kIGF2b2lkDQp0aGF0IGluZGVmaW5pdGUg
d2FpdC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRl
dmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6Ly9kcml2
ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZlcmRldi1k
ZXZlbAo=
