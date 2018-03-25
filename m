Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2889110-1521996884-2-2021831614028610849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521996883; b=LRGlFTG5x2yGsNKy78+uvbzE5AcbewS8cxp9I3UU+7QaNJQ
    IAPnzqGuMIYXbhHib41nCx5apmTYwCt2PbD4uSb1lROomodiljTpO/3KNaCQVIUj
    Rsd/r7Boa9hnChoQyzvLX5I3O+yK6Pl5CQaT4RcK3XxtzBhy+prcyGwBoMknKpxV
    Qm91HKoZXdNKK+WFZyML+czpUBnuaapz/5qQTCuZz3tH2WmdkhtRvufdIhf6jsov
    Uftn+VjmzbyNJCl+3GVsmHIZuPrh6o2JLd+dqDXb2Azfh+FJA+e+MH2/JOu4BkVs
    0R2ulGzPjMJD5bSAzkpRjbDRid3KvuuN5wgjWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521996883; bh=f
    BsNhs2K82in4+9zBIv59oUw5Skr6hXn0PUjcNMR8Y4=; b=Af/KrRPxKsEGpEGIv
    CGnFMcwuk7/HincUlyQalUQKB5XhpM7fhQlQ1L3JYUszBixawNz1uFZGsTQlcAGF
    DK1xG/Kqx6XYXjGuKzgZNhArhbWZnsABc/4FFFXkd37gqjy70Z18UJMgd9PLO0TQ
    8VIoae4pL578m8saYXZ3yPma54vTYEjSLhwbMLPmOfK2SOVALHBRTtIUDoQiOObB
    0qAwnvqIK/zb5yxUtfMR4RCIB9y6APACs6kXtWJ6H/D5b/t/Hbw7Zi/X6wMoDZm0
    Fp56s25XE0h/+p4TKAIAg6pHDAZn82Qc7pygYo0RCLDVytna1RQd9KyLAAena7+X
    gvyeA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660FE217BA
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 17:54:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Message-ID: <20180325175430.3f60741f@archlinux>
In-Reply-To: <6490BA61-EF6F-4407-A5A2-26B7E86B0629@gmail.com>
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

T24gU3VuLCAyNSBNYXIgMjAxOCAwMToyOTo0MSAtMDcwMApKb2huIFN5bmUgPGpvaG4zOTA5QGdt
YWlsLmNvbT4gd3JvdGU6Cgo+IEhpIEpvbmF0aGFuLApIaSBKb2huLAoKUGxlYXNlIHdyYXAgeW91
ciBub3JtYWwgZW1haWxzIChleGNlcHRpbmcgdGFibGVzKSB0byA4MCBjaGFycy4KCj4gCj4gSSB3
YXMgc3BlYWtpbmcgd2l0aCBSb2RyaWdvIGFuZCBoZXJlIGlzIHdoYXQgSSB0aGluayBtdXN0IGJl
IGRvbmUgdG8gbW92ZQo+IEFERTc4Nzggb3V0IG9mIHN0YWdpbmcKPiAKPiBIZXJlIGFyZSB0aGUg
c3RlcHMgYXMgSSBzZWUgdGhlbToKPiAKPiAxKSBEZWZpbmUgdGhlIElJTyBBdHRyaWJ1dGVzIHNv
IHRoZXkgYXJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgSUlPIEFCSS4gVGhpcwo+ICAgIHNob3VsZCBi
ZSBwcmV0dHkgc2ltcGxlIGdpdmVuIGFncmVlbWVudCBvbiB0aGUgbmFtaW5nIGNvbnZlbnRpb24u
ClBsZWFzZSBkb24ndCBnbyBqdXN0IGNoYW5naW5nIGF0dHJpYnV0ZSBuYW1lcyAtIHRoZSBkcml2
ZXIgbmVlZHMgdG8KdXNlIHRoZSBzdGFuZGFyZCBhcHByb2FjaCBvZiBpaW9fY2hhbl9zcGVjIGFu
ZCBjcmVhdGUgdGhlIHZhc3QKbWFqb3JpdHkgb2YgYXR0cmlidXRlcyBhdXRvbWF0aWNhbGx5IHZp
YSB0aGF0LiAgVGhlcmUgJ21heScgYmUKYSBmZXcgY29ybmVyIGNhc2VzIHdlZSBkb24ndCB3YW50
IHRvIG1ha2UgZ2VuZXJpYyBhbmQgdGhleSAnbWlnaHQnCmJlIGV4cG9zZWQgYXMgYXR0cmlidXRl
cy4KCkkgc3VzcGVjdCB0aGlzIGNoYW5nZSBpcyB0aGUgJ2JpZycgam9iLiAgVGhlIGNvcmUgc3Vw
cG9ydCBuZWNlc3NhcnkKZm9yIFJNUyBhbmQgTUFWIChjb21wdXRlZHR5cGUgb3Igd2hhdGV2ZXIg
d2UgY2FsbCBpdCkgd2lsbCBuZWVkIGFkZGluZwphcyB3ZWxsLiAgVGhhdCBpcyBhIHNlcGFyYXRl
IHBhdGNoIHNldCB3aXRoIHN1cHBvcnQgZm9yIHNvbWUgZXhhbXBsZXMKaW4gdGhlIGR1bW15IGRy
aXZlci4KIAo+IDIpIE1hcCB0aGUgQURFNzg1NCBpbnRlcnJ1cHQgc3RhdHVzIHRvIElJTyBldmVu
dHMuIFRoaXMgcmVxdWlyZXMgYW4KPiAgICBpbnRlcnJ1cHQgcHJvY2Vzc2luZyBzZWN0aW9uLgo+
IDMpIEFkZCBEZXZpY2VUcmVlIHN1cHBvcnQuCj4gNCkgQ3JlYXRlIERldmljZVRyZWUgb3Zlcmxh
eSBmb3IgdGhlIEFERTc4NTQuCk1vcmUgYSBjYXNlIG9mIGJpbmRpbmdzIGZvciBub3cuICBJZiB0
aG9zZSBhcmUgdXNlZCB2aWEgYW4gb3ZlcmxheQpmaW5lIGJ1dCBnaXZlbiB3ZSBkb24ndCBoYXZl
IGFueSBib2FyZHMgd2l0aCBvbmUgb25lIGluIG1haW5saW5lLAp0aGlzIGlzIGFuIGltcGxlbWVu
dGF0aW9uIGRldGFpbCBmb3IgdGhlIHVzZXIgcmF0aGVyIHRoYW4gcGFydApvZiBtb3ZpbmcgdGhp
cyBkcml2ZXIgb3V0IG9mIHN0YWdpbmcuCgo+IDUpIFVwZGF0ZSBBREU3ODU0IHByb2JlIHRvIHJl
YWQgaW4gdGhlIERldmljZVRyZWUgcmVnaXN0ZXIgc2V0dGluZ3MuCj4gNikgQWRkIHN1cHBvcnQg
Zm9yIHBvd2VyIG1vZGVzIChQTTEsIFBNMikuClRoaXMgaXNuJ3QgbmVjZXNzYXJ5IGZvciBhIG1v
dmUgb3V0IG9mIHN0YWdpbmcgKG5pY2UgdG8gaGF2ZSB0aG91Z2gpLgoKPiA3KSBOb3Qgc3VyZSBp
ZiB3ZSB3aWxsIHN1cHBvcnQgbWVhc3VyZW1lbnQgc3RyZWFtaW5nIG9uIHRoZSBBREU3ODU0Lgo+
ICAgIFRoZSBwcm9ibGVtIGlzIEFERTc4NTQgaXMgZGVzaWduZWQgYXMgYW4gU1BJIG1hc3Rlciwg
d2hpY2ggbWVhbnMKPiAgICBpdCBjb250cm9scyB0aGUgU1BJIGNsb2NrLCBzbyB0aGUgZHJpdmVy
IG11c3Qgc3VwcG9ydCBTUEkgc2xhdmUKPiAgICBtb2RlLiBIb3dldmVyLCB0aGUgTGludXggS2Vy
bmVsIGRvZXMgbm90IGN1cnJlbnRseSBzdXBwb3J0IFNQSQo+ICAgIHNsYXZlIG1vZGUuIFdlIGhh
dmUgdGhyZWUgY2hvaWNlcyB0byBtYWtlIHRoaXMgd29yayBhbmQgdGhleQo+ICAgIGFyZSBhbGwg
YSBsb3Qgb2Ygd29yazogMSkgQWRkIHN1cHBvcnQgZm9yIFNQSSBTbGF2ZSBtb2RlIHRvIHRoZQo+
ICAgIGtlcm5lbCwgIDIpIFVzZSBoYXJkd2FyZSB0byBjb252ZXJ0IFNQSSBzaWduYWxzIHRvIEky
UyBzaWduYWxzCj4gICAgYW5kIHdpdGggdGhlIHVzZSBvZiBhIGN1c3RvbSBjb2RlYywgdXNlIHRo
ZSBBTFNBIGZyYW1ld29yayB0bwo+ICAgIHN0cmVhbSB0aGUgc2FtcGxlcyAodGhpcyBpcyBhbiBh
cHByb2FjaCBJIHVzZWQsIGJ1dCBJIGRvbuKAmXQgbGlrZQo+ICAgIGl0KSwgMykgTW92ZSB0aGUg
STJTIGRyaXZlciBvdXQgb2YgdGhlIHNvdW5kIHN1YnN5c3RlbSBhbmQgdXNlIGl0Cj4gICAgdG9n
ZXRoZXIgd2l0aCBETUEgdG8gc3RyZWFtIHNhbXBsZXMgZGlyZWN0bHkgaW50byB0aGUgQURFNzg1
NCBkcml2ZXIKPiAgICAobXkgcHJlZmVycmVkIHNvbHV0aW9ucykuIFBlcmhhcHMgTWFyayBCcm93
biBoYXMgc29tZSBpZGVhcyBvbiBob3cKPiAgICAgdG8gbWFrZSB0aGlzIHdvcmsuIApJJ2xsIGJl
IGhvbmVzdCwgdGhpcyBpcyBhbiBlbmQgb2YgbGluZSBwYXJ0IGFuZCBmcmFua2x5IG1vcmUgdGhh
bgphIGxpdHRsZSBjcmF6eS4gSSB3b3VsZCBnbyB3aXRoIHNpbXBseSBub3Qgc3VwcG9ydGluZyB0
aGUgbWVhc3VyZW1lbnQKc3RyZWFtaW5nIGF0IGFsbCBmb3IgdGhpcyBwYXJ0LiAgSWYgeW91IHJl
YWxseSBuZWVkIGl0IHdlIGNhbiB0aGVuCm1vdmUgb250byB0aGUgaG93IHBhcnQsIGJ1dCBmcm9t
IHdoYXQgeW91IGhhdmUgc2FpZCBJJ20gZ3Vlc3NpbmcgeW91CmRvbid0IGNhcmUgZXhjZXB0IGlu
IGFuIGFic3RyYWN0ICdpdCB3b3VsZCBiZSBuaWNlJyBzb3J0IG9mIGEgd2F5PwoKPiAKPiBUaGUg
QURFOTAwMCB3aWxsIGJlIG11Y2ggZWFzaWVyIGJlY2F1c2UgaXQgdXNlcyBhbiBTUEkgU2xhdmUg
aW50ZXJmYWNlLiAKPiAKPiBJIGhvcGUgSSBoYXZlIGNhcHR1cmVkIGV2ZXJ5dGhpbmcsIGJ1dCBs
ZXQgbWUga25vdyBpZiBJIGhhdmUgbWlzc2VkIGFueXRoaW5nLgo+IAoKVGhhdCB3aWxsIGRvIGZv
ciBub3cgOykgIEknbSBzdXJlIHRoZXJlIHdpbGwgYmUgZGV0YWlscyB0aGF0IG5lZWQKdGlkeWlu
ZyB1cCBvbmNlIHdlIGhhdmUgdGhlIGFib3ZlIGRvbmUsIGJ1dCB0aGF0J3MgdHJ1ZSBmb3IgYW55
IG5ldwpkcml2ZXIgKGFuZCB0aGlzIHdpbGwgYmUgbmVhcmx5IGEgbmV3IGRyaXZlciBiZWZvcmUg
dGhpbmdzIGFyZSBkb25lKS4KCkpvbmF0aGFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnBy
b2plY3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
