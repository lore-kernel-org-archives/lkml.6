Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C906C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C89205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZRRFI1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C89205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeG0FdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:33:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37817 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0FdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:33:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so1748664plc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 21:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZnEhysQxhUpp/HXWZsfFOf+OGH7dtRnkQwcZmKabljM=;
        b=cZRRFI1GAmKK6RTD3u0+3PdXHcXOXg7Q0y7PmHefTGtogAQmOJpipHwLKQo4Tnucm6
         bZBtdIX3VzDst5WoOoXae/EYpru0Pwz9W2aJKmdjqkZvbMQdAxoKc26yCRiSrKTV2EK+
         6wTITtTmjB58cF5w6tLl7z+yLwHF1QRXE7wvevvdqnd4IhpNqJqMuBJQw8HgeL+N9Eyo
         FqJcw50WYmQeYcWZyXKFgMxi/BbpyO0BXV43vGuaYRRgLDsRPdEQikAZjA3TH1JaeqkY
         OPJwEcsxvIeHR6ZYciYxi7pEVNgHYC2q4VIHkMfh3j6yno4PkkoD8yf/JzFRHsCXyjcg
         /13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnEhysQxhUpp/HXWZsfFOf+OGH7dtRnkQwcZmKabljM=;
        b=edBRXQR+OcXGakaqyaJ3o4fgZ9tzoJ+OJ+e5UTzvwU+eMhB9PPpD23/goQFy0OvDpL
         VILqUs1enhd0slBldDx6orB4w7mlAhfxnwVqzRNVsyknfNoUcqwF0aJTBnJv/ybni6HL
         vgnaYmj1vemvS0qBceM4YS7xfcz3QQOYeWFhlaqUPciF7xCixKHm4T1Swncde3LAKdyd
         jmwsYaSWOhv/Hn58ooYAdk0EbvsHElQ35spyjsoBudC/ufoiqFaBJJWT9YB8yAhZkF3f
         w07an7Z1ZGmhM7ryt+TRsPfuKHoteZbUA8GE82eVAN5BVeDersWvqAeKh/1iktQLh8TP
         IPUw==
X-Gm-Message-State: AOUpUlGdV0s2Gnu5Px74Pp2kgr82PO5K6yQuFB0ZD0vuxgdPWBN3ozVr
        Q8Ie3yPX2WmFrVmlbEI76xc=
X-Google-Smtp-Source: AAOMgpdMOc0fthhS/sZQ4CtogFijvSfrdRS+0PWb1IjxIUruveuGi1FgTkEEOpownqSWes0luNwUtw==
X-Received: by 2002:a17:902:760b:: with SMTP id k11-v6mr4479139pll.91.1532664808191;
        Thu, 26 Jul 2018 21:13:28 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id 86-v6sm4780193pfh.0.2018.07.26.21.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 21:13:27 -0700 (PDT)
Date:   Fri, 27 Jul 2018 13:13:22 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org, kt0755@gmail.com,
        syzkaller@googlegroups.com, bammanag@purdue.edu,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in snd_virmidi_output_trigger
Message-ID: <20180727041322.GA13067@dragonet>
References: <20180726055326.GA12625@dragonet>
 <s5hva92yxda.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hva92yxda.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:50:25PM +0200, Takashi Iwai wrote:
> On Thu, 26 Jul 2018 07:53:26 +0200,
>  Dae R. Jeong  wrote:
> > 
> > Reporting the crash: BUG: soft lockup in snd_virmidi_output_trigger
> > 
> > This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
> > version of Syzkaller), which we describe more at the end of this
> > report.
> > 
> > Note that this bug is previously reported by Syzkaller a few month ago.
> > (https://syzkaller.appspot.com/bug?id=642c927972318775e0ea1b4779ccd8624ce9e6f5)
> > Nonetheless, the crash still can be detected. We guess that the crash has
> > not fixed yet.
> > We report the crash log and the attached reproducer with a hope that they are
> > helpful to diagnose the crash and to fix a bug.
> > 
> > C Reproducer:
> > https://kiwi.cs.purdue.edu/static/race-fuzzer/repro-dab082.c
> > 
> > Kernel config:
> > https://kiwi.cs.purdue.edu/static/race-fuzzer/config-dab082
> > 
> > (Please disregard all code related to "should_hypercall" in the C repro,
> > as this is only for our debugging purposes using our own hypervisor.)
> > 
> > 
> > Crash log:
> > ==================================================================
> > watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor0:24261]
> > Modules linked in:
> > irq event stamp: 6692
> > hardirqs last  enabled at (6691): [<ffffffff84eb1f12>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> > hardirqs last  enabled at (6691): [<ffffffff84eb1f12>] _raw_spin_unlock_irqrestore+0x62/0x90 kernel/locking/spinlock.c:184
> > hardirqs last disabled at (6692): [<ffffffff85000905>] interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
> > softirqs last  enabled at (1468): [<ffffffff852005ff>] __do_softirq+0x5ff/0x7f4 kernel/softirq.c:314
> > softirqs last disabled at (1455): [<ffffffff8130de56>] invoke_softirq kernel/softirq.c:368 [inline]
> > softirqs last disabled at (1455): [<ffffffff8130de56>] irq_exit+0x126/0x130 kernel/softirq.c:408
> > CPU: 1 PID: 24261 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
> > RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> > RIP: 0010:_raw_spin_unlock_irqrestore+0x7d/0x90 kernel/locking/spinlock.c:184
> > Code: 0d c8 ce 16 7b 5b 41 5c 5d c3 e8 3e 0f 52 fc 48 c7 c7 68 b0 71 86 e8 62 4c 8d fc 48 83 3d 42 91 86 01 00 74 0e 48 89 df 57 9d <0f> 1f 44 00 00 eb cd 0f 0b 0f 0b 0f 1f 84 00 00 00 00 00 55 48 89 
> > RSP: 0018:ffff8801b8e4f7e8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> > RAX: 0000000000000000 RBX: 0000000000000282 RCX: ffffffff84eb1f1e
> > RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: 0000000000000282
> > RBP: ffff8801b8e4f7f8 R08: ffffed002573a06a R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff88012b9d0348
> > R13: ffff8801e6417580 R14: ffff8801b8e4f868 R15: ffff8801e64175a8
> > FS:  00007f3447a49700(0000) GS:ffff8801f6d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f3447a48db8 CR3: 00000001ee58d000 CR4: 00000000000006e0
> > Call Trace:
> >  spin_unlock_irqrestore include/linux/spinlock.h:365 [inline]
> >  snd_virmidi_output_trigger+0x37d/0x420 sound/core/seq/seq_virmidi.c:205
> >  snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
> >  snd_rawmidi_kernel_write1+0x383/0x410 sound/core/rawmidi.c:1288
> >  snd_rawmidi_write+0x249/0xa50 sound/core/rawmidi.c:1338
> 
> This seems to be a long loop in snd_virmidi_output_trigger processed
> in a spinlock.  The below patch puts a cond_resched() for avoiding the
> possible stalls, and it seems working.
> 
> Let me know if this works for you.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: virmidi: Fix too long output trigger loop
> 
> The virmidi output trigger tries to parse the all available bytes and
> process sequencer events as much as possible.  In a normal situation,
> this is supposed to be relatively short, but a program may give a huge
> buffer and it'll take a long time in a single spin lock, which may
> eventually lead to a soft lockup.
> 
> This patch simply adds a workaround, a cond_resched() call in the loop
> if applicable.  A better solution would be to move the event processor
> into a work, but let's put a duct-tape quickly at first.
> 
> Reported-by: Dae R. Jeong <threeearcat@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_virmidi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
> index 289ae6bb81d9..65549d41533e 100644
> --- a/sound/core/seq/seq_virmidi.c
> +++ b/sound/core/seq/seq_virmidi.c
> @@ -163,6 +163,7 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>  	int count, res;
>  	unsigned char buf[32], *pbuf;
>  	unsigned long flags;
> +	bool check_resched = !in_atomic();
>  
>  	if (up) {
>  		vmidi->trigger = 1;
> @@ -200,6 +201,11 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>  					vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
>  				}
>  			}
> +			if (!check_resched)
> +				continue;
> +			spin_unlock_irqrestore(&substream->runtime->lock, flags);
> +			cond_resched();
> +			spin_lock_irqsave(&substream->runtime->lock, flags);
>  		}
>  	out:
>  		spin_unlock_irqrestore(&substream->runtime->lock, flags);
> -- 
> 2.18.0
> 

I tested it and it worked.
Thanks a lot!

Dae R. Jeong
