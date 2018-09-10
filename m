Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A383220866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laJRrSPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A383220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeIJLLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:11:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34662 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJLLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:11:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so20563359wrd.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KXQz/cUlix1xn6o7UaLdHX6Uh6j32KSOYR/NHWrB3UA=;
        b=laJRrSPiN+7fzXlqpL9NS9ioIKp96e6IyR6lXQ6eVVZ6trikkja0I4UlMIQcI+Fv0/
         roybR34WJ4Gz1sslg78SRomZgTsEoHXOFI8TDfutF/jqY7w92j/Kl2PGKCluxkl+Jo1l
         1NLEaPHYeyZ5lw3ZiBDO950pTWY3ne9gKaRFZ6wqLUfDqo5jyjK6lX8L/ACfKfV01agh
         S6IYnv7wflsLqzQJR+VVwVh3qYpmPuuvIMyZV3zvMQSeVsWFya/cpaXXQIR0igixtghN
         tLaDP5GeJlYuoQfycPn22MYj5ki1uWW+Ft/SPedVeGACR5alPPzvY4fJuo/deq07xUOp
         7WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXQz/cUlix1xn6o7UaLdHX6Uh6j32KSOYR/NHWrB3UA=;
        b=EiOIFaaOJ13b1BLI5jrINzbBmuC1GDXqD/WDQo/go04H+OzyXlo5OiLHR8NuYNxwOh
         KAp6vDFiF83LI9bLU/3orK/SmtcuDxffHbCgaJKQReoH1OyX3ELiyEnOLwc7py1ibDuy
         J7GDVyfcoW00VxXCf8ob9J7pGwn5+skOndm85r/oTIgtkIlJS1PUfbtT9zFSf4Pwmsp9
         jtkQtPdakkWEQmvkA4nHeZEoUgNauArHub6mCDkBXLYXX5SNsUhUEezluf//ZQLl1JpJ
         MZbjPQJDmWKcs32f+iYdHm35FduyQ6Fot6NEjI2uik/RDhFjxzirFiVLPsAjDmQSDxjC
         ztWg==
X-Gm-Message-State: APzg51CjUHD2MgdRuKUhh0p7PdwWvv5KeMl8J/HdQHbZ8hF61iCYpsj+
        rixM6fOzUGO87MCXJZhC2Fs=
X-Google-Smtp-Source: ANB0VdY7NRFjGr6hqCVCErLcIpAj6h+XWAvpl0W46lcVN7b64Tlbxig/CRX/UhWeJTbxK6idV5OiKg==
X-Received: by 2002:a05:6000:81:: with SMTP id m1mr2879871wrx.28.1536560322606;
        Sun, 09 Sep 2018 23:18:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b12sm10623148wrx.11.2018.09.09.23.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 23:18:41 -0700 (PDT)
Date:   Mon, 10 Sep 2018 08:18:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2 1/3] x86/mm/KASLR: Fix the wrong calculation of kalsr
 region initial size
Message-ID: <20180910061839.GA90334@gmail.com>
References: <20180909124946.17988-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909124946.17988-1-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> In memory KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate the
> initial size of the direct mapping region. This is right in the
> old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> 46bit, and only 4-level mode was supported.
> 
> Later, in commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> __PHYSICAL_MASK_SHIFT was changed to be 52 always, no matter it's
> 5-level or 4-level. This is wrong for 4-level paging. Then when
> adapt phyiscal memory region size based on available memory, it
> will overflow if the amount of system RAM and the padding is bigger
> than 64TB.
> 
> In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> 
> Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>

So this changelog has a handful of problems:

 - there's a typo in the title

 - what does 'memory KASLR' mean? All KASLR deals with memory.

 - there's a typo in the second paragraph

 - Please punctuate more precisely: '64TB' is written as '64 TB' and '46bit' is written as 
   '46 bits'

 - '52 always' is accurate but '52 bits always' would be more useful: write out units where
   appropriate to reduce  ambiguity and parsing complexity of changelogs. Also, in this
   particular sentence it should be 'always 52 bits'.

 - s/when adapt
    /when we adapt

 - s/This is right in the old code
    /This is correct in the old code

Thanks,

	Ingo
