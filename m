Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85544C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEAE206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUF9xpEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfAGOEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:04:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38435 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:04:08 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so1096088ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1G3UqNIUgpa+idTCbCb/BcNx+wY+IKRFXkMCPa6akg=;
        b=IUF9xpEJlrC/Dmd6eBobXW/p4QTOST3tzwou5pLy5dcrykoNxKSRcidRIZ1F0bfuIC
         Q0ct3V1exhrRSAsYlM39IfvRx/RqrhLjGZM+EHu9lvVMj+Fu0PuJ1uQcKWkebEonAk1d
         P8udVGCs5PAyTW+eu5+oMD6KXpCYGCh5ecDME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1G3UqNIUgpa+idTCbCb/BcNx+wY+IKRFXkMCPa6akg=;
        b=k0HCVBar61Igp0bpBYxlzSNK92wfBQT9v45K65c/nTSCJ9Ng/4wkjK/+2qmt+5RZ0v
         2V4JtSnwSQxnYROIcwmkj/7FM8Q7jDiZBP89gnKWoX9bDr61qYFA0UtQyFUhgFdzaZYZ
         /GaKIbMsUjcRNYxKG1dU6ccYLtCROge2FcRGySLxOGql+0XGtipadwo5WXQgqXAGquBG
         mLWVU+AsFzxGMVrBfYuVpMgur21thCNvBrYClVziRJpkPU7SfANhqm6OtloH9joxIOli
         t20p5GQglkSYdTZPZL+BRDH9FFKncXQmwB9pp+SbjGrdT9kG6XS+VPBD4ljzyIbdyWPl
         XCdA==
X-Gm-Message-State: AA+aEWYoEMGhVaoWEnebjaTje2sye8K/IuIdIb41IInNENz20sAm+gHj
        2UCcQSKAzSd0RC7Bd07YfzxO93qn4YA/w7SzoFz7dw==
X-Google-Smtp-Source: AFSGD/USQJ0YSerNBc6Ucfy3We0y+ijp1wygn3Kb6IZD3VT/nBFU0rk1ZJHRQOlY0eY6K1J8cXG+9f9YXoMVOYc9B74=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr38448187jak.11.1546869846859;
 Mon, 07 Jan 2019 06:04:06 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
 <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com> <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
 <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
In-Reply-To: <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Jan 2019 15:03:55 +0100
Message-ID: <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime interface
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

On Mon, 31 Dec 2018 at 13:32, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 21/12/2018 13:26, Vincent Guittot wrote:
> > On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin

[snip]

> >>
> >> If it is always monotonic, then worst case we report one wrong sample,
> >> which I guess is still not ideal since someone could be querying the PMU
> >> with quite low frequency.
> >>
> >> There are tests which probably can hit this, but to run them
> >> automatically your patches would need to be rebased on drm-tip and maybe
> >> sent to our trybot. I can do that after the holiday break if you are
> >> okay with having the series waiting until then.
> >
> > yes looks good to me
>
> Looks good to me as well. And our CI agrees with it. So:
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Thanks for the review and the test

>
> I assume you will take the patch through some power related tree and we
> will eventually pull it back to drm-tip.

Rafael,
How do you want to proceed with this patch and the 2 others of the serie ?

Regards,
Vincent

>
> Regards,
>
> Tvrtko
