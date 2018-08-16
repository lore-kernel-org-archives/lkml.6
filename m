Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E73C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A3120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuOZbDp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A3120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeHPW3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:29:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47010 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:29:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so4533611ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZw5OvJEl/OX00lGTUCtJvtdlkyYzSrrr3qXGoEaEQ8=;
        b=HuOZbDp0BOD4KVtJ9Ng/Ct9JXscJs2oqXQfEiNtDYaEBY4SsFV1xgEJh4mdWaBZKnb
         nsxj9icoMV4nVNivVHYMPUJZHFxk3yPPpYPtmWXf1KWTZMt/tO/H7vnrcF/JBh28M1Gm
         I/HnFRs2rTv2H5eZ8hDTydFzfuJZmkynOWBx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZw5OvJEl/OX00lGTUCtJvtdlkyYzSrrr3qXGoEaEQ8=;
        b=QE8n+knOZ1GXBAnuntFoKq68kKHuWCPxiLrr/duDMxecO+D35bzjM5wnykBjuGDmpN
         u8vq59O85597SDUYOancS38RNSLk9MGSS+TNgIvPVlotMYOKyu5iyAxoWdjSeZCPFHzW
         QXt8dRTl7BXwkZ1ua5ag1jJ22TmQTHodfewKHHJbRkeYhYJ/3PQ5FeNzhVJTjQCHZlL3
         4sB3LvRYyRJz6A6V9po/Tli8/KeYMfVwWa90qWn5CqQPk63ENy5gy0XCVg0XDgTFTv4I
         AkGF+nbisyzTDntJ2sMfMEZwujNrmLmWbkLRic7hCXY1Ow3RlbwheDIKnx5RtF1id5Sr
         IfAw==
X-Gm-Message-State: AOUpUlF7vQjKhUsOjMteOWjiHdWt2gSbQW1hvkOsqCuG1SYuRPbHek9y
        FydyEP+iuVHIyD7MRXi3kWb5BpAB2c1PfEiRXqZUjQ==
X-Google-Smtp-Source: AA+uWPws4TTWxh7IoKzQE1qmNc2gX9VRkbpnw2FJCEfX6T3RjWjcesMLTBmL92TLvSURthmzFGIuEMnppoO3jsO0eVE=
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr23212403lje.105.1534447720057;
 Thu, 16 Aug 2018 12:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
 <20180813124642.3d49c082a95fc294d926016e@arm.com> <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
 <20180814120910.ed225bbc462c58b09e5d68de@arm.com> <CANLsYkxZ_Wts6k9yqJhJf_R5oh74svpcuoNxhtFf6h3mz8U4ZA@mail.gmail.com>
 <20180815093912.GE2427@arm.com> <20180815102820.3520d0c3875d2fd82300cdef@arm.com>
In-Reply-To: <20180815102820.3520d0c3875d2fd82300cdef@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 16 Aug 2018 13:28:28 -0600
Message-ID: <CANLsYkz0j79+1C-Amz=3+7zw-0VZhnZ+rp5WAjHduEp+WjFs8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

On Wed, 15 Aug 2018 at 09:28, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Wed, 15 Aug 2018 10:39:13 +0100
> Will Deacon <will.deacon@arm.com> wrote:
>
> > On Tue, Aug 14, 2018 at 01:42:27PM -0600, Mathieu Poirier wrote:
> > > On Tue, 14 Aug 2018 at 11:09, Kim Phillips <kim.phillips@arm.com> wrote:
> > > > The other thing that's going on here is that I'm becoming numb to the
> > > > loathsome "failed to mmap with 12 (Cannot allocate memory)" being
> > > > returned no matter what the error is/was. E.g., an error that would
> > > > indicate a sense of non-implementation would be much better
> > > > appreciated than presumably what the above is doing, i.e., returning
> > > > -ENOMEM.  That, backed up with specific details in the form of human
> > > > readable text in dmesg would be *most* welcome.
> > >
> > > As part of the refactoring of the code to support CPU-wide scenarios I
> > > intend to emit better diagnostic messages from the driver.  Modifying
> > > rb_alloc_aux() to propagate the error message generated by the
> > > architecture specific PMUs doesn't look hard either and I _may_ get to
> > > it as part of this work.
> >
> > For the record, I will continue to oppose PMU drivers that dump diagnostics
> > about user-controlled input into dmesg, but the coresight drivers are yours
> > so it's up to you and I won't get in the way!
>
> That sounds technically self-contradicting to me.  Why shouldn't
> coresight share the same policies as those used for PMU drivers?  Or
> why not allow the individual vendor PMU driver authors control the
> level of user-friendliness of their own drivers?
>
> That being said, Matheiu, would you accept patches that make coresight
> more verbose in dmesg?

It depends on the issue you're hoping to address.  I'd rather see the
root cause of the problem fixed than adding temporary code.  Suzuki
added the ETR perf API and I'm currently working on CPU-wide
scenarios.  From there and with regards to what can happen in
setup_aux(), we should have things covered.

>
> Kim
