Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8439C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C70120873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ+nTFqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C70120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeG0HLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:11:23 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44555 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeG0HLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:11:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so1837306pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nKyCMFPH1a0FpO6y3GTtTcuwR+n7EQZ6GJoojYVCXKM=;
        b=XQ+nTFqVK8VD2liRuwkTyRovRYTIIytRURywF4F+sdIvpCjuEC5geSbFJGCG4Q5J3O
         D0lE7wqdZapVJrbKIRAuoWfrXnnX+Vw+8rmAc4+ROB33koTIPuVBJh19RxMrd0nhD4FD
         /hJiAAF6Zf9vbbV/iIY9XKHx80iN/RMJc46IgtkCzYP9fcjAwGqqBxpxKHEeyW6kVwWg
         VEuNRdDiAfRQUX8d3arkhSn+91QgJNKFQ3URI0olthKBTprSslh55Y9ZR4VQwKDImd8z
         S15Vai2lym34Xb88FenQhiY+8GMNl/XevXfCZeP64o9I83JLPiDyEGdqBOD8IsIEJ5SS
         VDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKyCMFPH1a0FpO6y3GTtTcuwR+n7EQZ6GJoojYVCXKM=;
        b=ntbzp98j/mg8mK1FW+FsmFP5FqwMuYXkCCbBrerX5dcc3U45waodZib/zp5E1WGu5S
         v0+6WSdUlBELXo+2XpGQHs64iHLv6cSTDEUq1zjzhwgwnZNtz9LcsqLe3rFz/7K4zOc7
         sSFHmsne7DVbpQX4rV9MYSYjcQLoPvEmhcZWZySP+5WTI5KNyf8xgrdnVmOjtnK1tvra
         +jpX9no9HDM0TWpkxh6IDb+ipAavfgdr9pxESLkbW5PLvoQIqrltaBcmSBWSbSDhpnf7
         r8VJz53/44CNI0UkOpLYf6+ZST4vKDbxyVNnHiiQ+nBpjyBafu8ns6FvK9LRRD3b6TiD
         rFRQ==
X-Gm-Message-State: AOUpUlHxUV0cTI+XmhDM3A60HBaPiZi9k73fDhh5KXU54heF0QBOujZ0
        HE46omc5013QUkRIXxQE7TQ=
X-Google-Smtp-Source: AAOMgpdV8ivAeRhN08el0Pkhr3t1CHNJwoSZhGJktsjlS/R+tsLvN3lgWlmomeoFTCWBAwvHRFTPmQ==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr4663604plo.4.1532670669295;
        Thu, 26 Jul 2018 22:51:09 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id s85-v6sm5481344pfa.116.2018.07.26.22.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 22:51:08 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:51:04 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org, kt0755@gmail.com,
        syzkaller@googlegroups.com, bammanag@purdue.edu,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in snd_virmidi_output_trigger
Message-ID: <20180727055104.GA18733@dragonet>
References: <20180726055326.GA12625@dragonet>
 <s5hva92yxda.wl-tiwai@suse.de>
 <20180727041322.GA13067@dragonet>
 <s5hbmatuue9.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbmatuue9.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 07:20:30AM +0200, Takashi Iwai wrote:

I think there is a mistake on the reported-by tag.
The reported-by tag (e4c8abb920ef...) is for WARNING in port_delete.
I guess the tag below is correct.
Reported-by: syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com
Could you please make sure that the reported-by tag is correct?

By the way, I can't reproduce the crash WARNING in port_delete so
far. I feel sad for saying this..
I really want to reproduce the crash and thus, to help to fix the
crash. If there is any progress on it, I will let you know
immediately.


Best regards,
Dae R. Jeong

> On Fri, 27 Jul 2018 06:13:22 +0200,
> Dae R. Jeong wrote:
> > 
> > I tested it and it worked.
> > Thanks a lot!
> 
> Good to hear.  Below is the final patch with a proper comment (and
> with syzbot reported-by, too) I'm going to queue to sound.git tree.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> 
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: virmidi: Fix too long output trigger loop
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
> Reported-and-tested-by: Dae R. Jeong <threeearcat@gmail.com>
> Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_virmidi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
> index 289ae6bb81d9..8ebbca554e99 100644
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
> @@ -200,6 +201,15 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>  					vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
>  				}
>  			}
> +			if (!check_resched)
> +				continue;
> +			/* do temporary unlock & cond_resched() for avoiding
> +			 * CPU soft lockup, which may happen via a write from
> +			 * a huge rawmidi buffer
> +			 */
> +			spin_unlock_irqrestore(&substream->runtime->lock, flags);
> +			cond_resched();
> +			spin_lock_irqsave(&substream->runtime->lock, flags);
>  		}
>  	out:
>  		spin_unlock_irqrestore(&substream->runtime->lock, flags);
> -- 
> 2.18.0
> 
