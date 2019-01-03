Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713EBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33428208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="edYGbBxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfACT6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:58:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35378 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfACT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:58:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so30046346edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcaOkKaskc6pwuQXJbemK24OWy2Us/5/O+TjG5KW5ms=;
        b=edYGbBxI+LMizHUYdh8fZKynCLVGzV1OSF+8jWzxiXXjFj71lRYLBHOc00m9+XJuCO
         HQFg1gYrklQauyIxTab68Q1Fp06Y721LjkckUusjXgCPeHJv9vj2N//s5xk355QENyB2
         fZC9lzfLX32K4g+kMGIl06WOSj4fTFW+ezgPfQG10eEk6Cj9ybeM4lfcb10X8/PmVclj
         R9X1QDBtTYLUwZnpKtHOmGEd9JZUSM4CC/tlQ63lxHcGlA2e+aBOhTK/hOGD+ZQd7Ox+
         zSg/Ag8tN47GT3TS4JV4rxDj3HfuWl3Vzv1s6oLHejdaavRrHRumYVYBNViRnIin1s/u
         nBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcaOkKaskc6pwuQXJbemK24OWy2Us/5/O+TjG5KW5ms=;
        b=Lsqnrna5Lq+CIBWEql//xAD37oUCEeVwYtIOkJDuWLDjmT/MB1+EXR5TMgo7bZY/h1
         1TO62OW+T8fcjy+pmLdqeg9okGCpRJQrogGErehOv0jwwbBQaebYqNvaRgRpDVZ/hE4x
         l3zxRwmGkvAaHoPbmcT04SI5STMB5FVAnxHGrgMJc4+YzDKp+zZWqKWJZCbIfHBYvRtX
         TUxYGkOakXe0WK2yx1H+sk5QGIGN7cahHAjTbH1NM7ZEP3oMd4xLvIJvYPZzFtRUJhTZ
         +5mNSSWiqNj2N81uhEiwEU+A72t0XVtOTGh+zTHvfQ6H5uGTcad8mYMUiZBwtypwL2MR
         7bFQ==
X-Gm-Message-State: AA+aEWYApA+xkXkEHL04HbRNWMi4+XqjoHzaVuoTiraFzB19jVkkJTqQ
        OJx7Q67QELAjqRW0pMzR7TdgkaO0zQkJwAYiPOKw5AVcej1p7Q==
X-Google-Smtp-Source: AFSGD/UjNghA7YS+jJdakehZdTH9Y+Xlm+kl+Y5hKRMZ9S43IPNy6YGYTOt0AqNUP5ryWeSqY9EWtgeqVaj+n0ILux8=
X-Received: by 2002:a50:9a42:: with SMTP id o60mr44986597edb.180.1546545516064;
 Thu, 03 Jan 2019 11:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
 <20181226164509.22916-4-pasha.tatashin@soleen.com> <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
In-Reply-To: <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Jan 2019 14:58:25 -0500
Message-ID: <CA+CK2bA_006YGu3dtJM24pN1ZGgcJZnF2oEeWKkq3QBrcCbB6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: Early boot time stamps
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I still think this approach is flawed. You provide the kernel with a
> potentially broken sched_clock that may jump back and forth until the
> workaround kicks in. Nobody expects this.
>
> Instead, I'd suggest you allow for a something other than local_clock()
> to be used for the time stamping until a properly working sched_clock
> gets registered.
>
> This way, you'll only impact the timestamps when running on a broken system.

I think, given that on other platforms sched_clock() is already used
early, it is not a good idea to invent a different clock just for time
stamps.

We could limit arm64 approach only for chips where cntvct_el0 is
working: i.e. frequency is known, and the clock is stable, meaning
cannot go backward. Perhaps we would start early clock a little later,
but at least it will be available for the sane chips. The only
question, where during boot time this is known.

Another approach is to modify sched_clock() in
kernel/time/sched_clock.c to never return backward value during boot.

1. Rename  current implementation of sched_clock() to sched_clock_raw()
2. New sched_clock() would look like this:

u64 sched_clock(void)
{
   if (static_branch(early_unstable_clock))
      return sched_clock_unstable();
   else
      return sched_clock_raw();
}

3. sched_clock_unstable() would look like this:

u64 sched_clock_unstable(void)
{
again:
  static u64 old_clock;
  u64 new_clock = sched_clock_raw();
  static u64 old_clock_read =   READ_ONCE(old_clock);
  /* It is ok if time does not progress, but don't allow to go backward */
  if (new_clock < old_clock_read)
    return old_clock_read;
   /* update the old_clock value */
   if (cmpxchg64(&old_clock, old_clock_read, new_clock) != old_clock_read)
      goto again;
   return new_clock;
}

Pasha
