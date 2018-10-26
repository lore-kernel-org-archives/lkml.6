Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88599C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213A920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt9yql63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213A920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeJZOSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:18:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41095 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:18:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so11431494otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YGDTumzDk9lWqXByw8gn/VH+8KSxb+IUJl2hS0SZm4g=;
        b=Qt9yql636jNGsB23+a2XhwLCWvkrJNlPVNw6jX+M721x6vljQ54nr4EDf0O8XerD3g
         dO+xyLnzZ8VHJzkUvZ0VOKHdVVFH8OwVPxrow6HahvarYprOQ1cKu6SRKv/zo9vnMFiW
         99+mxhwgxSKj6tqPmLqDmcg9s5mu6BpJ09f97kFmXr6+plCd5/JYi7WWqsJsQbFGrdCu
         k4JbFYW3QOKevJtq6vQKK1xaiHp0j+hRp3gpqCv6N1ZK+6DtV7EFfcNtQzyvrZeoasEc
         QC9Fh12IUsQDSXRLxLL67YVjwbD4vHMjC8hiznMP76stqeBakn1RP87UWNgmG8A2iSIi
         FQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YGDTumzDk9lWqXByw8gn/VH+8KSxb+IUJl2hS0SZm4g=;
        b=uXOKIdPJh7EVe3iOm4LoHdwpCPYOYyhJrtfrhhBvUbjefw7JMNeBMQQJ/2dFwAJHYn
         3CqUPthmcp/HViGtlIqWhZLnYKfTho2gT82K075Xlc0H+E89/NLUFTt1cYwdxLvHnhNb
         y2l5oWGcJ6En2wzs+Sm/NX4Hn89sPZx5Anx+sJg+xxOw0R2XmdHJFRlYR0o4YzTHDx4o
         wNGp5LLOrBpMutdmDl+BIDjkc6Gy5bIzb0z/GPqYiEnuvHAb1Cu5ieQFnSejx4b9RyLG
         o2tj/ez1s/zvlrugwgUfk0Q8PSXRcImtG4xzsvSQjXP48FBIOaxihlApXNU2RI4uobhv
         lMJQ==
X-Gm-Message-State: AGRZ1gKyLwR0T/cXkr+cdGm7i2KbtWqO1188qosKsVr83NP8ujbfyAjh
        yyjXmoPDPErjHTbOQ8KMUTO+UA28
X-Google-Smtp-Source: AJdET5cdV+4WGQoZwxoftTBStEIHnOyiQyy2t33oWe43YD2f5msL4WdDXZU7sLaSyGiHz2Jqhn/oxA==
X-Received: by 2002:a9d:7208:: with SMTP id u8mr1397375otj.320.1540532591103;
        Thu, 25 Oct 2018 22:43:11 -0700 (PDT)
Received: from [10.211.55.3] ([47.89.83.47])
        by smtp.gmail.com with ESMTPSA id d37sm3484945otb.72.2018.10.25.22.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 22:43:10 -0700 (PDT)
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com,
        Xishi Qiu <qiuxishi@linux.alibaba.com>,
        zy107165@alibaba-inc.com
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
From:   Xishi Qiu <qiuxishi@gmail.com>
Message-ID: <debe98dd-39f3-18d5-aeb4-fe94519aa0c9@gmail.com>
Date:   Fri, 26 Oct 2018 13:42:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

This patchset hotadd a pmem and use it like a normal DRAM, I
have some questions here, and I think my production line may
also concerned.

1) How to set the AEP (Apache Pass) usage percentage for one
process (or a vma)?
e.g. there are two vms from two customers, they pay different
money for the vm. So if we alloc and convert AEP/DRAM by global,
the high load vm may get 100% DRAM, and the low load vm may get
100% AEP, this is unfair. The low load is compared to another
one, for himself, the actual low load maybe is high load.

2) I find page idle only check the access bit, _PAGE_BIT_ACCESSED,
as we know AEP read performance is much higher than write, so I
think we should also check the dirty bit, _PAGE_BIT_DIRTY. Test
and clear dirty bit is safe for anon page, but unsafe for file
page, e.g. should call clear_page_dirty_for_io first, right?

3) I think we should manage the AEP memory separately instead
of together with the DRAM. Manage them together maybe change less
code, but it will cause some problems at high priority DRAM
allocation if there is no DRAM, then should convert (steal DRAM)
from another one, it takes much time.
How about create a new zone, e.g. ZONE_AEP, and use madvise
to set a new flag VM_AEP, which will enable the vma to alloc AEP
memory in page fault later, then use vma_rss_stat(like mm_rss_stat)
to control the AEP usage percentage for a vma.

4) I am interesting about the conversion mechanism betweent AEP
and DRAM. I think numa balancing will cause page fault, this is
unacceptable for some apps, it cause performance jitter. And the
kswapd is not precise enough. So use a daemon kernel thread
(like khugepaged) maybe a good solution, add the AEP used processes
to a list, then scan the VM_AEP marked vmas, get the access state,
and do the conversion.

Thanks,
Xishi Qiu
On 2018/10/23 04:13, Dave Hansen wrote:
> Persistent memory is cool.  But, currently, you have to rewrite
> your applications to use it.  Wouldn't it be cool if you could
> just have it show up in your system like normal RAM and get to
> it like a slow blob of memory?  Well... have I got the patch
> series for you!
> 
> This series adds a new "driver" to which pmem devices can be
> attached.  Once attached, the memory "owned" by the device is
> hot-added to the kernel and managed like any other memory.  On
> systems with an HMAT (a new ACPI table), each socket (roughly)
> will have a separate NUMA node for its persistent memory so
> this newly-added memory can be selected by its unique NUMA
> node.
> 
> This is highly RFC, and I really want the feedback from the
> nvdimm/pmem folks about whether this is a viable long-term
> perversion of their code and device mode.  It's insufficiently
> documented and probably not bisectable either.
> 
> Todo:
> 1. The device re-binding hacks are ham-fisted at best.  We
>    need a better way of doing this, especially so the kmem
>    driver does not get in the way of normal pmem devices.
> 2. When the device has no proper node, we default it to
>    NUMA node 0.  Is that OK?
> 3. We muck with the 'struct resource' code quite a bit. It
>    definitely needs a once-over from folks more familiar
>    with it than I.
> 4. Is there a better way to do this than starting with a
>    copy of pmem.c?
> 
> Here's how I set up a system to test this thing:
> 
> 1. Boot qemu with lots of memory: "-m 4096", for instance
> 2. Reserve 512MB of physical memory.  Reserving a spot a 2GB
>    physical seems to work: memmap=512M!0x0000000080000000
>    This will end up looking like a pmem device at boot.
> 3. When booted, convert fsdax device to "device dax":
> 	ndctl create-namespace -fe namespace0.0 -m dax
> 4. In the background, the kmem driver will probably bind to the
>    new device.
> 5. Now, online the new memory sections.  Perhaps:
> 
> grep ^MemTotal /proc/meminfo
> for f in `grep -vl online /sys/devices/system/memory/*/state`; do
> 	echo $f: `cat $f`
> 	echo online > $f
> 	grep ^MemTotal /proc/meminfo
> done
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> 
