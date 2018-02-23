Return-Path: <amelie.delaunay@st.com>
X-Google-Smtp-Source: AH8x224CsIRE6ru3aEQ4SvU8ziKVWxcd4qmQR8kfZks80o+Ss+QS35xYlnvb9b7OIak+JFksxBr4
ARC-Seal: i=1; a=rsa-sha256; t=1519382822; cv=none;
        d=google.com; s=arc-20160816;
        b=HMoEoxzJ4EDKJMQgfRXb/9UbXbmIBibGzPCHsqV/ki4WuSb/tTY8i3epQM3YIzZvqW
         ccm2cC9Zq8X034NOBdqQ3zyrHRMKfMRqTQvDVP3UebwoUYhN4ZOgSy+hyqGR908Lhf5N
         IghotVC2SGrr6g1NK1qJetSy/rV1elPfFBJeEwQ5XiQyvpTN4yKS4ehbEhQqvBd3cSg+
         1O6hcGlt0gZXpwEZkn0kX9zTJU1qD2J5gUjUyoHwoexBYEGIK+UFmNkBhyK8gZjQhDjY
         5XxlEho991AoPkVu9lajDcK8f852xTCivw7c9i6DkoGWT0NhF3BgCUjNdH4Yi3hPeiLQ
         L1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:user-agent
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=ydX2jkoQSQ+tE/2v7Fb0w0Ok5StH/Lv5JURxIqKQnMQ=;
        b=aM/CzzVgkgboqTbMTOQt/h5hC9frco7/6wKYEla6mz2rKn7NDyFI3tPTkgLJ7XrN8s
         2NmD+bFT/pNKVJUFDuJbjNpQnQxCdtEH9TQkuzxrS+VycxVHZdMA0YK638KlWidzc/ry
         hwQSYNfSMppZmMpznqtm03fi8hDDndDVmBETEZEkpC6rS4AvOO0/pok0XaRRuvbiAJCF
         o7oyUh0+oIm09DwpKc05ICN1j8qbqZX5xAIDIKyQGJ92dDt4KHOr9H/IlildXSeVvUMm
         WUBPRsO3lMWFuGUnibUorZ0NaDkUe9g03tKiZTxjS4JWw7wilV2QajjrYPt61I00h15e
         5hUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Roger Quadros <rogerq@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Topic: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Index: AQHTqkp3rnXPTZ4feU61xpBLtCmRWqOtQQQAgAAMt4CAAB4FgIAAGxYAgAKglwCAAIjvAIABEYSA
Date: Fri, 23 Feb 2018 10:46:52 +0000
Message-ID: <55196991-f9c1-6d8d-368f-2ab5f8e81c56@st.com>
References: <Pine.LNX.4.44L0.1802221325220.1295-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1802221325220.1295-100000@iolanthe.rowland.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D44959A5AE54364282A5D95E36AF70B9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_03:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592910586052663664?=
X-GMAIL-MSGID: =?utf-8?q?1593188362759417780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDAyLzIyLzIwMTggMDc6MjcgUE0sIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFRodSwg
MjIgRmViIDIwMTgsIEFtZWxpZSBERUxBVU5BWSB3cm90ZToNCj4gDQo+Pj4+Pj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0DQo+Pj4+Pj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0
DQo+Pj4+Pj4+IEBAIC0xOSw2ICsxOSw3IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+Pj4+Pj4+
ICAgICAgLSBwaHlzIDogcGhhbmRsZSArIHBoeSBzcGVjaWZpZXIgcGFpcg0KPj4+Pj4+PiAgICAg
IC0gcGh5LW5hbWVzIDogInVzYiINCj4+Pj4+Pj4gICAgICAtIHJlc2V0cyA6IHBoYW5kbGUgKyBy
ZXNldCBzcGVjaWZpZXIgcGFpcg0KPj4+Pj4+PiArIC0gdmJ1cy1zdXBwbHkgOiBwaGFuZGxlIG9m
IHJlZ3VsYXRvciBzdXBwbHlpbmcgdmJ1cw0KPj4+Pj4+PiAgICAgDQo+Pj4+Pj4NCj4+Pj4+PiBD
YW4gcGxhdGZvcm1zIGhhdmUgbW9yZSB0aGFuIG9uZSByZWd1bGF0b3IgZS5nLiBvbmUgcmVndWxh
dG9yIHBlciBwb3J0Pw0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gSSBpbWFnaW5lIHRoYXQgeWVzLCBw
bGF0Zm9ybXMgY291bGQgaGF2ZSBvbmUgcmVndWxhdG9yIHBlciBwb3J0Lg0KPj4+Pj4gUmVndWxh
dG9yIGNvbnN1bWVycyBiaW5kaW5ncyBpbXBvc2UgYSA8bmFtZT4tc3VwcGx5IHByb3BlcnR5IHBl
cg0KPj4+Pj4gcmVndWxhdG9yLCBzbywgd2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgOg0KPj4+Pj4g
dmJ1czAtc3VwcGx5IGZvciBwb3J0IzANCj4+Pj4+IHZidXMxLXN1cHBseSBmb3IgcG9ydCMxDQo+
Pj4+PiAuLi4NCj4+Pj4+IHZidXNOLXN1cHBseSBmb3IgcG9ydCNODQo+Pj4+Pg0KPj4+Pj4gQW5k
IHRoZW4gaW4gcHJvYmUsIGFsbG9jYXRlICdzdHJ1Y3QgcmVndWxhdG9yICp2YnVzX3N1cHBsaWVz
JyB3aXRoIGENCj4+Pj4+IHNpemUgY29ycmVzcG9uZGluZyB0byAnSENTX05fUE9SVFMoZWhjaS0+
aGNzX3BhcmFtcykgKiBzaXplb2Yoc3RydWN0DQo+Pj4+PiByZWd1bGF0b3IgKiknLg0KPj4+Pj4g
QW5kIGxvb3AgdG8gZ2V0IG9wdGlvbmFsIHJlZ3VsYXRvciB2YnVzMCwgdmJ1czEsLi4uLCB2YnVz
Ti4NCj4+Pj4+IEFuZCB0aGVuIGVuYWJsZS9kaXNhYmxlIHRoZSBjb3JyZXNwb25kaW5nIHJlZ3Vs
YXRvciBpbg0KPj4+Pj4gZWhjaV9wbGF0Zm9ybV9wb3J0X3Bvd2VyIHRoYW5rcyB0byBwb3J0bnVt
Lg0KPj4+Pg0KPj4+PiBMb29rcyBmaW5lIHRvIG1lIGJ1dCB3ZSBuZWVkIHRvIGdldCBBbGFuJ3Mg
b3BpbmlvbiBpZiB0aGlzIGlzIHdvcnRoIHRoZSBlZmZvcnQuDQo+Pj4+IElmIHRoZXJlIGlzbid0
IGEgc2luZ2xlIHBsYXRmb3JtIG5lZWRpbmcgaXQgd2UgY291bGQgcHJvYmFibHkgZG8gd2l0aG91
dCBpdA0KPj4+PiBidXQgdGhlIERUIGJpbmRpbmcgbXVzdCBiZSBzY2FsYWJsZSB0byBhZGQgdGhp
cyBmZWF0dXJlIGluIHRoZSBmdXR1cmUuDQo+Pj4NCj4+PiBJIGFncmVlIHRoYXQgZm9yIG5vdyB0
aGVyZSBkb24ndCBzZWVtIHRvIGJlIGFueSBwbGF0Zm9ybXMgcmVxdWlyaW5nDQo+Pj4gbW9yZSB0
aGFuIG9uZSByZWd1bGF0b3IsIGJ1dCB0aGlzIHNob3VsZCBiZSBpbXBsZW1lbnRlZCBpbiBhIHdh
eSB0aGF0DQo+Pj4gY291bGQgYmUgZXhwYW5kZWQgaWYgbmVjZXNzYXJ5Lg0KPj4+DQo+Pj4gQW55
d2F5LCB0aGUgYmFzaWMgaWRlYSBpcyByZWFzb25hYmxlLiAgSSBkb24ndCBrbm93IHRvIHdoYXQg
ZXh0ZW50DQo+Pj4gcGVvcGxlIHdhbnQgdG8gcG93ZXItb2ZmIHRoZWlyIEVIQ0kgcG9ydHMsIGJ1
dCBpZiB0aGV5IGRvIHRoZW4gd2Ugb3VnaHQNCj4+PiB0byB0dXJuIG9mZiBleHRlcm5hbCByZWd1
bGF0b3JzIGF0IHRoZSBzYW1lIHRpbWUuDQo+Pj4NCj4+PiBJcyB0aGVyZSBhIHJlYWwtbGlmZSB1
c2UgY2FzZSBmb3IgdGhpcz8NCj4+Pg0KPj4+IEFsYW4gU3Rlcm4NCj4+Pg0KPj4NCj4+IE9uIG15
IHNldHVwIEkgaGF2ZSB0aGUgZm9sbG93aW5nOg0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICBy
ZWd1bGF0b3JfX19fX3ZidXMNCj4+ICAgIF9fX19fX19fX19fX19fX19fICAgICAgICAgICAgIFwN
Cj4+IHwgRUhDSSBjb250cm9sbGVyIHwtcG9ydDAtLS0tLVtVU0IgY29ubmVjdG9yXQ0KPj4gfF9f
X19fX19fX19fX19fX19ffC1wb3J0MS0tLS0tWA0KPj4NCj4+IFNvLCBJIGhhdmUgb25lIHJlZ3Vs
YXRvciBvbmx5IGZvciBwb3J0MC4gQnV0IEkgY291bGQgSSBoYXZlIG9uZSBtb3JlIGlmDQo+PiBw
b3J0MSB3YXMgY29ubmVjdGVkLiBNeSBjdXJyZW50IHJlZ3VsYXRvciBjb3VsZCBhbHNvIHN1cHBs
aWVzIHBvcnQxLg0KPj4NCj4+IFRvIGFsbG9jYXRlIGEgdmJ1c19zdXBwbGllcyBhcnJheSBkZXBl
bmRpbmcgb24gTl9QT1JUUywgSSBoYXZlIHRvIG1vdmUNCj4+IHRoaXMgaW5pdGlhbGl6YXRpb24g
ZnJvbSBwcm9iZSB0byBlaGNpX3BsYXRmb3JtX3Jlc2V0LCBhZnRlciBlaGNpX3NldHVwDQo+PiBp
cyBkb25lLg0KPj4gVGhlbiwgSSBoYXZlIHRvIGRlZmluZSBlYWNoIHJlZ3VsYXRvciBpZCBkZXBl
bmRpbmcgb24gdGhlIHBvcnQgbnVtYmVyLg0KPj4gVGhpcyBpbXBvc2VzIGEgYmluZGluZyBsaWtl
DQo+PiAtIHBvcnROX3ZidXMtc3VwcGx5IDogcGhhbmRsZSBvZiByZWd1bGF0b3Igc3VwcGx5aW5n
IHZidXMgZm9yIHBvcnQgTg0KPj4gQnV0IEkgZG9uJ3Qga25vdyBpZiB3ZSBjYW4gZGVzY3JpYmUg
aXQgbGlrZSB0aGlzIGluIGR0LWJpbmRpbmdzID8NCj4+DQo+PiAmZWhjaSB7DQo+PiAJLi4uDQo+
PiAJcG9ydDBfdmJ1cy1zdXBwbHkgPSA8JnZidXNfcmVnPjsNCj4+IAlwb3J0MV92YnVzLXN1cHBs
eSA9IDwmdmJ1c19yZWc+OyAvL0NvdWxkIGJlIGFub3RoZXIgcmVndWxhdG9yLCBvciBub3QNCj4+
IHNwZWNpZmllZCBpZiBwb3J0IGlzIG5vdCBjb25uZWN0ZWQuDQo+PiAJLi4uDQo+PiB9Ow0KPj4N
Cj4+IElzIGl0IG9rIHRvIG1vdmUgdmJ1c19zdXBwbGllcyBpbml0aWFsaXphdGlvbiBpbiBlaGNp
X3BsYXRmb3JtX3Jlc2V0ID8NCj4gDQo+IFllcywgaXQncyBva2F5IHRvIG1vdmUgdGhlIGNvZGUg
aWYgeW91IG5lZWQgdG8uDQo+IA0KPiBIb3dldmVyLCBJIGNhbiBub3Qgc3BlYWsgb24gdGhlIERU
IGltcGxpY2F0aW9ucy4gIFNvbWVvbmUgd2hvIGtub3dzDQo+IG1vcmUgYWJvdXQgaXQgc2hvdWxk
IGNoaW1lIGluLg0KPiANCj4gQWxhbiBTdGVybg0KPiANCg0KVGhhbmtzIEFsYW4sDQoNCkknbSBn
b2luZyB0byBzZW5kIGEgdjMgaW5jbHVkaW5nIGFsbCB0aGVzZSBjaGFuZ2VzIHRvIGVhc2UgcmV2
aWV3Lg0KDQpSZWdhcmRzLA0KQW1lbGll
