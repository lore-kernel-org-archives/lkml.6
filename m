Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2662951-1518737502-2-15064397799525773296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso8859-7'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518737501; b=FoccrsPYMzmxxqC+qllzZcYrcg9IdmuBAU9bZjqEEkvTBRN
    GElVxcFsZBgsHHHBMDqT2dpKbHbHFJ0JzBWzMi3DRLfPSRhP6BjljVRxbD1d6+pY
    +LsrWscracEJ22XHMezyXGkHObl8fp78pa41NAhq5j2OZQCbhmBHY8B1sh7JEOh1
    kG19EBij6e6x9XH8Lp66gyO/Cfa9i8Aslkiisw+w8GfZaZFQHIVirYStit69jPDJ
    bQnJbzYPhwPcNPiqa6JNDUDDMkFbZ1ZLZ5bgkQwucU1Bg8SIxZ3gIyNNcqvfWz81
    04wm5kW9bHKO07AG0WlhkW4OWlCasITK7nhSq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518737501; bh=RcTKGMCN7tAac3YXRaYuaPJnR+hRlYoKtcWnudmY3Jk=; b=u
    4HZcGN9Qc2Yjjh68nDVCCUGIBqlUNx/mksPNxujOAqZYE09CuTwuxgm7KQ4AZPcB
    q5zm8hb+KAVSZQ1R9+Wp0xUTf0n8EorX1UJWLdVwJc9SW8Vu0RzYuC2OuTtQJx5j
    fS+3F5Eirx23unocuxHmdbXIu9bpLMb8pzZf9bmBfrgTDnmKdznuav9W+x3/HLbI
    zRwqsjwcsZDGhzXQp1NE4/6IsmDAYLCX4UsfERGNeNvd7QhPVdKa0lzDSOLszKAZ
    c3cPUEV13cpgXn5FSflDLG8vLfwP4af6vPL1dSfuBbwVg1UcxfSqKDjtMYWaPcvj
    Y54bAX0XH/p38pQiXngow==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i0wKH3Ln;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i0wKH3Ln;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2248cxKfFTHx5uUISP6n5F8lWLJtV9eQEqBkuNr1Wt8jzG2bCLtK+fdY1RXX4JjxPsuAGhPOuQ==
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
To: Liam Mark <lmark@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
 <20180212065620.iqlzczhqzlrmel5n@mwanda>
 <alpine.DEB.2.02.1802121319370.2345@lmark-linux.qualcomm.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9aa626cf-c122-55af-0c95-a9e9c12c6f19@redhat.com>
Date: Thu, 15 Feb 2018 15:31:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1802121319370.2345@lmark-linux.qualcomm.com>
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
Cc: devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="iso8859-7"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDIvMTIvMjAxOCAwMToyNSBQTSwgTGlhbSBNYXJrIHdyb3RlOgo+IAo+IE9uIE1vbiwgMTIg
RmViIDIwMTgsIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gCj4+IE9uIEZyaSwgRmViIDA5LCAyMDE4
IGF0IDEwOjE2OjU2UE0gLTA4MDAsIExpYW0gTWFyayB3cm90ZToKPj4+IEZpeCB0aGUgZHVwX3Nn
X3RhYmxlIGZ1bmN0aW9uIHRvIGluaXRpYWxpemUgdGhlIGRtYV9hZGRyZXNzIG9mIHRoZSBuZXcK
Pj4+IHNnIGxpc3QgZW50cmllcyBpbnN0ZWFkIG9mIHRoZSBzb3VyY2UgZG1hX2FkZHJlc3MgZW50
cmllcy4KPj4+Cj4+PiBGaXhlczogMTdmZDI4M2YzODcwICgic3RhZ2luZzogYW5kcm9pZDogaW9u
OiBEdXBsaWNhdGUgc2dfdGFibGUiKQo+Pj4gU2lnbmVkLW9mZi1ieTogTGlhbSBNYXJrIDxsbWFy
a0Bjb2RlYXVyb3JhLm9yZz4KPj4KPj4gSG93IGRpZCB5b3UgZmluZCB0aGlzIGJ1Zz8gIFdoYXQg
YXJlIHRoZSB1c2VyIHZpc2libGUgZWZmZWN0cyBvZiB0aGlzCj4+IGJ1Zz8gIEknbSBwcm9iYWJs
eSBnb2luZyB0byBhc2sgeW91IHRvIHNlbmQgYSB2MiBwYXRjaCB3aXRoIGEgbmV3Cj4+IGNoYW5n
ZWxvZyBkZXBlbmRpbmcgb24gdGhlIGFuc3dlcnMgdG8gdGhlc2UgcXVlc3Rpb25zLgo+IAo+IEkg
bm90aWNlZCB0aGUgYnVnIHdoZW4gcmVhZGluZyB0aHJvdWdoIHRoZSBjb2RlLCBJIGhhdmVuonQg
c2VlbiBhbnkKPiB2aXNpYmxlIGVmZmVjdHMgb2YgdGhpcyBidWcuCj4gCj4gIEZyb20gbG9va2lu
ZyBhdCB0aGUgY29kZSBJIGRvbqJ0IHNlZSBhbnkgb2J2aW91cyB3YXlzIHRoYXQgdGhpcyBidWcg
d291bGQKPiBpbnRyb2R1Y2UgYW55IGlzc3VlcyB3aXRoIHRoZSBjdXJyZW50IGNvZGUgYmFzZS4K
PiAKPiBMaWFtCj4gCgpHaXZlbiB0aGUgd2F5IHdlIGR1cGxpY2F0ZSB0aGUgc2dfbGlzdCB0aGlz
IHNob3VsZCBiZSBoYXJtbGVzcyBidXQgeW91CmFyZSByaWdodCBpdCdzIGNsZWFuZXIgaWYgd2Ug
aW5pdGlhbGl6ZSB0aGUgbmV3IGxpc3QuIFlvdSBjYW4gYWRkIG15CkFjayB3aGVuIHlvdSB1cGRh
dGUgd2l0aCBhIG5ldyBjaGFuZ2UgbG9nIGNsYXJpZnlpbmcgdGhpcy4KClRoYW5rcywKTGF1cmEK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFp
bGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5s
aW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
