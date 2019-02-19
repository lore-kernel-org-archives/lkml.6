Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440BF20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550589406;
	bh=0GwyVPyXTDAc+G6ge7E38GFelsqla7h49y8HV1Sj7Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKIuh1lHCgcmwF4MMkMJpLg++VYYpm+r2eX/Wz9OGUCN++7owmle5pU+3FOtgsjIB
	 X7CGhpN1oBUhlBRRr2ObXN5DOpF7rFv5S2OAcokwALjTZm33P8GyQI8/CbmsvF8xpk
	 9t1J7O6x1gRxJnHGQ6J8lrfGQsZKeRTBK5ScwFDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfBSPQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:16:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33480 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBSPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:16:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so22468904wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 07:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eT0bUCoBHfhOP4gcSW6ircRIODRHmcNi6D6u7VSNp9A=;
        b=d1sz4LuMl1XlfCxmwdQJPog8g5b5onZou0pHXv3+ry4zXhTHMy6f6LqXcOA0py0Blk
         KKTQCoVpmpwKkxJ/PqoZDpdibkvM0yuUomdtN9daxbbas2mtzzjGWrg8FWT/ApMydEfv
         WhG8mZqZfaC3YFMBkCCsSNhjqJjQ4pvjMPNHwyK+3U/cg83D1ap7yOJOYW2uBoYir+xv
         EVECKNSxCpcxanSnxcxJrQQUz3kkeSmJenQCS1bVYrkuJfpQgVbD3Dn8P0bGflLavpXB
         TU3jKn6d45utPESWPnD0eH/KIpKGmITkn3uEpkG98j0RmW9ByjrYANIAl+TN8mlnR5Xb
         bKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eT0bUCoBHfhOP4gcSW6ircRIODRHmcNi6D6u7VSNp9A=;
        b=gXEbpy6OCHQo1ZQvH/U9cfIU1kRhs7UlyXAlwnfph83b+GxBQA2vVZfNzc6VR4I9rD
         ADjLiwjGGwyg/Ks1VGiTs0+RvqLzHFk3P1o4X0OpeiAYoM8DhT/si84Ml5UrCE6nu2iG
         0MYr8Fug0Z/uGwGQYp6UtMy1f73va95pw7i41Y3TywbZ9wqifw9X1GlT1jDHCmHcjePJ
         Y5h1fn9NNMx/rrquGQm3XVcoOQi87O4eS09I8BBIk+9ddPCfJK/yo5uTFATRV+p5iZwW
         2Dr2ymhlJMp+fGGw+yLXFJGIzB76V+8wjRB7lRDfGneVOQs6mgKUrI2WswhYYGEJGe2E
         xf/w==
X-Gm-Message-State: AHQUAuZCUKoC7G064ZQQ2xRLuwVk6WlpBE0GQq/jjy1d8pz3zvqb/JlR
        gEsCraq07mVXAQptzU7iA0w=
X-Google-Smtp-Source: AHgI3IYKaAPiBC4JstjSoy8b83hYvL82DD9Iqbu9aXk+Z+hM9yc0kh/lQunl/tc0c2g9TERn3uLjdw==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr17804149wrp.138.1550589402875;
        Tue, 19 Feb 2019 07:16:42 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u17sm15742217wrg.71.2019.02.19.07.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 07:16:42 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:16:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [RFC GIT PULL] EFI fixes, memblock quirk
Message-ID: <20190219151639.GA77461@gmail.com>
References: <20190217105926.GA69415@gmail.com>
 <CAHk-=wi=ooh9chSKyLipU6+eFbdfc680PUn3uKEoxLAMDMyMgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=ooh9chSKyLipU6+eFbdfc680PUn3uKEoxLAMDMyMgg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Feb 17, 2019 at 2:59 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > I marked it RFC: please have a second look at the mm/memblock.c change,
> > which adds a INIT_MEMBLOCK_RESERVED_REGIONS detour that ARM64 takes for
> > these systems.
> 
> It's not pretty, but it looks minimal for now. Pulled.

Thanks!

> > Perhaps we should upgrade the build time sizing of all platforms to
> > INIT_MEMBLOCK_REGIONS+NR_CPUS+1 and thus centrally give an extra
> > allocation entry per CPU configured?
> >
> > Or is there some cleaner solution?
> 
> Is there some reason other platforms might want that kind of thing?

Not that I'm aware of.

> If not, then the current hack seems sufficient.

Ok!

Thanks,

	Ingo
