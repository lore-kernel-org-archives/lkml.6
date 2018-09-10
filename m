Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB0C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNv+9FV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB0C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeIJSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:12:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIJSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:12:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so21944274wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xu8ciilrk7ZUVKPh8CUy46PnshhIPmddPuu0CGGW+0M=;
        b=GNv+9FV5vWv/8s4yuyYpU4Hv5ws0adk3iF3svqq2J3o9SjytucAAzrPRzZdfeJ2uer
         lN8D8IfEMk9Ewxl3z60Llr3jRwkcFCbF0Qbd1k26RgkSqpV+hjOCQ1LRwqRIWny5HTnj
         SB211bfEzBoDsNXWpSjH+V3bo6oBq9uKOzefKG/eCKIyNqgl53OJEGbZkwRsTjn3pQfA
         sO48DAASRLCkSOGv1XvKBX23agKc6Hd7hMEVdQnl8n0MCVsJsArvmbd9x+qOvFrDcCJq
         +FQa1B5SGZe7F9GFJpERtuKVag6G9v8RkImsYB02fT37e6SWJRgdxBGcdb5cvUhaze7E
         0P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xu8ciilrk7ZUVKPh8CUy46PnshhIPmddPuu0CGGW+0M=;
        b=QQ5VRN/hpOjVQx7CrwdXVuX7KvJlo74t0k0cDGtjESH+vXVPcFUf9WECud4UXtDzFB
         o/YTDTBD4yGfN41bzfUdpo1BMUkqi01uDZrdWiXVtI6vg/KCxS3lsbKfUlmI76D7PjF5
         gaOhKLK8fl9A7j0ObIivmrPLZb2ZS+Hum6oqLu73CxglqV3jusmLs9v3HmDp8zmojQiz
         oCYJeECiUJhevo/ffROdwW4FgcnoQ0EBEyUxbVDnx9Rmwu5jz36llDXb9a/B6FDRj1K8
         24tVHx8KfviG0J+hLPWejMnkh3JzBIfqCloASI90wvt6uZEsAgqHCgJcbSMRmld6z9KM
         l5jw==
X-Gm-Message-State: APzg51BdCrl73Ld+q0RFd7UD4MQbnC7NWu2vse9Z8VCAmYlHtOk6P28U
        w/z3pHlgBCOeMY3yxEREtRQ=
X-Google-Smtp-Source: ANB0VdaQzbQc6Qrnswd7ow9RDOF0QEDOgXUBHhq1uxzqheB7nHCuvAtDfK6HaaBX1qIdUXlyT3VQQQ==
X-Received: by 2002:adf:ed88:: with SMTP id c8-v6mr14994712wro.264.1536585483419;
        Mon, 10 Sep 2018 06:18:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p11-v6sm17647055wrd.74.2018.09.10.06.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 06:18:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:18:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] x86: optimize memcpy_flushcache
Message-ID: <20180910131800.GA41487@gmail.com>
References: <20180519052503.325953342@debian.vm>
 <20180519052631.730455475@debian.vm>
 <CAPcyv4jpY0x7kZtT+afAKnHKy8Uy1AC_N_QM7RrELSj_0iNrRw@mail.gmail.com>
 <20180524182013.GA59755@redhat.com>
 <20180618132306.GA25431@redhat.com>
 <20180621143140.GA14095@gmail.com>
 <alpine.LRH.2.02.1806211224470.19940@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622013049.GA12505@gmail.com>
 <alpine.LRH.2.02.1808081720460.24747@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1808081720460.24747@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikulas Patocka <mpatocka@redhat.com> wrote:

> Here I resend it:
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> Subject: [PATCH] x86: optimize memcpy_flushcache
> 
> I use memcpy_flushcache in my persistent memory driver for metadata
> updates, there are many 8-byte and 16-byte updates and it turns out that
> the overhead of memcpy_flushcache causes 2% performance degradation
> compared to "movnti" instruction explicitly coded using inline assembler.
> 
> The tests were done on a Skylake processor with persistent memory emulated
> using the "memmap" kernel parameter. dd was used to copy data to the
> dm-writecache target.
> 
> This patch recognizes memcpy_flushcache calls with constant short length
> and turns them into inline assembler - so that I don't have to use inline
> assembler in the driver.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  arch/x86/include/asm/string_64.h |   20 +++++++++++++++++++-
>  arch/x86/lib/usercopy_64.c       |    4 ++--
>  2 files changed, 21 insertions(+), 3 deletions(-)

Applied to tip:x86/asm, thanks!

I'll push it out later today after some testing.

Thanks,

	Ingo
