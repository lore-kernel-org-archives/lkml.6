Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277805-2-15742359241779671506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520277805; b=ZcRiA+D2Dxxmv9gy+vqV2+JDZSqWYJygesX0N27lL0JuU6H
    kuC9qRvSVh+q4SubjaSFkOhha9sz1FtJr9WX7c2QpPjET0CsLpR0IIuJB3TMOW8p
    3HQ04Vwz6UBG660Vpg7GUEJQ8XO1cOAtR0OrHfGv3JNVyNQ9qUfxzgJXirNBl/bu
    Oa/o5QQ1VDP4Zhiyc+TT/vOEwK84thvv7NUb+ydNMvIcg7ypH0yqJd4x+o/+2/g5
    ToXqqsuqfvMVzDXprjWYnf+LLW8OzaVcTncXzXUBAF2JDKjwwsD9qCTIgPhsU6us
    ZR0Qcv2NV5W3EO23wvoqmO6Nlq6mEZNpBU+Y4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277805; bh=d
    xcpjU+MBI+Hs2y3C2Q7ClMN0dqMgwAn8tPDSitcHIQ=; b=I22KWp/sO2fExviK4
    eRrNEUQBpFERDZu4NNk2Ne31Dw5bpVLKG7wVkjBn86n24QQ4y9lNFmNaUga9hntd
    nfoCOST4O6MdsOut4Rq+f2bOKNwCCHRwFm6IcPzm6zjOYkoLJUc6r8Jrk6XjdC4J
    oOf20wxufWeUYSgEsei0mOJau16CjJu9AnYQQcvwTRQoFgslM+hdEg3RyVrtNk8H
    XTOmG8u4N4Ka0X1omzJYHRKiYUcHemSBxj9PbKFujHBvsy5Z7ZFq+h7TKV6hRpd2
    jw2rjbx4FZJUTecZydNyOh9wMaC+0tzJe4DRUDBEhbkC53GFL3ZW9G/1i85vM6g5
    9egdg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vl8XlyVM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p/okB+1w;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vl8XlyVM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p/okB+1w;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtWeHSLd2LMhNo9UpS6hIdYSFAi9M0eTjP6w3BLHfH09O44l0Tk7FjGq5BL7DhVBiJWBWeADg==
Message-ID: <1520277796.109662.10.camel@gmail.com>
Subject: Re: [PATCH] Fix partial warnings of checkpatch.pl for ipx_route.c
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Horatiu Vultur <hvultur@gmail.com>, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Mar 2018 11:23:16 -0800
In-Reply-To: <1520277563-3825-1-git-send-email-hvultur@gmail.com>
References: <1520277563-3825-1-git-send-email-hvultur@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTAzLTA1IGF0IDIwOjE5ICswMTAwLCBIb3JhdGl1IFZ1bHR1ciB3cm90ZToK
PiBGaXggcGFydGlhbCB3YXJuaW5ncyBvZiBjaGVja3BhdGNoLnBsIGZvciBpcHhfcm91dGUuYwo+
IAo+IFNpZ25lZC1vZmYtYnk6IEhvcmF0aXUgVnVsdHVyIDxodnVsdHVyQGdtYWlsLmNvbT4KPiAt
LS0KPiDCoGRyaXZlcnMvc3RhZ2luZy9pcHgvaXB4X3JvdXRlLmMgfCA3ICsrKystLS0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCgpQbGVhc2Ug
dGFrZSBhIGxvb2sgYXQgZHJpdmVycy9zdGFnaW5nL2lweC9UT0RPCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVs
QGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
