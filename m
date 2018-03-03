Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-511746-1520093804-2-12601413476603714455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520093804; b=SG2TjAuwrEPwSzw23eWpdiAElpveANWXhnNtKQfCfjUa3iz
    SGpWfG2hsnhMc8JtjqFdW+sP0rnWo8YjodHSGNOFFjKJ4Gth6nWhmmBuTPIeafPG
    LUBT5Hp9OPw2BovRygvpJ7M0FmEWgO+Cu5+Ky9IwvWQj7ARWn+T7AeT8Z/ItdUNZ
    jQrbyFTFoRXKUgvrvOsMJvLJ6D+OBeJy3FPJ3IMtTVYYZrHG5yKnaYv9/dG+MmR7
    tqYXrPMFny+0N5quhjs7ES2taDXf37hbUDp86Hf+2SNpv62sKbqhWvqEg05WuSDA
    IJPtjPuVvbdb5EV0WnqZKw5jflWJhtia2CYpTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520093804; bh=J
    XzGpq/rl8xzGmyn7MSAfzCOARrI60V4NnSHBJsh/5w=; b=pNQle9UbAZNAc2lkT
    tmIEE5j9pwSFICgIgFNLwZ0phf9JMKD9olqnsmn9zCcyaA8nX/EhP3gw0kS/lky+
    RDstehi7v/t3aI2jT4Kkq0d+56lIgy59DpxQsgxTScmr57ZiZ7uWOMlq+yBVyJ4v
    LVvJ+j1CjrmkQElBW9ewnGG5hs93mEKTpgPX/LFK9ZFGxXx3jOeNZiH/3vrDzRRv
    iXxNucxLPt+qiLZlxvFkDuFFh4/+9d7LBTkCyznqoYqn1VCwniOu2iAqEs6VNdQO
    vU6EHZj0kD5/+rV3EeK7HXFlzQODg1kuyI+uNo4PvC4LKaojCVfSQaqHN6Y18w3K
    Ti5Rg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD532178D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 16:16:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 6/6] Staging: iio: adis16209: Use sign_extend32 and
 adjust a switch statement
Message-ID: <20180303161633.654aaf9b@archlinux>
In-Reply-To: <1520091473.3137.4.camel@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
 <982b80d683b8c8e8c61cbc5b0864c265ea2ac768.1519995673.git.shreeya.patel23498@gmail.com>
 <20180303160557.26462aa7@archlinux>
 <1520091473.3137.4.camel@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gU2F0LCAwMyBNYXIgMjAxOCAyMTowNzo1MyArMDUzMApTaHJlZXlhIFBhdGVsIDxzaHJlZXlh
LnBhdGVsMjM0OThAZ21haWwuY29tPiB3cm90ZToKCj4gT24gU2F0LCAyMDE4LTAzLTAzIGF0IDE2
OjA1ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOgo+ID4gT24gRnJpLMKgwqAyIE1hciAy
MDE4IDE5OjA0OjQ5ICswNTMwCj4gPiBTaHJlZXlhIFBhdGVsIDxzaHJlZXlhLnBhdGVsMjM0OThA
Z21haWwuY29tPiB3cm90ZToKPiA+ICAgCj4gPiA+IAo+ID4gPiBVc2Ugc2lnbl9leHRlbmQzMiBm
dW5jdGlvbiBpbnN0ZWFkIG9mIG1hbnVhbGx5IGNvZGluZyBpdC4KPiA+ID4gQWxzbywgYWRqdXN0
IGEgc3dpdGNoIGJsb2NrIHRvIGV4cGxpY2l0bHkgbWF0Y2ggY2hhbm5lbHMKPiA+ID4gYW5kIHJl
dHVybiAtRUlOVkFMIGFzIGRlZmF1bHQgY2FzZSB3aGljaCBtYWtlcyB0aGUgY29kZQo+ID4gPiBz
ZW1hbnRpY2FsbHkgbW9yZSBjbGVhci4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNocmVl
eWEgUGF0ZWwgPHNocmVleWEucGF0ZWwyMzQ5OEBnbWFpbC5jb20+ICAKPiA+IENoYW5nZXMgYXJl
IGZpbmUsIGJ1dCAyIGNoYW5nZXMgdG8gZGlmZmVyZW50IHRoaW5ncyBzaG91bGQgYmUKPiA+IGlu
IDIgcGF0Y2hlcy7CoMKgUGxlYXNlIHNwbGl0LiBJJ2QgcHJvYmFibHkgaGF2ZSB0YWtlbiB0aGlz
IGFueXdheSBpZgo+ID4gaXQgaGFkbid0IGJlZW4gcXVldWVkIGJlaGluZCB0aGUgcmVxdWVzdGVk
IGNoYW5nZXMgdG8gdGhlIHByZXZpb3VzIDIKPiA+IHBhdGNoZXMgYW55d2F5Lgo+ID4gCj4gPiBH
b29kIHdvcmsgb24gdGhpcyBzZXJpZXMgdGhvdWdoIHNvIGxvb2tpbmcgZm9yd2FyZCB0byB2My7C
oAo+ID4gTm90ZSBwbGVhc2UgbWFyayB0aGUgc2V0IGFzIFtQQVRDSCB2M10gdG8gbWFrZSBpdCBj
bGVhciBpdAo+ID4gaXMgdGhlIDNyZCB2ZXJzaW9uIG9mIHNvbWUgb2YgdGhpcy4gIAo+IAo+IFll
cywgSSdsbCBkbyB0aGUgY2hhbmdlcy4KPiAKPiBEbyBJIG5lZWQgdG8gaW5jbHVkZSB0aGUgcGF0
Y2hlcyB3aGljaCBoYXZlIGJlZW4gbWVyZ2VkIGZyb20KPiB0aGlzIHNlcmllcyBpbiB2Mz/CoAo+
IApObywganVzdCB0aGUgb25lcyB0aGF0IGhhdmVuJ3QgbWVyZ2VkIHlldC4KClRoYW5rcywKCkpv
bmF0aGFuCgo+IFRoYW5rcwo+ID4gICAKPiA+ID4gCj4gPiA+IC0tLQo+ID4gPiDCoGRyaXZlcnMv
c3RhZ2luZy9paW8vYWNjZWwvYWRpczE2MjA5LmMgfCAxNSArKysrKysrKysrLS0tLS0KPiA+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiA+ID4g
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FjY2VsL2FkaXMxNjIwOS5j
Cj4gPiA+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyMDkuYwo+ID4gPiBpbmRl
eCA3MzYzZmQwLi41YWI0NGE0IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlv
L2FjY2VsL2FkaXMxNjIwOS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWNjZWwv
YWRpczE2MjA5LmMKPiA+ID4gQEAgLTE1MCwxMCArMTUwLDE2IEBAIHN0YXRpYyBpbnQgYWRpczE2
MjA5X3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2Cj4gPiA+ICppbmRpb19kZXYsCj4gPiA+IMKgCQlz
d2l0Y2ggKGNoYW4tPnR5cGUpIHsKPiA+ID4gwqAJCWNhc2UgSUlPX1ZPTFRBR0U6Cj4gPiA+IMKg
CQkJKnZhbCA9IDA7Cj4gPiA+IC0JCQlpZiAoY2hhbi0+Y2hhbm5lbCA9PSAwKQo+ID4gPiArCQkJ
c3dpdGNoIChjaGFuLT5jaGFubmVsKSB7Cj4gPiA+ICsJCQljYXNlIDA6Cj4gPiA+IMKgCQkJCSp2
YWwyID0gMzA1MTgwOyAvKiAwLjMwNTE4IG1WICovCj4gPiA+IC0JCQllbHNlCj4gPiA+ICsJCQkJ
YnJlYWs7Cj4gPiA+ICsJCQljYXNlIDE6Cj4gPiA+IMKgCQkJCSp2YWwyID0gNjEwNTAwOyAvKiAw
LjYxMDUgbVYgKi8KPiA+ID4gKwkJCQlicmVhazsKPiA+ID4gKwkJCWRlZmF1bHQ6Cj4gPiA+ICsJ
CQkJcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ICsJCQl9Cj4gPiA+IMKgCQkJcmV0dXJuIElJT19WQUxf
SU5UX1BMVVNfTUlDUk87Cj4gPiA+IMKgCQljYXNlIElJT19URU1QOgo+ID4gPiDCoAkJCSp2YWwg
PSAtNDcwOwo+ID4gPiBAQCAtMTk3LDkgKzIwMyw4IEBAIHN0YXRpYyBpbnQgYWRpczE2MjA5X3Jl
YWRfcmF3KHN0cnVjdCBpaW9fZGV2Cj4gPiA+ICppbmRpb19kZXYsCj4gPiA+IMKgCQlyZXQgPSBh
ZGlzX3JlYWRfcmVnXzE2KHN0LCBhZGRyLCAmdmFsMTYpOwo+ID4gPiDCoAkJaWYgKHJldCkKPiA+
ID4gwqAJCQlyZXR1cm4gcmV0Owo+ID4gPiAtCQl2YWwxNiAmPSAoMSA8PCBiaXRzKSAtIDE7Cj4g
PiA+IC0JCXZhbDE2ID0gKHMxNikodmFsMTYgPDwgKDE2IC0gYml0cykpID4+ICgxNiAtCj4gPiA+
IGJpdHMpOwo+ID4gPiAtCQkqdmFsID0gdmFsMTY7Cj4gPiA+ICsKPiA+ID4gKwkJKnZhbCA9IHNp
Z25fZXh0ZW5kMzIodmFsMTYsIGJpdHMgLSAxKTsKPiA+ID4gwqAJCXJldHVybiBJSU9fVkFMX0lO
VDsKPiA+ID4gwqAJfQo+ID4gPiDCoAlyZXR1cm4gLUVJTlZBTDsgIAo+IC0tCj4gVG8gdW5zdWJz
Y3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LWlp
byIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9y
Zwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jk
b21vLWluZm8uaHRtbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0
cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
dmVyZGV2LWRldmVsCg==
