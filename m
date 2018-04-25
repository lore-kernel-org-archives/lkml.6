Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-976924-1524674680-2-1879405718980434881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524674679; b=hCI1KuCyCNaNbYmyyyBlLt94q8lWBw9krDxtcWZ4y75PVYhrsZ
    /jfvqQkb4AWOR8ynGeil6a+tzx1muxJxYHCs1oH/SsJZHsn02KpDipCM8DmMpDBw
    mAtK4CrX4zTdtY0cAC0Fm8fKWf4wM8AcGreS6JymGGd3BUT5zT7SQ8jGLRsbf26I
    laHVYtnYPPe3cgkbzr2w1xs/gbxZ28hMNw1tK7j8PXmzmYrtPB8II5zSKgTvuLqa
    9TL+LSl9KsJTieNKRCJcVwmNtHE/LzrMkhjQBtFLaY0MrTROwcJCJtWgUZPjSaeJ
    m5lazCL7a3L9zfvUDoQp4XIlSMNAKfgbJmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:references:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1524674679; bh=NjNobt1y87cVYB/IM2DtuLnQ0zONbjIPZXz5158a0xU=; b=p
    tmaESB1LZy/iyFxzD5HOVwNB0PWH+8IG9Gluajk4w6HJ0pXaKBXJ4QwUF4holNYM
    y+jnrqQeTatWGVjKcVvyiMp8yL8UVfd8XJ8+L32hVkjb+jpgy78Dpe7T17jS8p1V
    z/JNlDjjSNNz7IQ5x6eQn8enYnJfO7El2jtIOD7Nzh4AndWyIfh+vgDvUg7BBb1w
    a7DOOAkqzlAqAHTE/JHm8waQEfjySjGgKd+uUyCwm/L/Gs/95bqdE1b1Y8s7eH/E
    nvm6RFG1F2eC5jtxLx/GOpQXvRGQOHFHKOW2BmBU0D2q71Mc+WelIfqIwzH5UZ1K
    gNVfI8xNghCUcrQvGbH/A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LCnTzE7M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gTxaG/vq;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LCnTzE7M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gTxaG/vq;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBaGRYL/ZBYyJIM3BomvNt3yed4ymDT1dXvQQt0FYo0Bt0HdOD1RIFYY64bVHzNT1AFzVQHF1obMjJBszAKYvypWiSXF9G6ROWaeEaVmYKfHKwna7rUO
    Wk7WrDBCNVpFTzrUppa5JCJ+sjZ0SE2BNrd3HkqLpylKeudbCYZK2q/eoLoMn55QpBZcH/n2q9DE0LJEe4IZilNVBPuPjxCVxm4ehr7jrAexJ/y+EePywzK5
    hy/aYnUS41n1874hMdhIsw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=Ati9N12YA0wA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=jhcWdLLKQc5ZSgbHUSYA:9 a=QEXdDO2ut3YA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48SukLyTkOAXn9MEo0yS8fKRAu0krN5qFtIz7k9NMDAKmvLnNLgWlxFuMo6OkkaSGK0MU3djw==
From: Janusz Lisiecki <janusz.lisiecki@gmail.com>
Subject: Re: [PATCH] staging: ks7010: fix ks_wlan_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20180424131824.5164-1-luc.vanoostenryck@gmail.com>
Message-ID: <2203ebe4-63c2-3728-50fa-a30b195d1508@gmail.com>
Date: Wed, 25 Apr 2018 18:44:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131824.5164-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
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
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Quytelda Kahja <quytelda@tamalin.org>,
 SUNIL KALLUR RAMEGOWDA <kallur.sunil@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VyBkbml1IDIwMTgtMDQtMjQgb8KgMTU6MTgsIEx1YyBWYW4gT29zdGVucnljayBwaXN6ZToKPiBU
aGUgbWV0aG9kIG5kb19zdGFydF94bWl0KCkgaXMgZGVmaW5lZCBhcyByZXR1cm5pbmcgYW4gJ25l
dGRldl90eF90JywKPiB3aGljaCBpcyBhIHR5cGVkZWYgZm9yIGFuIGVudW0gdHlwZSwgYnV0IHRo
ZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGlzCj4gZHJpdmVyIHJldHVybnMgYW4gJ2ludCcuCj4KPiBG
aXggdGhpcyBieSByZXR1cm5pbmcgJ25ldGRldl90eF90JyBpbiB0aGlzIGRyaXZlciB0b28uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBMdWMgVmFuIE9vc3RlbnJ5Y2sgPGx1Yy52YW5vb3N0ZW5yeWNrQGdt
YWlsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvc3RhZ2luZy9rczcwMTAva3Nfd2xhbl9uZXQuYyB8
IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcva3M3MDEwL2tzX3dsYW5fbmV0LmMg
Yi9kcml2ZXJzL3N0YWdpbmcva3M3MDEwL2tzX3dsYW5fbmV0LmMKPiBpbmRleCA5MDc4ZTEzYjAu
LjU3NDEyY2FhYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcva3M3MDEwL2tzX3dsYW5f
bmV0LmMKPiArKysgYi9kcml2ZXJzL3N0YWdpbmcva3M3MDEwL2tzX3dsYW5fbmV0LmMKPiBAQCAt
NzEsNyArNzEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGl3X2hhbmRsZXJfZGVmIGtzX3dsYW5f
aGFuZGxlcl9kZWY7Cj4gICAgKi8KPiAgIHN0YXRpYyBpbnQga3Nfd2xhbl9vcGVuKHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYpOwo+ICAgc3RhdGljIHZvaWQga3Nfd2xhbl90eF90aW1lb3V0KHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpOwo+IC1zdGF0aWMgaW50IGtzX3dsYW5fc3RhcnRfeG1pdChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKPiArc3RhdGljIG5ldGRl
dl90eF90IGtzX3dsYW5fc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KTsKPiAgIHN0YXRpYyBpbnQga3Nfd2xhbl9jbG9zZShzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KTsKPiAgIHN0YXRpYyB2b2lkIGtzX3dsYW5fc2V0X211bHRpY2FzdF9saXN0KHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYpOwo+ICAgc3RhdGljIHN0cnVjdCBuZXRfZGV2aWNlX3N0YXRz
ICprc193bGFuX2dldF9zdGF0cyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKPiBAQCAtMjc3Miw3
ICsyNzcyLDcgQEAgdm9pZCBrc193bGFuX3R4X3RpbWVvdXQoc3RydWN0IG5ldF9kZXZpY2UgKmRl
dikKPiAgIH0KPiAgIAo+ICAgc3RhdGljCj4gLWludCBrc193bGFuX3N0YXJ0X3htaXQoc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiArbmV0ZGV2X3R4X3Qga3Nf
d2xhbl9zdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpCj4gICB7Cj4gICAJc3RydWN0IGtzX3dsYW5fcHJpdmF0ZSAqcHJpdiA9IG5ldGRldl9wcml2
KGRldik7Cj4gICAJaW50IHJldDsKTWF5YmUgaW5zaWRlIGtzX3dsYW5fc3RhcnRfeG1pdCwgaW5z
dGVhZCBvZiAicmV0dXJuIDA7IiwgdGhlcmUgc2hvdWxkIGJlIAoicmV0dXJuIE5FVERFVl9UWF9P
SzsiIGFuZCAicmV0dXJuIE5FVERFVl9UWF9CVVNZOyIgb3RoZXJ3aXNlLiBJdCBpcyAKanVzdCBz
dWdnZXN0aW9uLgoKQnIsCkphbnVzeiBMaXNpZWNraQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJp
dmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
