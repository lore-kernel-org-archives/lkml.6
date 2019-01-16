Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB06C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1363206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Uq5oYQI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfAPWGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:06:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46309 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbfAPWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:06:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so4489540oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7r27cPH6QvmhGZvdPLqpBm2gsIRGHNSXibTSYkggwM=;
        b=Uq5oYQI3BBApJMKZCnuG5WBTN3n6G2h4ZRMgKM8BG+h7RoRAUOM6LgGgQGS377aiuc
         BisgBraGLnlxoJmRgqvX/OtHDk3+XpwfDXkzIN+PxyTupd7CHtw9khCI3KqtnZNJdP4D
         bzr1mJZ+2qlCVY3bLXhbGmWwFMjaB7PYvVwQhBZQXDFczi63Hswr9sokChIJ6S4JeVHV
         Pe1edn89lbK0QU++lnot2oGVNJNodAeqMwsDZH91kQG6Uw1mthtFlAQ0GCsD88zIGBLB
         9YqSNWZvmVI2WwRUn+Y0meelrrKDcjt7Dxw1gwKEyICxs05IwPrtlRUnLahDx/oeFxmV
         ix5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7r27cPH6QvmhGZvdPLqpBm2gsIRGHNSXibTSYkggwM=;
        b=jEVPfNIIuJwBYD4zz1mRvTfIiSBvl/mS6qyWcLF6SZ/AF1jkTUCR0DmrLmPWy/A6Ns
         //V2TfTzkSBveaQk6pXpxjMjcABFnwl1YVIZz5xzLIba/+IpiNAtTotC06WcwAypKiqJ
         X4tFrODc+3Gr8UTT/YB+0FqDJU7Cl03RGxFVFt52lYNRwP0pc98DYJZ+z9NuT21fC9OC
         yX9QMH/DrGuZ0YSefSYMk9Ed8jH1wc1Z/ZGu7hGSNgPt7zBfgAEQiRBvKznjNJJ3tt7c
         0QbnEiZJBO7eEFAmdA3FcPLf+WI2nI8zJHMx/vmLnlR4M4qOOKSPRKd1Y+SUWeah2goX
         oEkg==
X-Gm-Message-State: AJcUukcyuJOEB+3Z0EByHRXS7exS887Dy235TRFdga/c3FIlgv3jIk0O
        5o8nQ9jAn+KsZSqffpUC8d62aycnPRZc8Z7y4jz1hQ==
X-Google-Smtp-Source: ALg8bN4pYCr4EJDsaQN161STZjWM99XH/h4zhSKYSaZb9jT5UIcgy05VBZmlmCPw0TINTxQ2kGHIRNG3VdqDVL53fxk=
X-Received: by 2002:aca:d905:: with SMTP id q5mr3147783oig.0.1547676391437;
 Wed, 16 Jan 2019 14:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20190116181859.D1504459@viggo.jf.intel.com> <20190116181905.12E102B4@viggo.jf.intel.com>
 <CAErSpo55j7odYf-B-KSoogabD9Qqt605oUGYe6td9wZdYNq_Hg@mail.gmail.com> <98ab9bc8-8a17-297c-da7c-2e6b5a03ef24@intel.com>
In-Reply-To: <98ab9bc8-8a17-297c-da7c-2e6b5a03ef24@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Jan 2019 14:06:20 -0800
Message-ID: <CAPcyv4gD1SBksfjRWAY5Jn3uviGUu0E=dD-fw7Ti-i0QYFFnbw@mail.gmail.com>
Subject: Re: [PATCH 4/4] dax: "Hotplug" persistent memory for use like normal RAM
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave@sr71.net>, Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:40 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/16/19 1:16 PM, Bjorn Helgaas wrote:
> > On Wed, Jan 16, 2019 at 12:25 PM Dave Hansen
> > <dave.hansen@linux.intel.com> wrote:
> >> From: Dave Hansen <dave.hansen@linux.intel.com>
> >> Currently, a persistent memory region is "owned" by a device driver,
> >> either the "Direct DAX" or "Filesystem DAX" drivers.  These drivers
> >> allow applications to explicitly use persistent memory, generally
> >> by being modified to use special, new libraries.
> >
> > Is there any documentation about exactly what persistent memory is?
> > In Documentation/, I see references to pstore and pmem, which sound
> > sort of similar, but maybe not quite the same?
>
> One instance of persistent memory is nonvolatile DIMMS.  They're
> described in great detail here: Documentation/nvdimm/nvdimm.txt
>
> >> +config DEV_DAX_KMEM
> >> +       def_bool y
> >
> > Is "y" the right default here?  I periodically see Linus complain
> > about new things defaulting to "on", but I admit I haven't paid enough
> > attention to know whether that would apply here.
> >
> >> +       depends on DEV_DAX_PMEM   # Needs DEV_DAX_PMEM infrastructure
> >> +       depends on MEMORY_HOTPLUG # for add_memory() and friends
>
> Well, it doesn't default to "on for everyone".  It inherits the state of
> DEV_DAX_PMEM so it's only foisted on folks who have already opted in to
> generic pmem support.
>
> >> +int dev_dax_kmem_probe(struct device *dev)
> >> +{
> >> +       struct dev_dax *dev_dax = to_dev_dax(dev);
> >> +       struct resource *res = &dev_dax->region->res;
> >> +       resource_size_t kmem_start;
> >> +       resource_size_t kmem_size;
> >> +       struct resource *new_res;
> >> +       int numa_node;
> >> +       int rc;
> >> +
> >> +       /* Hotplug starting at the beginning of the next block: */
> >> +       kmem_start = ALIGN(res->start, memory_block_size_bytes());
> >> +
> >> +       kmem_size = resource_size(res);
> >> +       /* Adjust the size down to compensate for moving up kmem_start: */
> >> +        kmem_size -= kmem_start - res->start;
> >> +       /* Align the size down to cover only complete blocks: */
> >> +       kmem_size &= ~(memory_block_size_bytes() - 1);
> >> +
> >> +       new_res = devm_request_mem_region(dev, kmem_start, kmem_size,
> >> +                                         dev_name(dev));
> >> +
> >> +       if (!new_res) {
> >> +               printk("could not reserve region %016llx -> %016llx\n",
> >> +                               kmem_start, kmem_start+kmem_size);
> >
> > 1) It'd be nice to have some sort of module tag in the output that
> > ties it to this driver.
>
> Good point.  That should probably be a dev_printk().
>
> > 2) It might be nice to print the range in the same format as %pR,
> > i.e., "[mem %#010x-%#010x]" with the end included (start + size -1 ).
>
> Sure, that sounds like a sane thing to do as well.

Does %pR protect physical address disclosure to non-root by default?
At least the pmem driver is using %pR rather than manually printing
raw physical address values, but you would need to create a local
modified version of the passed in resource.

> >> +               return -EBUSY;
> >> +       }
> >> +
> >> +       /*
> >> +        * Set flags appropriate for System RAM.  Leave ..._BUSY clear
> >> +        * so that add_memory() can add a child resource.
> >> +        */
> >> +       new_res->flags = IORESOURCE_SYSTEM_RAM;
> >
> > IIUC, new_res->flags was set to "IORESOURCE_MEM | ..." in the
> > devm_request_mem_region() path.  I think you should keep at least
> > IORESOURCE_MEM so the iomem_resource tree stays consistent.
> >
> >> +       new_res->name = dev_name(dev);
> >> +
> >> +       numa_node = dev_dax->target_node;
> >> +       if (numa_node < 0) {
> >> +               pr_warn_once("bad numa_node: %d, forcing to 0\n", numa_node);
> >
> > It'd be nice to again have a module tag and an indication of what
> > range is affected, e.g., %pR of new_res.
> >
> > You don't save the new_res pointer anywhere, which I guess you intend
> > for now since there's no remove or anything else to do with this
> > resource?  I thought maybe devm_request_mem_region() would implicitly
> > save it, but it doesn't; it only saves the parent (iomem_resource, the
> > start (kmem_start), and the size (kmem_size)).
>
> Yeah, that's the intention: removal is currently not supported.  I'll
> add a comment to clarify.

I would clarify that *driver* removal is supported because there's no
Linux facility for drivers to fail removal (nothing checks the return
code from ->remove()). Instead the protection is that the resource
must remain pinned forever. In that case devm_request_mem_region() is
the wrong function to use. You want to explicitly use the non-devm
request_mem_region() and purposely leak it to keep the memory reserved
indefinitely.
