Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C84222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ri0rsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbfBMG3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:29:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfBMG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:29:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id z15so705875pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sv9/LKEnpYwGLMUP3w3TvtBoynYhwg7Tk2v6eo4unZY=;
        b=X+ri0rsITtoA/OYe22sGYeFft2TPL/q4wEy18AtjSAndTi9CIfufrr1A8Y/Jtm07GQ
         gbaCEAauDg9xk0aLa+XceMUfN0S9dg6DK9s1t3f1xevT3hjLnRUkcqZ8LNJceSa9wzAd
         Sq4k0Dr07STZ2WdGPcPUHX4LKu5q851F0HvwTuPWG5079Yg4B9TYRrNSjJlJ4+KGRFpZ
         qDvaNIA5WbpGxM+VuEUaaVhLHk5hG0qfANFypLiYua4YL1P67UilGHZ99Fc/fWfvPUtW
         /ufX+BwqI4/aH4vYTftaHqRgEHbMKjf1AsE+uDGivUo49DBA+db9c3odpDQlo7ONw7q0
         gP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sv9/LKEnpYwGLMUP3w3TvtBoynYhwg7Tk2v6eo4unZY=;
        b=f2/pqEsB7bzJLqg0iHE2xnGCLLqNSBw66GfjhugSuyLN9W6RBoavVDeOEGEm0VlH9U
         kKqA79ASMrz4OtEHy5t4231Mo/Zv8k76CAtDWjpHQbzuO9sO+qcuOv9e3VTFF9iaq4yr
         nkMg6nM4+i80VgqgdUeECKhGTzqEux9tMI6o9di83J6yp1j+hoCII/xOpavePv70mJZn
         AANLMrHRmVE+9mAD542oJhivZlS9Yd0/ZZdZV/d8BRbLLsMs1WtyMGpQFr7s1g8I19sF
         0519xubUo5Nb5MpHMyxBZDvUHf3HBjvtIoW/isfULBK8B8+2Yv5wtlSvmdCsDyCf3gG0
         VRVQ==
X-Gm-Message-State: AHQUAubHR+POBYdqzBqrrWaulUMhBoC/HasIolCMFV7wNeyjtzgDJLZD
        z5JLD8rJsroCknUpF3WaESw=
X-Google-Smtp-Source: AHgI3IYYHyd+C3sXrRh1nVJLSR/J79qhGqpSFyc1J7/b64pihYUeHLbslTnkx9J+1wy3glA97nAi+w==
X-Received: by 2002:a62:3811:: with SMTP id f17mr8193207pfa.206.1550039357653;
        Tue, 12 Feb 2019 22:29:17 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id d21sm17562572pgv.37.2019.02.12.22.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 22:29:16 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:29:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213062912.GA23233@jagdpanzerIV>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home>
 <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 14:19), xiang xiao wrote:
> Here is my case:
> 1.A small MCU(Cortex M4) in SoC run RTOS
> 2.RTOS append timestamp to log for the accurate timing
> 3.RTOS send log to Linux kernel when buffer exceed the threshold
> 4.Kernel call printk to dump the received buffer
> So I want that printk skip the timestamp here.
> 
> > If anything, I would probably prefer that we export whether
> > time is being printed, and have the caller not print time if printk is
> > doing it already, than to add the complexity into printk itself.
> 
> Actually, the timestamp of our initial implementation like your
> suggestion come from printk,

cat /sys/module/printk/parameters/time ?

Y - we add time prefix
N - we don't add time prefix

	-ss
