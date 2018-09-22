Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806A42150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BZU3fDXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806A42150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIWChl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:37:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41195 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeIWChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:37:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so14992684ljy.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1F53DeP330QpWm2udvHwsXVnMMzggjVWGKIFG7fDbcE=;
        b=BZU3fDXmofOSiKkB+H6OVheCTKDv7bpWWLQ2DPKOsTRUoC0NS7D8WbP+NMBdMtBAAR
         n1Wav1ST3c0XIPpxZAGzO2dyChtcCyojLgmQr/660mehltrR7sSz/1JsMgI/uos766D6
         rsSEcgVrUyZ+sbvstUQjQzBgy6Qsq2MXQmZh11TLWN6CYzauThx1jCfJgGQut2DGX6lP
         8r8K3E/L7njq2Q/FeOHCOWux0iIQkUVeFDhD5pWGqF/sH3ftwG7ndBvdGuuzGXjp0DSC
         B8Q7RuJANtbvjjVPAhrs7nANpDLQ2CVxEDBplW/yv7pMZLtHEAnNPREHyMVDdH0fnRNy
         u4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1F53DeP330QpWm2udvHwsXVnMMzggjVWGKIFG7fDbcE=;
        b=sCy5cbFhw0Wh3vE0D2e0sMwjpNiqMNq4d/r+WP4zvjpq4xvvWm7TGg4qU33bWJQ71j
         8aVlMz7lOHvy8cM6FgNY5C5KX/zyGjS4v9lkdzaoUfw/t6On8nitlJjJkhaAGnxQUkm9
         IxSfvsQZ3rqIlYpg/ev/4C5f7PTgDKJKw+sWYvbDZdgGP2rGSj/pUD5z1bvF1m14NKtQ
         7D22oOA0PE+oqgPwQHK+hlL37LKhxoRbmGsPj7m6tPt9RACDtN9z1Dnm66c7jGOetSXS
         t+oXs+I+4JMFvn+qozgmnnTot9+FiFvWfVdhx3kMryPlPlacOjdpyrYkOQY80g4Idy93
         7Q4A==
X-Gm-Message-State: ABuFfogqsCDxXsYNWSBBBH+1zPtzXqK24iz3fW2N3+szGon4jdixgj27
        LdaKE5cKslJtKnF2bGBrmIBTVA08mlj2bugZUFz/
X-Google-Smtp-Source: ANB0VdboyQ/PSPf9AdoYI2/xn9iFyeJpAvEMzBRGCceV9CBdpFj5SkmhDpiyKGU6MsyB1dSL29+2GCasYbHfmR8YEgs=
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr6124225ljf.102.1537648966670;
 Sat, 22 Sep 2018 13:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com>
 <CAFqZXNuir-8TE7WUHYhw5t446THO=sCjOXv+WAxNDs79e6OTWQ@mail.gmail.com>
 <CAHC9VhQ8dRTzC8vBsUOm8o4LQxVRiwgkSb23xEZwSDfsXhY3uw@mail.gmail.com> <CAFqZXNtqe8fF318pzmxzGaZgO0Mb_cacNKTRRbFNyMFhxUspJg@mail.gmail.com>
In-Reply-To: <CAFqZXNtqe8fF318pzmxzGaZgO0Mb_cacNKTRRbFNyMFhxUspJg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 22 Sep 2018 16:42:35 -0400
Message-ID: <CAHC9VhSoZD1uFX5FmUbLWeSPQS9ii2hyQAKV2yM8PeV5dHm-8Q@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     omosnace@redhat.com
Cc:     linux-audit@redhat.com, rgb@redhat.com, sgrubb@redhat.com,
        mlichvar@redhat.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 7:21 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Sep 17, 2018 at 4:51 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Sep 17, 2018 at 8:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Fri, Sep 14, 2018 at 5:19 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > Okay, with that in mind, perhaps when recording the offset values we
> > omit the "old" values (arguably that doesn't make much sense here) and
> > keep the sec/nsec split:
> >
> > type=TIME_CHANGE [...]: offset_sec=<X> offset_nsec=<Y>
> >
> > ... and for all others we stick with:
> >
> > type=TIME_CHANGE [...]: ntp_<VAR>=<NEWVAL> old=<OLD_VAL>
>
> Alright, that format would work. However, I would still like to have a
> separate type for the offset injection, since it has different field
> structure and semantics (difference vs. new+old). I don't see any
> reason to sacrifice the distinction for just one record type slot
> (AFAIK we technically still have about 2 billion left...).
>
> (Maybe you just duplicated the record type by mistake, in that case
> please disregard the last sentence.)

A reasonable guess on the typo, but no that was intentional :)

As described above, there is no set field ordering for the TIME_CHANGE
record, just like there is not set field ordering for the
CONFIG_CHANGE record.  Why?  We only include the state variables that
are being changed instead of including all of the available state
variables.  Yes, historically there are the "new" and "old" fields,
but I don't see that as a strong convention; the special "old=" field
name helps prevent confusion.

Yes, we aren't really at risk of running out of record types, but why
do we *need* two types here?  I don't believe the ordering/structure
argument is significant in this particular case, and I would much
rather see all the time related state changes included in one
TIME_CHANGE record.

-- 
paul moore
www.paul-moore.com
