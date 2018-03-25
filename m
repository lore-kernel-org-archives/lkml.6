Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1742742-1521966596-2-9155776409503377021
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
    t=1521966595; b=FChfz/6pURe9MCxXXFQmSAPwymIo3ZkPEbLlQVZd8BV480+
    jilrd8MoXNJy7qPVihONaUZub//CGF5tusQ9ocWfD8uhMGbFHGG+tf0Li7aOO2QU
    aFA0TjwHYzrrSGq7sDW1NSbGFscM0rkSXnvww6kGU3G57g6B8Xu7fk9dHPIaG6Pk
    ywwyej4HgtVd0pLuNTBn00YDDqZK61x2mFs7mi0trGxBb91WCDJq9pblj8HXb/HW
    zOg5P8JX8UOuJ2oMpcIamTgNmYq5e98aASCCIsM39TH9h/KiaTMnyZ8dxR8mbE1I
    Ae4yPdf8IUM56eg4zNSuqdUnAg0bH8KVw+w8Nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521966595; bh=r
    q3LC8fpRJtYW4jBr9RESZHkc2SKLXcfCwTX2cC9nmw=; b=XFdApdyGdwkCdLzW5
    OiyNvq4WLT1p+i6zkmHlW11ZqN/4FHQFdF8+S0DGY6SkbSgjeFPqPTuUlYsyusPK
    tVxoKTPRC/QbPmchiuO70FLhxQkv302AljUlkBHnrKmL1kaLby2GrLMr2XpeBO5v
    HyjE6ZfAT2ROP9iDtg8tYi7Lo2hrg/biC3UMqjvGRURmAzl0kvYo6OH5+XPA+mIJ
    xL4PldaSgU+20HGzAHv04zjgpO40pY7Z3V2LfxDPUQYH6i/l1RUM6nNRBUlnRdTG
    lcyNjHTCk+AOwMysQ8oBB2IcyCzCQ6YJYA51IlkD2fAGfhGBQIQoIaOINQRz2nF8
    ZtGnA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nuHrHET+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IH1fok7g;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nuHrHET+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IH1fok7g;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuqhPtsm0SKCHUqvQXRpwhbL2xv5pnPJr6s7dmJZzyCx2PkjsI9yi+aDAevY88fi3sBqUv/LA==
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180324151829.7d03ad15@archlinux>
Date: Sun, 25 Mar 2018 01:29:41 -0700
Message-Id: <6490BA61-EF6F-4407-A5A2-26B7E86B0629@gmail.com>
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

SGkgSm9uYXRoYW4sCgpJIHdhcyBzcGVha2luZyB3aXRoIFJvZHJpZ28gYW5kIGhlcmUgaXMgd2hh
dCBJIHRoaW5rIG11c3QgYmUgZG9uZSB0byBtb3ZlIEFERTc4Nzggb3V0IG9mIHN0YWdpbmcKCkhl
cmUgYXJlIHRoZSBzdGVwcyBhcyBJIHNlZSB0aGVtOgoKMSkgRGVmaW5lIHRoZSBJSU8gQXR0cmli
dXRlcyBzbyB0aGV5IGFyZSBjb25zaXN0ZW50IHdpdGggdGhlIElJTyBBQkkuIFRoaXMgc2hvdWxk
IGJlIHByZXR0eSBzaW1wbGUgZ2l2ZW4gYWdyZWVtZW50IG9uIHRoZSBuYW1pbmcgY29udmVudGlv
bi4gCjIpIE1hcCB0aGUgQURFNzg1NCBpbnRlcnJ1cHQgc3RhdHVzIHRvIElJTyBldmVudHMuIFRo
aXMgcmVxdWlyZXMgYW4gaW50ZXJydXB0IHByb2Nlc3Npbmcgc2VjdGlvbi4KMykgQWRkIERldmlj
ZVRyZWUgc3VwcG9ydC4KNCkgQ3JlYXRlIERldmljZVRyZWUgb3ZlcmxheSBmb3IgdGhlIEFERTc4
NTQuCjUpIFVwZGF0ZSBBREU3ODU0IHByb2JlIHRvIHJlYWQgaW4gdGhlIERldmljZVRyZWUgcmVn
aXN0ZXIgc2V0dGluZ3MuCjYpIEFkZCBzdXBwb3J0IGZvciBwb3dlciBtb2RlcyAoUE0xLCBQTTIp
Lgo3KSBOb3Qgc3VyZSBpZiB3ZSB3aWxsIHN1cHBvcnQgbWVhc3VyZW1lbnQgc3RyZWFtaW5nIG9u
IHRoZSBBREU3ODU0LiBUaGUgcHJvYmxlbSBpcyBBREU3ODU0IGlzIGRlc2lnbmVkIGFzIGFuIFNQ
SSBtYXN0ZXIsIHdoaWNoIG1lYW5zIGl0IGNvbnRyb2xzIHRoZSBTUEkgY2xvY2ssIHNvIHRoZSBk
cml2ZXIgbXVzdCBzdXBwb3J0IFNQSSBzbGF2ZSBtb2RlLiBIb3dldmVyLCB0aGUgTGludXggS2Vy
bmVsIGRvZXMgbm90IGN1cnJlbnRseSBzdXBwb3J0IFNQSSBzbGF2ZSBtb2RlLiBXZSBoYXZlIHRo
cmVlIGNob2ljZXMgdG8gbWFrZSB0aGlzIHdvcmsgYW5kIHRoZXkgYXJlIGFsbCBhIGxvdCBvZiB3
b3JrOiAxKSBBZGQgc3VwcG9ydCBmb3IgU1BJIFNsYXZlIG1vZGUgdG8gdGhlIGtlcm5lbCwgIDIp
IFVzZSBoYXJkd2FyZSB0byBjb252ZXJ0IFNQSSBzaWduYWxzIHRvIEkyUyBzaWduYWxzIGFuZCB3
aXRoIHRoZSB1c2Ugb2YgYSBjdXN0b20gY29kZWMsIHVzZSB0aGUgQUxTQSBmcmFtZXdvcmsgdG8g
c3RyZWFtIHRoZSBzYW1wbGVzICh0aGlzIGlzIGFuIGFwcHJvYWNoIEkgdXNlZCwgYnV0IEkgZG9u
4oCZdCBsaWtlIGl0KSwgMykgTW92ZSB0aGUgSTJTIGRyaXZlciBvdXQgb2YgdGhlIHNvdW5kIHN1
YnN5c3RlbSBhbmQgdXNlIGl0IHRvZ2V0aGVyIHdpdGggRE1BIHRvIHN0cmVhbSBzYW1wbGVzIGRp
cmVjdGx5IGludG8gdGhlIEFERTc4NTQgZHJpdmVyIChteSBwcmVmZXJyZWQgc29sdXRpb25zKS4g
UGVyaGFwcyBNYXJrIEJyb3duIGhhcyBzb21lIGlkZWFzIG9uIGhvdyB0byBtYWtlIHRoaXMgd29y
ay4gCgpUaGUgQURFOTAwMCB3aWxsIGJlIG11Y2ggZWFzaWVyIGJlY2F1c2UgaXQgdXNlcyBhbiBT
UEkgU2xhdmUgaW50ZXJmYWNlLiAKCkkgaG9wZSBJIGhhdmUgY2FwdHVyZWQgZXZlcnl0aGluZywg
YnV0IGxldCBtZSBrbm93IGlmIEkgaGF2ZSBtaXNzZWQgYW55dGhpbmcuCgpSZWdhcmRzLApKb2hu
CgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2
ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZl
cmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRl
dmVsCg==
