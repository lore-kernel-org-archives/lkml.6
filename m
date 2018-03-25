Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449035-1522011199-2-13178556102893537147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522011198; b=EY4H3MKHNc2rNc98N3T2vcRCbRnE045STQYzwJ6ght462xB
    bBOTu3kF2eaEIl40uv39/inTZrlRL8iMEchhPVRrjlXO/hJbQxSXO6cLGc8tbpPI
    ObbfvkQqz3Baf0mrrk4JTGtQJZy9LlGgYL4XpAJtejX1ZjyxzZ/YgtStFEvPAwdk
    qfdifvvIOTP8pDe27QptAvaE/b+NOjO0TcEar42ZLIV5SrF1edI6G2SiAB2VMSmQ
    ztEau3Fr3k58QlL/857BCOehXZ12g9Y9aX9BJFl5m61GAbGeoNoZQ6YG8yfbgwdD
    avLI6aTN8oZvlpicYXcp6Ix/ZwGFqJbyX/XtQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522011198; bh=V
    NQpmYnPJOeDLCm7oTZZP+ktAnNnu8NKfcMyLz3pfk8=; b=a64LAzZ0RcmdXVw9m
    Tg4O5E04JHF8IZ69YtcLgAORCQo7Ajp5fEtrw5CPIfgwez9lffgqdeLmKqKAna6w
    SMNAlVoJrHgP9sS8jIQ4XPyQKyRv8Z7Z4fa3ctt0VtfwQHq1MRVQK3FYFCS4i1bb
    8aoDQwOtfxJG6JeyvJdja+5jNPvY7cLaFueqo+jFA/as2Tbuj0k8TcRpio6NWJ0l
    7naw6CK4ntWwj+uaXGH6oul0b+S4J7aPargYXZGbJzqCgg/4bpr77nii2oBzIjPM
    WTwfZWCtWFd1v/pfIMBFSMVwdaKeLyQyUff7auw/xdru3oW4Q1Dd7YeW7kYu5Q8o
    RK/Kg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Qt+00Vh+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hEnVl1LK;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Qt+00Vh+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hEnVl1LK;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs2iLDnJzdfsFTM65vLaSc/ixYqKtY1oO0Rn7rSOIw0VICfAWxwj7B4F2K9xlXBrWCyFYP8rQ==
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180325175430.3f60741f@archlinux>
Date: Sun, 25 Mar 2018 13:53:02 -0700
Message-Id: <DEF2F80D-110C-4A63-8A4D-2354F95BA6D6@gmail.com>
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
 <6490BA61-EF6F-4407-A5A2-26B7E86B0629@gmail.com>
 <20180325175430.3f60741f@archlinux>
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
 Mark Brown <broonie@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cj4gT24gTWFyIDI1LCAyMDE4LCBhdCA5OjU0IEFNLCBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0Br
ZXJuZWwub3JnPiB3cm90ZToKPiAKPiBPbiBTdW4sIDI1IE1hciAyMDE4IDAxOjI5OjQxIC0wNzAw
Cj4gSm9obiBTeW5lIDxqb2huMzkwOUBnbWFpbC5jb20+IHdyb3RlOgo+IAo+PiBIaSBKb25hdGhh
biwKPiBIaSBKb2huLAo+IAo+IFBsZWFzZSB3cmFwIHlvdXIgbm9ybWFsIGVtYWlscyAoZXhjZXB0
aW5nIHRhYmxlcykgdG8gODAgY2hhcnMuClllYWgsIEnigJltIHRyeWluZyB0byBkbyB0aGF0LCBi
dXQgSSB1c2UgYSBNYWMgYW5kIEFwcGxlIE1haWwgZG9lc27igJl0CmhhdmUgYSBmZWF0dXJlIHRv
IHdyYXAgYXQgODAgYXV0b21hdGljYWxseSBzbyBJIGhhdmUgdG8gZG8KdGhpcyBtYW51YWxseS4K
PiAKPj4gCj4+IEkgd2FzIHNwZWFraW5nIHdpdGggUm9kcmlnbyBhbmQgaGVyZSBpcyB3aGF0IEkg
dGhpbmsgbXVzdCBiZSBkb25lIHRvIG1vdmUKPj4gQURFNzg3OCBvdXQgb2Ygc3RhZ2luZwo+PiAK
Pj4gSGVyZSBhcmUgdGhlIHN0ZXBzIGFzIEkgc2VlIHRoZW06Cj4+IAo+PiAxKSBEZWZpbmUgdGhl
IElJTyBBdHRyaWJ1dGVzIHNvIHRoZXkgYXJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgSUlPIEFCSS4g
VGhpcwo+PiAgIHNob3VsZCBiZSBwcmV0dHkgc2ltcGxlIGdpdmVuIGFncmVlbWVudCBvbiB0aGUg
bmFtaW5nIGNvbnZlbnRpb24uCj4gUGxlYXNlIGRvbid0IGdvIGp1c3QgY2hhbmdpbmcgYXR0cmli
dXRlIG5hbWVzIC0gdGhlIGRyaXZlciBuZWVkcyB0bwo+IHVzZSB0aGUgc3RhbmRhcmQgYXBwcm9h
Y2ggb2YgaWlvX2NoYW5fc3BlYyBhbmQgY3JlYXRlIHRoZSB2YXN0Cj4gbWFqb3JpdHkgb2YgYXR0
cmlidXRlcyBhdXRvbWF0aWNhbGx5IHZpYSB0aGF0LiAgVGhlcmUgJ21heScgYmUKPiBhIGZldyBj
b3JuZXIgY2FzZXMgd2VlIGRvbid0IHdhbnQgdG8gbWFrZSBnZW5lcmljIGFuZCB0aGV5ICdtaWdo
dCcKPiBiZSBleHBvc2VkIGFzIGF0dHJpYnV0ZXMuCj4gCj4gSSBzdXNwZWN0IHRoaXMgY2hhbmdl
IGlzIHRoZSAnYmlnJyBqb2IuICBUaGUgY29yZSBzdXBwb3J0IG5lY2Vzc2FyeQo+IGZvciBSTVMg
YW5kIE1BViAoY29tcHV0ZWR0eXBlIG9yIHdoYXRldmVyIHdlIGNhbGwgaXQpIHdpbGwgbmVlZCBh
ZGRpbmcKPiBhcyB3ZWxsLiAgVGhhdCBpcyBhIHNlcGFyYXRlIHBhdGNoIHNldCB3aXRoIHN1cHBv
cnQgZm9yIHNvbWUgZXhhbXBsZXMKPiBpbiB0aGUgZHVtbXkgZHJpdmVyLgpHcmVhdCB0aGF0IHlv
dSBtZW50aW9uZWQgdGhpcywgYmVjYXVzZSBJIHRob3VnaCB3ZSBvbmx5IG5lZWRlZCB0bwptb2Rp
ZnkgdGhlIElJT19BVFRSIG5hbWluZy4gSeKAmWxsIHRha2UgYSBsb29rIGF0IGlpb19jaGFuX3Nw
ZWMgYW5kCnRoZSBleGFtcGxlcyBpbiB0aGUgZHVtbXkgZHJpdmVyLgo+IAo+PiAyKSBNYXAgdGhl
IEFERTc4NTQgaW50ZXJydXB0IHN0YXR1cyB0byBJSU8gZXZlbnRzLiBUaGlzIHJlcXVpcmVzIGFu
Cj4+ICAgaW50ZXJydXB0IHByb2Nlc3Npbmcgc2VjdGlvbi4KPj4gMykgQWRkIERldmljZVRyZWUg
c3VwcG9ydC4KPj4gNCkgQ3JlYXRlIERldmljZVRyZWUgb3ZlcmxheSBmb3IgdGhlIEFERTc4NTQu
Cj4gTW9yZSBhIGNhc2Ugb2YgYmluZGluZ3MgZm9yIG5vdy4gIElmIHRob3NlIGFyZSB1c2VkIHZp
YSBhbiBvdmVybGF5Cj4gZmluZSBidXQgZ2l2ZW4gd2UgZG9uJ3QgaGF2ZSBhbnkgYm9hcmRzIHdp
dGggb25lIG9uZSBpbiBtYWlubGluZSwKPiB0aGlzIGlzIGFuIGltcGxlbWVudGF0aW9uIGRldGFp
bCBmb3IgdGhlIHVzZXIgcmF0aGVyIHRoYW4gcGFydAo+IG9mIG1vdmluZyB0aGlzIGRyaXZlciBv
dXQgb2Ygc3RhZ2luZy4KSSB3YXMgdGhpbmtpbmcgbW9yZSBhbG9uZyB0aGUgbGluZXMgb2YgZG9j
dW1lbnRhdGlvbiB0byBzaG93IGEKZGV2ZWxvcGVyIHdoYXQgd2FzIG5lZWRlZCB0byBnZXQgdGhl
IGRyaXZlciB3b3JraW5nLgo+IAo+PiA1KSBVcGRhdGUgQURFNzg1NCBwcm9iZSB0byByZWFkIGlu
IHRoZSBEZXZpY2VUcmVlIHJlZ2lzdGVyIHNldHRpbmdzLgo+PiA2KSBBZGQgc3VwcG9ydCBmb3Ig
cG93ZXIgbW9kZXMgKFBNMSwgUE0yKS4KPiBUaGlzIGlzbid0IG5lY2Vzc2FyeSBmb3IgYSBtb3Zl
IG91dCBvZiBzdGFnaW5nIChuaWNlIHRvIGhhdmUgdGhvdWdoKS4KPiAKPj4gNykgTm90IHN1cmUg
aWYgd2Ugd2lsbCBzdXBwb3J0IG1lYXN1cmVtZW50IHN0cmVhbWluZyBvbiB0aGUgQURFNzg1NC4K
Pj4gICBUaGUgcHJvYmxlbSBpcyBBREU3ODU0IGlzIGRlc2lnbmVkIGFzIGFuIFNQSSBtYXN0ZXIs
IHdoaWNoIG1lYW5zCj4+ICAgaXQgY29udHJvbHMgdGhlIFNQSSBjbG9jaywgc28gdGhlIGRyaXZl
ciBtdXN0IHN1cHBvcnQgU1BJIHNsYXZlCj4+ICAgbW9kZS4gSG93ZXZlciwgdGhlIExpbnV4IEtl
cm5lbCBkb2VzIG5vdCBjdXJyZW50bHkgc3VwcG9ydCBTUEkKPj4gICBzbGF2ZSBtb2RlLiBXZSBo
YXZlIHRocmVlIGNob2ljZXMgdG8gbWFrZSB0aGlzIHdvcmsgYW5kIHRoZXkKPj4gICBhcmUgYWxs
IGEgbG90IG9mIHdvcms6IDEpIEFkZCBzdXBwb3J0IGZvciBTUEkgU2xhdmUgbW9kZSB0byB0aGUK
Pj4gICBrZXJuZWwsICAyKSBVc2UgaGFyZHdhcmUgdG8gY29udmVydCBTUEkgc2lnbmFscyB0byBJ
MlMgc2lnbmFscwo+PiAgIGFuZCB3aXRoIHRoZSB1c2Ugb2YgYSBjdXN0b20gY29kZWMsIHVzZSB0
aGUgQUxTQSBmcmFtZXdvcmsgdG8KPj4gICBzdHJlYW0gdGhlIHNhbXBsZXMgKHRoaXMgaXMgYW4g
YXBwcm9hY2ggSSB1c2VkLCBidXQgSSBkb27igJl0IGxpa2UKPj4gICBpdCksIDMpIE1vdmUgdGhl
IEkyUyBkcml2ZXIgb3V0IG9mIHRoZSBzb3VuZCBzdWJzeXN0ZW0gYW5kIHVzZSBpdAo+PiAgIHRv
Z2V0aGVyIHdpdGggRE1BIHRvIHN0cmVhbSBzYW1wbGVzIGRpcmVjdGx5IGludG8gdGhlIEFERTc4
NTQgZHJpdmVyCj4+ICAgKG15IHByZWZlcnJlZCBzb2x1dGlvbnMpLiBQZXJoYXBzIE1hcmsgQnJv
d24gaGFzIHNvbWUgaWRlYXMgb24gaG93Cj4+ICAgIHRvIG1ha2UgdGhpcyB3b3JrLiAKPiBJJ2xs
IGJlIGhvbmVzdCwgdGhpcyBpcyBhbiBlbmQgb2YgbGluZSBwYXJ0IGFuZCBmcmFua2x5IG1vcmUg
dGhhbgo+IGEgbGl0dGxlIGNyYXp5LiBJIHdvdWxkIGdvIHdpdGggc2ltcGx5IG5vdCBzdXBwb3J0
aW5nIHRoZSBtZWFzdXJlbWVudAo+IHN0cmVhbWluZyBhdCBhbGwgZm9yIHRoaXMgcGFydC4gIElm
IHlvdSByZWFsbHkgbmVlZCBpdCB3ZSBjYW4gdGhlbgo+IG1vdmUgb250byB0aGUgaG93IHBhcnQs
IGJ1dCBmcm9tIHdoYXQgeW91IGhhdmUgc2FpZCBJJ20gZ3Vlc3NpbmcgeW91Cj4gZG9uJ3QgY2Fy
ZSBleGNlcHQgaW4gYW4gYWJzdHJhY3QgJ2l0IHdvdWxkIGJlIG5pY2UnIHNvcnQgb2YgYSB3YXk/
ClllYWgsIEnigJltIG1vdmluZyB0byB0aGUgQURFOTAwMCBzbyBJ4oCZbGwgZHJvcCB0aGlzLgo+
IAo+PiAKPj4gVGhlIEFERTkwMDAgd2lsbCBiZSBtdWNoIGVhc2llciBiZWNhdXNlIGl0IHVzZXMg
YW4gU1BJIFNsYXZlIGludGVyZmFjZS4gCj4+IAo+PiBJIGhvcGUgSSBoYXZlIGNhcHR1cmVkIGV2
ZXJ5dGhpbmcsIGJ1dCBsZXQgbWUga25vdyBpZiBJIGhhdmUgbWlzc2VkIGFueXRoaW5nLgo+PiAK
PiAKPiBUaGF0IHdpbGwgZG8gZm9yIG5vdyA7KSAgSSdtIHN1cmUgdGhlcmUgd2lsbCBiZSBkZXRh
aWxzIHRoYXQgbmVlZAo+IHRpZHlpbmcgdXAgb25jZSB3ZSBoYXZlIHRoZSBhYm92ZSBkb25lLCBi
dXQgdGhhdCdzIHRydWUgZm9yIGFueSBuZXcKPiBkcml2ZXIgKGFuZCB0aGlzIHdpbGwgYmUgbmVh
cmx5IGEgbmV3IGRyaXZlciBiZWZvcmUgdGhpbmdzIGFyZSBkb25lKS4KVGhhbmsgeW91IGFnYWlu
IGZvciBhbGwgdGhlIGRldGFpbGVkIGZlZWRiYWNrLgo+IAo+IEpvbmF0aGFuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QK
ZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVy
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
