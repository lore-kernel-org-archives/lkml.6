Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03013ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A197F214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PrNmi/Rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A197F214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeIQUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:04:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33016 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:04:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so13837634lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvcYDOZzMlpWw9iZ9Xf7XiARsGauY32eqDn8b34M7TM=;
        b=PrNmi/RvKx3QbOvQsjxd3Hu8ZQkdLPTNSF2k3eo/kiZaYmKC89LMUID5v6G7K4SeuZ
         xftPSGHhsnlpTTVt7RM8NprN9lHcHKcdM8vV24Lj4ytOUDC0VRq4Y0Lxv9/ebdx2kcF6
         bnBfLOuJqX6VR7KKo89ZO8xcpX2czAxlP+8I14aNEmvJFQ1BQG3IhdBHAhdKc+6Ut/Md
         9a9zlGDhPGK8ZpylIMJVbbhV1mDrhocrNjdjuVvdhA+FLgsHo+9foN01O1nWJY2ussVc
         QMYbRdfIFhRSVPXD3u31tVV5M974sNIotuCX19vRledsfA/iEOlRIhVyO/xHDZM+biCk
         6GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvcYDOZzMlpWw9iZ9Xf7XiARsGauY32eqDn8b34M7TM=;
        b=HCCxlnhX6fYMLZElq4/5VU9gOuTlS9OFfegBitD92RVyIlOh6LfXmaajHLiU1JMO8m
         0DV6PMMbvTWy7UVMy5c66i7MzUHdVuy0RgXiXmLCpol19h211yWm9yItZiwN+5s38zJq
         fixZGNEq4/oL3HxBCGmSy+TwtsYih/qqaS89qCjpHCkVWVwjk21sN4amGPhJ0lk32/UU
         Cv9ydgd/ZlF9AbdA9s+lQjDLw7f/HKkPs7OmcntzmERRC9zAW2Frh4IsSRDSRMmO4kPB
         5wgOJDgxpSXONSgh/tWV87swozYCK9D2BQog57BkH9WUxnQqrtUWIZL5SgKXdh1NabZz
         sVuw==
X-Gm-Message-State: APzg51A9TpjXsKihKpHPSj6iMMXGpV1CDtw74UyYoScrVxvJb6CKndA7
        tFxhlo/nW8KWNYPSkud9pcU95mPUAQfkSCXoueMe
X-Google-Smtp-Source: ANB0Vda1kCZTApgAaEt3Kf1kanjizTiQxfFc4ruDasANXX9A7IKkavq4/Ft87ajj3LG+JuP9WEhbdIWWpR1BXaYSfHI=
X-Received: by 2002:a19:14d4:: with SMTP id 81-v6mr6812213lfu.26.1537195021751;
 Mon, 17 Sep 2018 07:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com> <20180914151643.gwvm5te4nvion5ex@madcap2.tricolour.ca>
In-Reply-To: <20180914151643.gwvm5te4nvion5ex@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Sep 2018 10:36:50 -0400
Message-ID: <CAHC9VhQoBAHMU6stwH3v9cOU+QX1QDP3y-UpO35z8VtEr3Q3xQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     rgb@redhat.com
Cc:     omosnace@redhat.com, linux-audit@redhat.com, sgrubb@redhat.com,
        mlichvar@redhat.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:21 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-09-13 23:18, Paul Moore wrote:
> > On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This patch adds two auxiliary record types that will be used to annotate
> > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > been changed.
> > >
> > > Next, it adds two functions to the audit interface:
> > >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> > >    offset is injected by a syscall from userspace,
> > >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> > >    variable is changed by a syscall from userspace.
> > >
> > > Quick reference for the fields of the new records:
> > >     AUDIT_TIME_INJOFFSET
> > >         sec - the 'seconds' part of the offset
> > >         nsec - the 'nanoseconds' part of the offset
> > >     AUDIT_TIME_ADJNTPVAL
> > >         op - which value was adjusted:
> > >             offset - corresponding to the time_offset variable
> > >             freq   - corresponding to the time_freq variable
> > >             status - corresponding to the time_status variable
> > >             adjust - corresponding to the time_adjust variable
> > >             tick   - corresponding to the tick_usec variable
> > >             tai    - corresponding to the timekeeping's TAI offset
> >
> > I understand that reusing "op" is tempting, but the above aren't
> > really operations, they are state variables which are being changed.
> > Using the CONFIG_CHANGE record as a basis, I wonder if we are better
> > off with something like the following:
> >
> >  type=TIME_CHANGE <var>=<value_new> old=<value_old>
> >
> > ... you might need to preface the variable names with something like
> > "ntp_" or "offset_".  You'll notice I'm also suggesting we use a
> > single record type here; is there any reason why two records types are
> > required?
>
> Why not do something like:
>
>          type=TIME_CHANGE var=<var> new=<value_new> old=<value_old>
>
> So that we don't pollute the field namespace *and* create 8 variants on
> the same record format?  This shouldn't be much of a concern with binary
> record formats, but we're stuck with the current parsing scheme for now.

Since there is already some precedence with the "<var>=<value_new>"
format, and the field namespace is already a bit of a mess IMHO, I'd
like us to stick with the style used by CONFIG_CHANGE.

-- 
paul moore
www.paul-moore.com
