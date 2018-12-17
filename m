Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02262133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545070639;
	bh=Wbf1tNN4S/Moq0TrSngJq9cTzTmIMWEt0XeVz8XwQiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RsdadK9Ij3wkrnXWP4SmdnSH5L54LTVnnGfQJKw1pRAd4t26peUmeLO+9Y60bOUXD
	 PUZ8ryI12F8yzEFXfvj19ik+KbS3EW8c7yqcLQ8cn5zKh+alu8o7f9N5jRk9gWkBFD
	 PqzVgk2yD0nusSyu4MV1sbeKoaS4wyWuBuyhslgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbeLQSRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:17:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52833 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLQSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:17:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so181250wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jx6/GXBgfo8+sYGkb5xcxtVHh7yBz6EfhEjmDdjXMKI=;
        b=kAh5joHj6bB6aBAh4ZxUukEAyKRM3DGfRABCQbv7rq7IdZpmYH7t19aWeJlGJU5fOB
         kCLCeZ5O7NCk0WRmr2Q92y/dXAHUf0Kt4OqW2sH5XqP/y1/2lMhQuyFFYvVRekkKOn77
         5ZBm2bsVWYs8qyVaHxtbDD0+TA/mkfVl3Iv0yy0Bc+ENGt3XbhVIgJkVWvJd5BtM3fSq
         y7k7fKf3Qq5aD5t34UqBaHYeKW+1+mNqPGxBPPRqwtvWvIdS3BTfo1MU2Z7sronQuEW5
         HGgSB6Lcd0cqMRoTputYTUf6Y0eJ1BYhgMIreHVuGyMRxzGWilmTsvwF/YODtwhOj1D0
         1zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jx6/GXBgfo8+sYGkb5xcxtVHh7yBz6EfhEjmDdjXMKI=;
        b=BGArIZviW0SmGPX7cnoSGpHTOdRMPBflIjADvCsTqdCZK6j2EB0hhWhSpAPjL+4FFU
         XxHTBRt2wwEE6nBftBSxxTwBckEuPVVNurYyDa3s0SS1bm/Fgn+Q5ODgAq/y2EK4uzdH
         wgZAjvFBUrx4EXFv7xvWzSWXT4z3hhkaUAsalnMahUfFJBMRbm7x99Pv0luCjihH4X5A
         nB4nhyYjU1UdhPX4QCG3As122iR82U8IdMildfJic30CH6Dfm0TPNr/nC580s47yr+Z+
         C9JAVaGaYyjI6bMkUwBohWQaolPc5fxjECGcXGohnpzxKt47AOpfQQ97lXeCsjailPso
         kfXw==
X-Gm-Message-State: AA+aEWacoOr7Wf6JqHtHhC0s+9Po8A1tnAkFfR1rZEccVXP7UAjqsVVy
        pz2OfR0syd/B7Ca4+oGypP4=
X-Google-Smtp-Source: AFSGD/XL8sBTf6E7f3PaS6VWu1iYMVBOClDwR25nFTmV1B4+HGfhD1dpWDtOgMQxqPMQ3QbSUjIOdA==
X-Received: by 2002:a1c:66c5:: with SMTP id a188mr143986wmc.129.1545070635608;
        Mon, 17 Dec 2018 10:17:15 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v4sm14415286wme.6.2018.12.17.10.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:17:14 -0800 (PST)
Date:   Mon, 17 Dec 2018 19:17:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181217181712.GA5114@gmail.com>
References: <1544738377-3848-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544738377-3848-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> The db->lock is a raw spinlock and so the lock hold time is supposed to
> be short. This will not be the case when printk() is being involved in
> some of the critical sections.
> 
> In order to avoid the long hold time, in case some messages need to be
> printed, all the debug_object_is_on_stack() and debug_print_object()
> calls are now moved out of those critical sections in the following
> functions.
> 
>  - __debug_object_init()
>  - debug_object_activate()
>  - debug_object_deactivate()
>  - debug_object_destroy()
>  - debug_object_free()
>  - debug_object_active_state()
>  - __debug_check_no_obj_freed()
>  - check_results()
> 
> Holding the db->lock while calling printk() may lead to deadlock if
> printk() somehow requires the allocation/freeing of debug object that
> happens to be in the same hash bucket or a circular lock dependency
> warning from lockdep as reported in
> 
>   https://lkml.kernel.org/r/20181211091154.GL23332@shao2-debian

This makes me sad - whatever happened to the principle of keeping printk 
simple?

We should rename printk() to syslog() or so, and rename early_printk() to 
printk(), and be done with this.

Thanks,

	Ingo
