Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064CA2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Atajst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064CA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeIYSXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:23:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeIYSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:23:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id j25-v6so12478396wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rW/kSYu8LTrr+4zLRwegRUrIu36BbxqKZbqWHu6JcrM=;
        b=E0AtajstKCg7ek8UEOAMGVth6A0GTdaz4E4oGR8vWuEBpncTe3GF8MXJ2ZSkeCGObx
         1gwUPoDVZcbfvfLgqTdDZCqB2pfAR+dwrsdwI/ERBzlwUvOmyMcRf2vkFW5LtWicX2or
         vRRlCpBVik2qxppjndHWnGDaz4e8J2nhyHDA0qN3qQ8nbv2u9/qh0K5YbfPB+7fevygB
         ty3K8zOHfIBA3cxNCjdC+emOUWhssOBoJ/b05peoHG8NdMhZ6yJIheXXYDDonmF1fnzi
         VtJOSsP3TZg/W09iJSdE+LxylDzSCv8G8XfixoMpqeCdF3An3IjOzRYbHOaJtLbZ1zHK
         ljOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rW/kSYu8LTrr+4zLRwegRUrIu36BbxqKZbqWHu6JcrM=;
        b=kCTZLgZIeutNJK1P7Rpd53yqPHx40seD9lvTRrGA1X/8v+lncghGIluU1oTveZmEHg
         fo5f0gAHzaOMkj77mgadV20kWDJ5rvPaYH52gbvLKuy9oRHATZpep0XgMY6P9fCoOAjt
         T8F5BIntgcXi1iqmanWSeC6QgZCOsOMNmdOswMnDUNAiRoCsK9WjsaGj5kbZ7/UHJitw
         0ahuUIw8bpL25geW/YQtsWy5y3Ypi6IdctIA19wFHEeO7tr9SUn+yqKr0B7N1G8r8NiH
         Tqee5Ph/X1cSRdDAa0jubEOE5HznjP7on+S0ql0Pq+vT17d/kSgixD1kx+5vQ6mzrRMv
         iDJA==
X-Gm-Message-State: ABuFfogN0n1VwpJ2xMAH4F+pQX+Nmpp1sTGVzvNEArr5JM+LAHAQm7KJ
        teI7DwG7qOncwHY/WmelP6M=
X-Google-Smtp-Source: ACcGV62RvyRhqh/tjtQmFymRfgcwir9/vcWSZRQ8o1iBhCM6RsHKG53E6VzhMcdrgR2xxKTwNXUB8A==
X-Received: by 2002:a1c:cf8a:: with SMTP id f132-v6mr518383wmg.0.1537877774210;
        Tue, 25 Sep 2018 05:16:14 -0700 (PDT)
Received: from localhost ([178.121.95.75])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2837809wrd.74.2018.09.25.05.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 05:16:13 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Sep 2018 21:16:04 +0900
To:     He Zhe <zhe.he@windriver.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925121604.GC523@tigerII.localdomain>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
 <02b53bc1-3803-50b1-d07e-a7962f9e5688@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b53bc1-3803-50b1-d07e-a7962f9e5688@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/22/18 23:36), He Zhe wrote:
> I'd like to fix the above issues. But can I have your opinions about how to
> handle the syscall?

Hmm. This part is complex, I need to look at it more.
A signed int is a good buffer size limit for 32-bit user space.
But this also means that syslog might experience some problems
doing SYSLOG_ACTION_READ_ALL on a 32-bit system with a 4G log_buf.
Not to mention SYSLOG_ACTION_READ_ALL on a 64-bit system with a
log_buf=32G. So *maybe* things are alredy a bit broken in this
department. Dunno, need to think more.

	-ss
