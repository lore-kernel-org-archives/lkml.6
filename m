Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92478C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188420895
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDOJlF1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4188420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeGZHg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:36:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46596 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeGZHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:36:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so471784pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sEXKLVNBOKqjuIuJAKRq0v7zRYtuw5VcaU0Zx9zMpxM=;
        b=QDOJlF1dI447WLRI5isgoq/Z/yjObWKE+E9iuT/4CBwdhqYMT7f16cKYtggUzagXWo
         qaWrbBiO8lQIMtrua1EQjMasLY7g1prKo6zBkaFSmuzrs9H5n0MZlndUq+y58qhOqXzQ
         GZEcRhGNcIptte2aBgl8CLv8c6E6UUAd6AfX5ZFWSPSglOLIGH61iA6XBuf931ar0N8l
         LztrsMcQyJOWipCSoWtlSVF1wBgGPjzYNPcNRQEUaaXAj+IGIF3h7LFpAGokOaCbFAq2
         m09wBbqeMYIFGKVVKT7JiRib1lp1F3IKBN1skhEfn2toTjdZE4/XXJMNJLXvENSNXXle
         ruDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEXKLVNBOKqjuIuJAKRq0v7zRYtuw5VcaU0Zx9zMpxM=;
        b=Ei8yBG05DuI6cTMj8wDqIIF84t7ihT5MTQp7Bx59F5weDxs6fIKVMb/RXXi40WPTQn
         Kk/AS2ut1DqJt5cp4SiYoQu1QFxpBTwsIWtK1NsXXphxRlZiBSGRlGdCfZy/a26XJzJZ
         HM2oAw5JBEHWCJ9fNEWPeyIjjyUTrXATR4qbo8Z5RXNblCvs22Ja+FPNqdb0uHoYmO4L
         vBiWGrB1MdkQJTgunhHP7LitnDERcsLQ9Xl+Rf8ltgxROxP+kmyy5xRVeE9rz/K1aIDD
         8Ey47E7EE7hYAplxJMIeQlNtxD+yWTsviWxIscrqWOnwxb9NQFHMuJwRdkjEalS4MATy
         ZYRg==
X-Gm-Message-State: AOUpUlGIe3n5RuSAZUm6jAEvJGFH0b0+JNc+xPFM6okX5ZpobVnWojJU
        b9m6Aw5cxtoQZ8wAIJ3UDYj9fzw0
X-Google-Smtp-Source: AAOMgpfZYDs53WBOTdAolDTSlHKxVKDY65N+6b3B5S+t3tfnYF7wGMcF5E/+TSLHE4S+Pd9IyspX5g==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr697277pgc.344.1532586072139;
        Wed, 25 Jul 2018 23:21:12 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id x2-v6sm1088627pfi.166.2018.07.25.23.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 23:21:10 -0700 (PDT)
Date:   Thu, 26 Jul 2018 15:21:06 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180726062106.GB221405@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:10:41AM +0200, Tino Lehnig wrote:
> Hi,
> 
> On 07/26/2018 04:03 AM, Minchan Kim wrote:
> > A thing I could imagine is
> > [0bcac06f27d75, skip swapcache for swapin of synchronous device]
> > It was merged into v4.15. Could you check it by bisecting?
> 
> Thanks, I will check that.
> 
> > > My operating system is a minimal install of Debian 9. I took the kernel
> > > configuration from the default Debian kernel and built my own kernel with
> > > "make oldconfig" leaving all settings at their defaults. The only thing I
> > > changed in the configuration was enabling the zram writeback feature.
> > 
> > You mean you changed host kernel configuration?
> > 
> > > 
> > > All my tests were done on bare-metal hardware with Xeon processors and lots
> > > of RAM. I encounter the bug quite quickly, but it still takes several GBs of
> > > swap usage. Below is my /proc/meminfo with enough KVM instances running (3
> > > in my case) to trigger the bug on my test machine.
> > 
> > Aha.. you did writeback feature into your bare-metal host machine and execute
> > kvm with window images as a guest. So, PG_uptodate warning happens on host side,
> > not guest? Right?
> 
> Yes, I am only talking about the host kernel. Zram swap is set up on the
> host. I just used Windows guests to fill up the host RAM and force it into
> swap.
> 
> > > I will also try to reproduce the problem on some different hardware next.
> 
> Just to confirm, I was able to reproduce the problem on another machine
> running Ubuntu 18.04 with the Ubuntu stock kernel (4.15) and no
> modifications to the kernel configuration whatsoever. The host had 8 GB of

That means you could reproduce it without writeback feature?
If so, it would be more reasoanble to check [0bcac06f27d75, skip swapcache for swapin of synchronous device]

> RAM, 32 GB of swap with zram and a 32 GB SSD as backing device. I had to
> start only one Windows VM with "-m 32768" to trigger the bug.

Thanks. I will try it later today.

