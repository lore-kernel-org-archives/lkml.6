Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF470ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF5214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwX70Zx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAF5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIQSZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:25:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40146 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:25:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so7390325plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Et8Wbfh8P0o3lVThR//qMbebAWWevKTzCFTuhNTwbDY=;
        b=XwX70Zx2Wdom181OHnx3zvrC7LeB9nfxFrc/JScpiv7xNagsJOjdJKCCyKR+hcW9aa
         J6PsEFobfZAiCSKwg7OhGn+3OppNMEXXDOOHKevrOawS2C0hIemIEquWBO+xolNlfXnR
         RomRGZ+fltPd60KlkK4hUP+yWnWkcVIcWi18jh3SIgtA6kIFCdZqydK3Z6TOPLkYK6ZR
         wE0G6ADS+hEAfHSsS7ZFz6MmWRCaUI7N1In1OM6ULfXWoVOWT8JS3wKGZUIXxNM/L87t
         ez0cgHaoRhxYHVcYUzsMR/Xkq7Jmejr7ozVtFjQr9Po4UCFPym0JSoWxWpw2+wd1gu6v
         fxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Et8Wbfh8P0o3lVThR//qMbebAWWevKTzCFTuhNTwbDY=;
        b=IyOJMYpk6dyfnRS/b8R8eDDavILGEH3o5ot4PUrJhcsOwBX4z6Uj081Jvx6w5Un8Z1
         zwCND3ns7Oguh0v3kBj/66hgKpyEv1QYLbvAwrSPaQQDh00a49M+wOL3jxMgJdi6bm8H
         hDazoZcuTBIgWf6eXZIYYom6ys+SoWQXKCcYPow1StRLM3P+v2i6Q3ieBevGA3KxanP4
         k+utEQSgPBRSBftdPEIxvi5MQvwSh+AsLVtfLWAEwXFI352VM6P/R5o/0mcbUSWoMZvH
         wq0hHuHOLQECqCMVunEAV8Nk65DC6HiFnQkL0oXiVL5N/WYvnSXst+PMYb0G05x9vC64
         so/Q==
X-Gm-Message-State: APzg51CvVUCMO6nnfL8SFLsjAf6kEBICoDARvo5HUT2MUHU58v3BSrop
        1U/NmAqZPWb2RyVeIFWc41tjJfYo
X-Google-Smtp-Source: ANB0VdaNaK7OoxsMk2TVfypTTPHYdkluLYhwIcoE6N8pUcABCIFS9rjlhBPR41yrnFvixuUtsOBqSQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5-v6mr24786785plt.140.1537189118818;
        Mon, 17 Sep 2018 05:58:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s23-v6sm19052396pgo.44.2018.09.17.05.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:58:38 -0700 (PDT)
Date:   Mon, 17 Sep 2018 05:58:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
Message-ID: <20180917125837.GA20163@roeck-us.net>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 12:22:43PM -0700, Linus Torvalds wrote:
> [ So this email got a lot longer than I initially thought it would
> get,  but let's start out with the "regular Sunday release" part ]
> 
> Another week, another rc.
> 
Build results:
	total: 135 pass: 134 fail: 1
Failed builds: 
	sparc32:allmodconfig
Qemu test results:
	total: 315 pass: 315 fail: 0

All problems fixed except for the sparc32 build problems. I'll keep
building sparc32:allmodconfig for the time being, but I may drop it
by the time of the final release.

As for runtime warnings, the only warning left in my test boots is

WARNING: CPU: 0 PID: 1 at mm/slab.c:2666 cache_alloc_refill+0x8a/0x594

for sh4 boots. This has been discussed at

https://lkml.org/lkml/2018/8/3/773
https://www.spinics.net/lists/linux-sh/msg53298.html
https://marc.info/?t=153301426900002&r=1&w=2

but unfortunately the discussion has stalled.

Guenter
