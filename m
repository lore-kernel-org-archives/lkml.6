Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F102E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YQauBU5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F102E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeGRTO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:14:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34027 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:14:29 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so10699861ois.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lZY8QMuT7Vbq3sfluO9YRRPcacvm2T6ysDJmWYWu9vM=;
        b=YQauBU5mI6eUMYr+FjliNb6O+N8Mx3Ssnho3SI2YC4E/3eZeAt+379V0wC9iTmvMFy
         ouA+hzgQ1qxoqXkDjeuA5qZGQAIulIzy32Rb2YqnNUmrN/b8ulSKVN2F4JdcxfdbgFrb
         FuRnUZ5x8CzWzNG7Sg/i0KriVlW8IqHmeYpBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lZY8QMuT7Vbq3sfluO9YRRPcacvm2T6ysDJmWYWu9vM=;
        b=SgOBN0gr6eNR9BRCgehn6SZpvrFzncax5aVa8KDw0GMRWnxgqv8WJFVhjTWCR/N5wQ
         p/JYPJDFVL6p1bAudSPfd8aGq2ZuMhYBSrpAVTeHdWQahP3JjJx7VmIt/6b/L0LukZ9V
         D7AGo+Tx64Wg00KYS1P1tJr6UoJErobCV9HmH18XHPdRz3qHsGcOWP44Z50xXclKsuOG
         /Fah0wCRydK6GdyiDMJYJMgWurIXO6jOnQX6eu/LNdbsR6GyhEVHulcBf4bm/opBuHQ0
         /vAtd6Sc98/HDHmtk037cbIFZoA0j1/70XitlrHE5LtMbkpMjc5ius8ZUVn9Gy1OM+ff
         84ew==
X-Gm-Message-State: AOUpUlFyEC8IEfwY5CixAiP9DkOmUOvxwKF9eO9TpA08jwRTRxKMB93g
        ZANofqvAxkdEzyYs/scPj6pjntNyahFAjMnC6y2uYA==
X-Google-Smtp-Source: AAOMgpczx7YI42OlJOr3+0Xye9rdQcjWNxC/jNT6UdUmj2u3QYcaa8BgLXQTeBjRmBRSCgz3Tg7Lk3eu8CqpJzPo/Ss=
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr7159605oig.349.1531938919362;
 Wed, 18 Jul 2018 11:35:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 11:35:18
 -0700 (PDT)
In-Reply-To: <20180717092207.775e381c@t450s.home>
References: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com> <20180717092207.775e381c@t450s.home>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 19 Jul 2018 00:05:18 +0530
Message-ID: <CABe79T7eVS5Z5+CkNRfWik=jFeejq54xheUOS=Jc9oU6qX8=kA@mail.gmail.com>
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

On Tue, Jul 17, 2018 at 8:52 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Fri, 13 Jul 2018 10:26:17 +0530
> Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>
>> By default all BARs map with VMA access permissions
>> as pgprot_noncached.
>>
>> In ARM64 pgprot_noncached is MT_DEVICE_nGnRnE which
>> is strongly ordered and allows aligned access.
>> This type of mapping works for NON-PREFETCHABLE bars
>> containing EP controller registers.
>> But it restricts PREFETCHABLE bars from doing
>> unaligned access.
>>
>> In CMB NVMe drives PREFETCHABLE bars are required to
>> map as MT_NORMAL_NC to do unaligned access.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>> ---
>
> This has been discussed before:
>
> https://www.spinics.net/lists/kvm/msg156548.html
Thank you for inputs.. I have gone through the long list of mail chain
discussion.
>
> CC'ing the usual suspects from the previous thread.  I'm not convinced
> that the patch here has considered anything other than the ARM64
> implications and it's not clear that it considers compatibility with
> existing users or devices at all.  Can we guarantee for all devices and
> use cases that WC is semantically equivalent and preferable to UC?  If
> not then we need to device an extension to the interface that allows
> the user to specify WC.  Thanks,
>
To implement with user specified WC flags, many changes need to be done.
Suppose In DPDK, prefetcable BARs map using WC flag, then also same
question comes
that WC may be different for different CPUs.
As per functionality, both WC and PREFETCHABLE are same, like merging writes and
typically WC is uncached.
So, based on prefetchable BARs behavior and usage we need to map bar memory.
Is it right to map prefetchable BARs as strongly ordered, aligned
access and uncached?

Please correct me if my understanding is wrong.

Regards,
Srinath.

> Alex
>
>>  drivers/vfio/pci/vfio_pci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index b423a30..eff6b65 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -1142,7 +1142,10 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>>       }
>>
>>       vma->vm_private_data = vdev;
>> -     vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +     if (pci_resource_flags(pdev, index) & IORESOURCE_PREFETCH)
>> +             vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>> +     else
>> +             vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>       vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
>>
>>       return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>
