Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3426895-1522010683-2-10007305336099156527
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
    t=1522010683; b=MkXevZw0rIG5h0hdBL0s4Nq72F885sO2y/8Vpdi/hqsAE3o
    3zTeWNSscIlQv3kWU325PQrIGAv8TMnv3mpOriXe6OIqEkcn7HfaIwdGK6Gld8wq
    qLGt9vICfc9mnMQhkeDUR52YlWqk02nWKxLl5iQbXMWDarU/K+jLK8/2rrmnGUjy
    BgpYdOel7DRnacW4gV5ZmuKQv8y1Asj1TQrUrTQRYkwLHJnhdz2h2twI8PLuHaFy
    XDFFevknratzX+feS0ma10D3IvkQNG2Iu6ElqxeChOM5ChcsthY41baOGt5H+6Gc
    uvoe2ZRHzuB6KBE7DmwwAb4T2ZIWUnSteR8F1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522010683; bh=G
    Z06HyW1sKiETwWJJcRjWVhplQzE/JXjmUTw/Fyf3N0=; b=ArOOdMdSm4RunMxk2
    pTBd5mZr84yezwoq6f6hdARCwJDPZGsOFqdecxXpxQgQB7TgIfK2rvZvkRAw7Huf
    3r3hR130Q938bukifYHo/yxq/ndhNJvjP+f7pSJyQ9hAlgV/fvWXWHgPhku2Mxr9
    1OwMv+s9JH9Y43KDJyfEw57fm2b8Vb02eSfNAqq9EBtsEXJJCqSqzMZROINjaZDx
    PvOBPgrPx6pi//pdDAKDC4Igc8kRkIyeaHDoMYZlcbmdMWqrE0u4XM8sgICWcl8/
    gZxG7HIemoGxFxdmKb0cZUq3scdR2AeuXWv2TB0rS18tjcjUMLhap8cSE6WSiADn
    /+61A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q4XkwcwS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R3HUJdg0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q4XkwcwS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R3HUJdg0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+B4FD5VbQV8yr0kNitZhcy0AKG6lZd84Uw8/PHVEGbVyXF380/fJx3yvNF24WaQLmb0JfHuw==
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180325174401.43310fc1@archlinux>
Date: Sun, 25 Mar 2018 13:44:30 -0700
Message-Id: <D08F528D-0AC8-4D39-80C4-6DDAA50AF943@gmail.com>
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

PiAKPiBPbiBNYXIgMjUsIDIwMTgsIGF0IDk6NDQgQU0sIEpvbmF0aGFuIENhbWVyb24gPGppYzIz
QGtlcm5lbC5vcmc+IHdyb3RlOgo+IAo+IE9uIFNhdCwgMjQgTWFyIDIwMTggMTY6MDY6MTcgLTA3
MDAKPiBKb2huIFN5bmUgPGpvaG4zOTA5QGdtYWlsLmNvbT4gd3JvdGU6Cj4gCj4gVGhpcyB0aHJl
YWQgaXMgYmVjb21pbmcgdW5tYW5hZ2VhYmxlIHNvIEkgYW0gY3JvcHBpbmcgdGhpcyBkb3duIHRv
IGp1c3QKPiB0aGUgcXVlc3Rpb25zIHRoYXQgcmVtYWluIG9wZW4uCj4gCj4+Pj4gUHJvYmFibHkg
ZWFzaWVyIHRvIGNvcHkgYW5kIHBhc3RlIHRoaXMgdGFibGUgaW50byBhIHNwcmVhZHNoZWV0LiBM
ZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhbnl0aGluZyBJIGdvdCB3cm9uZy4gVGhhbmsgeW91IGFn
YWluIGZvciBhbGwgeW91ciBoZWxwLiAgCj4+PiBZZWFoLCB3ZSBuZWVkIHRvIHNocmluayB0aGlz
IGlmIHdlIGRvIGl0IGFnYWluLiAgCj4+IEnigJlsbCBzZW5kIGFuIHVwZGF0ZWQgY29weSBhZnRl
ciB0aGlzIGUtbWFpbC4gQ2FuIHlvdSBhY2NlcHQgYSBzcHJlYWRzaGVldCAKPj4gYXR0YWNobWVu
dCBvciBhIENTViBmaWxlPwo+IFdlIG5lZWQgdG8ga2VlcCB0aGUgZGlzY3Vzc2lvbiB2aXNpYmxl
IG9uIGxpc3Qgc28gaXQgbmVlZHMgdG8gc3RheSBpbgo+IHBsYWluIHRleHQuICBKdXN0IG5lZWQg
dG8gZHJvcCBhbnkgY29sdW1ucyB3ZSBhcmVuJ3QgY2FyaW5nIGFib3V0IHRvIG1ha2UKPiBpdCBl
YXNpZXIgdG8gcmVhZC4KRG9uZQo+Pj4gCj4gLi4uCj4+Pj4gMHg0MzlDCUNWQVJPUwlpbl9wb3dl
cnJlYWN0aXZlMF9waGFzZUNfb2Zmc2V0CQlpbglwb3dlcnJlYWN0aXZlCTAJcGhhc2VDCW9mZnNl
dAlSL1cJMjQJMzIgWlBTRQlTCTB4MDAwMDAwCVBoYXNlIEMgdG90YWwgcmVhY3RpdmUgcG93ZXIg
b2Zmc2V0IGFkanVzdCAoQURFNzg1OCwgQURFNzg2OCwgYW5kIEFERTc4NzgpLgo+Pj4+IDB4NDM5
RAlBRldHQUlOCWluX3Bvd2VyMF9waGFzZUFfZnVuZGFtZW50YWxfc2NhbGUJCWluCXBvd2VyCTAJ
cGhhc2VBX2Z1bmRhbWVudGFsCXNjYWxlCVIvVwkyNAkzMiBaUFNFCVMJMHgwMDAwMDAJUGhhc2Ug
QSBmdW5kYW1lbnRhbCBhY3RpdmUgcG93ZXIgZ2FpbiBhZGp1c3QuIExvY2F0aW9uIHJlc2VydmVk
IGZvciBBREU3ODU0LCBBREU3ODU4LCBhbmQgQURFNzg2OC4gIAo+Pj4gSG1tLiBGdW5kYW1lbnRh
bCBuZWVkcyB0byBiZSByZXByZXNlbnRlZCB1c2luZyBhIHNlcGFyYXRlIGNoYW5uZWwgaW5kZXgK
Pj4+IGFuZCBkZXNjcmlwdGlvbiBvZiB0aGUgZnJlcXVlbmN5IGZpbHRlcnMgYXBwbGllZC4gIFRo
YXQgc2hvdWxkIG1hcCBpdAo+Pj4gYSBnZW5lcmljIHdheS4gIAo+PiBIb3cgZG8gSSBkbyB0aGlz
Pwo+IERlZmluZSBhZGRpdGlvbmFsIGNoYW5uZWxzIHdpdGggZGlmZmVyZW50IGluZGV4IGFuZCBm
b3IgdGhlbQo+IHVzZSB0aGUgdGhlIGluZm9tYXNrIGVsZW1lbnRzCj4gSUlPX0NIQU5fSU5GT19M
T1dfUEFTU19GSUxURVJfM0RCX0ZSRVFVRU5DWSwKPiBJSU9fQ0hBTl9JTkZPX0hJR0hfUEFTU19G
SUxURVJfM0RCX0ZSRVFVRU5DWQo+IGFuZCBwcm92aWRlIHN1aXRhYmxlIHZhbHVlcyBmcm9tIHRo
ZSByZWFkX3JhdyBjYWxsYmFja3MgZm9yIHRoYXQKPiBjaGFubmVsLgo+IAo+IC4uLgo+Pj4+IDB4
NDNDMAlBSVJNUwlpbl9jdXJyZW50MF9waGFzZUFfcm1zCQlpbgljdXJyZW50CTAJcGhhc2VBX3Jt
cwkJUgkyNAkzMiBaUAlTCU4vQTQJUGhhc2UgQSBjdXJyZW50IHJtcyB2YWx1ZS4gIAo+Pj4gaW5f
Y3VycmVudDBfcGhhc2VBX3Jtc19yYXcgYXMgb3RoZXJ3aXNlIHdlIGRvbid0IGtub3cgd2UgbmVl
ZCB0byBhcHBseQo+Pj4gaW5fY3VycmVudDBfcGhhc2VBX3Jtc19zY2FsZSB0byBpdCAob3IgdGhl
IHNoYXJlZCB2YWx1ZSB0aGF0IG1hcHMgdG8gdGhhdCkuICAKPj4gWWVhaCwgdGhpcyBpcyBzdGls
bCBjb25mdXNpb24gdG8gbWUuIFRoaXMgc2hvdWxkIHJlYWQgaW5fY3VycmVudDBfcGhhc2VBX3Jt
c19nYWluIAo+PiBhcyBpdCBkaXJlY3RseSBhZmZlY3RzIHRoZSB2YWx1ZSBpbl9jdXJyZW50MF9w
aGFzZUFfcm1zX3Jhdy4gV2Ugc3RpbGwgaGF2ZSB0byBhcHBseQo+PiBhIHNjYWxlIHZhbHVlIHRv
IHR1cm4gdGhpcyBjcnlwdGljIG51bWJlciBpbnRvIHNvbWV0aGluZyBtZWFuaW5nZnVsLiAKPiBT
byBJJ20gYSBsaXR0bGUgbG9zdC4gV2UgaGF2ZSB2YXJpYWJsZSBnYWluIGZpbmUuCj4gRG9lcyBp
dCBlZmZlY3QgdGhlIG5lY2Vzc2FyeSBzY2FsZSBmYWN0b3IgdG8gZ28gZnJvbSByYXcgdG8gcmVh
bCB2YWx1ZSBvciBub3Q/Clllcwo+IDEpIFllcyBpdCBkb2VzIC0gdGhlbiByb2xsIGl0IGFzIGFw
cHJvcHJpYXRlIGludG8gdGhlIF9zY2FsZSBhdHRyaWJ1dGUuIAo+ICBJdCBzaG91bGQgbm90IGJl
IHNlcGFyYXRlZC4gIFRoaXMgb2Z0ZW4gcmVxdWlyZXMgc29tZSBpbnRlcmVzdGluZyBtYXRocwo+
ICBidXQgaXMgYSBvbmV0aW1lIHRoaW5nIGFzIHRoZSB2YWx1ZSBpc24ndCBjaGFuZ2luZyBkeW5h
bWljYWxseS4KCgo+IAo+IDIpIE5vIGl0IGRvZXNuJ3QgLSB0aGVuIGl0IGlzIGNhbGliZ2FpbiBh
cyBpdCByZXByZXNlbnRzIGEgbmVjZXNzYXJ5Cj4gIHBhcmFtZXRlciB0byBjaGFuZ2UgdGhlIGlu
Y29taW5nIGNpcmN1aXQgdG8gY29tcGVuc2F0ZSBmb3IgZXh0ZXJuYWwgZWZmZWN0cy4KVGhlIGhh
cmR3YXJlZ2FpbiBhbmQgY2FsaWJnYWluIGFyZSBzZXR1cCBvbmx5IG9uY2UgYW5kIGRvIG5vdCB2
YXJ5LgpUaGUgQURFNzg1NCBjYW4gYWNjZXB0IHZhcmlvdXMgaW5wdXQgcmFuZ2VzIHN1Y2ggYXMg
MC0yNTBtViwgMC01ViwgZXRjClRoZSBjYWxpYmdhaW4gaXMgdXNlZCB0byBjb21wZW5zYXRlIGZv
ciB0aGUgaW5hY2N1cmFjaWVzIG9mIHRoZSBzZW5zb3JzCmFuZCB0aGUgdGVybWluYXRpb24gY29t
cG9uZW50cy4gCj4gCj4gSXQgaXMgcG9zc2libGUgeW91IGhhdmUgYSBtaXh0dXJlIG9mIHRoZSB0
d28gYW5kIGhlbmNlIG5lZWQgYm90aCBidXQgdGhhdAo+IGlzIG5vcm1hbGx5IG9ubHkgdGhlIGNh
c2Ugd2l0aCBkZXZpY2VzIHdoZXJlIHRoZSBjYWxpYmdhaW4gaXMgYWJvdXQgZml4aW5nCj4gdGhl
IGZhY3RvcnkgY2FsaWJyYXRpb24uCj4gCj4gLi4uCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZl
cnByb2plY3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
