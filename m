Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B27C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198F92089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjQ8sM4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198F92089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeKKEgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:36:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeKKEf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:35:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so5175186wru.9;
        Sat, 10 Nov 2018 10:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUdZNl057h1ppg7CeFOZ/uN3JSVoi5GN7FTUDrPfd+Q=;
        b=WjQ8sM4FH5jDGFhHV+VNi6a8WSFzTqAieUer8QoNu9eqvcN2L7p+USlkP65WfMKjqg
         dm2GnPcLDpm3xem+fxXJFCYtw5CmNutE55HscK3J+ee8GQ06QYff1WehyV0nfmN+RkKG
         g/gUN5a0qxCgf2uPHJBgH2/UdKIO3sNzVwUoKmiAC3AiZ5oiy/f98T1IxESEhO/9ahBO
         JudB+4t3B5taX1xsZ8NvJ8gJ4938ZWNxHcoCaBWf/A7+mIhWUj7sfqFk9tOl/dOPlj0f
         3aU+dsJhgb7KWc03NEIGFLRLk3l/tOlHQ/Lqws4zgUZ289R5lOPHnXOXZb2KFmdsXQeH
         k3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JUdZNl057h1ppg7CeFOZ/uN3JSVoi5GN7FTUDrPfd+Q=;
        b=fd9pX61c7yrLL/xKTu3LIb5VllAFWGf6t99xLSCGYI9KMbTZPWBwzksEWDl//x/myl
         5Lm2sYZTu4ygWkCnfl0Q0Vq0RXHzhn1m2ij7QzDGIsajPnYZF6CLEurJJ0jlX9YVZcyx
         07H7WTsml9R4x2QzXpxhvN6H57CcAK/6gp1i1NK4xNNE3iYUash4gxJCiQPUowXNlx8B
         wvKT8GqpFWe0fLqs/b/smd1pKApw7Pp7GuNaxYvWEZFHE7weEE+7V0d1i0qk8jiGM2eh
         I7IMqHu1XZKmU76Hql0gKEN26QDPR2BISJKKjxO5UzVBDEP0LW18rCwRyPknHA0VDuat
         uCPg==
X-Gm-Message-State: AGRZ1gIB5ayaGkCCP70KftSbw7FiOO1Ew7xneFYHqqemvw+k40DFjRvT
        sN7+Z7reRJrHopGVeH5eQg==
X-Google-Smtp-Source: AJdET5f8l7mHngcj1bw0jngY2C0+qQFnWUAbJPtZhzpcN9GicE7ZGyrhA1XYz9VPOdJfnP67pZW4Lw==
X-Received: by 2002:adf:a512:: with SMTP id i18-v6mr13145325wrb.220.1541875800321;
        Sat, 10 Nov 2018 10:50:00 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id h5-v6sm17347541wrs.51.2018.11.10.10.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 10:49:59 -0800 (PST)
Date:   Sat, 10 Nov 2018 21:49:57 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     gorcunov@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Message-ID: <20181110184957.GB18252@avx2>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181110174727.GA26417@avx2>
 <1541872563.3175498.1572453416.153B57C9@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541872563.3175498.1572453416.153B57C9@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 03:56:03PM -0200, Rafael David Tinoco wrote:
> On Sat, Nov 10, 2018, at 3:47 PM, Alexey Dobriyan wrote:
> > On Fri, Nov 09, 2018 at 09:30:36AM -0200, Rafael David Tinoco wrote:
> > > Merge proc-self-map-files tests into one since this test should focus in
> > > testing readlink in /proc/self/map_files/* only, and not trying to test
> > > mapping virtual address 0.
> > > 
> > > Lowest virtual address for user space mapping in other architectures,
> > > like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
> > > guarantee that when MAP_FIXED flag, important to this test, is given.
> > > This patch also fixes this issue in remaining test.
> > 
> > > -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE, fd, 0);
> > > +	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,
> > 
> > I don't know ARM. Is this 2 page limitation a limitation of hardware or
> > kernel's?
> 
> Kernel:
> https://bugs.linaro.org/show_bug.cgi?id=3782#c7

Ahh. please test the path I've sent, I don't have arm install readily
available.
