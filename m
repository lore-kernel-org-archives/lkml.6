Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC3120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HQWpX4LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfBTSAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:00:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35377 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:00:40 -0500
Received: by mail-it1-f193.google.com with SMTP id v72so17753195itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kl01+T4uMj7fmD2zztnIHo/N79hA0NKHpGCUQv4ZYM=;
        b=HQWpX4LD8TLIWETN2XVwcD7VmunO+scsicoGBECs3kAmSAAI5ujZ+AgASW0MbwBYFl
         uVQeYpjlw9mSUnTHN9oHgov5TEubHSInWwi49SrPEwPvVV76AqhpSHqg1ox/hehkO2aL
         repEEgrPUsi0Y11BT64E1BS0K8KAMRnYeGWCsX7X/onLTNTWGGccoUzNsxSihtsxjzA8
         O9u9ZvOMwVfE1fpU/XoIxPttOt5MuA8zdCNVkxw7CFA8i0ZbvLEVUJupHHGHy6W4CURb
         MY5SRh0DQ4C3Su8Zu1lYLIgR6vpLFCY0UriZah6sBATSiwwlP4Vp8bHcx6631ECAZ5OB
         6lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kl01+T4uMj7fmD2zztnIHo/N79hA0NKHpGCUQv4ZYM=;
        b=HPnFy9ZLiqNzNDZp3yk46PJJGSEvsA7J+UoiIVcq48futtshAyQ03OhoE7oGz1lgcs
         MzV+gol20UOpIvt0e4jcZL2OGyXNHUamexI0eyPGdpIaSErtH9OXVlLW8hNpTMLctBmP
         lZOHWIU/M07935brAeFd/LZKmAhX1KD+mL+JM8Lfj5GChaeDKhFFApKVLzxEv/j0tN0Z
         wvhs0UxUIrGLSlaw2pmbMgT+WPOUPOlLruhZUDH/EQ5gpssz1kvQ1xAdbX3k3zbrTheU
         OEtMwJa0URbWJKW44GW/sWnatGcZyUHAMUmQ5j3CSyFBm5o3bIruv9sRgALPizWoao7b
         YRvA==
X-Gm-Message-State: AHQUAubCFZrHfzlNA3NweIaBDbNfFaApJ5Xl+8FKrHiqk/UCXsjLsOAa
        OYqXAUZ2cZbRyrcNBvbAc9vj/nqM0yseAh2uFt6X0g==
X-Google-Smtp-Source: AHgI3Ia12O452p15xNEX4T/wgW5yi5QFL2B3D1ewjo4maPiXTWNXvXSV4YmZIa4aiOJAHmV1Jzjxdqd95tO7rfNIdnM=
X-Received: by 2002:a24:715:: with SMTP id f21mr5764152itf.103.1550685639592;
 Wed, 20 Feb 2019 10:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20190220014836.20510-1-olof@lixom.net> <20190220085947.GA17969@hirez.programming.kicks-ass.net>
In-Reply-To: <20190220085947.GA17969@hirez.programming.kicks-ass.net>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 20 Feb 2019 10:00:28 -0800
Message-ID: <CAOesGMj8SPbkNS_GOZa6nmBzud03_c-pB=xHMN+LxJdc-1aVJA@mail.gmail.com>
Subject: Re: [PATCH] x86/nmi: ratelimit unknown nmi logs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 19, 2019 at 05:48:36PM -0800, Olof Johansson wrote:
> > Getting notified of unknown NMIs is obviously important, but getting
> > notified on every single one, especially on larger systems with slow
> > (serial) console causes more harm than good when it's a known noisy
> > non-relevant event.
> >
> > So, let's ratelimit to avoid locking up the system.
>
> What kind of bonghit broken crap system is that?
>
> That is; this _really_ should not happen, and this is a bandaid, not
> fixing the cause.

Oh, I agree -- this shouldn't happen, and it's being debugged and fixed.

So, I'm not looking at this as a bandaid to the real problem, but
there's also no reason to DoS the system with prink when it does
occur. If you want to configure the system to panic on unknown NMI
there are already hooks for it.

I'm obviously happy to carry local patches for this, since it's a
temporary problem. But yet again, I don't see a reason to have the
kernel run off the rails for this condition.


-Olof
