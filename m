Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D225C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9BE2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="C2xuymXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9BE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeJAXeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:34:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37348 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeJAXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:34:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so10924395oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGcKHCh6bs6/NCaS/KuIoAbeGjx6JVZJyOP2XH97EKs=;
        b=C2xuymXnJHmN8aCbXDo2CGOHUJF508/CUJWj5ASpxFz0cNZjxix3vZGcF7M3vQnoII
         6TWL2ChN9JdM6ol6M7ER430zbuKT63CFff3BqKd6B7iG2kQ4mjivUYlc8wxuc9QJT17a
         1r+hlVhi0uATT2Wv6bfAW54TSr8Vi9FDStPuLXVEnKfFOFFNCWLXcaJehHICACzRYRV9
         GUKO77xFrkme5wXXq35DUCvxJgRhrgxphxqObswr463UjkD0KQW9nDtZPpDzi1nAayls
         AZ0laLKk0hF8WY5YqkbfV5YZ9WJiwPNlUiKCn92E00yvKKI++5p1CNfZaJZoEW6tXxhE
         XAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGcKHCh6bs6/NCaS/KuIoAbeGjx6JVZJyOP2XH97EKs=;
        b=Z4+5+oEoEs+tLtTQMSDhun5hVoMYalHNKnX3wmiltjf4UxAPD9IBsHdAfltcR45Iw5
         EidAdAKLCCGOVG6xaMvwlW8YAWMUjAlFTZB9Fn3Pe/N/2SW0pXTYTVF0CcchNXDRKVn3
         nd48iWrwEXheTlHxa2TJs2Vo3SgQSF8ED8GJHjju6qgiwB0+CZaDgQriUPyhZreWhcg/
         4fmLKCk2ektptvo5P2xJImvoMrYGDIlkaQ15PosHqs+ci0N/ecvNifx8iuAlC8qSS44a
         pmutv8ERpTuSD9gDH33ba9v4Wu/FsVEeCHVdta4Bw2su0dIuXqMCQm678L0J8khggX56
         nutw==
X-Gm-Message-State: ABuFfogkqebvzToxkO5BBzSK3MuByCw8l63qEXgDnsdN6FE1qKez4Jrf
        yoIX/tqaS2kpSTwU4k4i4G/DoSZ5biUpmL+fRO9RKoJm
X-Google-Smtp-Source: ACcGV61t95RNoGw9GhXwsMQSbvsOjDxWX0IvisrED9PemI3TunJhKZpieCe1eQgl2qZqWdFuqXeYMqLqaMyqNbJY/RQ=
X-Received: by 2002:aca:60c1:: with SMTP id u184-v6mr5081042oib.99.1538412961486;
 Mon, 01 Oct 2018 09:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <153816098159.2233877.8382846671636531035.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3cf89dd3-a024-dbab-36ed-923f9466669c@linux.intel.com> <CAPcyv4hi7XLAswcoWEKOcQq_0FCTybxTUd_4H+mJj0S7BkTCjg@mail.gmail.com>
 <9f24ed83-5fea-da70-5470-36992b90c521@linux.intel.com>
In-Reply-To: <9f24ed83-5fea-da70-5470-36992b90c521@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Oct 2018 09:55:50 -0700
Message-ID: <CAPcyv4jh+qERkoAfiJ47HPG7TCHi+ktm3+CrK6rqrfXGVRi47A@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm, dimm: Maximize label transfer size
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 8:41 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 9/28/2018 4:03 PM, Dan Williams wrote:
> > On Fri, Sep 28, 2018 at 3:44 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> >>
> >> On 9/28/2018 11:56 AM, Dan Williams wrote:
> >>> Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
> >>> operations. Given the expense of calling into firmware, maximize the
> >>> amount of label data we transfer per call to be up to the total label
> >>> space if allowed by the firmware.
> >>>
> >>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>
> >> This looks mostly fine to me.
> >>
> >> The only thing I am not certain about is if we want to use the raw
> >> max_cmd_size value or not since there is no guarantee it is aligned to
> >> any sort of boundary. It might be beneficial to either cache line align
> >> it or align it to 256B if it is larger than that since that way we at
> >> least would be getting full labels instead of partial ones.
> >
> > If we leave any portion of the max transfer size unused it just means
> > we're that much more likely to need an additional call into the ASL
> > interpreter. That said It might be worthwhile capping the max transfer
> > size in case the BIOS specifies something extreme (> 1MB) in the
> > future.
>
> Actually it all depends on the size of the max transfer versus the size
> of the label area. So for example if the label area is 128K and the max
> transfer size is 64K minus 32 then it doesn't really make much
> difference until we get below 44K for our max read size.
>
> My main concern is that I don't want to waste resources on allocating
> memory that isn't needed. For smaller allocations I agree we need to use
> everything we have to minimize calls to the ASL interpreter, but when
> max transfer sizes start getting large we are just allocating multiple
> pages of memory that do not need to be used.
>
> If nothing else I can look at doing the logic to reduce our memory
> allocations as a set of follow-up patches.

Sounds good, I would like to get smarter about only needing to cache
the portion of the label area that is in active use. However there is
at least one bug around simultaneous label updates that I want to
squash before we make the label handling more clever.
