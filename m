Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40620C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08522208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAoUxIVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08522208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLDJJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:09:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43731 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:09:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so6773806eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pW9RvKPkaSQKP8bBC1jyOkJZEOFUi7wqndA9TmJZYoU=;
        b=CAoUxIVmNdR2sdarRHKTwk2FTPnjGoxyQPJzFW+4x5AJ/JJlk+RJiS5UI4fwsm2QBT
         ttqfce7yxm3x2FMtJs914/GgY9IqL9Jg8/TADK8hfY7Hv5e3gSrIeoFR7nHIo6TRtHKB
         Qqn5uyP189JYYH6edXySVbdswEolu9OKq+HxcBgkE/1W4thcowI++nMihyb1ThyfLR5G
         8V8/tVDrCV47/MP30bzQDzbYIUKu10IMHEeb24MWTCb+3AE/o9Ydhq/Ishv+YviZjt4I
         NFFwnKY/c0VvwHsS1Zdw9chfg5QWIl6VnEGDJgRgiZXOOZl0gQry/uUp1g9t8oWfAsAP
         5BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pW9RvKPkaSQKP8bBC1jyOkJZEOFUi7wqndA9TmJZYoU=;
        b=aK5x3YjJCwBVdeoSMdy+XlmpuuRyWOgP11gOkTGA137HILsgm8vIr0B9HegJOAS2J8
         twrkeBOYdbrVwwed86vHWDLo7m0gXXJ5wUuN+HMmB3Kq8xaJoFhhWWXfbh2pjRfbIVf4
         OwGQLEt13mBskmcnxZSAMUs3b382pc7mkMfuyqXnmAulPuZfkGzdQAQ1POgq+ueouHRu
         BL2E2AxuMpp7+5moWkRENSFP13glQB4NmseNtltZIJLxhwa+a5EXtyhf9BamuqJTktmJ
         i78eGXZ4KmZGHcvOGxUu/5/7Dy2vRkeRpyxjGz+0QMibsiAzkaNH0c1AEfALZkRdQrRP
         xl3A==
X-Gm-Message-State: AA+aEWYe4wJLGDS3agUtFTTZV6hj1qANiWEhL/QnlrIFvqYm09vV3DCH
        dUI1UewNBHcLlPp+yPih/3Q=
X-Google-Smtp-Source: AFSGD/UW7c0stMqbX5HUxLGelL3LHtie025JxRs1QRtWC5SWRrSkaQp1Cm4cZz/G7UTGy+hekSKrzg==
X-Received: by 2002:a50:9106:: with SMTP id e6mr16421175eda.148.1543914592139;
        Tue, 04 Dec 2018 01:09:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t9sm4477313edd.25.2018.12.04.01.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:09:51 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:09:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     richard.weiyang@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181204090950.ql3zbnbjjbfnvhdg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204065453.4rsyhtsk2aej4vim@master>
 <CAFgQCTvQBC11=4eGQ6T9vyB+KOznFCr4hjdg1wwD8GotSRWpDg@mail.gmail.com>
 <20181204083428.emgcaomg6vulknaq@master>
 <CAFgQCTtY28w=9LLgOMT5J-SfKqz-Cirv-bNvXQvjazn_Ev4F4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtY28w=9LLgOMT5J-SfKqz-Cirv-bNvXQvjazn_Ev4F4g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:52:52PM +0800, Pingfan Liu wrote:
>On Tue, Dec 4, 2018 at 4:34 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Tue, Dec 04, 2018 at 03:20:13PM +0800, Pingfan Liu wrote:
>> >On Tue, Dec 4, 2018 at 2:54 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>> >>
>> >> On Tue, Dec 04, 2018 at 11:05:57AM +0800, Pingfan Liu wrote:
>> >> >During my test on some AMD machine, with kexec -l nr_cpus=x option, the
>> >> >kernel failed to bootup, because some node's data struct can not be allocated,
>> >> >e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
>> >> >device->numa_node info is used as preferred_nid param for
>> >>
>> >> could we fix the preferred_nid before passed to
>> >> __alloc_pages_nodemask()?
>> >>
>> >Yes, we can doit too, but what is the gain?
>>
>> node_zonelist() is used some places. If we are sure where the problem
>> is, it is not necessary to spread to other places.
>>
>> >
>> >> BTW, I don't catch the function call flow to this point. Would you mind
>> >> giving me some hint?
>> >>
>> >You can track the code along slab_alloc() ->...->__alloc_pages_nodemask()
>>
>> slab_alloc() pass NUMA_NO_NODE down, so I am lost in where the
>> preferred_nid is assigned.
>>
>You can follow:
>[    5.773618]  new_slab+0xa9/0x570
>[    5.773618]  ___slab_alloc+0x375/0x540
>[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
>where static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
>

Well, thanks for your patience, but I still don't get it.

new_slab(node)
    allocate_slab(node)
       alloc_slab_page(node)
           if (node == NUMA_NO_NODE)
	       alloc_pages()
	   eles
	       __alloc_pages_node(node)

As you mentioned, this starts from slab_alloc() which pass NUMA_NO_NODE.
This means it goes to alloc_pages() and then alloc_pages_current() ->
__alloc_pages_nodemask(). Here we use policy_node() to get the
preferred_nid. 

I didn't catch the relathionship between policy_node() and
device->numa_node. Maybe I got wrong in some place. Would you minding
sharing more?

>Thanks,
>Pingfan

-- 
Wei Yang
Help you, Help me
