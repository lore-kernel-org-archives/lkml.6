Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA886222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAOo24Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfBNB0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:26:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42540 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfBNB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:26:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so2137882pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zC+lVYAy10p4CUm8lM/KoXPkssREyYS9QdNwiKZbvNA=;
        b=mAOo24LbtymrEIu01LYaykARFTXAlVPto3j4bdzgZKpeNrNy+3hNuCdskN347O4LPQ
         bIwPY6Bl/veFW+DxCbR/8TUlh5MRAOoMALGuIFwTr+6zv4Y77XN6KGT7W7egjzo2JcN2
         lZ4Axlh5MTmJQIDVw9ZUdjv/zUJZHKv41lWAcA/1dYuHsoXOjLmU1bTO4SButnhfJ+Nt
         MYP4waNFFbbSYJk2hqAbwznwHKpd6LE/60Sphi6alJewGJKXpWjanHX/u5U/f7lBHHMy
         aJmMGyInVlvceS3qDID75FcS/dONRpDS7kacxXoDZCy/3jIZR263MV/tBdTkcLPC7ihf
         R8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zC+lVYAy10p4CUm8lM/KoXPkssREyYS9QdNwiKZbvNA=;
        b=aXtgyQz/KRg5+Ck4xg6+d/PlFUa/bworUFIylT5Ap55KNmnTddb2E3GzAfo6hDWfaa
         buxVNvO0VV0SDMzvqFgApW7ImwAiOwN3Kp/QFxXuzE0rw/tPOl+uITRT/R39acv8jaOb
         LmXf+jv/1oii9pn0cfgQBMgXa62J2oN9+YlMYw+1GgAKsQl+e7Rs16BZz6kAebksxEM9
         KDCcv5lzy1OO0tIqAKer7wGXG8FbBM6+zbBts0/T6Q+yujLQo+DNln5fJcIBqp5e3xUC
         sO3vgXJivJY0nwSjeJvGyW7Id4y5Gi++wvgwoW7oZXDLIZqjRCtzsZeQhRlicGg64Jda
         S/nQ==
X-Gm-Message-State: AHQUAub47ePHnIOFYTLLGtLbIjpEKayWJZqwjqe14UyxDKG6NDW1IqjF
        6f8lIzA2f48IM3E7hQ6bPNY=
X-Google-Smtp-Source: AHgI3IbCLlE4IJKg/1WjNF0LZa9UUiVfvGbNJMsde4H03/YXgQOtIvz+QmV/z9qPIIk1Hgy3gtVJFw==
X-Received: by 2002:a63:1a0d:: with SMTP id a13mr1192174pga.202.1550107576458;
        Wed, 13 Feb 2019 17:26:16 -0800 (PST)
Received: from localhost ([175.223.34.156])
        by smtp.gmail.com with ESMTPSA id i8sm726055pgo.19.2019.02.13.17.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 17:26:15 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:26:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     xiang xiao <xiaoxiang781216@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190214012612.GA25915@jagdpanzerIV>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home>
 <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213084741.5512307a@gandalf.local.home>
 <CAH2Cfb9YTAf4j7tv4Q5dWM_jQCzsWBo6ufoT=BXYx5qpgcMCNQ@mail.gmail.com>
 <20190213093154.7af84743@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213093154.7af84743@gandalf.local.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 09:31), Steven Rostedt wrote:
> > Without this patch:
> > [   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
> > [   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
> > [   10.991450] remoteproc remoteproc1: remote processor
> > f9210000.toppwr:sen-rproc is now up
> > [   10.993715] virtio_rpmsg_bus virtio1: creating channel
> > rpmsg-ttySENSOR addr 0x1
> > [   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
> > [   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
> > [   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
> > [   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
> > [   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
> > [   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
> > [   11.105345][     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12
> > 2019 16:53:49 arm song/banks
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > [   11.918177] random: crng init done
> > [   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)
> > 
> > Which one do you think better?
> 
> Honestly, the one without the patch.

+1

> Seriously, it also makes it easy to see where that message happened
> with respect to the other printks. With your patch, we would have no
> idea, and if I was a normal user, unaware of this patch, I would
> probably submit a bug report claiming that something is wrong with the
> timestamps.

+1

	-ss
