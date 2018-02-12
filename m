Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2398327-1518471581-2-12391410084794833030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518471580; b=fg5UfJwELwYHb7CzHaQQ4UFvjc/qWV3I2D5camGq+zofTUC
    R3CQFjmlB4bP6q9fHcXrgi4TPVZdkh5uCU40nttQ10VgPRohQPko1dHbr6A4fYWM
    WXle1ElfLLZoa3TNVQen2xC/plKWoeEEE3FdbWNbNov1JralDVhmWVi+3ERHJHqO
    ptdECtLWY7jg4iKXbSOIWLje5rnfvcuBB0pLmQtN0oOHn4dQAB23nMciUinxS+/s
    RzO7XPH1CL7yaEvh1TW8ehadVH5hvkQjCOsZDXyJ+uWBdWQTitV21lx0VRhJdq3V
    dVWsD5AojQ4uh+J4/2jVxZj7efruWWmHK7R5ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518471580; bh=y
    jlePSoonV6jC2iRFnhD9im4LVLEWwKT43M97usH8hU=; b=HHvt9vy/SqJ2Wadr3
    oXyaTp2Anf8UwPGRqT+hn5UQRYcAjS6UBEPYRRUoWJG2t7JiLZYWiQF+LvClxNeH
    gtGvIVYoMvbv1wI/DN92lrBVMuNfEdQ7MHr/muLAQnL0YfQtGTNSMg1Xw+ignho8
    2kEJ8PiAuGhfKPYPBxDJgj0nnkNwG7aogyHhxlpOeY+4YrB+qGoF48c8W9cWEFtt
    2U5y6RWvvNrr/5ZwWqHrY1Rfq1OC62QCqHwBlFURl1t8Ei6O/NTpIDT080DkxQrW
    J6X0sKZ/8XnXfhN8H/LhKzDpRAkNwlzDrL2KDSVvf5OwoEUs3jHsTP+6cjIazSlS
    wWn+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000"; d="scan'208";a="26769653"
Subject: Re: [PATCH] staging: android: ion: Add requested allocation alignment
To: Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, devel@driverdev.osuosl.org
References: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
 <ae413008-6c8b-5e53-9251-d11f4ae9713a@redhat.com>
 <8284b2ba-a532-23fd-4c52-7ac556d63918@intel.com>
 <ed842c91-4c4c-7dc0-3957-7e2684e24e32@redhat.com>
 <8eb1f6c9-e08d-c6a5-934a-c7e7873d79f2@intel.com>
 <de9c0071-c45b-608c-67ab-015b284a6082@redhat.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <f1b008cc-b94d-2ab1-b618-7b6b13f9298a@intel.com>
Date: Mon, 12 Feb 2018 23:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <de9c0071-c45b-608c-67ab-015b284a6082@redhat.com>
Content-Language: en-US
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CgpPbiAwMi8xMi8yMDE4IDEwOjQ2IFBNLCBMYXVyYSBBYmJvdHQgd3JvdGU6Cj4gT24gMDIvMTIv
MjAxOCAxMjoyMiBQTSwgQWxleGV5IFNraWRhbm92IHdyb3RlOgo+Pgo+Pgo+PiBPbiAwMi8xMi8y
MDE4IDA5OjUyIFBNLCBMYXVyYSBBYmJvdHQgd3JvdGU6Cj4+PiBPbiAwMi8xMi8yMDE4IDExOjEx
IEFNLCBBbGV4ZXkgU2tpZGFub3Ygd3JvdGU6Cj4+Pj4KPj4+PiBPbiAwMi8xMi8yMDE4IDA4OjQy
IFBNLCBMYXVyYSBBYmJvdHQgd3JvdGU6Cj4+Pj4+IE9uIDAyLzEwLzIwMTggMDI6MTcgQU0sIEFs
ZXhleSBTa2lkYW5vdiB3cm90ZToKPj4+Pj4+IEN1cnJlbnQgaW9uIGRlZmluZWQgYWxsb2NhdGlv
biBpb2N0bCBkb2Vzbid0IGFsbG93IHRvIHNwZWNpZnkgdGhlCj4+Pj4+PiByZXF1ZXN0ZWQKPj4+
Pj4+IGFsbG9jYXRpb24gYWxpZ25tZW50LiBDTUEgaGVhcCBhbGxvY2F0ZXMgYnVmZmVycyBhbGln
bmVkIG9uIGJ1ZmZlcgo+Pj4+Pj4gc2l6ZQo+Pj4+Pj4gcGFnZSBvcmRlci4KPj4+Pj4+Cj4+Pj4+
PiBTb21ldGltZXMsIHRoZSBhbGlnbm1lbnQgcmVxdWlyZW1lbnQgaXMgbGVzcyByZXN0cmljdGl2
ZS4gSW4gc3VjaAo+Pj4+Pj4gY2FzZXMsCj4+Pj4+PiBwcm92aWRpbmcgc3BlY2lmaWMgYWxpZ25t
ZW50IG1heSByZWR1Y2UgdGhlIGV4dGVybmFsIG1lbW9yeQo+Pj4+Pj4gZnJhZ21lbnRhdGlvbgo+
Pj4+Pj4gYW5kIGluIHNvbWUgY2FzZXMgaXQgbWF5IGF2b2lkIHRoZSBhbGxvY2F0aW9uIHJlcXVl
c3QgZmFpbHVyZS4KPj4+Pj4+Cj4+Pj4+IEkgcmVhbGx5IGRvIG5vdCB3YW50IHRvIGJyaW5nIHRo
aXMgYmFjayBhcyBwYXJ0IG9mIHRoZSByZWd1bGFyCj4+Pj4+IEFCSS4KPj4+PiBZZXMsIEkga25v
dyBpdCB3YXMgcmVtb3ZlZCBpbiA0LjEyLgo+Pj4+IEhhdmluZyBhbiBhbGlnbm1lbnQgcGFyYW1l
dGVyIHRoYXQgZ2V0cyB1c2VkIGZvciBleGFjdGx5Cj4+Pj4+IG9uZSBoZWFwIG9ubHkgbGVhZHMg
dG8gY29uZnVzaW9uICh3aGljaCBpcyB3aHkgaXQgd2FzIHJlbW92ZWQKPj4+Pj4gZnJvbSB0aGUg
QUJJIGluIHRoZSBmaXJzdCBwbGFjZSkuCj4+Pj4gWW91IGFyZSBjb3JyZWN0IHJlZ2FyZGluZyB0
aGUgQ01BIGhlYXAuIEJ1dCwgcHJvYmFibHkgaXQgbWF5IGJlIHVzZWQgYnkKPj4+PiBjdXN0b20g
aGVhcCBhcyB3ZWxsLgo+Pj4KPj4+IEkgY2FuIHRoaW5rIG9mIGEgbG90IG9mIGluc3RhbmNlcyB3
aGVyZSBpdCBjb3VsZCBiZSB1c2VkIGJ1dAo+Pj4gdWx0aW1hdGVseSB0aGVyZSBuZWVkcyB0byBi
ZSBhbiBhY3R1YWwgaW4ga2VybmVsIHVzZXIgd2hvIHdhbnRzCj4+PiBpdC4KPj4+Cj4+Pj4+IFRo
ZSBhbGlnbm1lbnQgY2FtZSBmcm9tIHRoZSBiZWhhdmlvciBvZiB0aGUgRE1BIEFQSXMuIERvIHlv
dQo+Pj4+PiBhY3R1YWxseSBuZWVkIHRvIHNwZWNpZnkgYW55IGFsaWdubWVudCBmcm9tIHVzZXJz
cGFjZSBvciBkbwo+Pj4+PiB5b3Ugb25seSBuZWVkIHBhZ2Ugc2l6ZT8KPj4+PiBZZXMuIElmIENN
QSBnaXZlcyBpdCBmb3IgZnJlZSwgSSB3b3VsZCBzdWdnZXN0IHRvIGxldCB0aGUgaW9uIHVzZXIg
dG8KPj4+PiBkZWNpZGUKPj4+Cj4+PiBJJ20gcmVhbGx5IG5vdCBjb252aW5jZWQgY2hhbmdpbmcg
dGhlIEFCSSB5ZXQgYWdhaW4ganVzdCB0byBsZXQKPj4+IHRoZSB1c2VyIGRlY2lkZSBpcyBhY3R1
YWxseSB3b3J0aCBpdC4gSWYgd2UgY2FuIG1hbmFnZSBpdCwgSSdkCj4+PiBtdWNoIHJhdGhlciBz
ZWUgYSBwcm9wb3NhbCB0aGF0IGRvZXNuJ3QgY2hhbmdlIHRoZSBBQkkuCj4+IEkgZGlkbid0IGFj
dHVhbGx5IGNoYW5nZSB0aGUgQUJJIC0gSSBqdXN0IHVzZSB0aGUgInVudXNlZCIgbWVtYmVyOgo+
PiBzdHJ1Y3QgaW9uX2FsbG9jYXRpb25fZGF0YSB7Cj4+IEBAIC04MCw3ICs3OSw3IEBAIHN0cnVj
dCBpb25fYWxsb2NhdGlvbl9kYXRhIHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBfX3UzMiBoZWFwX2lk
X21hc2s7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgX191MzIgZmxhZ3M7Cj4+IMKgwqDCoMKgwqDCoMKg
wqAgX191MzIgZmQ7Cj4+IC3CoMKgwqDCoMKgwqAgX191MzIgdW51c2VkOwo+PiArwqDCoMKgwqDC
oMKgIF9fdTMyIGFsaWduOwo+PiDCoCB9Owo+Pgo+IAo+IFNvbWV0aGluZyB0aGF0IHdhcyBwcmV2
aW91c2x5IHVudXNlZCBpcyBub3cgYmVpbmcgdXNlZC4gVGhhdCdzIGEgY2hhbmdlCj4gaW4gaG93
IHRoZSBzdHJ1Y3R1cmUgaXMgaW50ZXJwcmV0ZWQgd2hpY2ggaXMgYW4gQUJJIGNoYW5nZSwgZXNw
ZWNpYWxseQo+IHNpbmNlIHdlIGhhdmVuJ3QgYmVlbiBjaGVja2luZyB0aGF0IHRoZSBfX3VudXNl
ZCBmaWVsZCBpcyBzZXQKPiB0byAwLgpZZXMgeW91IGFyZSBjb3JyZWN0LiBJIGp1c3QgcmVhbGl6
ZWQgdGhhdCBpdCBpc24ndCBldmVuIGJhY2t3YXJkCmNvbXBhdGlibGUuCj4gCj4+IEFzIGFuIGFs
dGVybmF0aXZlLCBJIG1heSBhZGQgX191NjQgaGVhcF9zcGVjaWZpY19wYXJhbSAtIGJ1dCB0aGlz
IHdpbGwKPj4gY2hhbmdlIHRoZSBBQkkuIEJ1dCwgcHJvYmFibHkgaXQgbWFrZXMgdGhlIEFCSSBt
b3JlIGdlbmVyaWM/Cj4gCj4gV2h5IGRvZXMgdGhlIEFCSSBuZWVkIHRvIGJlIG1vcmUgZ2VuZXJp
Yz8gSWYgd2UgY2hhbmdlIHRoZSBBQkkKPiB3ZSdyZSBzdHVjayB3aXRoIGl0IGFuZCBJJ2QgbGlr
ZSB0byBhcHByb2FjaCBpdCBhcyB0aGUgdmVyeSBsYXN0Cj4gcmVzb3J0Lgo+IAo+IFRoYW5rcywK
PiBMYXVyYQpJdCBzZWVtcywgdGhhdCB0aGVyZSBpcyBubyB3YXkgdG8gZG8gaXQgd2l0aG91dCBz
b21lIEFCSSBjaGFuZ2U/CgpUaGFua3MsCkFsZXhleQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2
ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
