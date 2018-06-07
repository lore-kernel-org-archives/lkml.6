Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BlQzLCDDGFt9RAAAmS7hNA
	; Thu, 07 Jun 2018 05:40:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EFE5E6089E; Thu,  7 Jun 2018 05:40:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN9MyG8N"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72ECF607DC;
	Thu,  7 Jun 2018 05:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72ECF607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeFGFkW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:40:22 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46319 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeFGFkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:40:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id q1-v6so4303294pff.13;
        Wed, 06 Jun 2018 22:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=McDeS/roM8NMD9O1NlRsu2E116L7PiqXs30zosmS7Ao=;
        b=tN9MyG8NIYuB+fZOaxxh3sjraY/jti+qHkGrNokbmjYeKNB+W4Atg8WbWM924DlyDR
         K629gEFf16Rl7xYNPmmd8EuW22kq1AdXfRt2EYk+zD/PgSHW2h7LTp6tY2V1FuJaK2MC
         QdvOh33cG2Eh9CEv8XtRotSW2OZfJ6tG8NErfxT1E70T1rGgb5pQVt5utgd43eZ5EYJE
         ri1iqIGkdT9ScDsmCDWtU1gdVAKkHbTSCXfjG0WWnQ4NcSnsjEx6d8Flvrgajx8KC61L
         u3WeAsxvolJkvDXthyu8ijxTpe2jPfHxeVQMms/nqqvIE0hMmqP4X+ezki0iWoFovt/e
         SmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=McDeS/roM8NMD9O1NlRsu2E116L7PiqXs30zosmS7Ao=;
        b=cKHkrKsSKwAE7F48eI6FhSaczDiwuJxu+iZ4yvlsO8CHomzb3fp2peC3guxF+4vip0
         W/mK6R/4U+a8clBXV7se8wtVCHJontHK/kZI2MNlYzsCQzv6BC20gT+9H7z1JiJy4vVI
         YPWF7J4P7enSHSVPGLbIA5me/rJa2Vg3ch21+ufQRiMNCx+e5vlZsEv368YBTY3n2KVR
         qOkhlxFl+eG553KBObP1Ss1A123I43NyRVISe5q0o91B91VOf/sfn5SaGwrsRZKe+3a5
         WhxgNnEi57dtY6DbJ1nbc9Omd+77ne4FJHannT9NkqjVl2BTDq0CXAIPNe5exKhpiG0s
         TLFg==
X-Gm-Message-State: APt69E3i3bhadlzTzVyzpv1MWX2tV0O0RhMh1lT5VV4+OtBvUc47Bwkm
        Gc8MQ4JfiOilOIveOxWaX1w=
X-Google-Smtp-Source: ADUXVKL3pmOqRoZNSD/CKi6RpDc/Wa39+fd/Qgr/aExIeKKJBgQCiXkIhb2S4iGgK88t3RVmPIwZBw==
X-Received: by 2002:a62:7db:: with SMTP id 88-v6mr486089pfh.178.1528350019585;
        Wed, 06 Jun 2018 22:40:19 -0700 (PDT)
Received: from localhost ([39.7.47.166])
        by smtp.gmail.com with ESMTPSA id 29-v6sm91111413pfj.14.2018.06.06.22.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:40:17 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:40:13 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180607054013.GB10406@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606111557.xzs6l3lkvg7lq3ts@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606111557.xzs6l3lkvg7lq3ts@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/06/18 13:15), Petr Mladek wrote:
> On Wed 2018-06-06 14:10:29, Sergey Senozhatsky wrote:
> > On (06/05/18 14:47), Petr Mladek wrote:
> > [..]
> > > Grr, the ABBA deadlock is still there. NMIs are not sent to the other
> > > CPUs atomically. Even if we detect that logbuf_lock is available
> > > in printk_nmi_enter() on some CPUs, it might still get locked on
> > > another CPU before the other CPU gets NMI.
> > 
> > Can we do something about "B"? :) I mean - any chance we can rework
> > locking in nmi_cpu_backtrace()?
> 
> I can't think of any possibility at the moment. Well, it does not mean
> that it does not exist.
> 
> The irony is that we need the extra lock in nmi_cpu_backtrace() only
> because we try to store the messages into the common log buffer.
> If we always use the per-CPU buffers in NMI then the lock would
> not cause any problems but it also won't be necessary.

Yep. I think we can come up with something. It seems that the only
problem is that we want in this particular case to avoid printk_nmi()->logbuf
and instead we want to enforce per-CPU printk_nmi buffers. Then we can
drop nmi_cpu_backtrace() spinlock, because the messages will be
serialized by printk_safe flush spin_lock. That doesn't sound like an
impossible thing to do. What am I missing?

Could you please check my follow up email?

> > >   => I suggest to revert the commit 719f6a7040f1bdaf96fcc70
> > >      "printk: Use the main logbuf in NMI when logbuf_lock is available"
> > >      for-4.18 and stable until we get a better solution.
> > 
> > Just random thoughts.
> > 
> > May be we need to revert it, but let's not "panic". I think [but don't
> > insist on it] that the patch in question is *probably* "good enough". It
> > addresses a bug report after all.
> 
> It was a problem reported by me. I found it when testing other changes.
> The patch improved the situation definitely. The question is if it is
> enough in practice.

Oh, certainly. But I was talking about 719f6a7040f1bdaf96fcc70. We
introduced that change in response to a bug report from Steven. He would
not be able to debug his kernel otherwise, because per-CPU printk_nmi was
too limited in size.
So on one hand we have the problem that you reported, which you found
while you were hammering/testing NMI printk-s [a valid report on its
own]; on the other hand we have the problem that Steven reported, which
he triggered while he was debugging the kernel. It might be the case that
Steven's problem is more likely to happen in real world. So that's why I
proposed to keep 719f6a7040f1bda for the time being [until we come up with
another fix]. I may be wrong.

	-ss
