Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D917EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847FC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMiyA17n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847FC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIFBHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:07:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43509 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIFBHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:07:16 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so7079503ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6DxylLr/YiUzXV5RmOTu6Mbl/BCWyKG6XOwKTdCzOY=;
        b=MMiyA17nMp1AdpzA62Cm+LrrQWY7XhfbH8kByicmOu4e6W7BxX2pokcQomNSsuU9Z2
         EpfnPsJjI9Ml4BwgRwuYu/Y8tmCvofVscZ3x4JvmebR+51sciPv5RwuYvnNLTxRmsnF2
         ZVqX+Bs+b/lxc8HnC45dh32hjsrY0vwmlu4mtNE+O0A2ZVe/1+Qi+TYFvBPY8LKj1/F9
         eaj8Vg6tJPFZVBVVbBL85XOzhD/MnIpGCgVH5P7Nd+Vv+SKIissmV/5qOONdNMdcvSBT
         jj/5dRlceHH/c78qkqWtoJDJHmZNHPaMycgaXqtt6tXegsApJq6TbPFAhOIBNQ65Rdbl
         k6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6DxylLr/YiUzXV5RmOTu6Mbl/BCWyKG6XOwKTdCzOY=;
        b=ELPVjDWzmzXA6rzoYSCVtToWHbV4BjYuU6me0fE8Ov3miT52NtKM120CaqDr9dmwVC
         J5VY2PtuAbKKKUPkXz7DLycUokibAZ/vYa5wPGAfLSxKDQ00mYpCQdFOZBsYoYH92wAD
         RpFxCLI88uNFgqgnqdWHKmsixEB2bsu5R0N3J8QyNiJnQuWmjG0HOc3RW9E0VFwOFXD1
         W1CUEuRfhrJP7zhcWc+s4Q6Vz0qPduCg/UK3lC3p39l4HMpTboBsESF9llsFalo8kTkk
         0ckbkPVI0c9sOSA1kVHldCOkByb4yV3fzO768tWH+DogFAuGq7FKNL+7MN/COOPTq0Of
         s+CA==
X-Gm-Message-State: APzg51AJ8JhNCm9INSXijV//OpouLt/TFFxV375eAO6qs8e+Wcr71QDs
        7gULSdOrm2qGOtF+oQ21yPvfvOsS6fMGl1l+17E=
X-Google-Smtp-Source: ANB0VdbPigqD2wogyvNJrWMX1Swg6aTmKip/Iu+ho2u0K5C3SvVYAy47qmlb8I1UfQThRYO1pGJ7wWZy3shuzPde85w=
X-Received: by 2002:a6b:cac3:: with SMTP id a186-v6mr27250299iog.116.1536179723982;
 Wed, 05 Sep 2018 13:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183345.4416.76515.stgit@localhost.localdomain> <20180905062428.GV14951@dhcp22.suse.cz>
 <CAKgT0UeT1dL0VNMo1RSDkjABYBGLKjMsz5LsE_ML-EV+w2OURg@mail.gmail.com> <ec060d9b-d313-417c-4389-2ac7b482f94c@microsoft.com>
In-Reply-To: <ec060d9b-d313-417c-4389-2ac7b482f94c@microsoft.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Sep 2018 13:35:11 -0700
Message-ID: <CAKgT0UdtgaZv5sjAcSe8-UYsxoji4scbJTRvTECZDpt+TPM+FA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
To:     Pavel.Tatashin@microsoft.com
Cc:     mhocko@kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 1:22 PM Pasha Tatashin
<Pavel.Tatashin@microsoft.com> wrote:
>
>
>
> On 9/5/18 4:18 PM, Alexander Duyck wrote:
> > On Tue, Sep 4, 2018 at 11:24 PM Michal Hocko <mhocko@kernel.org> wrote:
> >>
> >> On Tue 04-09-18 11:33:45, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@intel.com>
> >>>
> >>> It doesn't make much sense to use the atomic SetPageReserved at init time
> >>> when we are using memset to clear the memory and manipulating the page
> >>> flags via simple "&=" and "|=" operations in __init_single_page.
> >>>
> >>> This patch adds a non-atomic version __SetPageReserved that can be used
> >>> during page init and shows about a 10% improvement in initialization times
> >>> on the systems I have available for testing.
> >>
> >> I agree with Dave about a comment is due. I am also quite surprised that
> >> this leads to such a large improvement. Could you be more specific about
> >> your test and machines you were testing on?
> >
> > So my test case has been just initializing 4 3TB blocks of persistent
> > memory with a few trace_printk values added to track total time in
> > move_pfn_range_to_zone.
> >
> > What I have been seeing is that the time needed for the call drops on
> > average from 35-36 seconds down to around 31-32.
>
> Just curious why is there variance? During boot time is usually pretty
> consistent, as there is only one thread and system is in pretty much the
> same state.
>
> A dmesg output in the commit log would be helpful.
>
> Thank you,
> Pavel

The variance has to do with the fact that it is being added via
hot-plug. So in this case the system boots and then after 5 minutes it
then goes about hot-plugging the memory. The memmap_init_zone call
will make regular calls into cond_resched() and it seems like if there
are any other active threads that can end up impacting the timings and
provide a few hundred ms of variation between runs.

In addition there is also NUMA locality that plays a role. I have seen
values as low as 25.5s pre-patch, 23.2 after, and values as high as
39.17 pre-patch, 37.3 after. I am assuming that the lowest values just
happened to luck into being node local, and the highest values end up
being 2 nodes away on the 4 node system I am testing. I'm planning to
try and address the NUMA issues using an approach similar to what the
deferred_init is already doing by trying to start a kernel thread on
the correct node and then probably just waiting on that to complete
outside of the hotplug lock. The solution will end up being a hybrid
probably between the work Dan Williams had submitted a couple months
ago and the existing deferred_init code. But I will be targeting that
for 4.20 at the earliest.

- Alex
