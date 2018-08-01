Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ABCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EFC20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gCQwinN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EFC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeHATpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:45:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37679 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeHATpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:45:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id j205-v6so6365950oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+r7+b+0b48kr+UsI63pOhi971NcDB/+j0t/8tpk+5s4=;
        b=gCQwinN2VnieDxIse7tYtZ5uiVwX9Z2Az4vhU065/CPyH8lK82diDtsMB/DuXKM1/T
         4yc8EsPwGaT4WkIlwx5RBTnx2QJLhoLENP5kxyhRwFsGLB7ztkYz9o3Af5In18EuFN/M
         rZE/alDVOvoC8U5/WPLqjYRXWN1IFjhLPTpBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+r7+b+0b48kr+UsI63pOhi971NcDB/+j0t/8tpk+5s4=;
        b=FKCTFfydWI1p2h272/0Icfnfu+2Kpf83OyF7x/+9WWe6EBXzJH8N2Y1z0NQrc8cOXN
         /47U9DaVU01MGvQqmN1CcDV601Ss5Smt+T1kb/v+CFSAA/BDg9L8SdIlNJmAfZu2pL5Q
         Z3lnRoPCfvaeUsPKLVkGQFM4QOa03MpQwYvkxFS8Y4WMBmgnsAoCsuMLtm1CHp2QlW6z
         r8sBy5F78FHrWYvj00WRUEmI3ONyF6ctylh1tzgjgMPgLJgIe4SJZo+elhbxv3kzNujw
         Yamp1G8PgDhoxrbl2D28FzH4srkdXoVMbzhuWG7Ge/9Yc5RHvBuyQiiBFvoFIFPVp9IT
         6iQw==
X-Gm-Message-State: AOUpUlFSgfPmmxnKgaG0nBRhdApbOXN/CBJ05iNXVGYiQBRM52wqR7Jz
        STYHBUlw2iECLxXLqTUEwf8cgw5JN1DMKFYErRFq9xPVHn0=
X-Google-Smtp-Source: AAOMgpfttHzdcdtWIhCZQBmUCmTP7gQ5o1OTjec0jMXHvZKSc33nyn+vhn3dhXbtWkZ6aA1+xentGc+q7jnhjYAA0ZM=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr4856569oih.227.1533146333896;
 Wed, 01 Aug 2018 10:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 10:58:53 -0700 (PDT)
In-Reply-To: <CABe79T5du2Ctx9LuFU8_5eO+9ckm6+BMB0vMf6yL2A_wNwE1TQ@mail.gmail.com>
References: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
 <20180717092207.775e381c@t450s.home> <CABe79T7eVS5Z5+CkNRfWik=jFeejq54xheUOS=Jc9oU6qX8=kA@mail.gmail.com>
 <20180718152531.60f7df6b@t450s.home> <CABe79T6G2_eegbQ_SOy4W38xXngQE3b4RBPys-tO+yBd2jq_fQ@mail.gmail.com>
 <20180719091252.749f2433@t450s.home> <CABe79T7A2ud3jbm9B43S9RQvOdJ0b29NUb3s9yKNTv257sfEMw@mail.gmail.com>
 <20180720142728.572dd2d7@t450s.home> <CABe79T5du2Ctx9LuFU8_5eO+9ckm6+BMB0vMf6yL2A_wNwE1TQ@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 1 Aug 2018 23:28:53 +0530
Message-ID: <CABe79T7-+qL3siCDc6SeEqEaj3TJQ6O_sVTZzm+wXoYJQWyvbA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfio/pci: map prefetchble bars as writecombine
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        kvm@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>,
        benh@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

In user space UIO driver (DPDK) implementation, sysfs interface
"/sys/devices/pci/.../resource0_wc" is used to map prefetchable PCI
resources as WC.
Platforms which support write-combining maps of PCI resources have
arch_can_pci_mmap_wc() flag enabled. So that it allows to map resources as WC.
In this approach mmap calls "pci_mmap_resource_range" kernel function
with write_combine parameter set.
"drivers/pci/pci-sysfs.c" kernel file has this implementation.

If this approach fits to vfio driver, then code change in vfio driver are

 if (arch_can_pci_mmap_wc() &&
     (pci_resource_flags(pdev, index) & IORESOURCE_PREFETCH))
            vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
        else
vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

Please provide your feedback.

Thank you.

On Mon, Jul 23, 2018 at 2:03 PM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> On Sat, Jul 21, 2018 at 1:57 AM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
>> On Thu, 19 Jul 2018 21:49:48 +0530
>> Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>
>>> HI Alex,
>>>
>>> On Thu, Jul 19, 2018 at 8:42 PM, Alex Williamson
>>> <alex.williamson@redhat.com> wrote:
>>> > On Thu, 19 Jul 2018 20:17:11 +0530
>>> > Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>> >
>>> >> HI Alex,
>>> >>
>>> >> On Thu, Jul 19, 2018 at 2:55 AM, Alex Williamson
>>> >> <alex.williamson@redhat.com> wrote:
>>> >> > On Thu, 19 Jul 2018 00:05:18 +0530
>>> >> > Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>> >> >
>>> >> >> Hi Alex,
>>> >> >>
>>> >> >> On Tue, Jul 17, 2018 at 8:52 PM, Alex Williamson
>>> >> >> <alex.williamson@redhat.com> wrote:
>>> >> >> > On Fri, 13 Jul 2018 10:26:17 +0530
>>> >> >> > Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>> >> >> >
>>> >> >> >> By default all BARs map with VMA access permissions
>>> >> >> >> as pgprot_noncached.
>>> >> >> >>
>>> >> >> >> In ARM64 pgprot_noncached is MT_DEVICE_nGnRnE which
>>> >> >> >> is strongly ordered and allows aligned access.
>>> >> >> >> This type of mapping works for NON-PREFETCHABLE bars
>>> >> >> >> containing EP controller registers.
>>> >> >> >> But it restricts PREFETCHABLE bars from doing
>>> >> >> >> unaligned access.
>>> >> >> >>
>>> >> >> >> In CMB NVMe drives PREFETCHABLE bars are required to
>>> >> >> >> map as MT_NORMAL_NC to do unaligned access.
>>> >> >> >>
>>> >> >> >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> >> >> >> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> >> >> >> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>>> >> >> >> ---
>>> >> >> >
>>> >> >> > This has been discussed before:
>>> >> >> >
>>> >> >> > https://www.spinics.net/lists/kvm/msg156548.html
>>> >> >> Thank you for inputs.. I have gone through the long list of mail chain
>>> >> >> discussion.
>>> >> >> >
>>> >> >> > CC'ing the usual suspects from the previous thread.  I'm not convinced
>>> >> >> > that the patch here has considered anything other than the ARM64
>>> >> >> > implications and it's not clear that it considers compatibility with
>>> >> >> > existing users or devices at all.  Can we guarantee for all devices and
>>> >> >> > use cases that WC is semantically equivalent and preferable to UC?  If
>>> >> >> > not then we need to device an extension to the interface that allows
>>> >> >> > the user to specify WC.  Thanks,
>>> >> >> >
>>> >> >> To implement with user specified WC flags, many changes need to be done.
>>> >> >> Suppose In DPDK, prefetcable BARs map using WC flag, then also same
>>> >> >> question comes
>>> >> >> that WC may be different for different CPUs.
>>> >> >> As per functionality, both WC and PREFETCHABLE are same, like merging writes and
>>> >> >> typically WC is uncached.
>>> >> >> So, based on prefetchable BARs behavior and usage we need to map bar memory.
>>> >> >> Is it right to map prefetchable BARs as strongly ordered, aligned
>>> >> >> access and uncached?
>>> >> >
>>> >> > Is it possible to answer that question generically?  Whether to map a
>>> >> > BAR as UC or WC is generally a question for the driver.  Does the
>>> >> > device handle unaligned accesses?  Does the device need strong memory
>>> >> > ordering?  If this is a driver level question then the driver that
>>> >> > needs to make that decision is the userspace driver.  VFIO is just a
>>> >> > pass-through here and since we don't offer the user a choice of
>>> >> > mappings, we take the safer and more conservative mapping, ie. UC.
>>> >> >
>>> >> Yes, you are right, driver should make the decision based on its requirement.
>>> >> In my case, user space driver is part of SPDK, so SPDK should request DPDK
>>> >> and DPDK should request VFIO to map BAR for its choice of mapping.
>>> >> So to implement this we need code changes in VFIO, DPDK and SPDK.
>>> >>
>>> >> > You're suggesting that there are many changes to be done if we modify
>>> >> > the vfio interface to expose WC under the user's control rather than
>>> >> > simply transparently impose WC for all mappings, but is that really the
>>> >> > case?  Most devices on most platforms seem to work fine now.  Perhaps WC
>>> >> > is a performance optimization, but this is the first instance I've seen
>>> >> > of it as a functional issue.  Does that suggest that the imposed
>>> >> > alignment on your platform is perhaps unique and the relaxed alignment
>>> >> > should be implemented at the architecture specific memory flags for UC
>>> >> > mappings?  For instance, does x86 require this change for the same
>>> >> > device?  The chance for regressions of other devices on other platforms
>>> >> > seems rather high as proposed. Thanks,
>>> >> This issue is not specific to platform or device. this is the requirement of
>>> >> CMB enabled NVMe cards.
>>> >> NVMe kernel driver already has support to map CMB bar as WC using
>>> >> ioremap_wc function.
>>> >> File: drivers/nvme/host/pci.c
>>> >> Function: nvme_map_cmb
>>> >> code: dev->cmb = ioremap_wc(pci_resource_start(pdev, bar) + offset, size);
>>> >> It means ioremap_wc is working with all platforms and WC map of
>>> >> perfetchable BARs does not harm.
>>> >> Same is required in SPDK NVMe driver also, without WC map it may work
>>> >> in x86 platform, but it does not work in ARM platforms.
>>> >
>>> > Doesn't this contradict your assertion that it's not specific to
>>> > platform or device?  The device requires support for unaligned
>>> > accesses.  The platform chooses to restrict unaligned accesses for
>>> > non-WC mappings while other platforms do not.  The native driver can
>>> > still clearly have performance considerations for choosing to use WC
>>> > mappings, but it's still not clear to me that the functionality issue
>>> > isn't self inflicted by the platform definition of UC vs WC.  Thanks,
>>> >
>>> Device allows both aligned and unaligned access.. so software have
>>> flexibility can do unaligned access.
>>> As per ARM64 platform, with UC map, memory access should be un-cached,
>>> aligned access and strongly order mapping.
>>> with WC map, memory access can be aligned/unaligned and un-cached. I
>>> thought this is the property of platform not issue.
>>> To allow software to do unaligned access of device memory, we need to
>>> use WC map of ARM64 platform case.
>>> In ARM platforms UC mapping is used to map controller registers which
>>> are 4 byte aligned exposed by non-prefetchable bars.
>>> Also prefetchable BARs allows write merging so I thought using WC map
>>> fulfills both write merging (add performance) and unaligned
>>> access.
>>> Can I modify the code as below to enable only for ARM platforms.
>>>         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>>> +       if (pci_resource_flags(pdev, index) & IORESOURCE_PREFETCH)
>>> +               vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>>> +#endif
>>>         vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
>>
>> While the risk of regression is smaller by restricting this to ARM, I
>> don't think it's the right solution.  What happens when a device
>> requires strict ordering?  ARM now behaves differently than any other
>> architecture, that's not acceptable.  Thanks,
> If strict ordering is required for prefetchable bars, driver software
> has to add barrier instructions.
> With this we can assume for prefetchable bars WC mapping should be fine?
>
> Regards,
> Srinath.
>>
>> Alex
