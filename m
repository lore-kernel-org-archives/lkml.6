Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23910C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AA721473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwSg+gpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AA721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeHTQ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:28:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45562 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeHTQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:28:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so8459496edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwXWbfxdMBCFJHvTOGjGor1FqktWUysKvhXmAdettj8=;
        b=UwSg+gpM5JaPoFA9bk0ua3brOTtbbc6F89tcQ4Z37Zr+65o/pqimInZho+1ZXS10Gi
         UFOS60qlP4T3T2/ftGdmrGdgjqjCqRVC+XCwKedVFsv23gyH8c4tHJL4x5hvVx1HgZpv
         C2ct2O7MDWvoupjF6Z/8f0O2+rvqlPlCafa2L+A/Lijn+yVoJ25anRJjihjam+UwX9B7
         exTKOOP9UWEbzzGNVWY43aC7or0iX2ZvGzzrGWAxFBaGloXBRlvlxRanxz0U/SgVmmht
         MujPvqe96LHmwpXkN+UBsnyltdpyjh7+bgTstjyUg7u0hBTQ7pHjUGo6uyV+o4Th+1FC
         WKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwXWbfxdMBCFJHvTOGjGor1FqktWUysKvhXmAdettj8=;
        b=lcL2D3UL7guuSC/FbxCBsVPkWwQEMeZlK+xw7l25TPVAHfVA/Lj9MdkfeJuIcdi3IY
         KXDsVlVmhlofV13S2SvTT4wLMrzizwqvUf1NaHFcrR898/Arrw0Lb+uB4+DTdfTn9ztl
         SVDOGDoM0aF+LzBPHk3+yEkbjgJDQsnwxvvDICjVwYECTmkZBKLmi4oIOzgfwmNQxsLG
         wzS9O88on4f18l8heD+rsniSqfT06UdQs3mFOeuSqXqF+PukFJbIJ3rXk5eRU3g7Nxq7
         hW56RqpgTn+7s1Nn5pnR1T5yFuw3DkNf1YH0cPbGdeZSo6Yk+wZrPhNKYzToZEAvx4EX
         7jTA==
X-Gm-Message-State: AOUpUlFGLU7PPAtcNw8tEu1Vi+0fxco+JJMsYvhD5AHS1uWYSv39Zg8j
        53ooVBguamiNFLLg+nxAi9U=
X-Google-Smtp-Source: AA+uWPyHIT7xt+GvRNX5m27X+7uGwXbuCWlemPb3eV3dDlLVkohWEv7G5WxyaJKAbKeoFLLEvEkv4w==
X-Received: by 2002:a50:b5e6:: with SMTP id a93-v6mr54916169ede.94.1534770750686;
        Mon, 20 Aug 2018 06:12:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g38-v6sm815102edc.40.2018.08.20.06.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 06:12:30 -0700 (PDT)
Date:   Mon, 20 Aug 2018 13:12:29 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>, Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: print only with DEBUG_VM in
 online/offline_pages()
Message-ID: <20180820131229.mloadxcqmfb3skdo@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-6-david@redhat.com>
 <20180817081853.GB17638@techadventures.net>
 <20180819123403.GA22352@WeideMacBook-Pro.local>
 <a36c4a26-658a-f57a-fdff-9fcf17fc27a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36c4a26-658a-f57a-fdff-9fcf17fc27a6@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 11:57:04AM +0200, David Hildenbrand wrote:
>On 19.08.2018 14:34, Wei Yang wrote:
>> On Fri, Aug 17, 2018 at 10:18:53AM +0200, Oscar Salvador wrote:
>>>>  failed_addition:
>>>> +#ifdef CONFIG_DEBUG_VM
>>>>  	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
>>>>  		 (unsigned long long) pfn << PAGE_SHIFT,
>>>>  		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
>>>> +#endif
>>>
>>> I have never been sure about this.
>>> IMO, if I fail to online pages, I want to know I failed.
>>> I think that pr_err would be better than pr_debug and without CONFIG_DEBUG_VM.
>>>
>>> But at least, if not, envolve it with a CONFIG_DEBUG_VM, but change pr_debug to pr_info.
>>>
>> 
>> I don't have a clear rule about these debug macro neither.
>> 
>> While when you look at the page related logs in calculate_node_totalpages(),
>> it is KERNEL_DEBUG level and without any config macro.
>> 
>> Maybe we should leave them at the same state?
>
>I guess we can do that for the to debug messages.
>
>When offlining memory right now:
>
>:/# echo 0 > /sys/devices/system/memory/memory9/online
>[   24.476207] Offlined Pages 32768
>[   24.477200] remove from free list 48000 1024 50000
>[   24.477896] remove from free list 48400 1024 50000
>[   24.478584] remove from free list 48800 1024 50000
>[   24.479454] remove from free list 48c00 1024 50000
>[   24.480192] remove from free list 49000 1024 50000
>[   24.480957] remove from free list 49400 1024 50000
>[   24.481752] remove from free list 49800 1024 50000
>[   24.482578] remove from free list 49c00 1024 50000
>[   24.483302] remove from free list 4a000 1024 50000
>[   24.484300] remove from free list 4a400 1024 50000
>[   24.484902] remove from free list 4a800 1024 50000
>[   24.485462] remove from free list 4ac00 1024 50000
>[   24.486381] remove from free list 4b000 1024 50000
>[   24.487108] remove from free list 4b400 1024 50000
>[   24.487842] remove from free list 4b800 1024 50000
>[   24.488610] remove from free list 4bc00 1024 50000
>[   24.489548] remove from free list 4c000 1024 50000
>[   24.490392] remove from free list 4c400 1024 50000
>[   24.491224] remove from free list 4c800 1024 50000
>...
>
>While "remove from free list" is pr_info under CONFIG_DEBUG_VM,
>"Offlined Pages ..." is pr_info without CONFIG_DEBUG_VM.

Hmm... yes, don't see the logic between them.

>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
