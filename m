Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2365247-1517958685-2-9119733323285556757
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517958685; b=FQ8fzBFjeQz8gl4ayNnVao8aCXS2bW+jfLzvOf1uAWvUF/K
    CzUn4wHdlSecj9mXyguQC39d3VIXsVWZRw6BLdo/779vJu7ISBM16TQxSENpoW/n
    yuWmTqu2KyzsRUhBafLxkylqb1kh6BoOV/jZ2bgyLbPCXSGyFc7JPY1DYBX4MfeT
    Fugx0FqihH208nwuOtgfVgjmIMxmdtnHUiFb4ihZDKRWRaiVXCLeOtjubnUfAbz6
    5PTnREQeKPut1GKmgfBg6ZVVLNi5NgSqD5bnG2hQdomjjJmUb5Pnb6vLvx0R2HY6
    lkzc3sOay3eh6CHwBQA1P4n+J9BxMyKqZE/7Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:references:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517958685; bh=xyiq6aFAyS3u0WIddWQPZZyga96PjtLPuJ09/PrrkFs=; b=A
    QuFhXruYmEupevUK9lUVktR32k6JDPPCyYB7/dvTINRspRbxp7r38rm9uiWLoUyv
    RetPRTkNAHmeTg+ejp9XUFYzYQ5ZyLna66a8NS/fFY1xWho5Sg/wyOfimxnU6K+K
    b0wSDvN0ad9x7xJAVdzEZmBh/QQX1IhxPCHnh6L+cocotrBE82Zz46r+f9iEF+cC
    mdHXJypIMYDNTEaJbLIIfoE2HHnp9do05Zm7/+L4u+VEVFbduw3lfDvv+cQaCa6D
    zZAIRADLdbCbgq85mNwBr47O7qaCJQ8u1gM4Jj6A/hOPTGzAz7R1vWIElCiDLZqa
    U5WIi7EGBVDjvN0soQXCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gp0Lo5ht;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gp0Lo5ht;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225DVbwkJSbKpBv05WYuV+JyUcxfmgAg1Jxfb+Xx5pcPSu8hD6tbQN+sNFF8fgG11pPLkOnPgg==
Subject: Re: [PATCH 1/2] staging: android: ion: Remove dead code in
 ion_page_pool_free
From: Laura Abbott <labbott@redhat.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
References: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
 <6286ae0a-f439-3477-91bb-8df0e454b98e@redhat.com>
Message-ID: <a8c0aec1-5e90-ccbf-01bb-bb6d12281035@redhat.com>
Date: Tue, 6 Feb 2018 15:11:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <6286ae0a-f439-3477-91bb-8df0e454b98e@redhat.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDIvMDYvMjAxOCAwMzoxMCBQTSwgTGF1cmEgQWJib3R0IHdyb3RlOgo+IE9uIDAyLzA0LzIw
MTggMDc6MjYgUE0sIFlpc2hlbmcgWGllIHdyb3RlOgo+PiBpb25fcGFnZV9wb29sX2FkZCB3aWxs
IGFsd2F5cyByZXR1cm4gMCwgaG93ZXZlciBpb25fcGFnZV9wb29sX2ZyZWUgd2lsbAo+PiBjYWxs
IGlvbl9wYWdlX3Bvb2xfZnJlZV9wYWdlcyB3aGVuIGlvbl9wYWdlX3Bvb2xfYWRkJ3MgcmV0dXJu
IHZhbHVlIGlzCj4+IG5vdCAwLCBzbyBpdCBpcyBhIGRlYWQgY29kZSB3aGljaCBjYW4gYmUgcmVt
b3ZlZC4KPj4KPiAKPiBDYW4geW91IGNsZWFuIHVwIGlvbl9wYWdlX3Bvb2xfYWRkIHRvIGJlIGEg
dm9pZCByZXR1cm4gYXMgd2VsbD8KPiBObyBzZW5zZSBpbiBoYXZpbmcgaXQganVzdCBhbHdheXMg
cmV0dXJuIDAuCj4gCgpOZXZlcm1pbmQsIGp1c3Qgc2F3IHRoZSBmb2xsb3cgdXAgcGF0Y2guIEJv
dGggb2YgdGhlbToKCkFja2VkLWJ5OiBMYXVyYSBBYmJvdHQgPGxhYmJvdHRAcmVkaGF0LmNvbT4K
Cj4+IFNpZ25lZC1vZmYtYnk6IFlpc2hlbmcgWGllIDx4aWV5aXNoZW5nMUBodWF3ZWkuY29tPgo+
PiAtLS0KPj4gwqAgZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvaW9uL2lvbl9wYWdlX3Bvb2wuYyB8
IDYgKy0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9pb25f
cGFnZV9wb29sLmMgYi9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC9pb24vaW9uX3BhZ2VfcG9vbC5j
Cj4+IGluZGV4IDQ0NTJlMjguLjE1MDYyNmYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvc3RhZ2lu
Zy9hbmRyb2lkL2lvbi9pb25fcGFnZV9wb29sLmMKPj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2Fu
ZHJvaWQvaW9uL2lvbl9wYWdlX3Bvb2wuYwo+PiBAQCAtNzksMTMgKzc5LDkgQEAgc3RydWN0IHBh
Z2UgKmlvbl9wYWdlX3Bvb2xfYWxsb2Moc3RydWN0IGlvbl9wYWdlX3Bvb2wgKnBvb2wpCj4+IMKg
IHZvaWQgaW9uX3BhZ2VfcG9vbF9mcmVlKHN0cnVjdCBpb25fcGFnZV9wb29sICpwb29sLCBzdHJ1
Y3QgcGFnZSAqcGFnZSkKPj4gwqAgewo+PiAtwqDCoMKgIGludCByZXQ7Cj4+IC0KPj4gwqDCoMKg
wqDCoCBCVUdfT04ocG9vbC0+b3JkZXIgIT0gY29tcG91bmRfb3JkZXIocGFnZSkpOwo+PiAtwqDC
oMKgIHJldCA9IGlvbl9wYWdlX3Bvb2xfYWRkKHBvb2wsIHBhZ2UpOwo+PiAtwqDCoMKgIGlmIChy
ZXQpCj4+IC3CoMKgwqDCoMKgwqDCoCBpb25fcGFnZV9wb29sX2ZyZWVfcGFnZXMocG9vbCwgcGFn
ZSk7Cj4+ICvCoMKgwqAgaW9uX3BhZ2VfcG9vbF9hZGQocG9vbCwgcGFnZSk7Cj4+IMKgIH0KPj4g
wqAgc3RhdGljIGludCBpb25fcGFnZV9wb29sX3RvdGFsKHN0cnVjdCBpb25fcGFnZV9wb29sICpw
b29sLCBib29sIGhpZ2gpCj4+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0
Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcml2ZXJkZXYtZGV2ZWwK
