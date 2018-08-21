Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA362170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA362170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHUSHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:07:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50242 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeHUSHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:07:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B477A9;
        Tue, 21 Aug 2018 07:47:03 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4253F5BC;
        Tue, 21 Aug 2018 07:47:01 -0700 (PDT)
Date:   Tue, 21 Aug 2018 09:47:01 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, <ast@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <suzuki.poulosi@arm.com>,
        <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
Message-Id: <20180821094701.685b14d25490fe09ecb32d12@arm.com>
In-Reply-To: <cba4017f-8a81-e47b-1e99-d510ef9b2a67@arm.com>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
        <20180813124642.3d49c082a95fc294d926016e@arm.com>
        <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
        <20180814120910.ed225bbc462c58b09e5d68de@arm.com>
        <CANLsYkxZ_Wts6k9yqJhJf_R5oh74svpcuoNxhtFf6h3mz8U4ZA@mail.gmail.com>
        <20180815093912.GE2427@arm.com>
        <20180815102820.3520d0c3875d2fd82300cdef@arm.com>
        <CANLsYkz0j79+1C-Amz=3+7zw-0VZhnZ+rp5WAjHduEp+WjFs8A@mail.gmail.com>
        <18fe78a3-9a58-cecd-ddb9-d46cbc473b95@arm.com>
        <20180820092252.32dd015afcc5cbf2fe4c7ab7@arm.com>
        <a2edfae3-302e-bbc7-0563-337186fc2919@arm.com>
        <20180820102532.96a90fe59d9ea3785df76a4d@arm.com>
        <cba4017f-8a81-e47b-1e99-d510ef9b2a67@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 09:39:22 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 08/20/2018 04:25 PM, Kim Phillips wrote:
> > On Mon, 20 Aug 2018 15:36:47 +0100
> > Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > 
> >> On 08/20/2018 03:22 PM, Kim Phillips wrote:
> >>> On Mon, 20 Aug 2018 11:03:03 +0100
> >>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>>
> >>>> On 08/16/2018 08:28 PM, Mathieu Poirier wrote:
> >>>>> On Wed, 15 Aug 2018 at 09:28, Kim Phillips <kim.phillips@arm.com> wrote:
> >>>>>>
> >>>>>> On Wed, 15 Aug 2018 10:39:13 +0100
> >>>>>> Will Deacon <will.deacon@arm.com> wrote:
> >>>>>>
> >>>>>>> On Tue, Aug 14, 2018 at 01:42:27PM -0600, Mathieu Poirier wrote:
> >>>>>>>> On Tue, 14 Aug 2018 at 11:09, Kim Phillips <kim.phillips@arm.com> wrote:
> >>>>>>>>> The other thing that's going on here is that I'm becoming numb to the
> >>>>>>>>> loathsome "failed to mmap with 12 (Cannot allocate memory)" being
> >>>>>>>>> returned no matter what the error is/was. E.g., an error that would
> >>>>>>>>> indicate a sense of non-implementation would be much better
> >>>>>>>>> appreciated than presumably what the above is doing, i.e., returning
> >>>>>>>>> -ENOMEM.  That, backed up with specific details in the form of human
> >>>>>>>>> readable text in dmesg would be *most* welcome.
> >>>>>>>>
> >>>>>>>> As part of the refactoring of the code to support CPU-wide scenarios I
> >>>>>>>> intend to emit better diagnostic messages from the driver.  Modifying
> >>>>>>>> rb_alloc_aux() to propagate the error message generated by the
> >>>>>>>> architecture specific PMUs doesn't look hard either and I _may_ get to
> >>>>>>>> it as part of this work.
> >>>>>>>
> >>>>>>> For the record, I will continue to oppose PMU drivers that dump diagnostics
> >>>>>>> about user-controlled input into dmesg, but the coresight drivers are yours
> >>>>>>> so it's up to you and I won't get in the way!
> >>>>>>
> >>>>>> That sounds technically self-contradicting to me.  Why shouldn't
> >>>>>> coresight share the same policies as those used for PMU drivers?  Or
> >>>>>> why not allow the individual vendor PMU driver authors control the
> >>>>>> level of user-friendliness of their own drivers?
> >>>>>>
> >>>>>> That being said, Matheiu, would you accept patches that make coresight
> >>>>>> more verbose in dmesg?
> >>>>>
> >>>>> It depends on the issue you're hoping to address.  I'd rather see the
> >>>>> root cause of the problem fixed than adding temporary code.  Suzuki
> >>>>> added the ETR perf API and I'm currently working on CPU-wide
> >>>>> scenarios.  From there and with regards to what can happen in
> >>>>> setup_aux(), we should have things covered.
> >>>>
> >>>> I think the main issue is the lack of error code propagation from
> >>>> setup_aux() back to the perf_aux_output_handle_begin(), which always
> >>>> return -ENOMEM. If we fix that, we could get better idea of whats
> >>>> wrong.
> >>>
> >>> Why get a better idea when we can get the exact details?
> >>
> >> The different values for error numbers are there for a reason...
> > 
> > But the same error number, e.g., EINVAL, can be returned for different
> > reasons.
> 
> True, but then you can narrow it down by tuning it.

I'm trying to avoid having our users have to do that every time
something isn't quite right :)

> We do that for
> several syscalls without printing any useful messages to debug. Why
> should the perf syscalls be any different ?

Not sure what syscalls you kernel hackers are talking about, nor
whether the work was being done on behalf of an end-user, but things
like mount have the same problem as perf, and perf is notorious for it.

> >>>> If someone is planning to add verbose messages, they may do so by adding
> >>>> dev_dbg() / pr_debug(), which can be turned on as and when needed.
> >>>
> >>> I disagree:  that just adds another usage and kernel configuration
> >>> obstacle.  Why not use pr_err straight up?
> >>
> >> I personally don't agree to usage of pr_err() in paths which are easily
> >> triggered from user input.
> > 
> > Why not?  pr_* are ratelimited.
> > 
> >> Also, we are moving all the "debugging"
> >> messages to the dynamic debug, to prevent lockdep splats.
> > 
> > Are you referring to this?:
> > 
> > https://lkml.org/lkml/2018/5/1/7
> 
> Definitely not that thread.

bah, sorry, apparently the trailing 3 was removed somehow.  Here you go:

https://lkml.org/lkml/2018/5/1/73

> > Re-reading the thread, AFAICT, it was never proven that the splats
> > occurred due to the dev_infos, and there's no dev_info in this
> > stacktrace:
> > 
> > https://lkml.org/lkml/2018/5/10/269
> 
> That doesn't have the stack trace. Mathieu was also able to reproduce
> the lockdep splat involving console lock lately. Unfortunately none of
> these were captured here.

OK, I'd rather we see and properly debug and fix the so-called lockdep
splats rather than hiding them by lowering their loglevel.

> > But even if it were, wouldn't the splats also occur with dev_dbg?
> 
> Not normally. dev_dbg() has to be turned on manually and the user knows
> what he is doing. That allows the normal user to use the system without
> any trouble.

I thought it was obvious that I was talking about when dev_dbg _is_
enabled.  There, the problem still occurs, so you can't say 'we are
moving all the "debugging" messages to the dynamic debug, to prevent
lockdep splats.'

Please let's see the lockdep splat and the proper fix for it instead of
paper-taping over it via dev_dbg, thanks.

Kim
