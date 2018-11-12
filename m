Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DC7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA0F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+w/zUdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeKLNPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:15:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41542 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:15:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id g188-v6so6042543oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 19:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pn5046+rUwy0GXMaW8cVYFZgBGkhWejDIdB57BoQJ1Q=;
        b=j+w/zUdNJcXaRdOt10v7IBSXn/K6aFP00I/hT/NNIwvAlKe4DHFE2FhUFGoUqLDqmF
         Eqq0pq+dtBPT/BqM7FABMTQUNHXPz2wjwSIcmdVue1N+x7wOw1cKE8O9Yq2scH4VXNJn
         jwSJKkYgWR9TJIiV9C2OvaT2x/FPVeVn2qg+FP861J2kuhwcQyf0WyttkhfLZMbdgtxD
         W226MXB4Mbaz2fX4yj3z1hNcu7V4Q7aj7nCipYRt0UJJLyi0PysEdrfR4FrD9qydSQEn
         GKgzQ1V2vuTwNF5C3FpgPqiFkuusz8fwEgHMvNBgjYyrDQfY1qCBj/7loagzojPu6tIF
         Xgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pn5046+rUwy0GXMaW8cVYFZgBGkhWejDIdB57BoQJ1Q=;
        b=ZKfAg0qikP3HyBF4jF23HBQnT7+TrZUerxlT4veBXIm/sQYbj3B/zORGyUS7xCsBDR
         6YWODhpGZNsYfkHLHgeqw03RYwmNgVt1XCcFICxs6TxZgyRJhgHmjf12PcPp/VRrPTHI
         j/Jdfwb0pWSCTv789nwzeHB4BAHS6t4DGBtjHBDlGywS1/VOXUe0YEsAMZatj9DgnWWs
         z/kgleuAh7ooeMBSvwe45lk6Fn0HegRcxJmuxEReM7ZWWS4mve9Tx6vZ8VQDYbFolMu/
         MuQ/ck0GtjErMWppUxpLtoucVJtrHZ+QAKkkgRSQR4y3tN7UU3MCf5yyriy/II9yIxPL
         d8eg==
X-Gm-Message-State: AGRZ1gIbgIA+SIS25fu8Yp9hA4SqBzbLvp/3pWyHlgRcw7/95ABt9GHf
        r42AH/WYSvKUQsXL3OY0Yp8uWZDK
X-Google-Smtp-Source: AJdET5eO7akKKipOLCwJJ9D4w4HNgaxulhOdQmNj21JFGzM0QWEVAxrL1L7mew7YvlPSaThFeUVB6w==
X-Received: by 2002:aca:54d2:: with SMTP id i201-v6mr9773255oib.238.1541993075891;
        Sun, 11 Nov 2018 19:24:35 -0800 (PST)
Received: from [10.211.55.3] ([47.89.83.35])
        by smtp.gmail.com with ESMTPSA id u8sm6102530otc.11.2018.11.11.19.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 19:24:35 -0800 (PST)
Subject: Re: [PATCH] mm:vmalloc add vm_struct for vm_map_ram
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
References: <1541675689-13363-1-git-send-email-huangzhaoyang@gmail.com>
From:   Xishi Qiu <qiuxishi@gmail.com>
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        David Rientjes <rientjes@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Message-ID: <bdd6deb0-9c28-9353-e445-5bf5c893d64d@gmail.com>
Date:   Mon, 12 Nov 2018 11:24:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541675689-13363-1-git-send-email-huangzhaoyang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/8 19:14, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> There is no caller and pages information etc for the area which is
> created by vm_map_ram as well as the page count > VMAP_MAX_ALLOC.
> Add them on in this commit.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/vmalloc.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index cfea25b..819b690 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -45,7 +45,8 @@ struct vfree_deferred {
>  static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
>  
>  static void __vunmap(const void *, int);
> -
> +static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
> +			      unsigned long flags, const void *caller);
>  static void free_work(struct work_struct *w)
>  {
>  	struct vfree_deferred *p = container_of(w, struct vfree_deferred, wq);
> @@ -1138,6 +1139,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	BUG_ON(!va);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));
> +	kfree(va->vm);
>  	free_unmap_vmap_area(va);
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
> @@ -1170,6 +1172,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
>  		addr = (unsigned long)mem;
>  	} else {
>  		struct vmap_area *va;
> +		struct vm_struct *area;
> +
>  		va = alloc_vmap_area(size, PAGE_SIZE,
>  				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
>  		if (IS_ERR(va))
> @@ -1177,11 +1181,17 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
>  
>  		addr = va->va_start;
>  		mem = (void *)addr;
> +		area = kzalloc_node(sizeof(*area), GFP_KERNEL, node);
> +		if (likely(area)) {
> +			setup_vmalloc_vm(area, va, 0, __builtin_return_address(0));
> +			va->flags &= ~VM_VM_AREA;
> +		}
Hi Zhaoyang，

I think if we set the flag VM_VM_AREA, that means we have some info,
so how about do not clear the flag after setup_vmalloc_vm, and just
update the print in s_show.

	...
	if (v->flags & VM_ALLOC)
		seq_puts(m, " vmalloc");
+	if (v->flags & VM_MAP_RAM)  // add a new flag for vm_map_ram?
+		seq_puts(m, " vm_map_ram");
	...

Thanks,
Xishi QIu
>  	}
>  	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
>  		vm_unmap_ram(mem, count);
>  		return NULL;
>  	}
> +
>  	return mem;
>  }
>  EXPORT_SYMBOL(vm_map_ram);
> @@ -2688,19 +2698,19 @@ static int s_show(struct seq_file *m, void *p)
>  	 * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
>  	 * behalf of vmap area is being tear down or vm_map_ram allocation.
>  	 */
> -	if (!(va->flags & VM_VM_AREA)) {
> -		seq_printf(m, "0x%pK-0x%pK %7ld %s\n",
> -			(void *)va->va_start, (void *)va->va_end,
> -			va->va_end - va->va_start,
> -			va->flags & VM_LAZY_FREE ? "unpurged vm_area" : "vm_map_ram");
> -
> +	if (!(va->flags & VM_VM_AREA) && !va->vm)
>  		return 0;
> -	}
>  
>  	v = va->vm;
>  
> -	seq_printf(m, "0x%pK-0x%pK %7ld",
> -		v->addr, v->addr + v->size, v->size);
> +	if (!(va->flags & VM_VM_AREA))
> +		seq_printf(m, "0x%pK-0x%pK %7ld %s\n",
> +				(void *)va->va_start, (void *)va->va_end,
> +				va->va_end - va->va_start,
> +				va->flags & VM_LAZY_FREE ? "unpurged vm_area" : "vm_map_ram");
> +	else
> +		seq_printf(m, "0x%pK-0x%pK %7ld",
> +				v->addr, v->addr + v->size, v->size);
>  
>  	if (v->caller)
>  		seq_printf(m, " %pS", v->caller);
> 
