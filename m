Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C174C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D520645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEu2Gvr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0D520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLDKim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:38:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36057 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:38:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7196459pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hb2GCOeKWm1h4Bo3+dT5dEeX5Dib46yKsR+ppaLMr3s=;
        b=TEu2Gvr9/AMjN3bs2VXIRo5hK9hRVdbzkt9M19HTq1yQnIgu17a2jycFki5//j4v73
         hW9S4Zjyb6kODbQtQa9T5ecKVkEp5+PDhd6JfFk6xn8jUZHZYuXPTi/Qb2BeswtH9761
         jYuUiAZ9Jw9Gu5U0FMaI6Ljyvz8VDEaqrGtTiVQKXXqImgHVlWzroIwUKXnUt08OdQ4O
         ZXGhxpWczNjOJMCeO6m2jr3JxtdQrMuSuQawym6XB6hpawKk11JTo2qBp9ksEEzziKrz
         Y7aIRygU345gH4SLBwaEQscKac4dFJg3Y9yhD5ZS6NldjZTQ/b9sGbBAIX1r5vOg3GcI
         K6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hb2GCOeKWm1h4Bo3+dT5dEeX5Dib46yKsR+ppaLMr3s=;
        b=YILOrifg3daXPJN3YCZ5vlAikanLeNkdZmSJWKOt1Y2Yk++C19Gi632N8VdToCHNWn
         uGkFNuR4NfP4i6V1h6/fNpcZr5tf37ADuhUKLNTWKWpqA3XgLMSiWbnH6JthCPQDnyvj
         xzJTMKnG9tw5XjSiWtS+VIkULY2S2oLILz6q0PXh8KpnN0rKNVw3Oy9vkAqGFrlgZQY8
         e+YDPydh/ACyYNupdCMgv1LJKbXjiap4MdaWuX4yCpc/liq7jaFeUbqxMkl6a3FFQWaf
         aqKm/LfYXo6vc6Rf2/26ws34jDOCjEAMpq5ow/dZW3zP0m6lI4GviYkLwzqsPZsGux2N
         vEvA==
X-Gm-Message-State: AA+aEWb71GNUlDIsxVfsrqYsJOtx8piDv92tTJFbppviiJAGdtOHKpK2
        aDen6Ri9VJj38+rQ8eckIrYByo88
X-Google-Smtp-Source: AFSGD/X+Zndj4DPPRBUT8Cm7SdVIq6Dt7TLLCZOgr9lBoxrNFC4INFHkXH8Q/tPgzhes++wKpO9lIg==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr16397162pgj.341.1543919920282;
        Tue, 04 Dec 2018 02:38:40 -0800 (PST)
Received: from localhost ([175.223.44.178])
        by smtp.gmail.com with ESMTPSA id i62sm19392425pge.44.2018.12.04.02.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 02:38:39 -0800 (PST)
Date:   Tue, 4 Dec 2018 19:38:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181204103836.GB530@jagdpanzerIV>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <1bd509ec-0a3a-55cc-d43b-02baa489019a@i-love.sakura.ne.jp>
 <20181204020224.GA7580@jagdpanzerIV>
 <be668360-279b-5c24-4fc1-10ef050bd87f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be668360-279b-5c24-4fc1-10ef050bd87f@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/04/18 19:16), Tetsuo Handa wrote:
> On 2018/12/04 11:02, Sergey Senozhatsky wrote:
> > On (12/02/18 20:23), Tetsuo Handa wrote:
> >>
> >> Some examples for console output:
> >>
> >>   [    0.919699]@T1 x86: Booting SMP configuration:
> >>   [    4.152681]@T271 Fusion MPT base driver 3.04.20
> >>   [    5.070470]@C0 random: fast init done
> >>   [    6.587900]@C3 random: crng init done
> > 
> > This is hard to read. Let's have a fixed width space for from_id.
> 
> Console might be only 80 columns. When we have to check from screen capture of
> crash, triggering needless newlines due to occupying columns more than needed
> will not be nice. Also, syzbot has file size limit for saving console output.
> Wasting with needless spaces increases possibility of loosing past lines.
> Given that said, do you still want to waste precious columns with spaces?

Well, if the feature will be useful for non-syzbot cases as well, as
you mention below, then I'd say let's make the output human readable.
To some extent, at least.

I think we consume much more bytes on pr_fmt prefixes; and not all of them
are very useful all the time.

[..]
[    1.223872] nouveau 0000:01:00.0: DRM: DCB outp 00: 01000f02 00020030
[    1.224090] nouveau 0000:01:00.0: DRM: DCB outp 01: 02011f62 00020010
[..]
[    2.676030] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC662 rev3: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    2.676643] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    2.677258] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    2.677879] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    2.678578] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    2.679150] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[..]
[  430.768498] rndis_host 1-1:1.0 enp0s20f0u1: unregister 'rndis_host' usb-0000:00:14.0-1, RNDIS device


So, to me, PRINTK_FROM probably does not look like a really bad
serial console abuser. How many bytes do we need for PRINTK_FROM?
7-8?

> CONFIG_DEBUG_AID_FOR_SYZBOT is currently linux-next only option.
> This feature will be useful for non-syzbot environments.

	-ss
