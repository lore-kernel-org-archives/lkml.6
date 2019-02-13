Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D31C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A47E222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO2qUv2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbfBMOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:00:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45521 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfBMOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:00:25 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so2565845qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYbCWBQ0Y9GWex24vzz5nL8T5g6xF4FMzPuyoRoFGm4=;
        b=gO2qUv2jZwtHceCBFPeMhKMpEfxaOZqwURhBXpcZlaeGe13MhG6UWFkg/gvKxXEBwm
         JvE4ZF6041L4Op5jDYiPFR8y8gWlLbyFpirVyTA9c8Gv3i6SfEddjebeCGOpirkj3+yI
         l+KD2AoBjwfzrBQHtuLToRsZC2UpG833ssoDl9/0qARcyks7rJzx3zWT10YpzaFArDAi
         uA3uaVawxAIq4EbDqSwbTm0gTPkTrh1e3+kqZl1i5AgnVU56ilS+3spt7kaqz+w1cqcL
         DvXeF92JzYFWSutKgwVhk1nfP6R/Os1XboCsK8QkI3shRdRkebtgpXTwJcim/W1u7CEM
         n8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYbCWBQ0Y9GWex24vzz5nL8T5g6xF4FMzPuyoRoFGm4=;
        b=Cf6NEsCAciE99hdZ/qX7311uO+rjDHHRV33a7BJCkW4PHSBEN/LRvM5+F8Mrz4NReK
         aCfchR9CPiF7e15WrMIRztkKWNFbU+RewEKm/KESBaRAhvJqDsY6PXc/GM87r3tUYF8n
         MuFLB870j7fPXK61rYc9O2y0R3KtalVfkzrkHttXni8ypGw8Jq7jNdFYekFy62PXt6mC
         VgrJ/ihWx3eLROuVeHh5XePaLm4+B3gSD774f+mfEvKOXbTExpuSRONGME+xI3PcIXNk
         4r9I8J57ghsa56IK3QTu5Tlyb8CmCQCNYEBC+jkQgZZw17YF3bCPYOTTWj2XF9f3Sxng
         7GGw==
X-Gm-Message-State: AHQUAuac4/QOZXKwUwn+kXKWePucOihozJ48TZ4x4AOXRlMWbgZM53J9
        bD2ruYFcHioUpuxGyjDAXYSXcj2PICD+ujuv0cM=
X-Google-Smtp-Source: AHgI3IbBnL3R3iUAHhrZpZwlxn7HkL1sSvXQjcDZXuxVoXXewikybOJu1QlJ9oAR7fulmA33dLjHQKqFyE7FVXc7jlM=
X-Received: by 2002:a0c:8aa1:: with SMTP id 30mr479699qvv.1.1550066424479;
 Wed, 13 Feb 2019 06:00:24 -0800 (PST)
MIME-Version: 1.0
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home> <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213084741.5512307a@gandalf.local.home>
In-Reply-To: <20190213084741.5512307a@gandalf.local.home>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 22:00:04 +0800
Message-ID: <CAH2Cfb9YTAf4j7tv4Q5dWM_jQCzsWBo6ufoT=BXYx5qpgcMCNQ@mail.gmail.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 13 Feb 2019 14:19:01 +0800
> xiang xiao <xiaoxiang781216@gmail.com> wrote:
>
> > On Wed, Feb 13, 2019 at 3:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 13 Feb 2019 02:11:05 +0800
> > > Xiang Xiao <xiaoxiang781216@gmail.com> wrote:
> > >
> > > > Because log may already add the timestamp sometime
> > >
> > > Can you be a bit more detailed on this. When and where does this
> > > happen?
> >
> > Here is my case:
> > 1.A small MCU(Cortex M4) in SoC run RTOS
> > 2.RTOS append timestamp to log for the accurate timing
> > 3.RTOS send log to Linux kernel when buffer exceed the threshold
> > 4.Kernel call printk to dump the received buffer
> > So I want that printk skip the timestamp here.
> >
> > > If anything, I would probably prefer that we export whether
> > > time is being printed, and have the caller not print time if printk is
> > > doing it already, than to add the complexity into printk itself.
> >
> > Actually, the timestamp of our initial implementation like your
> > suggestion come from printk,
> > but we found that timestamp from kernel isn't accurate as from RTOS
> > due the buffer and IPC.
> >
>
> If the timestamps are different, then you don't want to remove the
> printk one. Otherwise you are going to have a confusion between your
> added timestamp mixed in with the kernel's inaccurate timestamps.
>

Here is a sample output with this patch:
[   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
[   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
[   10.991450] remoteproc remoteproc1: remote processor
f9210000.toppwr:sen-rproc is now up
[   10.993715] virtio_rpmsg_bus virtio1: creating channel
rpmsg-ttySENSOR addr 0x1
[   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
[   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
[   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
[   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
[   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
[   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
[     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12 2019 16:53:49
arm song/banks
^^^^^^^^^^^^^
[   11.918177] random: crng init done
[   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)

Without this patch:
[   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
[   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
[   10.991450] remoteproc remoteproc1: remote processor
f9210000.toppwr:sen-rproc is now up
[   10.993715] virtio_rpmsg_bus virtio1: creating channel
rpmsg-ttySENSOR addr 0x1
[   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
[   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
[   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
[   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
[   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
[   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
[   11.105345][     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12
2019 16:53:49 arm song/banks
^^^^^^^^^^^^^^^^^^^^^^^^^^
[   11.918177] random: crng init done
[   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)

Which one do you think better?

> -- Steve
