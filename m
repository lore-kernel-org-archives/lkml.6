Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD83C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE91D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn+kgZz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE91D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeLMMk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:40:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36846 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeLMMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:40:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so1024199pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9lBXaRBoDvXn0j5hqFOxEDzTKNWUEI+JAXuXjli6Ao=;
        b=dn+kgZz8GiH8eJtkfL0gy9tukG9H+m4GS4FZou/h+UY9eBv6ilZJB8LS614NG4N1Hc
         XfHbPxMRrdZZ+fAamQiXFu+QW6uRQOY/JEmJvlO35rnP5Z7s1Eu7uy0jg5/5aOCa1q5K
         BR6JoFiJksUphFQfiafaJD81OZzouZ69DHbZO8QlCwqarRQZ4Jw3fMMxEvtF7+mhLAmD
         lweD56g6TFRCUXhzMLWR04fossmpxisKMcw1hNcrdW6CraKaEET3fIbmc2WR+ku5n8Yz
         DedPJfxIRm75SU6oKFJFwa2fplKpA+9HypgmjEHVktLBpy11haOiPLIVUGyfjZHl0bYR
         sE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9lBXaRBoDvXn0j5hqFOxEDzTKNWUEI+JAXuXjli6Ao=;
        b=OVv6pvzkfgYG7KbEWd5hRAvQzzv6CJ/cSPVgElLjiXZDy9wHvTG+zx6osk8zIWz+Gl
         MsSGG3ifncZabYLioH9IFpyofPQkTkllNaA1wJB+jQJZ6WK3D3bE/QM/H98vmWB7YEcn
         GdkE58k510FZv73KSG+QuweQ1TWOLuKfU8q9/eQK39pyB3JqKv6mXrGi74bikG6uyt+T
         d8egaNi6CDEWI6KjOKTTtldvRxhHEyaw/OCH6VoxJb7xusikWs63dvFN/0TbCVrBvNCb
         bvxFYLEgYMZ9GyPZy4mDvK/UpmeWhrfdHAUuXceAP8o27f3kRT+i+RHzoC5fUkOWNl54
         5H4Q==
X-Gm-Message-State: AA+aEWZkhjfu1L3Ktqj8QxZxJshHuutaFzHbtuCDCdjx3E0pre+7/5Q8
        bZPuvcKp9BN6IuVwF+DjJik=
X-Google-Smtp-Source: AFSGD/W6TmcQjj3jQBN1A+iCoE6sXnNjqerAYS/1c+xIunbql/5lZIiofNzX83N5f4U9hxKOImrjMQ==
X-Received: by 2002:a63:e001:: with SMTP id e1mr21898149pgh.39.1544704858570;
        Thu, 13 Dec 2018 04:40:58 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id j21sm2734328pfn.175.2018.12.13.04.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 04:40:57 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 13 Dec 2018 21:40:54 +0900
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] kernel/hung_task.c: Force console verbose before panic
Message-ID: <20181213124054.GA3053@tigerII.localdomain>
References: <27240C0AC20F114CBF8149A2696CBE4A6015B675@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015B675@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/13/18 01:51), Liu, Chuansheng wrote:
> V1: console_verbose() is used instead of ignore_loglevel,
>     suggested by Sergey.
>     Tweak the function check_hung_task() suggested by
>     Tetsuo to make code more readable.
> 
> V2: Petr suggests to make 2 patches:
>     One is addressing console_verbose() only, which is
>     this patch's aim.
>     The other is about forcing sched_show_task() during
>     panic, which needs more discussion yet.
> 
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
