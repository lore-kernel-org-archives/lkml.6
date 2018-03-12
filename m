Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3703740-1520834322-2-15559237777928448553
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520834321; b=kvfemYITfIMimkkQSxRHSEqlxxpp4pnryiEgLKqs9USg23E
    pg21uSzbyV13oMCdEbAcACewTSTInaz3GWwuj49VM1rKXO2y8VS44/fUAH8uSKWW
    Zfl68v/StKY62Dxedm9JSq4lXQGYFUfmBmBgcRlPRWBc5KcP92KOWFvaBncUIzdi
    IG6sExKvBSSM4sBoFHNv0rPQAfm4u/a0ZR6NzNUXU4nDYFOD22ietuMXPUVRYp31
    2vCcomNIkFE5pdGzMF8lWLyqqlbFVj45OiYZmhix9tfhco54KInyzMlH9+JUqMJY
    J/CPDA2Z2FInSDcrESnh2r7qIoGRdx9AYGtMbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:subject:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520834321; bh=i
    zGuCtNF3v+54JG0TS9KAngiMZoMoxCo+pg3zVu/XRg=; b=Veziw7qj3ok+Y1+nX
    XrBl7ii+ALRbIoI6dt3Bdw8D9vDH0Jca9RX/5V+budNn6pJ3xfneQAlvVTIcQ/tR
    NbK1IEmHeJrJvPwLoaxvq4lmLXl9pwOhHrUoL9G2z42xgg7Fd8zf40EeCIuSWULw
    SglY6WhT5FsZNWJwNay6rSs/IyQQG/XA2XogrcjL3YNhPlfyzShg+tHqIOgLth8u
    hE9JAsJN0IYmyEGQ830gu1wLO8+SwU/7Ep2+ELd5oYV7wu/xN9f1CvveH4uJutaC
    6jqbSOH503uhq4E/4e+Zryvnz4fuN7Q+MsWezQhGOe9AZqIJd2lyeawEIVNHtlg+
    WJsAw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-80 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=i2se.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-80 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=i2se.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Mar 2018 06:58:04 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Tobin C. Harding" <me@tobin.cc>
Message-ID: <1166411830.411906.1520834284931@email.1und1.de>
In-Reply-To: <20180312054613.GG8631@eros>
References: <1520818673-14084-1-git-send-email-me@tobin.cc>
 <20180312054613.GG8631@eros>
Subject: Re: [PATCH v2] staging: vchiq_arm: Clear VLA warning
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:AX0RfyY3AXcIde7Krp3pAKYQOVqU0sdVUHQdS+fpqLfmvwX7UyV
 dUwn0xxHPSBMCSBOxTZqZOqxUzexTk4uLpUqZP8At3qjlYv0d5ByF+dTtsPbHaam6KzuOFG
 n40ZQpjfKsBx8aDtMTkVLDswq76R0/48eUcFD/xzDQPP7hyQWA8x4jt7E78XYWKXx+pddQx
 tcxbUo7LAB6vVpcNs/BkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bydMn80nupA=:UqZFVh/yGzvAHFNnJ8ZvUD
 HOWhd5MhY4S8zJ7RdNmXzgbja7qcMIOjnxQOn7jzV1yWUoNffeuAv5eGqm7+UQXfhFR+/h5vi
 c2R3SUEFLbBHweYrc1ogbIZqhVOf5RzW4p8qfN/mYgPMAbvQ22TqNtky5dNNXMZVGZR1A/96T
 SbsIFNIXcAhoN18D5lI6M/dARBbAadIc1xLdPj44pzR8rVLQWnEW6ZUiDojc4P2800x9yARft
 wk8Aq50lNQ/YO4rj1vUCr9GpCz40RUQtlm4nOnSRZ6EH5bMbRYQXzJO1ek0JU9tBvFj5ZNaCN
 BrtiPrzo8jCzhq3m+yTpndkkufc3jka21JAFeXsfqaKGDvV8R4qm3kHBEIO5v/5ACAkCnbIHJ
 jgK1UvD/+FxeHbxJYTCiDVEPct+VYg8z3HQ7yGxRev7ySZInJkprARhlZSBSzKykd2suXrAuf
 P/F2D2pX8NW+In4421hF6NsY/wgwXcc1iwVcaA8mnralgFg/XQC0E9eVwfZvu5pQLIafXR9Rd
 CjAcL0nzAfxzyvstBbOIAGCYyt1ESdfofOn82brb5iU3gTTbUAve1ulaaucnYLQlhoVi/W7E5
 rvMDmrnPtQlx39kcxtE53mqPzC/ojtPf2hC4CjFfWMm1C26XszgamHjSrgOf4qdt1ngNQA9Uz
 zbX6fwHA+KQxOe2WeXnmTDXco/tQ2eFil2Vq5IgtcMP4ebd9FiGfomRYYHLcPrRdsAooNnL5K
 2ykDOZkUVQYKeFqJPMGsARATXLoOvuJY3LRhqcXPWOrxG5AvybvHbanIpCg=
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
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
 driverdev-devel@linuxdriverproject.org, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgVG9iaW4sCgo+ICJUb2JpbiBDLiBIYXJkaW5nIiA8bWVAdG9iaW4uY2M+IGhhdCBhbSAxMi4g
TcOkcnogMjAxOCB1bSAwNjo0NiBnZXNjaHJpZWJlbjoKPiAKPiAKPiBPbiBNb24sIE1hciAxMiwg
MjAxOCBhdCAxMjozNzo1M1BNICsxMTAwLCBUb2JpbiBDLiBIYXJkaW5nIHdyb3RlOgo+ID4gVGhl
IGtlcm5lbCB3b3VsZCBsaWtlIHRvIGhhdmUgYWxsIHN0YWNrIFZMQSB1c2FnZSByZW1vdmVkWzFd
LiAgVGhlIGFycmF5Cj4gPiBoZXJlIGlzIGZpeGVkIChkZWNsYXJlZCB3aXRoIGEgY29uc3QgdmFy
aWFibGUpIGJ1dCBpdCBhcHBlYXJzIGxpa2UgYSBWTEEKPiA+IHRvIHRoZSBjb21waWxlci4gIEFs
c28sIGN1cnJlbnRseSB3ZSBhcmUgcHV0dGluZyA3NjggYnl0ZXMgb24gdGhlCj4gPiBzdGFjay4g
IFRoaXMgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgb24gdGhlIGVycm9yIHBhdGggc28gcGVyZm9y
bWFuY2UgaXMKPiA+IG5vdCBjcml0aWNhbCwgbGV0J3MganVzdCBhbGxvY2F0ZSB0aGUgbWVtb3J5
IGluc3RlYWQgb2YgdXNpbmcgdGhlCj4gPiBzdGFjay4gIFRoaXMgc2F2ZXMgc3RhY2sgc3BhY2Ug
YW5kIHJlbW92ZXMgdGhlIFZMQSBidWlsZCB3YXJuaW5nLgo+ID4gCj4gPiBrbWFsbG9jIGEgYnVm
ZmVyIGZvciBkdW1waW5nIHN0YXRlIGluc3RlYWQgb2YgdXNpbmcgdGhlIHN0YWNrLgo+ID4gCj4g
PiBbMV06IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzMvNy82MjEKPiA+IAo+ID4gU2lnbmVk
LW9mZi1ieTogVG9iaW4gQy4gSGFyZGluZyA8bWVAdG9iaW4uY2M+Cj4gPiAtLS0KPiAKPiBEcm9w
IHRoaXMgcGxlYXNlLCBsZWFrcyBtZW1vcnkuCgpleGNlcHQgZnJvbSB0aGUgbGVhaywgZGlkIHlv
dSB0ZXN0IHRoaXMgcGF0Y2ggb24gYSBSUGk/CgpUaGFua3MKU3RlZmFuCgo+IAo+IHRoYW5rcywK
PiBUb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2Ry
aXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2
LWRldmVsCg==
