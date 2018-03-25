Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3426895-1522010653-2-7423030622315629798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522010652; b=AKUkkyctFY+64y2R8rFF58CkKii90KEaBzJinHRvMnaB6rk
    POJ3/PlcGBLM/TUEiwViVBiaBxnpq+n4C0yCxyE070n69rEaxRpwRniBqiFjIyZE
    tMyzPCeIi2UapU0mUbXGieZM8zt/u2/KMOIKYcFjPdp76/KvB+d7BPL0rITvgaQd
    MWrtAr9MHtRYuKdsodjDtdRrxMr+Pa+xDqG/rY5//U8PlUM2dOo5bM63xpZzvd7N
    A2IjbnPA1EP4v0M50orhMd8cVUmzxX8SKrjAiZErtppdQVsWor5J/UV8KREOPhuW
    bAw0bqcJW+3HghaTNlrFO1UOO9gs3cu/0IlQzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522010652; bh=t
    R2Q+zqJjQoOn2B92eYaQvBmsL8j0gMlwYhkygI6M6M=; b=KL+iv28VKjmrS/Ska
    l27bKaJkxfq8GfBlBd3FWrUmgCX3Cj6k198/i1tsyuTVgVIh0zJwcivTuJLWfz6r
    wLkOK0NUFGyaUJRLWrwYcZddX4B70vpOB40zk8jDBZilXs0tWPvXFG1B1hJQ79AD
    3Ge5TV+smiIuMwGuV56Hef10b8VwzBDGZBUf57VIOLro4spWW2Op9NFt9Q9Qz6x2
    RMj2CMIaAaKuM2lMVzwEF5u4IcXG1yIzoJDUmq7DGksg7eZl6etVtGkLo54SgCAc
    gpg8z0GUXrfPTz7Gxrtqmd/HWK6MhQsuYFhmUvn/tivs7fn68ss88EnXSkWP+FRJ
    fCYMw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PtNCi3c0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TmKGIUFt;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PtNCi3c0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TmKGIUFt;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs/TXMDmlgEiKr4gdURKdoZ1qgo5aVlq5SzolaftbyF5Vq4TN4sEXP75Oqfbm6Ge7B5p3Wvzw==
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180325174401.43310fc1@archlinux>
Date: Sun, 25 Mar 2018 13:43:58 -0700
Message-Id: <8D03BD37-2985-4648-9CE0-094D8E1BC643@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
 <20180324151829.7d03ad15@archlinux>
 <21395383-9236-4312-AA1A-3378F4E5B0BC@gmail.com>
 <20180325174401.43310fc1@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cj4gT24gTWFyIDI1LCAyMDE4LCBhdCA5OjQ0IEFNLCBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0Br
ZXJuZWwub3JnPiB3cm90ZToKPiAKPiBPbiBTYXQsIDI0IE1hciAyMDE4IDE2OjA2OjE3IC0wNzAw
Cj4gSm9obiBTeW5lIDxqb2huMzkwOUBnbWFpbC5jb20+IHdyb3RlOgo+IAo+IFRoaXMgdGhyZWFk
IGlzIGJlY29taW5nIHVubWFuYWdlYWJsZSBzbyBJIGFtIGNyb3BwaW5nIHRoaXMgZG93biB0byBq
dXN0Cj4gdGhlIHF1ZXN0aW9ucyB0aGF0IHJlbWFpbiBvcGVuLgo+IAo+Pj4+IFByb2JhYmx5IGVh
c2llciB0byBjb3B5IGFuZCBwYXN0ZSB0aGlzIHRhYmxlIGludG8gYSBzcHJlYWRzaGVldC4gTGV0
IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgSSBnb3Qgd3JvbmcuIFRoYW5rIHlvdSBhZ2Fp
biBmb3IgYWxsIHlvdXIgaGVscC4gIAo+Pj4gWWVhaCwgd2UgbmVlZCB0byBzaHJpbmsgdGhpcyBp
ZiB3ZSBkbyBpdCBhZ2Fpbi4gIAo+PiBJ4oCZbGwgc2VuZCBhbiB1cGRhdGVkIGNvcHkgYWZ0ZXIg
dGhpcyBlLW1haWwuIENhbiB5b3UgYWNjZXB0IGEgc3ByZWFkc2hlZXQgCj4+IGF0dGFjaG1lbnQg
b3IgYSBDU1YgZmlsZT8KPiBXZSBuZWVkIHRvIGtlZXAgdGhlIGRpc2N1c3Npb24gdmlzaWJsZSBv
biBsaXN0IHNvIGl0IG5lZWRzIHRvIHN0YXkgaW4KPiBwbGFpbiB0ZXh0LiAgSnVzdCBuZWVkIHRv
IGRyb3AgYW55IGNvbHVtbnMgd2UgYXJlbid0IGNhcmluZyBhYm91dCB0byBtYWtlCj4gaXQgZWFz
aWVyIHRvIHJlYWQuCkRvbmUKPj4+IAo+IC4uLgo+Pj4+IDB4NDM5QwlDVkFST1MJaW5fcG93ZXJy
ZWFjdGl2ZTBfcGhhc2VDX29mZnNldAkJaW4JcG93ZXJyZWFjdGl2ZQkwCXBoYXNlQwlvZmZzZXQJ
Ui9XCTI0CTMyIFpQU0UJUwkweDAwMDAwMAlQaGFzZSBDIHRvdGFsIHJlYWN0aXZlIHBvd2VyIG9m
ZnNldCBhZGp1c3QgKEFERTc4NTgsIEFERTc4NjgsIGFuZCBBREU3ODc4KS4KPj4+PiAweDQzOUQJ
QUZXR0FJTglpbl9wb3dlcjBfcGhhc2VBX2Z1bmRhbWVudGFsX3NjYWxlCQlpbglwb3dlcgkwCXBo
YXNlQV9mdW5kYW1lbnRhbAlzY2FsZQlSL1cJMjQJMzIgWlBTRQlTCTB4MDAwMDAwCVBoYXNlIEEg
ZnVuZGFtZW50YWwgYWN0aXZlIHBvd2VyIGdhaW4gYWRqdXN0LiBMb2NhdGlvbiByZXNlcnZlZCBm
b3IgQURFNzg1NCwgQURFNzg1OCwgYW5kIEFERTc4NjguICAKPj4+IEhtbS4gRnVuZGFtZW50YWwg
bmVlZHMgdG8gYmUgcmVwcmVzZW50ZWQgdXNpbmcgYSBzZXBhcmF0ZSBjaGFubmVsIGluZGV4Cj4+
PiBhbmQgZGVzY3JpcHRpb24gb2YgdGhlIGZyZXF1ZW5jeSBmaWx0ZXJzIGFwcGxpZWQuICBUaGF0
IHNob3VsZCBtYXAgaXQKPj4+IGEgZ2VuZXJpYyB3YXkuICAKPj4gSG93IGRvIEkgZG8gdGhpcz8K
PiBEZWZpbmUgYWRkaXRpb25hbCBjaGFubmVscyB3aXRoIGRpZmZlcmVudCBpbmRleCBhbmQgZm9y
IHRoZW0KPiB1c2UgdGhlIHRoZSBpbmZvbWFzayBlbGVtZW50cwo+IElJT19DSEFOX0lORk9fTE9X
X1BBU1NfRklMVEVSXzNEQl9GUkVRVUVOQ1ksCj4gSUlPX0NIQU5fSU5GT19ISUdIX1BBU1NfRklM
VEVSXzNEQl9GUkVRVUVOQ1kKPiBhbmQgcHJvdmlkZSBzdWl0YWJsZSB2YWx1ZXMgZnJvbSB0aGUg
cmVhZF9yYXcgY2FsbGJhY2tzIGZvciB0aGF0Cj4gY2hhbm5lbC4KPiAKPiAuLi4KPj4+PiAweDQz
QzAJQUlSTVMJaW5fY3VycmVudDBfcGhhc2VBX3JtcwkJaW4JY3VycmVudAkwCXBoYXNlQV9ybXMJ
CVIJMjQJMzIgWlAJUwlOL0E0CVBoYXNlIEEgY3VycmVudCBybXMgdmFsdWUuICAKPj4+IGluX2N1
cnJlbnQwX3BoYXNlQV9ybXNfcmF3IGFzIG90aGVyd2lzZSB3ZSBkb24ndCBrbm93IHdlIG5lZWQg
dG8gYXBwbHkKPj4+IGluX2N1cnJlbnQwX3BoYXNlQV9ybXNfc2NhbGUgdG8gaXQgKG9yIHRoZSBz
aGFyZWQgdmFsdWUgdGhhdCBtYXBzIHRvIHRoYXQpLiAgCj4+IFllYWgsIHRoaXMgaXMgc3RpbGwg
Y29uZnVzaW9uIHRvIG1lLiBUaGlzIHNob3VsZCByZWFkIGluX2N1cnJlbnQwX3BoYXNlQV9ybXNf
Z2FpbiAKPj4gYXMgaXQgZGlyZWN0bHkgYWZmZWN0cyB0aGUgdmFsdWUgaW5fY3VycmVudDBfcGhh
c2VBX3Jtc19yYXcuIFdlIHN0aWxsIGhhdmUgdG8gYXBwbHkKPj4gYSBzY2FsZSB2YWx1ZSB0byB0
dXJuIHRoaXMgY3J5cHRpYyBudW1iZXIgaW50byBzb21ldGhpbmcgbWVhbmluZ2Z1bC4gCj4gU28g
SSdtIGEgbGl0dGxlIGxvc3QuIFdlIGhhdmUgdmFyaWFibGUgZ2FpbiBmaW5lLgo+IERvZXMgaXQg
ZWZmZWN0IHRoZSBuZWNlc3Nhcnkgc2NhbGUgZmFjdG9yIHRvIGdvIGZyb20gcmF3IHRvIHJlYWwg
dmFsdWUgb3Igbm90PwpZZXMKPiAxKSBZZXMgaXQgZG9lcyAtIHRoZW4gcm9sbCBpdCBhcyBhcHBy
b3ByaWF0ZSBpbnRvIHRoZSBfc2NhbGUgYXR0cmlidXRlLiAKPiAgIEl0IHNob3VsZCBub3QgYmUg
c2VwYXJhdGVkLiAgVGhpcyBvZnRlbiByZXF1aXJlcyBzb21lIGludGVyZXN0aW5nIG1hdGhzCj4g
ICBidXQgaXMgYSBvbmV0aW1lIHRoaW5nIGFzIHRoZSB2YWx1ZSBpc24ndCBjaGFuZ2luZyBkeW5h
bWljYWxseS4KCgo+IAo+IDIpIE5vIGl0IGRvZXNuJ3QgLSB0aGVuIGl0IGlzIGNhbGliZ2FpbiBh
cyBpdCByZXByZXNlbnRzIGEgbmVjZXNzYXJ5Cj4gICBwYXJhbWV0ZXIgdG8gY2hhbmdlIHRoZSBp
bmNvbWluZyBjaXJjdWl0IHRvIGNvbXBlbnNhdGUgZm9yIGV4dGVybmFsIGVmZmVjdHMuClRoZSBo
YXJkd2FyZWdhaW4gYW5kIGNhbGliZ2FpbiBhcmUgc2V0dXAgb25seSBvbmNlIGFuZCBkbyBub3Qg
dmFyeS4KVGhlIEFERTc4NTQgY2FuIGFjY2VwdCB2YXJpb3VzIGlucHV0IHJhbmdlcyBzdWNoIGFz
IDAtMjUwbVYsIDAtNVYsIGV0YwpUaGUgY2FsaWJnYWluIGlzIHVzZWQgdG8gY29tcGVuc2F0ZSBm
b3IgdGhlIGluYWNjdXJhY2llcyBvZiB0aGUgc2Vuc29ycwphbmQgdGhlIHRlcm1pbmF0aW9uIGNv
bXBvbmVudHMuIAo+IAo+IEl0IGlzIHBvc3NpYmxlIHlvdSBoYXZlIGEgbWl4dHVyZSBvZiB0aGUg
dHdvIGFuZCBoZW5jZSBuZWVkIGJvdGggYnV0IHRoYXQKPiBpcyBub3JtYWxseSBvbmx5IHRoZSBj
YXNlIHdpdGggZGV2aWNlcyB3aGVyZSB0aGUgY2FsaWJnYWluIGlzIGFib3V0IGZpeGluZwo+IHRo
ZSBmYWN0b3J5IGNhbGlicmF0aW9uLgo+IAo+IC4uLgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJp
dmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
