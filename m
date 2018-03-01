Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3379410-1519921650-2-3878658622364625366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921649; b=Prrp/PwAlSiNo5gzQTsQ9JS9l9m4UDzzvjBE56yicLPrxpF
    AJGkoZajnPVUJ++UgZ74CY6bPtPeP18qff7jKluUjzZpU+ndjYb5S9j87ydcFcSt
    Jrg5hQP7IGkhlShvL1kiaYoQRH7YbFQmmrTkF3u198UbcGHvFu/mzVaeE52IfGSA
    YI9iAP9QcRnsOu79ay28Hj3V8zlHfoDlZhwAmLHc9huIEmMk+pDqih5oNtmIc+M+
    tCBrfWJl4oslU73IphLR379tpkVyjLTq132ccKuwze09jnOLWdiLiFL6FQoML2M5
    gfD5VyhUwDkj/hbpOkycx9ZpaHcmxt4Ajp9rtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519921649; bh=t
    K7vj7uRZg3nSLAvLKTM4YYNwYNafjHqGq6DHJ0NUoA=; b=Ig6osHXiW89PWpHoe
    LumvXaknj27iVbqEKtIEADnpilg8PvSnV+hNxlcBnY1BXt+gyLltxKOVQD41UmaT
    8vkJtx8Eo2RFgXuuNLJgyadOHoSKwfhEOlNtl05VpaQqL+0qa5r/xhi/YL4sVXqx
    Ba45zxhqr2NSWmhGwHmnLhG8xYcP+C0Y8ynCjy2BOC4n/KfPjUd17vcOmDS7+scp
    QpkN/yR138yEslZvDri5ijCoU1AZ5Kld/aay6kTjCmZZ48p+qe27O8SKARQmxg8T
    s1WcN7j6OnmnSsuYFDn1TQIp1szyhK3ClP8ZSvXZqg1CGTzaeirYufnjmMa5ddQv
    I7+3Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-ID: <1519921628.3034.5.camel@pengutronix.de>
Subject: Re: [PATCH] staging/imx: Fix inconsistent IS_ERR and PTR_ERR
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>
Date: Thu, 01 Mar 2018 17:27:08 +0100
In-Reply-To: <CAOMZO5B_UGZ3De1UjUXzU6-wGMgRrRJVWZ8z+a+HoCpwWkeBwg@mail.gmail.com>
References: <20180301040939.GA13274@embeddedgus>
 <CAOMZO5B_UGZ3De1UjUXzU6-wGMgRrRJVWZ8z+a+HoCpwWkeBwg@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: devel@driverdev.osuosl.org
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTAxIGF0IDEzOjAyIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOgo+
IE9uIFRodSwgTWFyIDEsIDIwMTggYXQgMTowOSBBTSwgR3VzdGF2byBBLiBSLiBTaWx2YQo+IDxn
dXN0YXZvQGVtYmVkZGVkb3IuY29tPiB3cm90ZToKPiA+IEZpeCBpbmNvbnNpc3RlbnQgSVNfRVJS
IGFuZCBQVFJfRVJSIGluIGlteF9jc2lfcHJvYmUuCj4gPiBUaGUgcHJvcGVyIHBvaW50ZXIgdG8g
YmUgcGFzc2VkIGFzIGFyZ3VtZW50IGlzIHBpbmN0cmwKPiA+IGluc3RlYWQgb2YgcHJpdi0+dmRl
di4KPiA+IAo+ID4gVGhpcyBpc3N1ZSB3YXMgZGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBvZiBDb2Nj
aW5lbGxlLgo+ID4gCj4gPiBGaXhlczogNTJlMTcwODlkMTg1ICgibWVkaWE6IGlteDogRG9uJ3Qg
aW5pdGlhbGl6ZSB2YXJzIHRoYXQgd29uJ3QgYmUgdXNlZCIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBH
dXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgo+ID4gLS0tCj4gPiAg
ZHJpdmVycy9zdGFnaW5nL21lZGlhL2lteC9pbXgtbWVkaWEtY3NpLmMgfCAyICstCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvaW14L2lteC1tZWRpYS1jc2kuYyBiL2RyaXZl
cnMvc3RhZ2luZy9tZWRpYS9pbXgvaW14LW1lZGlhLWNzaS5jCj4gPiBpbmRleCA1YTE5NWY4Li40
ZjI5MGEwIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL2lteC9pbXgtbWVk
aWEtY3NpLmMKPiA+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9pbXgvaW14LW1lZGlhLWNz
aS5jCj4gPiBAQCAtMTc5OCw3ICsxNzk4LDcgQEAgc3RhdGljIGludCBpbXhfY3NpX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgICAgICAgIHByaXYtPmRldi0+b2Zfbm9k
ZSA9IHBkYXRhLT5vZl9ub2RlOwo+ID4gICAgICAgICBwaW5jdHJsID0gZGV2bV9waW5jdHJsX2dl
dF9zZWxlY3RfZGVmYXVsdChwcml2LT5kZXYpOwo+ID4gICAgICAgICBpZiAoSVNfRVJSKHBpbmN0
cmwpKSB7Cj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihwcml2LT52ZGV2KTsKPiA+
ICsgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHBpbmN0cmwpOwo+ID4gICAgICAgICAgICAg
ICAgIGdvdG8gZnJlZTsKPiAKPiBUaGlzIHBhdGNoIGlzIGNvcnJlY3QsIGJ1dCBub3cgSSBhbSBz
ZWVpbmcgdGhhdAo+IGRldm1fcGluY3RybF9nZXRfc2VsZWN0X2RlZmF1bHQoKSBhbHdheXMgZmFp
bHMuCj4gCj4gSSBhZGRlZCB0aGlzIGRlYnVnIGxpbmU6Cj4gCj4gLS0tIGEvZHJpdmVycy9zdGFn
aW5nL21lZGlhL2lteC9pbXgtbWVkaWEtY3NpLmMKPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvbWVk
aWEvaW14L2lteC1tZWRpYS1jc2kuYwo+IEBAIC0xNzk5LDYgKzE3OTksNyBAQCBzdGF0aWMgaW50
IGlteF9jc2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgICAgICAgIHBp
bmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0X3NlbGVjdF9kZWZhdWx0KHByaXYtPmRldik7Cj4gICAg
ICAgICBpZiAoSVNfRVJSKHBpbmN0cmwpKSB7Cj4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9F
UlIocGluY3RybCk7Cj4gKyAgICAgICAgICAgICAgIHByX2VycigiKioqKioqKioqKioqIHBpbmN0
cmwgZmFpbGVkXG4iKTsKPiAgICAgICAgICAgICAgICAgZ290byBmcmVlOwo+ICAgICAgICAgfQo+
IAo+IGFuZCB0aGlzIGlzIHdoYXQgSSBnZXQgaW4gaW14NnEtc2FicmVzZDoKPiAKPiBbICAgIDMu
NDUzOTA1XSBpbXgtbWVkaWE6IHN1YmRldiBpcHUxX3ZkaWMgYm91bmQKPiBbICAgIDMuNDU4NjAx
XSBpbXgtbWVkaWE6IHN1YmRldiBpcHUyX3ZkaWMgYm91bmQKPiBbICAgIDMuNDYzMzQxXSBpbXgt
bWVkaWE6IHN1YmRldiBpcHUxX2ljX3BycCBib3VuZAo+IFsgICAgMy40Njg5MjRdIGlwdTFfaWNf
cHJwZW5jOiBSZWdpc3RlcmVkIGlwdTFfaWNfcHJwZW5jIGNhcHR1cmUgYXMgL2Rldi92aWRlbzAK
PiBbICAgIDMuNDc2MjM3XSBpbXgtbWVkaWE6IHN1YmRldiBpcHUxX2ljX3BycGVuYyBib3VuZAo+
IFsgICAgMy40ODE2MjFdIGlwdTFfaWNfcHJwdmY6IFJlZ2lzdGVyZWQgaXB1MV9pY19wcnB2ZiBj
YXB0dXJlIGFzIC9kZXYvdmlkZW8xCj4gWyAgICAzLjQ4ODgwNV0gaW14LW1lZGlhOiBzdWJkZXYg
aXB1MV9pY19wcnB2ZiBib3VuZAo+IFsgICAgMy40OTM2NTldIGlteC1tZWRpYTogc3ViZGV2IGlw
dTJfaWNfcHJwIGJvdW5kCj4gWyAgICAzLjQ5ODgzOV0gaXB1Ml9pY19wcnBlbmM6IFJlZ2lzdGVy
ZWQgaXB1Ml9pY19wcnBlbmMgY2FwdHVyZSBhcyAvZGV2L3ZpZGVvMgo+IFsgICAgMy41MDU5NThd
IGlteC1tZWRpYTogc3ViZGV2IGlwdTJfaWNfcHJwZW5jIGJvdW5kCj4gWyAgICAzLjUxMTMxOF0g
aXB1Ml9pY19wcnB2ZjogUmVnaXN0ZXJlZCBpcHUyX2ljX3BycHZmIGNhcHR1cmUgYXMgL2Rldi92
aWRlbzMKPiBbICAgIDMuNTE4MzM1XSBpbXgtbWVkaWE6IHN1YmRldiBpcHUyX2ljX3BycHZmIGJv
dW5kCj4gWyAgICAzLjUyNDYyMl0gaXB1MV9jc2kwOiBSZWdpc3RlcmVkIGlwdTFfY3NpMCBjYXB0
dXJlIGFzIC9kZXYvdmlkZW80Cj4gWyAgICAzLjUzMDkwMl0gaW14LW1lZGlhOiBzdWJkZXYgaXB1
MV9jc2kwIGJvdW5kCj4gWyAgICAzLjUzNTQ1M10gKioqKioqKioqKioqIHBpbmN0cmwgZmFpbGVk
Cj4gWyAgICAzLjUzOTY4NF0gKioqKioqKioqKioqIHBpbmN0cmwgZmFpbGVkCj4gWyAgICAzLjU0
MzY3N10gKioqKioqKioqKioqIHBpbmN0cmwgZmFpbGVkCj4gWyAgICAzLjU0ODI3OF0gaW14LW1l
ZGlhOiBzdWJkZXYgaW14Ni1taXBpLWNzaTIgYm91bmQKPiAKPiBTbyBpbXhfY3NpX3Byb2JlKCkg
ZG9lcyBub3Qgc3VjY2VlZCBhbnltb3JlIHNpbmNlCj4gZGV2bV9waW5jdHJsX2dldF9zZWxlY3Rf
ZGVmYXVsdCgpIGFsd2F5cyBmYWlscy4KPiAKPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIGNv
bW1lbnRzIHRoYXQgZXhwbGFpbiB0aGUgbmVlZCBmb3IgcGluY3RybAo+IGhhbmRsaW5nIGluc2lk
ZSB0aGUgZHJpdmVyLgoKT2gsIHRoaXMgb25seSB3b3JrcyBmb3IgY3NpIHBvcnRzIHRoYXQgaGF2
ZSBwaW5jdHJsIGluIHRoZWlyIGNzaSBwb3J0Cm5vZGUsIGxpa2U6CgomaXB1MV9jc2kwIHsKwqDC
oMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CsKgwqDCoMKgwqDCoMKgwqBw
aW5jdHJsLTAgPSA8JnBpbmN0cmxfaXB1MV9jc2kwPjsKfTsKCkZvciBhbGwgb3RoZXIgcG9ydHMg
aXQgZmFpbHMuIFNvIHdlIGluZGVlZCBoYXZlIHRvIHNpbGVudGx5IGNvbnRpbnVlIGlmCnRoZXJl
IGlzIG5vIHBpbmN0cmwgaW4gdGhlIHBvcnQgbm9kZS4KCj4gQ2FuJ3Qgd2UganVzdCBnZXQgcmlk
IG9mIGl0IGxpa2UgdGhpcz8KCnBpbmN0cmwgd291bGQgaGF2ZSB0byBiZSBtb3ZlZCBvdXQgb2Yg
dGhlIGNzaSBwb3J0IG5vZGVzLCBmb3IgZXhhbXBsZQppbnRvIHRoZWlyIHBhcmVudCBpcHUgbm9k
ZXMsIG9yIG1heWJlIG1vcmUgY29ycmVjdGx5LCBpbnRvIHRoZSB2aWRlbyBtdXgKbm9kZXMgaW4g
ZWFjaCBkZXZpY2UgdHJlZS4KCnJlZ2FyZHMKUGhpbGlwcAo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGlu
dXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
