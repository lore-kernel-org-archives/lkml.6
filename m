Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9192082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtI7s48J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9192082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLDIeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:34:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40508 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbeLDIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:34:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so13141388edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42DPJbxTAc+Ek7zaYRynT9Xbuqdi6d9nrHhRy0JKN9Y=;
        b=mtI7s48JboIsB4KkGGP/oCbS57eA28JxdeWH99F2JU4DP1XiRctLl9Jh9/FHd/PcT3
         NdPKpbPgcvS8yf0bhguOGXznCf0ve0DwPsMXBHzlKFPBFyir3FBNrhDXuREYqF+oHlvN
         ClAUqyZsOyJpNkSAKVQMSkr5UI/pPvj8wRvnIxtCSG9HsoGxGeRyJtNBUHFT1sGP4Sfb
         YQ9S3W6TG930V6LAIzsxLf/N+NVLltZfxc5NgjKD1IiVV0Mnt2PNdhOqxH0ZDzgtdrk7
         ULESngTkAM/pA9bNdzWWDet8oZOgBKehEMu0MISB6OJKwPYapOSGKibuXkVMbtjpNc/Z
         IQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=42DPJbxTAc+Ek7zaYRynT9Xbuqdi6d9nrHhRy0JKN9Y=;
        b=jMp95BF8L8yuOyYgpdgIyXvDsnSfsS4/HBhUt1VJo0JzDorMqslgznd24sONlX8gEn
         cJDK1UmgKwqVyLCxJzBmpm3lCC0HpoH3mhjadYqSoIHwP4qxCHpjZCa/fRkV06+mI7Tq
         WlQU84b+FyttZpNUx44WwjYIrbkZph3kjrMBVJZYvkU6GKMzSUIudrFwA4/twn+4u7Oz
         keuVXw8Hn2A3FDg7t9HxgVuDOu9cGP2DwoHYBk3OQm1vxZryYCyr5HeRk71RVQx0E3p0
         COsJjWjIuf/2gVHymubsL1aujYIFa7fseFJ8AZjnBPX8wkGRgKtbrcigd1l/T/Co8bDY
         Uo9w==
X-Gm-Message-State: AA+aEWa20aX5VaKvL6pw+8dleB5iSSMSh6GcAOdXFNBcjWYOIjJRU0kX
        b8B6tzaQQUYX3QIgxn55gXg=
X-Google-Smtp-Source: AFSGD/X+8N9Og+wV9b0rFWNuVsOB7oklH4fbypPM3f3a6Fu1dl3OEHHggdyu7vaWfX3pGyBDQHW/0g==
X-Received: by 2002:a50:f489:: with SMTP id s9mr16990398edm.101.1543912469323;
        Tue, 04 Dec 2018 00:34:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id f20sm4454754edf.19.2018.12.04.00.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:34:28 -0800 (PST)
Date:   Tue, 4 Dec 2018 08:34:28 +0000
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
Message-ID: <20181204083428.emgcaomg6vulknaq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204065453.4rsyhtsk2aej4vim@master>
 <CAFgQCTvQBC11=4eGQ6T9vyB+KOznFCr4hjdg1wwD8GotSRWpDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvQBC11=4eGQ6T9vyB+KOznFCr4hjdg1wwD8GotSRWpDg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:20:13PM +0800, Pingfan Liu wrote:
>On Tue, Dec 4, 2018 at 2:54 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Tue, Dec 04, 2018 at 11:05:57AM +0800, Pingfan Liu wrote:
>> >During my test on some AMD machine, with kexec -l nr_cpus=x option, the
>> >kernel failed to bootup, because some node's data struct can not be allocated,
>> >e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
>> >device->numa_node info is used as preferred_nid param for
>>
>> could we fix the preferred_nid before passed to
>> __alloc_pages_nodemask()?
>>
>Yes, we can doit too, but what is the gain?

node_zonelist() is used some places. If we are sure where the problem
is, it is not necessary to spread to other places.

>
>> BTW, I don't catch the function call flow to this point. Would you mind
>> giving me some hint?
>>
>You can track the code along slab_alloc() ->...->__alloc_pages_nodemask()

slab_alloc() pass NUMA_NO_NODE down, so I am lost in where the
preferred_nid is assigned.

>
>Thanks,
>Pingfan

-- 
Wei Yang
Help you, Help me
