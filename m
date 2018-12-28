Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44110C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B65B20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546014697;
	bh=WtS2H+3rtyOwNuIsN2DFbLkYiURCLPJrfD/VGyW5o70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=efAcDgqLmq+JQj7Dd5nJBECdPUSxBnc62bPqi8UlXOXXaxAPHT4Wbjxm09k+BsbvE
	 mgU2V7Kosce5wH+4L2863xWuRqkDsRr4j5I1eu1iW5HJKCJM3ruw6Y1DCjGNN+GBS8
	 6SoVo/Vhn1p3hBrhTNo3Gc2yUun8sgp6eovDynLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeL1Qbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:31:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46677 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeL1Qbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:31:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so10229987pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 08:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AaHStz8boNdIIgB/rLsxnfmspyudQAuWbBjy2YDspc=;
        b=Bg3rAQVGESclFsqOyQB8yRgMi9ilQKgqqcyNtBwGsNTuUF7LaZXBUTsXO0iqlsi//j
         L5XbZwBf/hexOer9g+oX/kBgLAR1KDtMFoacwVLk0qgHU0Nsgyiy0VfJxeSHa49VcWqv
         QsyRKiFIXOMh8dIvljI87fY1GBLPawdG8w/LGe3UZ5JCCpLRwaLnkaVwTkqd2knBnm9A
         PCTI83zP1F429TZ/Gvxz62h8Cb0eeRCpUPJJS+o3PcLpCb+7MkFu+AB06/c9vAlh9c5l
         sQ0HP3GLhEibZE7Rp7ecn/cHMlHKXL6F8RAE94+DvwLuX89Fzopb3Pjyrrwln3pWDoH4
         kj/g==
X-Gm-Message-State: AJcUukcPlgeerPkfZa+1MNy46GcQxShQb8UoBHPNk6ZzdNMBycBy7rgx
        KPnkyO13BQWyN0mJkf0jA0A/TcH7
X-Google-Smtp-Source: ALg8bN4/c0OX83BKExRR2/gVJKqZ1PqHHLAR6i3tdPX6efotOWU8PezVjEKd0lZn4FW1jHIXUrDTTw==
X-Received: by 2002:a63:c848:: with SMTP id l8mr26689526pgi.78.1546014694548;
        Fri, 28 Dec 2018 08:31:34 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:f30e])
        by smtp.gmail.com with ESMTPSA id 6sm77621119pfv.30.2018.12.28.08.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:31:33 -0800 (PST)
Date:   Fri, 28 Dec 2018 10:31:30 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] percpu changes for v4.21-rc1
Message-ID: <20181228163130.GA8614@dennisz-mbp.dhcp.thefacebook.com>
References: <20181227170432.GA86441@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227170432.GA86441@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 11:04:32AM -0600, Dennis Zhou wrote:
> Hi Linus,
> 
> Michael Cree noted generic UP Alpha has been broken since v3.18. This is
> a small fix for locking in UP percpu code that fixes the issue.
> 
> Thanks,
> Dennis
> 
> The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:
> 
>   Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-4.21
> 
> for you to fetch changes up to 6ab7d47bcbf0144a8cb81536c2cead4cde18acfe:
> 
>   percpu: convert spin_lock_irq to spin_lock_irqsave. (2018-12-18 09:04:08 -0800)
> 
> ----------------------------------------------------------------
> Dennis Zhou (1):
>       percpu: convert spin_lock_irq to spin_lock_irqsave.
> 
>  mm/percpu-km.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> index 38de70ab1a0d..0f643dc2dc65 100644
> --- a/mm/percpu-km.c
> +++ b/mm/percpu-km.c
> @@ -50,6 +50,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
>  	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
>  	struct pcpu_chunk *chunk;
>  	struct page *pages;
> +	unsigned long flags;
>  	int i;
>  
>  	chunk = pcpu_alloc_chunk(gfp);
> @@ -68,9 +69,9 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
>  	chunk->data = pages;
>  	chunk->base_addr = page_address(pages) - pcpu_group_offsets[0];
>  
> -	spin_lock_irq(&pcpu_lock);
> +	spin_lock_irqsave(&pcpu_lock, flags);
>  	pcpu_chunk_populated(chunk, 0, nr_pages, false);
> -	spin_unlock_irq(&pcpu_lock);
> +	spin_unlock_irqrestore(&pcpu_lock, flags);
>  
>  	pcpu_stats_chunk_alloc();
>  	trace_percpu_create_chunk(chunk->base_addr);
> 

Sigh, I missed +linux-kernel..

Thanks,
Dennis
