Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D9E21736
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D9E21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeHCQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:52:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeHCQwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A4F9406E886;
        Fri,  3 Aug 2018 14:55:32 +0000 (UTC)
Received: from redhat.com (ovpn-125-78.rdu2.redhat.com [10.10.125.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0411D10CD65B;
        Fri,  3 Aug 2018 14:55:27 +0000 (UTC)
Date:   Fri, 3 Aug 2018 10:55:26 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Hao Fang <fanghao11@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180803145526.GB4079@redhat.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802111000.4649d9ed@alans-desktop>
 <20180802144627.GB3481@redhat.com>
 <20180803152043.40f88947@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180803152043.40f88947@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 14:55:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 14:55:32 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 03:20:43PM +0100, Alan Cox wrote:
> > If we are going to have any kind of general purpose accelerator API then
> > > it has to be able to implement things like  
> > 
> > Why is the existing driver model not good enough ? So you want
> > a device with function X you look into /dev/X (for instance
> > for GPU you look in /dev/dri)
> 
> Except when my GPU is in an FPGA in which case it might be somewhere else
> or it's a general purpose accelerator that happens to be usable as a GPU.
> Unusual today in big computer space but you'll find it in
> microcontrollers.

You do need a specific userspace driver for each of those device
correct ?

You definitly do for GPU and i do not see that going away any time
soon. I doubt Xilinx and Altera will ever compile down to same bit-
stream format either.

So userspace application is bound to use some kind of library that
implement the userspace side of the driver and that library can
easily provide helpers to enumerate all the devices it supports.

For instance that is what OpenCL allows for both GPU and FPGA.
One single API and multiple different hardware you can target from
it.


> > Each of those device need a userspace driver and thus this
> > user space driver can easily knows where to look. I do not
> > expect that every application will reimplement those drivers
> > but instead use some kind of library that provide a high
> > level API for each of those devices.
> 
> Think about it from the user level. You have a pipeline of things you
> wish to execute, you need to get the right accelerator combinations and
> they need to fit together to meet system constraints like number of
> IOMMU ids the accelerator supports, where they are connected.

Creating a pipe of device ie one device consuming the work of
the previous one, is a problem on its own and it should be solved
separatly and not inside VFIO.

GPU (on ARM) already have this pipe thing because the IP block
that do overlay, or the IP block that push pixel to the screen or
the IP block that do 3D rendering are all coming from different
company.

I do not see the value of having all the device enumerated through
VFIO to address this problem. I can definitly understand having a
specific kernel mechanism to expose to userspace what is do-able
but i believe this should be its own thing that allow any device
(a VFIO one, a network one, a GPU, a FPGA, ...) to be use in "pipe"
mode.


> > Now you have a hierarchy of memory for the CPU (HBM, local
> > node main memory aka you DDR dimm, persistent memory) each
> 
> It's not a heirarchy, it's a graph. There's no fundamental reason two
> accelerators can't be close to two different CPU cores but have shared
> HBM that is far from each processor. There are physical reasons it tends
> to look more like a heirarchy today.

Yes you are right i used the wrong word.

> 
> > Anyway i think finding devices and finding relation between
> > devices and memory is 2 separate problems and as such should
> > be handled separatly.
> 
> At a certain level they are deeply intertwined because you need a common
> API. It's not good if I want a particular accelerator and need to then
> see which API its under on this machine and which interface I have to
> use, and maybe have a mix of FPGA, WarpDrive and Google ASIC interfaces
> all different.
> 
> The job of the kernel is to impose some kind of sanity and unity on this
> lot.
> 
> All of it in the end comes down to
> 
> 'Somehow glue some chunk of memory into my address space and find any
> supporting driver I need'
> 
> plus virtualization of the above.
> 
> That bit's easy - but making it usable is a different story.

My point is that for all those devices you will have a userspace drivers
and thus all the complexity of finding best memory for a given combination
of hardware can be push to userspace. Kernel only have to expose the
topology of the different memory and their relation with each of the
devices. Very much like you have NUMA node for CPU.


I rather see kernel having one API to expose topology, one API to
expose device mixing capabilities (ie how can you can pipe device
together if at all). Then having to update every single existing
upstream driver that want to participate in the above to now become
a VFIO driver.


I have nothing against VFIO ;) Just to me it seems that this is all
reinventing a new device driver infrastructure under it while the
existing one is good enough and can evolve to support all the cases
discussed here.

Cheers,
Jérôme
