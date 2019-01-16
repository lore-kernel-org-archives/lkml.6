Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A82C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E2F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfAPVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:40:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:14942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfAPVkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:40:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 13:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="128348691"
Received: from ray.jf.intel.com (HELO [10.7.201.126]) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 16 Jan 2019 13:40:48 -0800
Subject: Re: [PATCH 4/4] dax: "Hotplug" persistent memory for use like normal
 RAM
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <20190116181905.12E102B4@viggo.jf.intel.com>
 <CAErSpo55j7odYf-B-KSoogabD9Qqt605oUGYe6td9wZdYNq_Hg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <98ab9bc8-8a17-297c-da7c-2e6b5a03ef24@intel.com>
Date:   Wed, 16 Jan 2019 13:40:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo55j7odYf-B-KSoogabD9Qqt605oUGYe6td9wZdYNq_Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 1:16 PM, Bjorn Helgaas wrote:
> On Wed, Jan 16, 2019 at 12:25 PM Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>> Currently, a persistent memory region is "owned" by a device driver,
>> either the "Direct DAX" or "Filesystem DAX" drivers.  These drivers
>> allow applications to explicitly use persistent memory, generally
>> by being modified to use special, new libraries.
> 
> Is there any documentation about exactly what persistent memory is?
> In Documentation/, I see references to pstore and pmem, which sound
> sort of similar, but maybe not quite the same?

One instance of persistent memory is nonvolatile DIMMS.  They're
described in great detail here: Documentation/nvdimm/nvdimm.txt

>> +config DEV_DAX_KMEM
>> +       def_bool y
> 
> Is "y" the right default here?  I periodically see Linus complain
> about new things defaulting to "on", but I admit I haven't paid enough
> attention to know whether that would apply here.
> 
>> +       depends on DEV_DAX_PMEM   # Needs DEV_DAX_PMEM infrastructure
>> +       depends on MEMORY_HOTPLUG # for add_memory() and friends

Well, it doesn't default to "on for everyone".  It inherits the state of
DEV_DAX_PMEM so it's only foisted on folks who have already opted in to
generic pmem support.

>> +int dev_dax_kmem_probe(struct device *dev)
>> +{
>> +       struct dev_dax *dev_dax = to_dev_dax(dev);
>> +       struct resource *res = &dev_dax->region->res;
>> +       resource_size_t kmem_start;
>> +       resource_size_t kmem_size;
>> +       struct resource *new_res;
>> +       int numa_node;
>> +       int rc;
>> +
>> +       /* Hotplug starting at the beginning of the next block: */
>> +       kmem_start = ALIGN(res->start, memory_block_size_bytes());
>> +
>> +       kmem_size = resource_size(res);
>> +       /* Adjust the size down to compensate for moving up kmem_start: */
>> +        kmem_size -= kmem_start - res->start;
>> +       /* Align the size down to cover only complete blocks: */
>> +       kmem_size &= ~(memory_block_size_bytes() - 1);
>> +
>> +       new_res = devm_request_mem_region(dev, kmem_start, kmem_size,
>> +                                         dev_name(dev));
>> +
>> +       if (!new_res) {
>> +               printk("could not reserve region %016llx -> %016llx\n",
>> +                               kmem_start, kmem_start+kmem_size);
> 
> 1) It'd be nice to have some sort of module tag in the output that
> ties it to this driver.

Good point.  That should probably be a dev_printk().

> 2) It might be nice to print the range in the same format as %pR,
> i.e., "[mem %#010x-%#010x]" with the end included (start + size -1 ).

Sure, that sounds like a sane thing to do as well.

>> +               return -EBUSY;
>> +       }
>> +
>> +       /*
>> +        * Set flags appropriate for System RAM.  Leave ..._BUSY clear
>> +        * so that add_memory() can add a child resource.
>> +        */
>> +       new_res->flags = IORESOURCE_SYSTEM_RAM;
> 
> IIUC, new_res->flags was set to "IORESOURCE_MEM | ..." in the
> devm_request_mem_region() path.  I think you should keep at least
> IORESOURCE_MEM so the iomem_resource tree stays consistent.
> 
>> +       new_res->name = dev_name(dev);
>> +
>> +       numa_node = dev_dax->target_node;
>> +       if (numa_node < 0) {
>> +               pr_warn_once("bad numa_node: %d, forcing to 0\n", numa_node);
> 
> It'd be nice to again have a module tag and an indication of what
> range is affected, e.g., %pR of new_res.
> 
> You don't save the new_res pointer anywhere, which I guess you intend
> for now since there's no remove or anything else to do with this
> resource?  I thought maybe devm_request_mem_region() would implicitly
> save it, but it doesn't; it only saves the parent (iomem_resource, the
> start (kmem_start), and the size (kmem_size)).

Yeah, that's the intention: removal is currently not supported.  I'll
add a comment to clarify.

>> +               numa_node = 0;
>> +       }
>> +
>> +       rc = add_memory(numa_node, new_res->start, resource_size(new_res));
>> +       if (rc)
>> +               return rc;
>> +
>> +       return 0;
> 
> Doesn't this mean "return rc" or even just "return add_memory(...)"?

Yeah, all of those are equivalent.  I guess I just prefer the explicit
error handling path.
