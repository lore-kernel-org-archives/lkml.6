Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F22084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UunUL+Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeGSPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:30:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39825 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbeGSPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:30:43 -0400
Received: by mail-it0-f65.google.com with SMTP id g141-v6so7817465ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oV9S0475DEDsfesOo3+P9mrKtaTTDVI4OmTKpoEwQII=;
        b=UunUL+Fb3dk0Vwnso+in5SHW9yuFFmg6J240DGSLvRz1gL5YfIFn8RkGKI3vwbO+SJ
         HUSC28AGkV4gpTLGYp1T4SJCKAgnQQMB8qrl+09ofAUrrvauR3nvh1q0TJK+xE6X+JuR
         Bvu7hf117QftN1D7ryBiv/SfdsQrU976BY+B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oV9S0475DEDsfesOo3+P9mrKtaTTDVI4OmTKpoEwQII=;
        b=nEA3WSYALI6SSxia5nHGiX55HD25B2oH7wD0cGPhaV6PqLMifkyvgW/IfxUK5+NQ1E
         eB8Lvw3n9h949Tchishf1i8TPA7j+iGw1heXGV9W491nxEaeHRHhaZlYkKZfaWpSYo+A
         neZJUTHzfEQ7KSGwp1AQCM9L9CWy1TOY+2R12z762AJXOCXWPBRdrKnu/d0F/JADaq62
         I+MvvldwIjoWmhDLnXsMBlRpsL7/WIIYZDo61xUcjZP6OrZ7YAaQg7aZVfaxk76GDc0+
         wgPaFHPEh2US3exWpF/Dd08uDYYR2GXQmbNjmbLCmSJCgf992lr/xMAUqET8xlDZ7qmZ
         6Mbg==
X-Gm-Message-State: AOUpUlHjpjNkWJKs3fosz6GwrZfwsM/xCc8iWzLCY0DHxatsAKJyjO9g
        FYwvoSDCCTl2qY4VE6vaJaves2aBRMRMC46QhYT+LA==
X-Google-Smtp-Source: AAOMgpfMne5kIsKEGqkyE5X+SqQL2WWmsaZHxXDk8IiY2KCO50yVl5V6Hko8eG2UWoTuav9CTsq8QinwRGqRulTQefo=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr10389500oia.154.1532011632600;
 Thu, 19 Jul 2018 07:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 07:47:11
 -0700 (PDT)
In-Reply-To: <20180718152531.60f7df6b@t450s.home>
References: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
 <20180717092207.775e381c@t450s.home> <CABe79T7eVS5Z5+CkNRfWik=jFeejq54xheUOS=Jc9oU6qX8=kA@mail.gmail.com>
 <20180718152531.60f7df6b@t450s.home>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 19 Jul 2018 20:17:11 +0530
Message-ID: <CABe79T6G2_eegbQ_SOy4W38xXngQE3b4RBPys-tO+yBd2jq_fQ@mail.gmail.com>
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

HI Alex,

On Thu, Jul 19, 2018 at 2:55 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 19 Jul 2018 00:05:18 +0530
> Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>
>> Hi Alex,
>>
>> On Tue, Jul 17, 2018 at 8:52 PM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>> > On Fri, 13 Jul 2018 10:26:17 +0530
>> > Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>> >
>> >> By default all BARs map with VMA access permissions
>> >> as pgprot_noncached.
>> >>
>> >> In ARM64 pgprot_noncached is MT_DEVICE_nGnRnE which
>> >> is strongly ordered and allows aligned access.
>> >> This type of mapping works for NON-PREFETCHABLE bars
>> >> containing EP controller registers.
>> >> But it restricts PREFETCHABLE bars from doing
>> >> unaligned access.
>> >>
>> >> In CMB NVMe drives PREFETCHABLE bars are required to
>> >> map as MT_NORMAL_NC to do unaligned access.
>> >>
>> >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> >> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> >> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>> >> ---
>> >
>> > This has been discussed before:
>> >
>> > https://www.spinics.net/lists/kvm/msg156548.html
>> Thank you for inputs.. I have gone through the long list of mail chain
>> discussion.
>> >
>> > CC'ing the usual suspects from the previous thread.  I'm not convinced
>> > that the patch here has considered anything other than the ARM64
>> > implications and it's not clear that it considers compatibility with
>> > existing users or devices at all.  Can we guarantee for all devices and
>> > use cases that WC is semantically equivalent and preferable to UC?  If
>> > not then we need to device an extension to the interface that allows
>> > the user to specify WC.  Thanks,
>> >
>> To implement with user specified WC flags, many changes need to be done.
>> Suppose In DPDK, prefetcable BARs map using WC flag, then also same
>> question comes
>> that WC may be different for different CPUs.
>> As per functionality, both WC and PREFETCHABLE are same, like merging writes and
>> typically WC is uncached.
>> So, based on prefetchable BARs behavior and usage we need to map bar memory.
>> Is it right to map prefetchable BARs as strongly ordered, aligned
>> access and uncached?
>
> Is it possible to answer that question generically?  Whether to map a
> BAR as UC or WC is generally a question for the driver.  Does the
> device handle unaligned accesses?  Does the device need strong memory
> ordering?  If this is a driver level question then the driver that
> needs to make that decision is the userspace driver.  VFIO is just a
> pass-through here and since we don't offer the user a choice of
> mappings, we take the safer and more conservative mapping, ie. UC.
>
Yes, you are right, driver should make the decision based on its requirement.
In my case, user space driver is part of SPDK, so SPDK should request DPDK
and DPDK should request VFIO to map BAR for its choice of mapping.
So to implement this we need code changes in VFIO, DPDK and SPDK.

> You're suggesting that there are many changes to be done if we modify
> the vfio interface to expose WC under the user's control rather than
> simply transparently impose WC for all mappings, but is that really the
> case?  Most devices on most platforms seem to work fine now.  Perhaps WC
> is a performance optimization, but this is the first instance I've seen
> of it as a functional issue.  Does that suggest that the imposed
> alignment on your platform is perhaps unique and the relaxed alignment
> should be implemented at the architecture specific memory flags for UC
> mappings?  For instance, does x86 require this change for the same
> device?  The chance for regressions of other devices on other platforms
> seems rather high as proposed. Thanks,
This issue is not specific to platform or device. this is the requirement of
CMB enabled NVMe cards.
NVMe kernel driver already has support to map CMB bar as WC using
ioremap_wc function.
File: drivers/nvme/host/pci.c
Function: nvme_map_cmb
code: dev->cmb = ioremap_wc(pci_resource_start(pdev, bar) + offset, size);
It means ioremap_wc is working with all platforms and WC map of
perfetchable BARs does not harm.
Same is required in SPDK NVMe driver also, without WC map it may work
in x86 platform, but it does not work in ARM platforms.


Regards,
Srinath.
>
> Alex
