Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31866C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2F2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOUTUuzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F2F2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbeGZT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:26:14 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45990 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbeGZT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:26:13 -0400
Received: by mail-ua0-f193.google.com with SMTP id k8-v6so1680286uaq.12;
        Thu, 26 Jul 2018 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maDKt0uDuoaXyshADOV/F/yFe6IhCXy4n9Nh4uwmeh4=;
        b=EOUTUuzSXtPbVu8UAoFKqzPJUXbZxWcd0yCvO/2TANAd++6IFnqM6HzHBJ3Up+7tYD
         X56KfemgoLxJc6EXJvvXwA2Uf1wN/HbJwTK5iJzi9wSHYN8OEieIA1utI/iORuNczCuQ
         iHbgE8/DVFzL0iUdQtKtH8AYRTPIOSpebS/KAMUERDuaLI/NdZFh/ed6I/+C9GNiiJBv
         4ucYTlROyJ0maAsaDOOR241RVFUSiWc9ukhb3uVz3xmXLMKT0Tk1rTV9/hlNg8WYlZBk
         cKRtYo89iDspq17O+LV/gHpRhsLy0FW5j+4uN5NozAMUBZzTVD/0sT60Hp9/TGQgvdFL
         zorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maDKt0uDuoaXyshADOV/F/yFe6IhCXy4n9Nh4uwmeh4=;
        b=ildlSi56Gt3d8ztWQW9si98MX3nbN4bWTg1s4005OSIbg4N4lemK3Sl4AKOVEYjMIY
         3Mr/8PbyafhmilVcb7bqZ4KH8K/lAfDpvU6VQu4cHl1Zlo5Wb0qVoinv8DI0kJmEI5AK
         CY9Vjv9PY+H1F9pM1F3UhSgCRF7McpLXzb7UxEzKmNznJx+ObaFppSlf4Y7xDfsZk4hC
         3npWFfaxoi6+yg5Ydgl03SNt+idZ9yMjQmu6JGwATZXmgHOfgzRr0CMuUff0MtmH2JMV
         uR95FXb0tnDwt+etIa7rHnLR81KTsBnip5ySjBWOq+blP5H8moZqW41e/3y8MFYVBwS6
         m1Sw==
X-Gm-Message-State: AOUpUlHKWwPh8aPKQgGLljZ9w2eGLF/6QVQ7aTog+ARTTTy9YUzcSuoy
        KMvTH7K3oE+GJGPjXUkA9m9dvmnzoM+NKoHo/EY=
X-Google-Smtp-Source: AAOMgpcZliJ+bBr8xUS/N8AScGQDRqliMoPM0xJpLYIcCm8KLkWIfu1e+pFuob6mgXj1RqX9ND4vjZkIbs6jERVVIlE=
X-Received: by 2002:ab0:6214:: with SMTP id m20-v6mr2126903uao.147.1532628496761;
 Thu, 26 Jul 2018 11:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
 <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com> <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
In-Reply-To: <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Thu, 26 Jul 2018 23:38:05 +0530
Message-ID: <CAOuPNLgXNMm20nuPPDtUoy3qTF9MLDTRNmsOsocYYLrXtS0rBg@mail.gmail.com>
Subject: Re: [PREEMPT_RT]: Using printk-rt-aware.patch in non-rt kernel
To:     sebastian.siewior@linutronix.de
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 9:08 PM Sebastian Andrzej Siewior
<sebastian.siewior@linutronix.de> wrote:
>
> On 2018-07-18 20:19:15 [+0530], Pintu Kumar wrote:
> > Hi All,
> Hi,
>
> > I have a question about PREEMPT_RT patch for 3.10 kernel.
> > I am trying to port this rt patch: 0224-printk-rt-aware.patch.patch
> > (see the patch below), in non-rt kernel.
> > I could able to successfully apply this patch after replacing:
> > migrate_enable/disable with preempt_enable/disable.
> > Things were working fine so far.
>
> Why?
>
> > Then, I noticed that "printk" from interrupt context is not appearing
> > on console (minicom), if console shell is active.
> > However, it appears on the dmesg output.
> >
> > So, I am wondering, what could be the cause of this patch for this
> > behavior in non-rt kernel?
> > Is this the expected behavior, even on PREEMPT_RT kernel?
>
> I *think* it is but there are hardly any prints from atomic context for
> anyone to notice. And the next print from non-atomic context should
> flush it out.
>
Yes, we observed the same behavior with CONFIG_PREEMPT_RT_FULL with
beagle bone-rt kernel 4.9.
And yes, after doing : echo "1234" > /dev/kmsg the content were flushed.
So, I guess this is the expected behavior with this patch.

> > Is there a way we can fix this issue on non-rt kernel?
> I would guess that a wakeup to klogd would fix it.
>
Sorry, can you elaborate more about "wakeup to klogd".
I wanted to try it and check.

> > Please help us with your suggestions.
> >
> > Thanks,
> > Pintu
>
> Sebastian
