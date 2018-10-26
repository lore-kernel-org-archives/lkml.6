Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F63C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4852082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD74vVZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeJZQkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:40:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43423 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:40:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id s69-v6so226251oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iii6pxs0o3Dq+7wL6FagJmNAA3Zr9SL7dypWcq5uNsM=;
        b=lD74vVZ7tqHrFMD3DvXrR0Jkqyo5J3w+7uKXnVsz7OfkKVM6m1xmr7MPSvlj0RT62V
         ysXSTBCkeNqAPhNthx/+LmD/szIJNl7zY6LG6LNdod4vc2JoKr1zm56hZFP62h1NQ8RA
         WuPcqBzVYsEk0WXcVlRJes36PO0yczteYtlg3vVyZoyetL6u+gtzaMioZwJyR4OjiekS
         dztUDUg6WJAZYuxOb7j/8dVu+8JcgtNKygVnAmEQcuvpXdgtC2F2RlGFr+b82ROI2HbM
         TV7HsBGbkpI4trAjalVRS3TsNCORjAUph+J4Czz/Wiw44hRAnZDdToMi/JJ/P0MqO9Ul
         jX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iii6pxs0o3Dq+7wL6FagJmNAA3Zr9SL7dypWcq5uNsM=;
        b=Ab1c7f+0oj3MYURua6QKFmfoWyMq+0+Ns9/rJmCMIUjswHV0jax9eGGN5qh0vVzCGj
         CpBRBsGCL9Ww7KaCdbIvw665yo9N1CWIWV3vaGrbvN9/otNqnLVF/SYF4wtfxyye8nTd
         4k99oGO1XOtufgCAo21xehEwOh8s2IxQ+uvez100nnVvlDEPom26ekaDKmC3++0zvd0/
         mlQ5IN5QWNdUgllCNHbgmo1bEq5evW0K3deODBUo9Ia/edCzjyyIVco+UDnQoVO5b5GE
         O2fGFQ+h6LLJ440khC6s8Sbxlw60W/nhpqNmW78v0++gU77bNng0gYUdB9Nzs+lSjL98
         urqg==
X-Gm-Message-State: AGRZ1gLDxybi7wprjKj1v32aFJ2YEGFF5y0zEzKI/gm6M6yC6EoftTsI
        yx2BgXEAIPXutX7Ik0QzVN8=
X-Google-Smtp-Source: AJdET5dM94qvKRDc4yIzv1kBiW06Q9Pa3ZnED9Pdb5Ggqy7k0rjhUIo3wbN2d5UsL8sWM0OpZBCPiA==
X-Received: by 2002:aca:d841:: with SMTP id p62-v6mr1405412oig.118.1540541045900;
        Fri, 26 Oct 2018 01:04:05 -0700 (PDT)
Received: from [10.211.55.3] ([47.89.83.47])
        by smtp.gmail.com with ESMTPSA id q16sm3220752otf.35.2018.10.26.01.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 01:04:05 -0700 (PDT)
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Xishi Qiu <qiuxishi@linux.alibaba.com>,
        zy107165@alibaba-inc.com
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
 <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
 <CAPcyv4hFoPkda0YfNKo=nFxttyBG3OjD7vKWyNzLY+8T5gLc=g@mail.gmail.com>
From:   Xishi Qiu <qiuxishi@gmail.com>
Message-ID: <352acc87-a6da-65e4-bbe6-0dbffdc72acc@gmail.com>
Date:   Fri, 26 Oct 2018 16:03:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hFoPkda0YfNKo=nFxttyBG3OjD7vKWyNzLY+8T5gLc=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

How about let the BIOS report a new type for kmem in e820 table?
e.g.
#define E820_PMEM	7
#define E820_KMEM	8

Then pmem and kmem are separately, and we can easily hotadd kmem
to the memory subsystem, no disturb the existing code (e.g. pmem,
nvdimm, dax...).

I don't know whether Intel will change some hardware features for
pmem which used like a volatility memory in the future. Perhaps
faster than pmem, cheaper, but volatility, and no need to care
about atomicity, consistency, L2/L3 cache...

Another question, why call it kmem? what does the "k" mean?

Thanks,
Xishi Qiu
On 2018/10/23 09:11, Dan Williams wrote:
> On Mon, Oct 22, 2018 at 6:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Mon, Oct 22, 2018 at 1:18 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>>
>>> Persistent memory is cool.  But, currently, you have to rewrite
>>> your applications to use it.  Wouldn't it be cool if you could
>>> just have it show up in your system like normal RAM and get to
>>> it like a slow blob of memory?  Well... have I got the patch
>>> series for you!
>>>
>>> This series adds a new "driver" to which pmem devices can be
>>> attached.  Once attached, the memory "owned" by the device is
>>> hot-added to the kernel and managed like any other memory.  On
>>> systems with an HMAT (a new ACPI table), each socket (roughly)
>>> will have a separate NUMA node for its persistent memory so
>>> this newly-added memory can be selected by its unique NUMA
>>> node.
>>>
>>> This is highly RFC, and I really want the feedback from the
>>> nvdimm/pmem folks about whether this is a viable long-term
>>> perversion of their code and device mode.  It's insufficiently
>>> documented and probably not bisectable either.
>>>
>>> Todo:
>>> 1. The device re-binding hacks are ham-fisted at best.  We
>>>    need a better way of doing this, especially so the kmem
>>>    driver does not get in the way of normal pmem devices.
>>> 2. When the device has no proper node, we default it to
>>>    NUMA node 0.  Is that OK?
>>> 3. We muck with the 'struct resource' code quite a bit. It
>>>    definitely needs a once-over from folks more familiar
>>>    with it than I.
>>> 4. Is there a better way to do this than starting with a
>>>    copy of pmem.c?
>>
>> So I don't think we want to do patch 2, 3, or 5. Just jump to patch 7
>> and remove all the devm_memremap_pages() infrastructure and dax_region
>> infrastructure.
>>
>> The driver should be a dead simple turn around to call add_memory()
>> for the passed in range. The hard part is, as you say, arranging for
>> the kmem driver to not stand in the way of typical range / device
>> claims by the dax_pmem device.
>>
>> To me this looks like teaching the nvdimm-bus and this dax_kmem driver
>> to require explicit matching based on 'id'. The attachment scheme
>> would look like this:
>>
>> modprobe dax_kmem
>> echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/new_id
>> echo dax0.0 > /sys/bus/nd/drivers/dax_pmem/unbind
>> echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/bind
>>
>> At step1 the dax_kmem drivers will match no devices and stays out of
>> the way of dax_pmem. It learns about devices it cares about by being
>> explicitly told about them. Then unbind from the typical dax_pmem
>> driver and attach to dax_kmem to perform the one way hotplug.
>>
>> I expect udev can automate this by setting up a rule to watch for
>> device-dax instances by UUID and call a script to do the detach /
>> reattach dance.
> 
> The next question is how to support this for ranges that don't
> originate from the pmem sub-system. I expect we want dax_kmem to
> register a generic platform device representing the range and have a
> generic platofrm driver that turns around and does the add_memory().
> 
