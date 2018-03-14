Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1280822-1521019336-2-10548744695923537684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521019335; b=fq9yWtZGq94qjofv+Jddu4BwfMSybTFRF2MqIvNEVlsj1ce
    9l/FKj+AkjJ4oub+SE74+WVTIoG0tjJGBRzbjtmgAsrjpBsgs4gB/E+VFYAxJmfF
    zv/14P5xcKQCQWaFrvbZc6REYS3O6QY7S+1MZKAks+quQOmDee/xDBptw4dOmoOo
    qsyNyV7WE8q1WXmZzNhFBKr4NXCFGdEQdwUuf3UwPMvqkj1etJwWOIAIH9lghoQP
    +8W9RG1kAmne/pZRxuDgtLw/O4AiMBEOBY1sxqr4o5uI+rKZaEdY3ANDIzCcRVHY
    SurtYOj2qEwjU/WJPUz0oSXOmHVWDy+ouM+j5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1521019335; bh=+ZN6jQO+5meVeTyDdqbolC6dAu/op4yXhNLZGEECCn4=; b=M
    ur0rQn519ay5u95VdQxddcC1KL8bZXmMrvTIp6rNTqbXWc+WLjnd1J/ERw8yXOsW
    GxlfcH1aBsL7Y0X++KfJPco2ujKKeY7aYVqAn4/yU/ZhBgPiBRdgPFp23NfuKtsU
    3HLWKCzxrSKNsbcknsl3I4j6zp/FiyYFAGBFsh961Zzd4lI8Zc+Gr7aCVSTX5yKx
    p3+CO81hFtvuOcx/Mnpnnt/T9WzzSWqU8135R13D0mAo/tNRXJljb+dr/fAsCitd
    C1FY1f0fAyJBF1B+GJpDQC9MsGtloEe+cDdFPhUkQFUaJ2U00RO7dHMwDZR5m0Qt
    25s1dxyaJAn170bJ84L/A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-ID: <1521019321.8260.1.camel@redhat.com>
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
From: Mohammed Gamal <mgamal@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 14 Mar 2018 10:22:01 +0100
In-Reply-To: <20180313123521.5b486da1@xeon-e3>
References: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
 <20180313123521.5b486da1@xeon-e3>
Organization: Red Hat
Mime-Version: 1.0
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
Reply-To: mgamal@redhat.com
Cc: otubo@redhat.com, sthemmin@microsoft.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTAzLTEzIGF0IDEyOjM1IC0wNzAwLCBTdGVwaGVuIEhlbW1pbmdlciB3cm90
ZToKPiBPbiBUdWUsIDEzIE1hciAyMDE4IDIwOjA2OjUwICswMTAwCj4gTW9oYW1tZWQgR2FtYWwg
PG1nYW1hbEByZWRoYXQuY29tPiB3cm90ZToKPiAKPiA+IERyaW5nIGhpZ2ggbmV0d29yayB0cmFm
ZmljIGNoYW5nZXMgdG8gbmV0d29yayBpbnRlcmZhY2UgcGFyYW1ldGVycwo+ID4gc3VjaCBhcyBu
dW1iZXIgb2YgY2hhbm5lbHMgb3IgTVRVIGNhbiBjYXVzZSBhIGtlcm5lbCBwYW5pYyB3aXRoIGEK
PiA+IE5VTEwKPiA+IHBvaW50ZXIgZGVyZWZlcmVuY2UuIFRoaXMgaXMgZHVlIHRvIG5ldHZzY19k
ZXZpY2VfcmVtb3ZlKCkgYmVpbmcKPiA+IGNhbGxlZCBhbmQgZGVhbGxvY2F0aW5nIHRoZSBjaGFu
bmVsIHJpbmcgYnVmZmVycywgd2hpY2ggY2FuIHRoZW4gYmUKPiA+IGFjY2Vzc2VkIGJ5IG5ldHZz
Y19zZW5kX3BrdCgpIGJlZm9yZSB0aGV5J3JlIGFsbG9jYXRlZCBvbiBjYWxsaW5nCj4gPiBuZXR2
c2NfZGV2aWNlX2FkZCgpCj4gPiAKPiA+IFRoZSBwYXRjaCBmaXhlcyB0aGlzIHByb2JsZW0gYnkg
Y2hlY2tpbmcgdGhlIGNoYW5uZWwgc3RhdGUgYW5kCj4gPiByZXR1cm5pbmcKPiA+IEVOT0RFViBp
ZiBub3QgeWV0IG9wZW5lZC4gV2UgYWxzbyBtb3ZlIHRoZSBjYWxsIHRvCj4gPiBodl9yaW5nYnVm
X2F2YWlsX3BlcmNlbnQoKQo+ID4gd2hpY2ggbWF5IGFjY2VzcyB0aGUgdW5pbml0aWFsaXplZCBy
aW5nIGJ1ZmZlci4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTW9oYW1tZWQgR2FtYWwgPG1nYW1h
bEByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYyB8
IDUgKysrLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+
ID4gYi9kcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjLmMKPiA+IGluZGV4IDAyNjVkNzAuLjQ0YTgz
NTggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjLmMKPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+ID4gQEAgLTc1Nyw3ICs3NTcsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBuZXR2c2Nfc2VuZF9wa3QoCj4gPiDCoAlzdHJ1Y3QgbmV0ZGV2X3F1ZXVl
ICp0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKG5kZXYsCj4gPiBwYWNrZXQtPnFfaWR4KTsKPiA+
IMKgCXU2NCByZXFfaWQ7Cj4gPiDCoAlpbnQgcmV0Owo+ID4gLQl1MzIgcmluZ19hdmFpbCA9IGh2
X3JpbmdidWZfYXZhaWxfcGVyY2VudCgmb3V0X2NoYW5uZWwtCj4gPiA+b3V0Ym91bmQpOwo+ID4g
Kwl1MzIgcmluZ19hdmFpbDsKPiA+IMKgCj4gPiDCoAludm1zZy5oZHIubXNnX3R5cGUgPSBOVlNQ
X01TRzFfVFlQRV9TRU5EX1JORElTX1BLVDsKPiA+IMKgCWlmIChza2IpCj4gPiBAQCAtNzczLDcg
Kzc3Myw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG5ldHZzY19zZW5kX3BrdCgKPiA+IMKgCj4gPiDC
oAlyZXFfaWQgPSAodWxvbmcpc2tiOwo+ID4gwqAKPiA+IC0JaWYgKG91dF9jaGFubmVsLT5yZXNj
aW5kKQo+ID4gKwlpZiAob3V0X2NoYW5uZWwtPnJlc2NpbmQgfHwgb3V0X2NoYW5uZWwtPnN0YXRl
ICE9Cj4gPiBDSEFOTkVMX09QRU5FRF9TVEFURSkKPiA+IMKgCQlyZXR1cm4gLUVOT0RFVjsKPiA+
IMKgCj4gPiDCoAlpZiAocGFja2V0LT5wYWdlX2J1Zl9jbnQpIHsKPiA+IEBAIC03OTEsNiArNzkx
LDcgQEAgc3RhdGljIGlubGluZSBpbnQgbmV0dnNjX3NlbmRfcGt0KAo+ID4gwqAJCQkJwqDCoMKg
wqDCoMKgwqBWTUJVU19EQVRBX1BBQ0tFVF9GTEFHX0NPTVAKPiA+IExFVElPTl9SRVFVRVNURUQp
Owo+ID4gwqAJfQo+ID4gwqAKPiA+ICsJcmluZ19hdmFpbCA9IGh2X3JpbmdidWZfYXZhaWxfcGVy
Y2VudCgmb3V0X2NoYW5uZWwtCj4gPiA+b3V0Ym91bmQpOwo+ID4gwqAJaWYgKHJldCA9PSAwKSB7
Cj4gPiDCoAkJYXRvbWljX2luY19yZXR1cm4oJm52Y2hhbi0+cXVldWVfc2VuZHMpOwo+ID4gwqAK
PiAKPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guIFllcyB0aGVyZSBhcmUgcmFjZXMgd2l0aCB0aGUg
Y3VycmVudCB1cGRhdGUKPiBsb2dpYy4gVGhlIHJvb3QgY2F1c2UgZ29lcyBoaWdoZXIgdXAgaW4g
dGhlIGZsb3c7IHRoZSBzZW5kIHF1ZXVlcwo+IHNob3VsZAo+IGJlIHN0b3BwZWQgYmVmb3JlIG5l
dHZzY19kZXZpY2VfcmVtb3ZlIGlzIGNhbGxlZC4gU29sdmluZyBpdCB3aGVyZQo+IHlvdSB0cmll
ZAo+IHRvIGlzIHJhY3kgYW5kIG5vdCBnb2luZyB0byB3b3JrIHJlbGlhYmx5Lgo+IAo+IE5ldHdv
cmsgcGF0Y2hlcyBzaG91bGQgZ28gdG8gbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+IAo+IFlvdSBj
YW4ndCBtb3ZlIHRoZSByaW5nX2F2YWlsIGNoZWNrIHVudGlsIGFmdGVyIHRoZSB2bWJ1c19zZW5k
cGFja2V0Cj4gYmVjYXVzZQo+IHRoYXQgd2lsbCBicmVhayB0aGUgZmxvdyBjb250cm9sIGxvZ2lj
Lgo+IApXaHk/IEkgZG9uJ3Qgc2VlIHJpbmdfYXZhaWwgYmVpbmcgdXNlZCBiZWZvcmUgdGhhdCBw
b2ludC4KCj4gSW5zdGVhZCwgeW91IHNob3VsZCBqdXN0IG1vdmUgdGhlIGF2YWlsX3JlYWQgY2hl
Y2sgdW50aWwganVzdCBhZnRlcgo+IHRoZSBleGlzdGluZyByZXNjaW5kCj4gY2hlY2suCj4gCj4g
QWxzbywgeW91IHNob3VsZG4ndCBuZWVkIHRvIGNoZWNrIGZvciBPUEVORURfU1RBVEUsIGp1c3Qg
cmVzY2luZCBpcwo+IGVub3VnaC4KClRoYXQgcmFyZWx5IG1pdGlnYXRlZCB0aGUgcmFjZS4gY2hh
bm5lbC0+cmVzY2luZCBmbGFnIGlzIHNldCBvbiB2bWJ1cwpleGl0IC0gY2FsbGVkIG9uIG1vZHVs
ZSB1bmxvYWQgLSBhbmQgd2hlbiBhIHJlc2NpbmQgb2ZmZXIgaXMgcmVjZWl2ZWQKZnJvbSB0aGUg
aG9zdCwgd2hpY2ggQUZBSUNUIGRvZXNuJ3QgaGFwcGVuIG9uIGV2ZXJ5IGNhbGwgdG8KbmV0dnNj
X2RldmljZV9yZW1vdmUsIHNvIGl0J3MgcXVpdGUgcG9zc2libGUgdGhhdCB0aGUgcmluZ2J1ZmZl
ciBpcwphY2Nlc3NlZCBiZWZvcmUgaXQncyBhbGxvY2F0ZWQgYWdhaW4gb24gY2hhbm5lbCBvcGVu
IGFuZCBoZW5jZSB0aGUKY2hlY2sgZm9yIE9QRU5FRF9TVEFUIC0gd2hpY2ggaXMgb25seSBzZXQg
YWZ0ZXIgYWxsIHZtYnVzIGRhdGEgaXMKaW5pdGlhbGl6ZWQuCgo+IAo+IAo+IAo+IApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxp
c3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJp
dmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
