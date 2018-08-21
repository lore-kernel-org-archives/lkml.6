Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D172183D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmdM+VCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D172183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHUUiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36751 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeHUUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so14921921lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhJVq2UVLFY04vF/xJIbhQ5ZujucudCfmHJk6TpRCJ0=;
        b=VmdM+VCKyB1esx0n45h4cEFdesrJGp5oO92ohWrHt41Zk5xETIH4YA00FcUR8Di/SD
         kSdzrZdg1fHK4TwvaOAO4puBULDqI7MNB4nlAyYGmkGdvUg2M4F4le2jlSOWx9n83BCi
         mPEIvkR8AqWi+8pBNRuqWt2zRuQljg1Qub62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhJVq2UVLFY04vF/xJIbhQ5ZujucudCfmHJk6TpRCJ0=;
        b=ek1HhyGjIqPsC2ETbiOzt8oYRJrdiT1hUO2GhCz8G1byEQUaPZmGBJO55GwlWoMp96
         cCZVMrp9SdZRbO8QnQEQz29pROG0wukb5eaagOeBLbkRQbJYioU2hgutebgvDf53xeS9
         x0r7UH0nErWvQmaQm/qfpVCbLLBcs4yEjDSegu45Q740g/vfrvaf5IGOcbVFckGqGvM/
         dnj8lJSmDYDEb1HXuhn+R5J00nDhrxzVEbTiGJcCKjpkZVNnqTkXPo8EX2sN72HkXL1T
         NWLS3dwNDMK3iBvOxSLAIxu2UgfFRDvrl8RlrMIQN3EPgEca55KAe/PajwYoL38N6+UY
         EJKQ==
X-Gm-Message-State: AOUpUlEwSa+JMrBS8JvVTB2RKX0rEZkEPzFuzgIIoSAFuXvKBFP25NpZ
        wsL28qTti300mCpWMeNeeqGE44MEm4/Jvg6AwAG2iA==
X-Google-Smtp-Source: AA+uWPweZztpXZwuBdx5kmIzJuCHS2rXiSFnSV5ZV3odWmTce0oMkKJtYoY96kbA8l9pi3MR41O0x+obAR7MGiK4JCg=
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr11025781ljk.133.1534871820456;
 Tue, 21 Aug 2018 10:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
 <20180813124642.3d49c082a95fc294d926016e@arm.com> <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
 <20180814120910.ed225bbc462c58b09e5d68de@arm.com> <CANLsYkxZ_Wts6k9yqJhJf_R5oh74svpcuoNxhtFf6h3mz8U4ZA@mail.gmail.com>
 <20180815093912.GE2427@arm.com> <20180815102820.3520d0c3875d2fd82300cdef@arm.com>
 <CANLsYkz0j79+1C-Amz=3+7zw-0VZhnZ+rp5WAjHduEp+WjFs8A@mail.gmail.com>
 <18fe78a3-9a58-cecd-ddb9-d46cbc473b95@arm.com> <20180820092252.32dd015afcc5cbf2fe4c7ab7@arm.com>
 <a2edfae3-302e-bbc7-0563-337186fc2919@arm.com>
In-Reply-To: <a2edfae3-302e-bbc7-0563-337186fc2919@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 21 Aug 2018 11:16:49 -0600
Message-ID: <CANLsYkzvEfaoHVLTiUiYAV++O2ZJ1YBzyRMwJLtz_v1=h1uX-g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     Kim Phillips <kim.phillips@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 at 08:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 08/20/2018 03:22 PM, Kim Phillips wrote:
> > On Mon, 20 Aug 2018 11:03:03 +0100
> > Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> >> On 08/16/2018 08:28 PM, Mathieu Poirier wrote:
> >>> On Wed, 15 Aug 2018 at 09:28, Kim Phillips <kim.phillips@arm.com> wrote:
> >>>>
> >>>> On Wed, 15 Aug 2018 10:39:13 +0100
> >>>> Will Deacon <will.deacon@arm.com> wrote:
> >>>>
> >>>>> On Tue, Aug 14, 2018 at 01:42:27PM -0600, Mathieu Poirier wrote:
> >>>>>> On Tue, 14 Aug 2018 at 11:09, Kim Phillips <kim.phillips@arm.com> wrote:
> >>>>>>> The other thing that's going on here is that I'm becoming numb to the
> >>>>>>> loathsome "failed to mmap with 12 (Cannot allocate memory)" being
> >>>>>>> returned no matter what the error is/was. E.g., an error that would
> >>>>>>> indicate a sense of non-implementation would be much better
> >>>>>>> appreciated than presumably what the above is doing, i.e., returning
> >>>>>>> -ENOMEM.  That, backed up with specific details in the form of human
> >>>>>>> readable text in dmesg would be *most* welcome.
> >>>>>>
> >>>>>> As part of the refactoring of the code to support CPU-wide scenarios I
> >>>>>> intend to emit better diagnostic messages from the driver.  Modifying
> >>>>>> rb_alloc_aux() to propagate the error message generated by the
> >>>>>> architecture specific PMUs doesn't look hard either and I _may_ get to
> >>>>>> it as part of this work.
> >>>>>
> >>>>> For the record, I will continue to oppose PMU drivers that dump diagnostics
> >>>>> about user-controlled input into dmesg, but the coresight drivers are yours
> >>>>> so it's up to you and I won't get in the way!
> >>>>
> >>>> That sounds technically self-contradicting to me.  Why shouldn't
> >>>> coresight share the same policies as those used for PMU drivers?  Or
> >>>> why not allow the individual vendor PMU driver authors control the
> >>>> level of user-friendliness of their own drivers?
> >>>>
> >>>> That being said, Matheiu, would you accept patches that make coresight
> >>>> more verbose in dmesg?
> >>>
> >>> It depends on the issue you're hoping to address.  I'd rather see the
> >>> root cause of the problem fixed than adding temporary code.  Suzuki
> >>> added the ETR perf API and I'm currently working on CPU-wide
> >>> scenarios.  From there and with regards to what can happen in
> >>> setup_aux(), we should have things covered.
> >>
> >> I think the main issue is the lack of error code propagation from
> >> setup_aux() back to the perf_aux_output_handle_begin(), which always
> >> return -ENOMEM. If we fix that, we could get better idea of whats
> >> wrong.
> >
> > Why get a better idea when we can get the exact details?
>
> The different values for error numbers are there for a reason...
>
> >
> >> If someone is planning to add verbose messages, they may do so by adding
> >> dev_dbg() / pr_debug(), which can be turned on as and when needed.
> >
> > I disagree:  that just adds another usage and kernel configuration
> > obstacle.  Why not use pr_err straight up?

I think everything on this topic has been said already.  As I remarked
earlier once I'm done with CPU-wide support we shouldn't need detailed
error reporting.  Everything should be handled via error code
propagation and that is what I'd like to see addressed in the first
place.  From there we can think about individual error cases as they
come up.

>
> I personally don't agree to usage of pr_err() in paths which are easily
> triggered from user input. Also, we are moving all the "debugging"
> messages to the dynamic debug, to prevent lockdep splats.

A slight correction here - we are moving most of the framework error
reporting to dynamic debug because they clog the log file and aren't
useful outside of a development context.  It is not a remedy for the
negative interaction between event locking and console access
generated by the framework's reporting of device status as a path is
built/enabled/disabled.

>
> Suzuki
