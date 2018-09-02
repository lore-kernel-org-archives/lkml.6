Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157A20856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="r+QxmRze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeICBCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:02:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35294 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeICBCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:02:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9-v6so7682441plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZhNl1ItDIS8tpID3vJKnIJUPKwJW5SBWwBZmhkfnCG0=;
        b=r+QxmRzen/XthL5y5mcj1D/96KelGbNLkWTqwufpCYhyuIqknIDzy84f0Aq0X5ZaQn
         dnZlNItsu+KUNVl7394cU46/XSOpi4ywPnwk5IucoytmNF/B65f4B8BUt3oRNC9FgO2z
         JXxSnMk4ntkZLBVjDcIqa+iFE+kAl1QHkzqUdhufQn4iS58FFKUD1Zh7Og4+pbVejpmC
         4KYxqbhW2Fi7nDyrIh3YzctYRWHUvbdiuO4Wf6x4Hs8Eg1nm79yclqcaxPfKSkfYw7un
         5F/k6sL0VkacDLr9YZP5f6bYrHG64BJgXBoW7jfSdziBvoFUY5knhIZMMOU0Jy0nkFso
         L2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZhNl1ItDIS8tpID3vJKnIJUPKwJW5SBWwBZmhkfnCG0=;
        b=sgDyPDFV1JRHn0WfCItxW7/VAu4xpUWW6+tr9rCX4vffD4qN80GDnzYUiS+3NrsBaq
         HJeoa1GWyZpdc58gzPoegLiAAKSnBqYB6k1/JYLPG+zLxN9VNfYUw++8gS7mO4NveJFI
         HShR/4v2YZR7nMaSBpUeI9WKG/BDf0LGJ1T3nWBcalg9dkNTfEA4VozhO22B+0+eTm3H
         1e7zxnnKgEM7Q/YJDMsIbs4zvpyh/FXm7ocyTv/UGglNPuBUZFc0yjJmoKzokUOhJPqZ
         z5tNTENRZ2nC9xv/DmqkD525Eqhssf+ViPD7whT55TIJD/lxtlyf8LrwKT/8re+3xASr
         z6dQ==
X-Gm-Message-State: APzg51A8H5bIqTMxiFQjVflRTYqJYJlEfc+azQ/6obvYLTocnna3QtyB
        fIEdMr3PBHjmONs9rSMZNuYvcAZ3fHE=
X-Google-Smtp-Source: ANB0VdbXZWG2OW9Qh9WNFA65kKXCc+1EjRGE1nuUeBN1gAgIn74FjXmO134ciYHIq/OHae5u4qZC/Q==
X-Received: by 2002:a17:902:6806:: with SMTP id h6-v6mr15274835plk.304.1535921116733;
        Sun, 02 Sep 2018 13:45:16 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id x9-v6sm456846pfd.31.2018.09.02.13.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 13:45:15 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5D4AC300D89; Sun,  2 Sep 2018 23:45:10 +0300 (+03)
Date:   Sun, 2 Sep 2018 23:45:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180902204510.enghtkdnjenfhimp@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
 <20180830141202.GA14702@192.168.1.2>
 <20180830142739.gfpa23nvex7xbkkf@black.fi.intel.com>
 <20180830145751.GC14702@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830145751.GC14702@192.168.1.2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:57:51PM +0800, Baoquan He wrote:
> On 08/30/18 at 05:27pm, Kirill A. Shutemov wrote:
> > On Thu, Aug 30, 2018 at 02:12:02PM +0000, Baoquan He wrote:
> > > On 08/30/18 at 04:58pm, Kirill A. Shutemov wrote:
> > > > On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> > > > > This was suggested by Kirill several months ago, I worked out several
> > > > > patches to fix, then interrupted by other issues. So sort them out
> > > > > now and post for reviewing.
> > > > 
> > > > Thanks for doing this.
> > > > 
> > > > > The current upstream kernel supports 5-level paging mode and supports
> > > > > dynamically choosing paging mode during bootup according to kernel
> > > > > image, hardware and kernel parameter setting. This flexibility brings
> > > > > several issues for kexec/kdump:
> > > > > 1)
> > > > > Switching between paging modes, requires changes into target kernel.
> > > > > It means you cannot kexec() 4-level paging kernel from 5-level paging
> > > > > kernel if 4-level paging kernel doesn't include changes. 
> > > > > 
> > > > > 2)
> > > > > Switching from 5-level paging to 4-level paging kernel would fail, if
> > > > > kexec() put kernel image above 64TiB of memory.
> > > > 
> > > > I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
> > > > paging allows to address 256TiB in 1-to-1 mapping. We just don't have
> > > > machines with that wide physical address space (which don't support
> > > > 5-level paging too).
> > > 
> > > Hmm, afaik, the MAX_PHYSMEM_BITS limits the maximum address space
> > > which physical RAM can mapped to. We have 256TB for the whole address
> > > space for 4-level paging, that includes user space and kernel space,
> > > it might not allow 256TB entirely for the direct mapping.
> > > And the direct mapping is only for physical RAM mapping, and
> > > kexec/kdump only cares about the physical RAM space and load them
> > > inside.
> > > 
> > > # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
> > > 
> > > Not sure if my understanding is right, please correct me if I am wrong.
> > 
> > IIRC, we only care about the place kexec puts the kernel before it gets
> > decompressed. After the decompression kernel will be put into the right
> > spot.
> > 
> > Decompression is done in early boot where we use 1-to-1 mapping (not a
> > usual kernel virtual memory layout). All 256TiB should be reachable.
> 
> My understanding that is although it's 1:1 identity mapping, it still
> has to be inside available physical RAM region. I don't remember what
> the old code did, now in __startup_64(),

I'm talking about the code that runs before __startup_64(), in
arch/x86/boot/compressed. Physcal memory start at virtual address 0 there,
without PAGE_OFFSET.

> you can see that there's a check like below, and at this time, it's
> still identity mapping.
> 
>         /* Is the address too large? */
>         if (physaddr >> MAX_PHYSMEM_BITS)
>                 for (;;);
> 
> Thanks
> Baoquan

-- 
 Kirill A. Shutemov
