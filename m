Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RFosEL7eHVtQKQAAmS7hNA
	; Mon, 11 Jun 2018 02:39:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E705760791; Mon, 11 Jun 2018 02:39:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 060936070A;
	Mon, 11 Jun 2018 02:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 060936070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeFKCjZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 22:39:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753785AbeFKCjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 22:39:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B2dAGj039359
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 22:39:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jhcf3x12m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 22:39:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Mon, 11 Jun 2018 03:39:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 03:39:16 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B2dFJl29753460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 02:39:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10F3942041;
        Mon, 11 Jun 2018 03:29:30 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D979A4203F;
        Mon, 11 Jun 2018 03:29:26 +0100 (BST)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.200.197])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jun 2018 03:29:26 +0100 (BST)
Date: Sun, 10 Jun 2018 19:39:09 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        benh@kernel.crashing.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180607185234-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18061102-0008-0000-0000-000002463BD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061102-0009-0000-0000-000021AC5C3C
Message-Id: <20180611023909.GA5726@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:28:35PM +0300, Michael S. Tsirkin wrote:
> On Wed, Jun 06, 2018 at 10:23:06PM -0700, Christoph Hellwig wrote:
> > On Thu, May 31, 2018 at 08:43:58PM +0300, Michael S. Tsirkin wrote:
> > > Pls work on a long term solution. Short term needs can be served by
> > > enabling the iommu platform in qemu.
> > 
> > So, I spent some time looking at converting virtio to dma ops overrides,
> > and the current virtio spec, and the sad through I have to tell is that
> > both the spec and the Linux implementation are complete and utterly fucked
> > up.
> 
> Let me restate it: DMA API has support for a wide range of hardware, and
> hardware based virtio implementations likely won't benefit from all of
> it.
> 
> And given virtio right now is optimized for specific workloads, improving
> portability without regressing performance isn't easy.
> 
> I think it's unsurprising since it started a strictly a guest/host
> mechanism.  People did implement offloads on specific platforms though,
> and they are known to work. To improve portability even further,
> we might need to make spec and code changes.
> 
> I'm not really sympathetic to people complaining that they can't even
> set a flag in qemu though. If that's the case the stack in question is
> way too inflexible.

We did consider your suggestion. But can't see how it will work.
Maybe you can guide us here. 

In our case qemu has absolutely no idea if the VM will switch itself to
secure mode or not.  Its a dynamic decision made entirely by the VM
through direct interaction with the hardware/firmware; no
qemu/hypervisor involved.

If the administrator, who invokes qemu, enables the flag, the DMA ops
associated with the virito devices will be called, and hence will be
able to do the right things. Yes we might incur performance hit due to
the IOMMU translations, but lets ignore that for now; the functionality
will work. Good till now.

However if the administrator
ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
flag, virtio will not be able to pass control to the DMA ops associated
with the virtio devices. Which means, we have no opportunity to share
the I/O buffers with the hypervisor/qemu.

How do you suggest, we handle this case?

> 
> 
> 
> > Both in the flag naming and the implementation there is an implication
> > of DMA API == IOMMU, which is fundamentally wrong.
> 
> Maybe we need to extend the meaning of PLATFORM_IOMMU or rename it.
> 
> It's possible that some setups will benefit from a more
> fine-grained approach where some aspects of the DMA
> API are bypassed, others aren't.
> 
> This seems to be what was being asked for in this thread,
> with comments claiming IOMMU flag adds too much overhead.
> 
> 
> > The DMA API does a few different things:
> > 
> >  a) address translation
> > 
> > 	This does include IOMMUs.  But it also includes random offsets
> > 	between PCI bars and system memory that we see on various
> > 	platforms.
> 
> I don't think you mean bars. That's unrelated to DMA.
> 
> >  Worse so some of these offsets might be based on
> > 	banks, e.g. on the broadcom bmips platform.  It also deals
> > 	with bitmask in physical addresses related to memory encryption
> > 	like AMD SEV.  I'd be really curious how for example the
> > 	Intel virtio based NIC is going to work on any of those
> > 	plaforms.
> 
> SEV guys report that they just set the iommu flag and then it all works.

This is one of the fundamental difference between SEV architecture and
the ultravisor architecture. In SEV, qemu is aware of SEV.  In
ultravisor architecture, only the VM that runs within qemu is aware of
ultravisor;  hypervisor/qemu/administrator are untrusted entities.

I hope, we can make virtio subsystem flexibe enough to support various
security paradigms.

Apart from the above reason, Christoph and Ben point to so many other
reasons to make it flexibe. So why not, make it happen?


> I guess if there's translation we can think of this as a kind of iommu.
> Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?
> 
> And apparently some people complain that just setting that flag makes
> qemu check translation on each access with an unacceptable performance
> overhead.  Forcing same behaviour for everyone on general principles
> even without the flag is unlikely to make them happy.
> 
> >   b) coherency
> > 
> > 	On many architectures DMA is not cache coherent, and we need
> > 	to invalidate and/or write back cache lines before doing
> > 	DMA.  Again, I wonder how this is every going to work with
> > 	hardware based virtio implementations.
> 
> 
> You mean dma_Xmb and friends?
> There's a new feature VIRTIO_F_IO_BARRIER that's being proposed
> for that.
> 
> 
> >  Even worse I think this
> > 	is actually broken at least for VIVT event for virtualized
> > 	implementations.  E.g. a KVM guest is going to access memory
> > 	using different virtual addresses than qemu, vhost might throw
> > 	in another different address space.
> 
> I don't really know what VIVT is. Could you help me please?
> 
> >   c) bounce buffering
> > 
> > 	Many DMA implementations can not address all physical memory
> > 	due to addressing limitations.  In such cases we copy the
> > 	DMA memory into a known addressable bounc buffer and DMA
> > 	from there.
> 
> Don't do it then?
> 
> 
> >   d) flushing write combining buffers or similar
> > 
> > 	On some hardware platforms we need workarounds to e.g. read
> > 	from a certain mmio address to make sure DMA can actually
> > 	see memory written by the host.
> 
> I guess it isn't an issue as long as WC isn't actually used.
> It will become an issue when virtio spec adds some WC capability -
> I suspect we can ignore this for now.
> 
> > 
> > All of this is bypassed by virtio by default despite generally being
> > platform issues, not particular to a given device.
> 
> It's both a device and a platform issue. A PV device is often more like
> another CPU than like a PCI device.
> 
> 
> 
> -- 
> MST

-- 
Ram Pai
