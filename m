Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017E9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D02089F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEXIu7CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54D02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeKOMWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:22:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38136 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:22:14 -0500
Received: by mail-it1-f194.google.com with SMTP id k141-v6so27055306itk.3;
        Wed, 14 Nov 2018 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQHBAtntwHS5DQK8rKpseSf7SvF6HJrPt72yAzEe/bE=;
        b=FEXIu7CDhACTWR/TYSVLGG+hybOTspf1JcwGY1/2x+oKl+TROmK8xnj+eZD0JHiFqV
         U0TOkI6Z3cvx+slqgU5N35SeeBLyP52XCm1QXrHkpFp+RTm9zSj7TW/FCh0aQ6VyLVRx
         tnsjSy5MAP97vwl0iw11oJI9GQMPTrBVglEsTufPmQAkofeU1JsnN7Pk3Bv00SA1fFbv
         +dVB4syU9IfU5qRsoe9RGinVNQk3OOXJYSdoY2LVtIyLoaOZClyGJGecikEFsC1Tdy6a
         JNwzScTi9fXVMCNba0lkpxRcaV4WlFCErZISIc7wC2MzDWncJ3TZauE54iXvoC+VVU9x
         gJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQHBAtntwHS5DQK8rKpseSf7SvF6HJrPt72yAzEe/bE=;
        b=UJWNuMUbSGn8g8vXojagbT9LULe0+vOAUnb0cUuEaG5ge6KmTRtJRWky/6QmaW8t2l
         Hy709AcWU9/S4u//FYpOrlleptZNS3J6X1+Kz9ef2+Nohg+Hp3dTHPouFsF9Sl19/BOB
         sHijTnRxGeJchNKBz/dbzP0npkcKjWUoXO6Fe57W64SIYl0zTNO0W3wv6IGkPJdz+SKm
         Xy4tQn+xUS1sxLBzjxhAKHEmCafPtNuxkZ1ZBGM9v0zAyiY7FBV7k9grsDofJTOIC9HT
         0LjEgarr08Nsud48vWY/B4c57BQS2Bma7DwLmJSUBnkihPsi6X/0TTg6VdhoSwOVasvN
         pmtw==
X-Gm-Message-State: AA+aEWY+UhzmXR4I+6Z0T1F1JKhKSzl0SnnyLIKPeHb8wMZO2IyEo3wu
        neGNdqTwiYriFW2WW23vi5HTvquBsR7Qt92rvZ43L2KldQc=
X-Google-Smtp-Source: AJdET5e45JDTfAvZ/VCWwh6Pa0jDtE/w3o7M8aLnmP6II4ovWDEm8EtVGMv+AwKz9/4C6ySo/rk+vls8zrTWgwfrr/Y=
X-Received: by 2002:a24:ad66:: with SMTP id a38-v6mr3889058itj.175.1542248183012;
 Wed, 14 Nov 2018 18:16:23 -0800 (PST)
MIME-Version: 1.0
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava> <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com> <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
 <20181111010702.GC6218@tassilo.jf.intel.com> <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
 <20181112032637.GG6218@tassilo.jf.intel.com>
In-Reply-To: <20181112032637.GG6218@tassilo.jf.intel.com>
From:   Travis Downs <travis.downs@gmail.com>
Date:   Wed, 14 Nov 2018 21:15:46 -0500
Message-ID: <CAOBGo4xzvkitZvqnsPMKE3RYwfCsVSe3ng3eJkP2vdi35JSTFg@mail.gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
To:     ak@linux.intel.com
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:26 PM Andi Kleen <ak@linux.intel.com> wrote:
> On Sat, Nov 10, 2018 at 09:50:05PM -0500, Travis Downs wrote:

> LBR is not part of PEBS, but is collected separately in the PMI handler.

Thanks for clearing this up - so you can ignore any earlier
suggestions on my part of trying to use LBR to fix the unwinding
inconsistency.

> >    In the case that PEBS events are used, the IP will differ essentially 100%
> >    of the time, right? That is, there will always be *some* skid.
>
> I wouldn't say that.  It depends on what the CPU is doing and the IPC
> of the code.

Well other than say a long-latency cache miss, it is my experience
that the skid is generally never zero. That is, the PEBS and ireg IP
will usually differ. This is mostly moot though: what is important is
how often the ireg skip results in a different call chain (i.e., a
return occurred between the PEBS point and the interrupt), as you have
pointed out.

>
> Also the backtrace inconsistency can only happen if the sample races with
> function return. If you don't then the backtrace will point
> to the correct function, even though the unwind IP is different.
>
> For example in the common case where you profile a long loop it
> is unlikely to happen.

Agreed.


> Could collect numbers how often it happens, but it would surprise
> me if anything complicated is worth it. I would just do the minimum fixes
> to address the unwinder errors, and perhaps add the "unwind ip differs"
> indication.

As above, I think the most important UX problem is not when the IP
differs, but when the top frame of the IP unwind is different than the
function in which the PEBS sample occurred. I think the case where the
skid ends up with both in the same function doesn't pose any
presentation difficulties [1]. When they are different though, it
seems tough to present a consistent picture.

[1] Strictly speaking, this the "IPs are in the same function" is not
sufficient. Imagine a scenario where you have T->B->A (T calls B calls
A) and the PEBS sample happens in A, and then A and B return, and now
C then A are called (T->C->A) and the PMI happens. Now the PEBS IP and
the ireg IP are in the same function, but the stacks are still
inconsistent. It is probably fine to paper this over and show the user
the T->C->A stack, as this stack is somehow accurate (it really
happened), but the user might be confused when he looks at the
annotation for A, and sees code being executed (having PEBS samples)
that he knows can never execute when C calls A (for example) since the
annotations are based on the hidden T->B->A execution...

Bleh.
