Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1122852-1525704042-2-7817800350838368716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525704041; b=IFhDxnr2GbiFBlyqBN+O2VbKChuXeIUZx5Fv/M7TgwhV8pFlhn
    UZ8Y8rYQ9ba8UuXj0xpulJXPad2RcqjUgAPAEtOA/QzsNv39alk9cHtVJRwpQbZ3
    nf/h1YDjv33I4tJcBr9oEYk3APawPI4NJ5d90/LUh5V414QeutN/JTz8Gw9tciMy
    AZXIojRBoI7MhgLKqFATbi5GGpWWgCvg4il1PpOQDtlBXOGkUFQJzMc6sCAMkfaP
    uw8VP1/AwIwgm5YqJgT8LyE5NUGp+GlcDTaqO+qtRrrEv4mdzV081/pQUXY/2ngR
    xBGkuLY2VOAOnuxHNTML6iFlhaJWOhkMOc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525704041; bh=6IH3J
    o+Sg+1LwRw6EcmmMUK4j6zje1ig6u9TTckFWJ4=; b=JGvCd1retUZTF1R2ge/yt
    gYZkKx1zLU8EOnlG48D+3ccoSDYkIqxnhBsbNvqxWAgiAXunugjMqKaZTMbgSL7i
    JUgFIS35Q1KlKBOcmKXt9le1Up3nrZ3HdC8rddRbeiJ+/NQfpnaTSTlb4Hw9WbTP
    ds8Q8USXjDt/ALa3Sn4ximXd6TYOGXouwOSzjETVdXISfyYOccSFoSjnLUbEdI8v
    qk5LUdxF/3ERi6Vt3ovt6z+o2U+2X1mIDwdItVNqdhopJ/Bjeqvecy8zhXSf3zz0
    CrEHDkwOtyYiBlP59As89w3aRaJYzhfzYudwz8PPwKyv4YbroQTVBgMlhp7cIKGe
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=e14GnAcq x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=De05gzK3;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=e14GnAcq x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=De05gzK3;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrGDhU88tmEunpfPs73xFUzHk0fvXZ5z26LOyrC2STUhDQ7gcbcgA9AOLjQkG45csvf2EnPaoeKY3tQtHuo584iTKeNHlyv/w+gq4yzTZSY1bfKQR7B
    m9i5Yg03kzDCzdDxvjGw75qBroJmGFmCpGd0KKsFrWYoSbJX+i8c9Z2MoRKE8QaSufp85n5wAclhEZge5DYx9FIpHkvMGmphg6E9ZsWnze6U+vFK1iJjCLAJ
    HT2zlPYptnCk49/iZF7AFg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=MrCnlDKheoE8nKk3lxAA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqmtD6eKVinZde0eon7m6xwk1RqTq8BObfo89iQZYDnRz1jiN1nZCV8ejwJYXcaKcN5Av7DTw==
Date: Mon, 7 May 2018 07:40:29 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 1/2] staging: android: ion: Fix license identifier
 comment format
Message-ID: <20180507144029.GA2084@localhost>
References: <20180507011854.12627-1-natechancellor@gmail.com>
 <d157b475-7893-3ab6-87a8-b6ce5aa13b4f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d157b475-7893-3ab6-87a8-b6ce5aa13b4f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Joe Perches <joe@perches.com>, Martijn Coenen <maco@android.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 06:37:52AM -0700, Laura Abbott wrote:
> On 05/06/2018 06:18 PM, Nathan Chancellor wrote:
> > checkpatch.pl complains these are invalid because the rules in
> > Documentation/process/license-rules.rst state that C headers should
> > have "/* */" style comments.
> > 
> 
> The SPDX markings are special, but I don't see anything from a
> quick read of the SPDX specification that says they have to use //.
> I think this is going to generate a lot of possible noise so it
> might be worth adjusting checkpatch.
> 
> Thanks,
> Laura

Under section 2 of "License identifier syntax" in the license rules
file, it shows the preferred style for each type of file. Apparently
there was some build breakage with // in header files so I assume they
want /* */ for uniformity sake.

Thanks!
Nathan

> 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >   drivers/staging/android/ion/ion.h  | 2 +-
> >   drivers/staging/android/uapi/ion.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
> > index ea0897812780..16cbd38a7160 100644
> > --- a/drivers/staging/android/ion/ion.h
> > +++ b/drivers/staging/android/ion/ion.h
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +/* SPDX-License-Identifier: GPL-2.0 */
> >   /*
> >    * drivers/staging/android/ion/ion.h
> >    *
> > diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
> > index 825d3e95ccd3..5d7009884c13 100644
> > --- a/drivers/staging/android/uapi/ion.h
> > +++ b/drivers/staging/android/uapi/ion.h
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +/* SPDX-License-Identifier: GPL-2.0 */
> >   /*
> >    * drivers/staging/android/uapi/ion.h
> >    *
> > 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
