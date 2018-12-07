Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C01BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AF32082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXtZYRkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AF32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLGRAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:00:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54986 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeLGRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:00:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id z18so5049296wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWR/CKRAPHnbW5Y7mQVehmQMx4mGMyMA0zPhmnP+ReM=;
        b=BXtZYRkZjWyqJi+M9/Za/SBLLemkf3VXlFl4vCV+58gZiFtfCijEWJm5znCShtPyie
         mhGsYOkOYOFTbaR+H2yIgaAv5bEPMvZ/M2owgUDEY3yEapsA594u62cB0NvrkGTbfJFB
         LMJAPRsTGQyJQIKR+g2b9QlnAdB0u6XdSAhf6WbZZJai86UYppL+vsD93KVFCxxIg1j/
         ABQRnra5dbm9RSMWw6QeAkl4q9bV4GY2yvTXjbGxukCjMeaujUsKA+gtu4J2tgp00thW
         Ex5kUBOucsGYAWdhjP0Q3YxK+c+2z6hhuh60otxMvR4DtwXs+bqtlrRCb68CbrBO2TML
         f4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWR/CKRAPHnbW5Y7mQVehmQMx4mGMyMA0zPhmnP+ReM=;
        b=mk1qi73jqVJdbamJ6D96IKtWoN7tl2d8RN0ZIBf8Uwx2bXq1i+UM7XntfxBkA3CZeI
         ckBcE/woM+o3uA1qnquOCdoU0uGX5zuUgoIOHJCB2fplZZvLeJTyhdfZR9yimtV+0567
         mtqUyQqSyialHO+gxkhxVSjrY+1/mWVxCPdnwGk9OON8VX16Aw/ntCwQwn9dWuiXe5pk
         oQxUIL3blE78xJ4puhVd4YOPFSW1zLjUcDvdsozn4i1NiNfjYK42oueqSgXKnOnZ6QcM
         fGB9srIQKZLAXk36DKfrsUYREkCQw8pNwlyzKfEJKXep6iIZwsf3zjWRFvj5aVMYeuCq
         UTbQ==
X-Gm-Message-State: AA+aEWaemGODX2rCJauAcE3Zg9u7o51xCdKQnztY+mIoPjR0dN8RDGbs
        3YYrqg7+TeM1ehEvuDd/kFwfm5XjIA==
X-Google-Smtp-Source: AFSGD/XJLn1CvYLTdRFM67ZrqgIU74Yr3HfHgrC6JgGpMtQIbHH6sOxqX3xnhATxpvA3MCipYXPRnw==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr2871044wmc.103.1544202027689;
        Fri, 07 Dec 2018 09:00:27 -0800 (PST)
Received: from localhost (host34-126-dynamic.27-79-r.retail.telecomitalia.it. [79.27.126.34])
        by smtp.gmail.com with ESMTPSA id h12sm9755756wma.48.2018.12.07.09.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:00:27 -0800 (PST)
Date:   Fri, 7 Dec 2018 18:00:26 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-ID: <20181207170026.GA1379@Dell>
References: <20181206095648.GA8249@Dell>
 <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
 <20181208010120.c3eda9042912068aecc68317@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208010120.c3eda9042912068aecc68317@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 01:01:20AM +0900, Masami Hiramatsu wrote:
> Hi Andrea and Ingo,
> 
> Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
> After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
> to some arches.
> 
> Thank you,
> 
> [RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area
> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Blacklist symbols in arch-defined probe-prohibited areas.
> With this change, user can see all symbols which are prohibited
> to probe in debugfs.
> 
> All archtectures which have custom prohibit areas should define
> its own arch_populate_kprobe_blacklist() function, but unless that,
> all symbols marked __kprobes are blacklisted.
> 
> Reported-by: Andrea Righi <righi.andrea@gmail.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---

[snip]

> +int kprobe_add_ksym_blacklist(unsigned long entry)
> +{
> +	struct kprobe_blacklist_entry *ent;
> +	unsigned long offset = 0, size = 0;
> +
> +	if (!kernel_text_address(entry) ||
> +	    !kallsyms_lookup_size_offset(entry, &size, &offset))
> +		return -EINVAL;
> +
> +	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> +	if (!ent)
> +		return -ENOMEM;
> +	ent->start_addr = entry - offset;
> +	ent->end_addr = entry - offset + size;

Do we need to take offset into account? The code before wasn't using it.

> +	INIT_LIST_HEAD(&ent->list);
> +	list_add_tail(&ent->list, &kprobe_blacklist);
> +
> +	return (int)size;
> +}
> +
> +/* Add functions in arch defined probe-prohibited area */
> +int __weak arch_populate_kprobe_blacklist(void)
> +{
> +	unsigned long entry;
> +	int ret = 0;
> +
> +	for (entry = (unsigned long)__kprobes_text_start;
> +	     entry < (unsigned long)__kprobes_text_end;
> +	     entry += ret) {
> +		ret = kprobe_add_ksym_blacklist(entry);
> +		if (ret < 0)
> +			return ret;
> +		if (ret == 0)	/* In case of alias symbol */
> +			ret = 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Lookup and populate the kprobe_blacklist.
>   *
> @@ -2104,26 +2142,20 @@ NOKPROBE_SYMBOL(dump_kprobe);
>  static int __init populate_kprobe_blacklist(unsigned long *start,
>  					     unsigned long *end)
>  {
> +	unsigned long entry;
>  	unsigned long *iter;
> -	struct kprobe_blacklist_entry *ent;
> -	unsigned long entry, offset = 0, size = 0;
> +	int ret;
>  
>  	for (iter = start; iter < end; iter++) {
>  		entry = arch_deref_entry_point((void *)*iter);
> -
> -		if (!kernel_text_address(entry) ||
> -		    !kallsyms_lookup_size_offset(entry, &size, &offset))
> +		ret = kprobe_add_ksym_blacklist(entry);
> +		if (ret == -EINVAL)
>  			continue;
> -
> -		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> -		if (!ent)
> -			return -ENOMEM;
> -		ent->start_addr = entry;
> -		ent->end_addr = entry + size;
> -		INIT_LIST_HEAD(&ent->list);
> -		list_add_tail(&ent->list, &kprobe_blacklist);
> +		if (ret < 0)
> +			return ret;
>  	}
> -	return 0;
> +
> +	return arch_populate_kprobe_blacklist();
>  }
>  
>  /* Module notifier call back, checking kprobes on the module */
