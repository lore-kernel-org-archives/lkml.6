Return-Path: <amelie.delaunay@st.com>
X-Google-Smtp-Source: AIpwx4/GHodeTEnwpqhKbIuNYqtcEc2pUyT6oGKXFLgKYIJJcPTObmVRCt69q+CMlHdqkfHyR11/
ARC-Seal: i=1; a=rsa-sha256; t=1522061780; cv=none;
        d=google.com; s=arc-20160816;
        b=kn0uRwfuD0eJJpZWXTx9RfEyXdmd1InsKao7Cc1d6ED0WVSxQ95GCZN6txCYJhECcC
         /WtU8VrG780YDjNN5jPa3kj3urp6FTffb6btfW+g8fV/vWBv3/Vv8BcuaIe4GwsRVsYx
         7VoAo0aHJ8OeWtQCH9tF4NGpbxxc5czSKw1ks3oEaFsEvBq1g/uKSkgmXr48RfKpP4oa
         yzdDAEVagM2JJH3P9nIjkyOGYJSrHu0wRRUxNc6FK8WZLBaL8p8TAu+7uP+S3GXnYz6O
         6jXQlSgNabFAx7BAbuno7kLfMiQPtKlv2FL4sMkKjGDiHliTlP+flJcWHwZlTUP56anz
         qvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:user-agent
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=jW2RnWHUBNsD1AsrikxOFGk6M3LVjGxw+MKYbA86nd4=;
        b=vfS0hT474eThwFWK6oshE2AVO24mVVeNjooIbJQA9Ru9f7SHU5ahlM0fPHJNBa6y93
         hnAQSsxZlj0Ix0Pev6iEl2rlv1xgv3JNtzOzEJBS1BRjHryY2HcvkI8r8eIFFFzhIg/4
         kBTLoxw5pZtEVBbXOosUScV4HE++rqTbCzAKue1PaAwLC1r67jz3wDaWYd8hpw1irwnc
         O2gJNMfLum+VGqZ4vdz2nERsMs7J1X1lY4cYcqw1i1FvEvJKJ1wOKbTAlaA3wfEzNjva
         py035Vvdx1xlIBy9OdmrpIctQzwSzK1PWKBtz/jUpB9SqaqLjrPYvonz3ppkON4tSjYK
         aJqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heiko Stuebner
	<heiko@sntech.de>,
        Minas Harutyunyan <hminas@synopsys.com>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Topic: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Index: AQHTxOD5IYVs/LbjlkS2pJRFzyTVB6PiNtWA
Date: Mon, 26 Mar 2018 10:56:15 +0000
Message-ID: <4abf7dee-8cb1-6d76-2f75-82db12f096a2@st.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180326090001.57627-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20180326090001.57627-1-tomeu.vizoso@collabora.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <76147D6AB3557A46B014023D41D6123A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1595997453684982759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksDQoNCk9uIDAzLzI2LzIwMTggMTE6MDAgQU0sIFRvbWV1IFZpem9zbyB3cm90ZToNCj4gZGV2
bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsIHJldHVybnMgLUVOT0RFViBpZiB0aGUgcmVndWxhdG9y
IGlzbid0DQo+IHRoZXJlLCBzbyBpZiB0aGF0J3MgdGhlIGNhc2Ugd2UgaGF2ZSB0byBtYWtlIHN1
cmUgbm90IHRvIGxlYXZlIC1FTk9ERVYNCj4gaW4gdGhlIHJlZ3VsYXRvciBwb2ludGVyLg0KPiAN
Cj4gQWxzbywgbWFrZSBzdXJlIHdlIHJldHVybiAwIGluIHRoYXQgY2FzZSwgYnV0IGNvcnJlY3Rs
eSBwcm9wYWdhdGUgYW55DQo+IG90aGVyIGVycm9ycy4gQWxzbyBwcm9wYWdhdGUgdGhlIGVycm9y
IGZyb20gX2R3YzJfaGNkX3N0YXJ0Lg0KPiANCj4gRml4ZXM6IDUzMWVmNWViZWE5NiAoInVzYjog
ZHdjMjogYWRkIHN1cHBvcnQgZm9yIGhvc3QgbW9kZSBleHRlcm5hbCB2YnVzIHN1cHBseSIpDQo+
IENjOiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBzdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5jb20+DQo+IA0KPiAt
LS0NCj4gDQo+IHYyOiBPbmx5IG92ZXJ3cml0ZSB0aGUgZXJyb3IgaW4gdGhlIHBvaW50ZXIgYWZ0
ZXIgY2hlY2tpbmcgaXQgKEhlaWtvDQo+ICAgICAgU3TDvGJuZXIgPGhlaWtvQHNudGVjaC5kZT4p
DQo+IHYzOiBSZW1vdmUgaHVua3MgdGhhdCBzaG91bGRuJ3QgYmUgaW4gdGhpcyBwYXRjaA0KPiB2
NDogRG9uJ3Qgb3ZlcndyaXRlIHRoZSBlcnJvciBjb2RlIGJlZm9yZSByZXR1cm5pbmcgaXQgKGti
dWlsZCB0ZXN0DQo+ICAgICAgcm9ib3QgPGxrcEBpbnRlbC5jb20+KQ0KPiAtLS0NCj4gICBkcml2
ZXJzL3VzYi9kd2MyL2hjZC5jIHwgMTMgKysrKysrKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gaW5kZXggMTkw
Zjk1OTY0MDAwLi5jNTFiNzNiM2UwNDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIv
aGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBAQCAtMzU4LDkgKzM1OCwx
NCBAQCBzdGF0aWMgdm9pZCBkd2MyX2d1c2JjZmdfaW5pdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNv
dGcpDQo+ICAgDQo+ICAgc3RhdGljIGludCBkd2MyX3ZidXNfc3VwcGx5X2luaXQoc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIHsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICAgCWhzb3RnLT52
YnVzX3N1cHBseSA9IGRldm1fcmVndWxhdG9yX2dldF9vcHRpb25hbChoc290Zy0+ZGV2LCAidmJ1
cyIpOw0KPiAtCWlmIChJU19FUlIoaHNvdGctPnZidXNfc3VwcGx5KSkNCj4gLQkJcmV0dXJuIDA7
DQo+ICsJaWYgKElTX0VSUihoc290Zy0+dmJ1c19zdXBwbHkpKSB7DQo+ICsJCXJldCA9IFBUUl9F
UlIoaHNvdGctPnZidXNfc3VwcGx5KTsNCj4gKwkJaHNvdGctPnZidXNfc3VwcGx5ID0gTlVMTDsN
Cj4gKwkJcmV0dXJuIHJldCA9PSAtRU5PREVWID8gMCA6IHJldDsNCj4gKwl9DQo+ICAgDQo+ICAg
CXJldHVybiByZWd1bGF0b3JfZW5hYmxlKGhzb3RnLT52YnVzX3N1cHBseSk7DQo+ICAgfQ0KPiBA
QCAtNDM0Miw5ICs0MzQ3LDcgQEAgc3RhdGljIGludCBfZHdjMl9oY2Rfc3RhcnQoc3RydWN0IHVz
Yl9oY2QgKmhjZCkNCj4gICANCj4gICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaHNvdGctPmxv
Y2ssIGZsYWdzKTsNCj4gICANCj4gLQlkd2MyX3ZidXNfc3VwcGx5X2luaXQoaHNvdGcpOw0KPiAt
DQo+IC0JcmV0dXJuIDA7DQo+ICsJcmV0dXJuIGR3YzJfdmJ1c19zdXBwbHlfaW5pdChoc290Zyk7
DQo+ICAgfQ0KPiAgIA0KPiAgIC8qDQo+IA0KDQpSZXZpZXdlZC1ieTogQW1lbGllIERlbGF1bmF5
IDxhbWVsaWUuZGVsYXVuYXlAc3QuY29tPg0KDQpUaGFua3MsDQpBbWVsaWU=
