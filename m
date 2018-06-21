Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A410208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XooEUluk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A410208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeFUIRM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:17:12 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41674 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932695AbeFUIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:17:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so1260639ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k0g6lmZ49b8ntwBqahUjJNp88VXk44As/Dwja4ypfX4=;
        b=XooEUlukUsJdyI05VPGpwBWbhs29Xifmn8O5LI+S3H/jXySO8MV4NCJAx6fWBY1Wb0
         QaKv/uUt8cqi2JgpItNF8SIDo47Cododd3OHcq3qS1j1P84GRTs7c+mSxwRCqDfNg85J
         M41COioTxzwMEG4MNP2G0AcrnGFFMmVAZhVWfVVDzeI2wd4HyyEAW8zkrnHRhw/EUPao
         1ar2wvP6y7H7VperYr/VwB+SyZztZ5u60hlcRkvj/0T64YHRGRSfKgbmbDEWctje3Ifu
         cu3s993vNhi0GEuQaWrjCXxa0Szsm1A78T5x/g/Su4whXMMVuLzre/5vZXFmD6vRgw8W
         7Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0g6lmZ49b8ntwBqahUjJNp88VXk44As/Dwja4ypfX4=;
        b=rKpfV2j1xZJ9KXQmiNmJtM3XoQHcoVlLcOnfQukV/wZrEuN9yxpZHCVLVg30uzTXBJ
         ap2T8VCwnTkSDBWIU1Lrwa3rQVgbyvq3UcyF3Ka4KYoVyrMzOVptMwxt5gKpGSRZR5J1
         nU6dhVD1b96nd4ZagX7W+mqs6vwlq1R9i7kKgLhw3ua6sw0+EyYk9StpxF8AJgLlRjLd
         iB3g34AIUUcGDESScX62lTO5obOYOAmzAQG6VxDZHXdTqkv3An6FCHsMs78bWjWIS/DW
         osucISFULgwHimVFs/zvtBJu6lCH4DhLH644/avAQ0FMjcjuFbBk2aLHigv9gPRys4ou
         LOow==
X-Gm-Message-State: APt69E1VZAGioOS4BHn6mvEd2cvK0VtTmhJGFxsVYUwMLwzDsVdvnZgs
        az439fL5mK3IZoEWXYNI6QM=
X-Google-Smtp-Source: ADUXVKKeGtZR+5MOI4JZtb/vG0I759QHEPLbn+QmP5AdUgVJemS2ynY+176fa9ukRYlgPfeF3kERgg==
X-Received: by 2002:a17:902:345:: with SMTP id 63-v6mr27788643pld.328.1529569029352;
        Thu, 21 Jun 2018 01:17:09 -0700 (PDT)
Received: from localhost ([39.7.59.103])
        by smtp.gmail.com with ESMTPSA id 29-v6sm9969028pfp.24.2018.06.21.01.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 01:17:07 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:17:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Vyukov <dvyukov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] arch/x86: get rid of KERN_CONT in show_fault_oops()
Message-ID: <20180621081704.GA677@jagdpanzerIV>
References: <20180620125540.228766-1-dvyukov@gmail.com>
 <CAHp75VdR_gDBk7v9WDN1fHc=1q=j2mx3CkTz83SZZWm=pbnczA@mail.gmail.com>
 <CACT4Y+bjdmgdeRLM5kBaf6-vunFwFRD0_zCZX=A-rY+XEEfnEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bjdmgdeRLM5kBaf6-vunFwFRD0_zCZX=A-rY+XEEfnEA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/21/18 09:59), Dmitry Vyukov wrote:
> >
> >> +       printk(KERN_ALERT "BUG: unable to handle kernel %s at %px\n",
> >> +               (address < PAGE_SIZE ? "NULL pointer dereference" :
> >> +               "paging request"), (void *) address);
> >
> > Perhaps pr_alert() ?
> 
> It's the same, right? Make sense.

Right.

In printk(KERN_<LEVEL> ...) people tend to forget KERN_<LEVEL> sometimes,
so, I think, in general we want to see more pr_foo() and less printk().

	-ss
