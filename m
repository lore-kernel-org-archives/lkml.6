Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34330C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F111021470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ffj1B/Ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJMAgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:36:17 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40994 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:36:16 -0400
Received: by mail-pf1-f176.google.com with SMTP id m77-v6so6496466pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ny7ITH6fFe3Ml5lgu1hpv37LIslLXGeqwDXFmwXagQQ=;
        b=Ffj1B/FtXI+VSatwdzIOX/MOoZxcy2wXvPvl8+tDfj7FOTIZxkNYqP1IAKIXro2wOX
         vwZR1OZS9Q/7TFBymzUdKcR1FjwPyUEAq4z/sODGAOXgsA1euCFdqi3Md/anQJRjt56m
         zO16wpqUyAqS1ahAr60bSjfgeW5Rg+70eLsMiqLy7tvrF8Zdf9rWdldcAuaJ92Fz1g0i
         IauF9BKwTSVGgm38j3NkhXEvW+Qmzq5VdysouA8hMZu1/upona+F0TCLgQwmRHpJU8o7
         ZptQ/OWvJXXzkG9rMXy/XKH9e2tpw7y+TH61uqz0y12hw7eUttM5b0d1TVMQByAuYHtu
         RPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ny7ITH6fFe3Ml5lgu1hpv37LIslLXGeqwDXFmwXagQQ=;
        b=t1FXyqAlU4lThm/MdYxGB+WpDOLrB9mQXiqquZySwlUPFrcogeQjLUkIFDeBR8r6cP
         HqCihIItMwEQEZqeU16r6WXn3YiUUgFJUFWIMTF9ue6I+mHUZfzOd0awGH0icpXD8tzr
         iBfRFZNlbeGjQEWXWsqQxHk0Nr8B/5J41F5/TQbqSm7nXXHtNmfp0z5rxaBygNj5T272
         7+rmZkO5ctx3Z/5AC4EZ+CXBqZb0zuDBm/tNMwsjOTj1F/iVypcb+5jK/rusA42k0ETU
         HGzJq5aLq8JrlQn1QIqcmUP4DiZSv1FWdGsZsfZwuwkitQ1tPiVcILwTYEhxoNXBbTb8
         glJQ==
X-Gm-Message-State: ABuFfojOpWWBsQ94JesgEZDrVSiiXVAB6Q01NXOwOYck0uPXX+WC+BDD
        V2kB+VQPSi0rjRczIQP8y+60a6nlDAMFtjQiuhAjMg==
X-Google-Smtp-Source: ACcGV63bMeq52II7wVoXuOZNb6g0T/jaYSZP7V4q07orTuWEcAFOxJTn7aKZ1qhIWd8oK9BNoD+KfGf53NW+RlUDNrA=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr6300853pgn.145.1539363770541;
 Fri, 12 Oct 2018 10:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
In-Reply-To: <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Oct 2018 10:02:39 -0700
Message-ID: <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     denkenz@gmail.com
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 5:29 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Nick,
>
> > @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
> >    */
> >   static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> >                       unsigned int keylen, unsigned char *h1,
> > -                     unsigned char *h2, unsigned char h3, ...)
> > +                     unsigned char h2, unsigned char *h3, ...)
> >   {
> >       unsigned char paramdigest[SHA1_DIGEST_SIZE];
> >       struct sdesc *sdesc;
>
> So my concern here is that this actually breaks the natural argument
> order compared to what the specification uses.  This in turn requires
> one to perform some mental gymnastics and I'm not sure that this is such
> a good idea.

Thanks for the review.

> Refer to
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf
> for details.

 Can you cite the relevant section?

>
> Note that H3 is really the 'continueAuthSession' variable which is a
> bool.  In the above specification BOOL has a size of 1, and TSS_authhmac
> already assigns a h3 to 'c' which is used for the actual hashing.
>
> So can't we simply use 'bool' or uint32 as the type for h3 instead of
> re-ordering everything?

int was exactly what I originally proposed:
https://github.com/ClangBuiltLinux/linux/issues/41#issuecomment-428365339.
If that works for you and the maintainers, I can send that in patch
form.

>
> Regards,
> -Denis



-- 
Thanks,
~Nick Desaulniers
