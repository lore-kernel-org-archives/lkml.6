Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-679016-1521131068-2-5131200236794707634
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521131067; b=dkuCSPkgKsyYSTM0A4xIPazpPS7jrskczxjvXnzMbEjDJs7
    TyiTX7eMDNSwWkDQ1Wen0QlAwn2DJJR7u0TLdO5iTZkpyetwlf9U6UMoYlbcHdir
    clIJVQ28nAKmz4OInknBRWl7xTHx1F+tMCvovGbHux3AZsBRuOjYPWfTd07df8C8
    ZsJvqaSocSli+Fv6lhgYq0u9s2C0H3oUz6/EQMnxAmo4MBZoNNMH1mZpUbxMgark
    gcx3jNS47K1Wv7oUAH+BJgDN6R0wXZop2DZIRZ/rHBoiLWSb7hvFNn4GAUS0i394
    pvpqXolT/mnGO0q/m0cvuZxxLFtMLg6g0X4ZE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1521131067; bh=dFVs8ZehM1jnwKNPgs+DJ2oJjAiz2IoyeuyEDmQdqok=; b=U
    50KIh9gA183c5OAH5jx/+uSWIUoGkfy3BXEVSu0pwutWriiA0xk5vQQoT3wY/a17
    GyCmuKf3NqFYWsWff0G9CRbK/0E1xNSPnpCdbaJTrt1CP+GhIkpZ9OcGbutup4NQ
    aw+qQG2h44Maz4bA11SV9mhCwNh1Im4oMPIq79xqPfttiADX9ElZMnU/ORUXChCW
    iOSewBqz8qdKfmiGdc2hUzPI319XYjwiUtYK5/8sG0oDrw3z/FnAzl+hfd1nLlMK
    7b+jDmgFOFPt/thZglTZbfYX2bAiuEHpeL8YGl0SP4AimWIBZ5suFhN6sP8Y2Gou
    eDYBU1WL4NJtwZnJqdxqQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-ID: <1521131053.30828.1.camel@redhat.com>
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
From: Mohammed Gamal <mgamal@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 15 Mar 2018 17:24:13 +0100
In-Reply-To: <1521019321.8260.1.camel@redhat.com>
References: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
 <20180313123521.5b486da1@xeon-e3> <1521019321.8260.1.camel@redhat.com>
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

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDEwOjIyICswMTAwLCBNb2hhbW1lZCBHYW1hbCB3cm90ZToK
PiBPbiBUdWUsIDIwMTgtMDMtMTMgYXQgMTI6MzUgLTA3MDAsIFN0ZXBoZW4gSGVtbWluZ2VyIHdy
b3RlOgo+ID4gT24gVHVlLCAxMyBNYXIgMjAxOCAyMDowNjo1MCArMDEwMAo+ID4gTW9oYW1tZWQg
R2FtYWwgPG1nYW1hbEByZWRoYXQuY29tPiB3cm90ZToKPiA+IAo+ID4gPiBEcmluZyBoaWdoIG5l
dHdvcmsgdHJhZmZpYyBjaGFuZ2VzIHRvIG5ldHdvcmsgaW50ZXJmYWNlCj4gPiA+IHBhcmFtZXRl
cnMKPiA+ID4gc3VjaCBhcyBudW1iZXIgb2YgY2hhbm5lbHMgb3IgTVRVIGNhbiBjYXVzZSBhIGtl
cm5lbCBwYW5pYyB3aXRoIGEKPiA+ID4gTlVMTAo+ID4gPiBwb2ludGVyIGRlcmVmZXJlbmNlLiBU
aGlzIGlzIGR1ZSB0byBuZXR2c2NfZGV2aWNlX3JlbW92ZSgpIGJlaW5nCj4gPiA+IGNhbGxlZCBh
bmQgZGVhbGxvY2F0aW5nIHRoZSBjaGFubmVsIHJpbmcgYnVmZmVycywgd2hpY2ggY2FuIHRoZW4K
PiA+ID4gYmUKPiA+ID4gYWNjZXNzZWQgYnkgbmV0dnNjX3NlbmRfcGt0KCkgYmVmb3JlIHRoZXkn
cmUgYWxsb2NhdGVkIG9uIGNhbGxpbmcKPiA+ID4gbmV0dnNjX2RldmljZV9hZGQoKQo+ID4gPiAK
PiA+ID4gVGhlIHBhdGNoIGZpeGVzIHRoaXMgcHJvYmxlbSBieSBjaGVja2luZyB0aGUgY2hhbm5l
bCBzdGF0ZSBhbmQKPiA+ID4gcmV0dXJuaW5nCj4gPiA+IEVOT0RFViBpZiBub3QgeWV0IG9wZW5l
ZC4gV2UgYWxzbyBtb3ZlIHRoZSBjYWxsIHRvCj4gPiA+IGh2X3JpbmdidWZfYXZhaWxfcGVyY2Vu
dCgpCj4gPiA+IHdoaWNoIG1heSBhY2Nlc3MgdGhlIHVuaW5pdGlhbGl6ZWQgcmluZyBidWZmZXIu
Cj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNb2hhbW1lZCBHYW1hbCA8bWdhbWFsQHJlZGhh
dC5jb20+Cj4gPiA+IC0tLQo+ID4gPiDCoGRyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYyB8IDUg
KysrLS0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2Mu
Ywo+ID4gPiBiL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+ID4gPiBpbmRleCAwMjY1ZDcw
Li40NGE4MzU4IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjLmMK
PiA+ID4gKysrIGIvZHJpdmVycy9uZXQvaHlwZXJ2L25ldHZzYy5jCj4gPiA+IEBAIC03NTcsNyAr
NzU3LDcgQEAgc3RhdGljIGlubGluZSBpbnQgbmV0dnNjX3NlbmRfcGt0KAo+ID4gPiDCoAlzdHJ1
Y3QgbmV0ZGV2X3F1ZXVlICp0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKG5kZXYsCj4gPiA+IHBh
Y2tldC0+cV9pZHgpOwo+ID4gPiDCoAl1NjQgcmVxX2lkOwo+ID4gPiDCoAlpbnQgcmV0Owo+ID4g
PiAtCXUzMiByaW5nX2F2YWlsID0gaHZfcmluZ2J1Zl9hdmFpbF9wZXJjZW50KCZvdXRfY2hhbm5l
bC0KPiA+ID4gPiBvdXRib3VuZCk7Cj4gPiA+IAo+ID4gPiArCXUzMiByaW5nX2F2YWlsOwo+ID4g
PiDCoAo+ID4gPiDCoAludm1zZy5oZHIubXNnX3R5cGUgPSBOVlNQX01TRzFfVFlQRV9TRU5EX1JO
RElTX1BLVDsKPiA+ID4gwqAJaWYgKHNrYikKPiA+ID4gQEAgLTc3Myw3ICs3NzMsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBuZXR2c2Nfc2VuZF9wa3QoCj4gPiA+IMKgCj4gPiA+IMKgCXJlcV9pZCA9
ICh1bG9uZylza2I7Cj4gPiA+IMKgCj4gPiA+IC0JaWYgKG91dF9jaGFubmVsLT5yZXNjaW5kKQo+
ID4gPiArCWlmIChvdXRfY2hhbm5lbC0+cmVzY2luZCB8fCBvdXRfY2hhbm5lbC0+c3RhdGUgIT0K
PiA+ID4gQ0hBTk5FTF9PUEVORURfU1RBVEUpCj4gPiA+IMKgCQlyZXR1cm4gLUVOT0RFVjsKPiA+
ID4gwqAKPiA+ID4gwqAJaWYgKHBhY2tldC0+cGFnZV9idWZfY250KSB7Cj4gPiA+IEBAIC03OTEs
NiArNzkxLDcgQEAgc3RhdGljIGlubGluZSBpbnQgbmV0dnNjX3NlbmRfcGt0KAo+ID4gPiDCoAkJ
CQnCoMKgwqDCoMKgwqDCoFZNQlVTX0RBVEFfUEFDS0VUX0ZMQUdfQ08KPiA+ID4gTVAKPiA+ID4g
TEVUSU9OX1JFUVVFU1RFRCk7Cj4gPiA+IMKgCX0KPiA+ID4gwqAKPiA+ID4gKwlyaW5nX2F2YWls
ID0gaHZfcmluZ2J1Zl9hdmFpbF9wZXJjZW50KCZvdXRfY2hhbm5lbC0KPiA+ID4gPiBvdXRib3Vu
ZCk7Cj4gPiA+IAo+ID4gPiDCoAlpZiAocmV0ID09IDApIHsKPiA+ID4gwqAJCWF0b21pY19pbmNf
cmV0dXJuKCZudmNoYW4tPnF1ZXVlX3NlbmRzKTsKPiA+ID4gwqAKPiA+IAo+ID4gVGhhbmtzIGZv
ciB5b3VyIHBhdGNoLiBZZXMgdGhlcmUgYXJlIHJhY2VzIHdpdGggdGhlIGN1cnJlbnQgdXBkYXRl
Cj4gPiBsb2dpYy4gVGhlIHJvb3QgY2F1c2UgZ29lcyBoaWdoZXIgdXAgaW4gdGhlIGZsb3c7IHRo
ZSBzZW5kIHF1ZXVlcwo+ID4gc2hvdWxkCj4gPiBiZSBzdG9wcGVkIGJlZm9yZSBuZXR2c2NfZGV2
aWNlX3JlbW92ZSBpcyBjYWxsZWQuIFNvbHZpbmcgaXQgd2hlcmUKPiA+IHlvdSB0cmllZAo+ID4g
dG8gaXMgcmFjeSBhbmQgbm90IGdvaW5nIHRvIHdvcmsgcmVsaWFibHkuCj4gPiAKPiA+IE5ldHdv
cmsgcGF0Y2hlcyBzaG91bGQgZ28gdG8gbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+ID4gCj4gPiBZ
b3UgY2FuJ3QgbW92ZSB0aGUgcmluZ19hdmFpbCBjaGVjayB1bnRpbCBhZnRlciB0aGUKPiA+IHZt
YnVzX3NlbmRwYWNrZXQKPiA+IGJlY2F1c2UKPiA+IHRoYXQgd2lsbCBicmVhayB0aGUgZmxvdyBj
b250cm9sIGxvZ2ljLgo+ID4gCj4gCj4gV2h5PyBJIGRvbid0IHNlZSByaW5nX2F2YWlsIGJlaW5n
IHVzZWQgYmVmb3JlIHRoYXQgcG9pbnQuCgpBaCwgc3R1cGlkIG1lLiB2bWJ1c19zZW5kcGFja2V0
KCkgd2lsbCB3cml0ZSB0byB0aGUgcmluZyBidWZmZXIgYW5kCnRoYXQgbWVhbnMgdGhhdCByaW5n
X2F2YWlsIHZhbHVlIHdpbGwgYmUgZGlmZmVyZW50IHRoYW4gdGhlIGV4cGVjdGVkLgoKPiAKPiA+
IEluc3RlYWQsIHlvdSBzaG91bGQganVzdCBtb3ZlIHRoZSBhdmFpbF9yZWFkIGNoZWNrIHVudGls
IGp1c3QgYWZ0ZXIKPiA+IHRoZSBleGlzdGluZyByZXNjaW5kCj4gPiBjaGVjay4KPiA+IAo+ID4g
QWxzbywgeW91IHNob3VsZG4ndCBuZWVkIHRvIGNoZWNrIGZvciBPUEVORURfU1RBVEUsIGp1c3Qg
cmVzY2luZCBpcwo+ID4gZW5vdWdoLgo+IAo+IFRoYXQgcmFyZWx5IG1pdGlnYXRlZCB0aGUgcmFj
ZS4gY2hhbm5lbC0+cmVzY2luZCBmbGFnIGlzIHNldCBvbiB2bWJ1cwo+IGV4aXQgLSBjYWxsZWQg
b24gbW9kdWxlIHVubG9hZCAtIGFuZCB3aGVuIGEgcmVzY2luZCBvZmZlciBpcyByZWNlaXZlZAo+
IGZyb20gdGhlIGhvc3QsIHdoaWNoIEFGQUlDVCBkb2Vzbid0IGhhcHBlbiBvbiBldmVyeSBjYWxs
IHRvCj4gbmV0dnNjX2RldmljZV9yZW1vdmUsIHNvIGl0J3MgcXVpdGUgcG9zc2libGUgdGhhdCB0
aGUgcmluZ2J1ZmZlciBpcwo+IGFjY2Vzc2VkIGJlZm9yZSBpdCdzIGFsbG9jYXRlZCBhZ2FpbiBv
biBjaGFubmVsIG9wZW4gYW5kIGhlbmNlIHRoZQo+IGNoZWNrIGZvciBPUEVORURfU1RBVCAtIHdo
aWNoIGlzIG9ubHkgc2V0IGFmdGVyIGFsbCB2bWJ1cyBkYXRhIGlzCj4gaW5pdGlhbGl6ZWQuCj4g
CgpQZXJoYXBzIEkgaGF2ZW4ndCBiZWVuIGNsZWFyIGVub3VnaC4gVGhlIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZQpoYXBwZW5zIGluIHRoZSBjYWxsIHRvIGh2X3JpbmdidWZfYXZhaWxfcGVyY2Vu
dCgpIHdoaWNoIGlzIHVzZWQgdG8KY2FsY3VsYXRlIHJpbmdfYXZhaWwuwqAKClNvIHdlIG5lZWQg
dG8gc3RvcCB0aGUgcXVldWVzIGJlZm9yZSBjYWxsaW5nIGl0IGlmIHRoZSBjaGFubmVsJ3Mgcmlu
ZwpidWZmZXJzIGhhdmVuJ3QgYmVlbiBhbGxvY2F0ZWQgeWV0LCBidXQgT1RPSCB3ZSBzaG91bGQg
b25seSBzdG9wIHRoZQpxdWV1ZXMgYmFzZWQgdXBvbiB0aGUgdmFsdWUgb2YgcmluZ19hdmFpbCwg
c28gdGhpcyBsZWFkcyBpbnRvIGEgY2hpY2tlbgphbmQgZWdnIHNpdHVhdGlvbi7CoAoKSXMgbXkg
b2JzZXJ2YXRpb24gaGVyZSBjb3JyZWN0PyBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdyb25n
LApTdGVwaGVuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8v
ZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJk
ZXYtZGV2ZWwK
