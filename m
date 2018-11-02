Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8662082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="toM57DGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8662082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeKCAcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:32:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40030 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCAcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:32:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so2086833lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xw5nKTWQnFRX1MqZ0SNMxwfdIu2Jry3Kwo9Dls8r2DE=;
        b=toM57DGueAip1GtMfqJJcMt8UEgrNtRaH/IXcX57KQT5OTe0P0TTwDfWGQG45dxfXa
         n1+EKJVq1HvlVTliXyt4eUB14GEOIQSw8Xqr2mB0zI0UdYHcU9GqEq3puTYJQtNai7bk
         d9EXyl6gFnkobLYUJfzAv2DAJtvjb4pNBIDzcamknqD97B2T6bG/OtBvx74du1qmE8d3
         lWPFWNR6Do764HqmnZbUS2+aXy2lXJ5KggcOfXEYQ5JvBOcY4Ot+FShE4fJPdG8Hjo2d
         D/wYVqzafYz5ave3G3Uo6p4lviXXmY28smpeXlmrkVw85p1GbquoZHKPFeHCAOba/q25
         0xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xw5nKTWQnFRX1MqZ0SNMxwfdIu2Jry3Kwo9Dls8r2DE=;
        b=RCbpACTDhJED5lq4NS2+/ld+xFJEEkNiwkjz4SPD19mdd4OMsrlXWl7amONNVrNiTa
         SlypB+tQzML/tOJ3GGy1Tun2ggdMcR7y9BwPW1RHpcPbq88g6ajgejACFy0008CAkjLC
         y729yuemvG4DS48iGSzbdrCHV8QUJN0865HkPUcg3v79/CLplwF7PzOsfLekz5LfnTNw
         kS6YtFJ5F6Aax26dE7QjNdARex0JZ7/WzsgYtvD3ivZNWceaCFqQpwNb+j27Zf70cPV2
         wx3nIFQXAv1cDCHWTpbYgl+iStkrhMjCd0RJRZugnehW/GIeqMi6IG5vShsvlGO7zh4i
         jCVw==
X-Gm-Message-State: AGRZ1gKed8TJyfdWdqI2ETYwpnS8Gai2lfaBFl4erc2YE9rR4EBwzbBO
        1sSPYLW8M2wp8Vg9DKJ1T5/a9w==
X-Google-Smtp-Source: AJdET5d7W7CVIm9DYEIO7n3de1nTGKVbNnNQNxF6ZVCuit3vs+HX2euUR1+neVuN47Yd8Lx6ogCgFQ==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr7961419lje.28.1541172319110;
        Fri, 02 Nov 2018 08:25:19 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-83-111-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.111.83])
        by smtp.gmail.com with ESMTPSA id r199sm2602874lff.50.2018.11.02.08.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 08:25:18 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C25F230164F; Fri,  2 Nov 2018 18:25:16 +0300 (+03)
Date:   Fri, 2 Nov 2018 18:25:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mremap: properly flush TLB before releasing the page
Message-ID: <20181102152516.dkqpeubxh6c3phl2@kshutemo-mobl1>
References: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
 <20181102145638.gehn7eszv22lelh6@kshutemo-mobl1>
 <CAG48ez38PmTKPq_UQ4q39bwtWmb7epyet3-iSvt5b7JfwmCniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez38PmTKPq_UQ4q39bwtWmb7epyet3-iSvt5b7JfwmCniw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:00:17PM +0100, Jann Horn wrote:
> On Fri, Nov 2, 2018 at 3:56 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Fri, Nov 02, 2018 at 01:22:42PM +0000, Will Deacon wrote:
> > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > >
> > > Commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.
> >
> > I have never seen the original patch on mailing lists, so I'll reply to
> > the backport.
> 
> For context, the original bug report is public at
> https://bugs.chromium.org/p/project-zero/issues/detail?id=1695 .

Okay. I see.

I wounder if it would be cheaper to fix this by taking i_mmap_lock_write()
unconditionally in mremap() path rather than do a lot of flushing.
We take the lock now only to remap to lower addresses.

-- 
 Kirill A. Shutemov
