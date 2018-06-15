Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40224C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E734A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bXZCELnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E734A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755832AbeFOGLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:11:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33132 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755746AbeFOGLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:11:48 -0400
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so7880317oiy.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 23:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LVHngQBKM0Gl68s4rX5Cic5Abn77PgegYwpXUISJEpk=;
        b=bXZCELnWjDf3SZUnnf3b6LRqlROua6JrnD9dZkJyXdcJmqV/RyRI5vHH9Yh/+BJTjA
         tr2Q9AwO2HK4XEwAbqx4JFXy7/HxWOkueAe1JO/4b9FAcvK0/S4a0ZO6fsGg9xK0U6xv
         WYK8QfKt4ncdgYFNJ3gD6cQHdz4+nLsNKDysE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LVHngQBKM0Gl68s4rX5Cic5Abn77PgegYwpXUISJEpk=;
        b=mrlK7xU9zDGCiME8wnwvhmGh3IrElO/O0tbm1Imajf77k9RIRN+1mVYRH5PGgJkUTr
         DSdOaEzFd5LNk8SakRFb3JpZJvwSF7q35rgcPLks1AUYZUXssyKhsWlJJjI7a5vfTnaj
         bL4AXI8Cq+6n4HEDZX0Un228567DbB/26aTDw7qJpw3/gC+ko1YOz0j29OGs+BuiOxCW
         mHY6eeuIgAIJylqtlTl0JXYy70nmY6IAU7Otb4FZuJTXfXuBdVUU1kPlcKnZ9ATFk7Fu
         rpJrHtULmkPPefyLJDIXFIXaccGqA5O46RHcJ10/oMRi3KY5K8k3RKr7B0DltukVx5z0
         0xKQ==
X-Gm-Message-State: APt69E39hs/u7nPffJszo70gJ7pC8K03vCknrxRAXzg7J+CBbb6PAQ8y
        B8gg4jMaQ8W9FoaRTrYqRCbwKHO7voU+UV18NhGnbQ==
X-Google-Smtp-Source: ADUXVKIt0JVxV6NQ0SHCSZnKZ/AOB7LDqsBbSTt6PHkZlXFJNV/k1S7wvWReWT0Bl3TSn8YF8DFs6vg1FTBYkvdLkqo=
X-Received: by 2002:aca:e6c2:: with SMTP id d185-v6mr173171oih.154.1529043108097;
 Thu, 14 Jun 2018 23:11:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 23:11:47
 -0700 (PDT)
In-Reply-To: <fc8795b0a4619d4c4abc55fdf010015db7272db5.camel@intel.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de> <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org> <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
 <20180614085015.3f39b367@w520.home> <fc8795b0a4619d4c4abc55fdf010015db7272db5.camel@intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 15 Jun 2018 11:41:47 +0530
Message-ID: <CABe79T4yopn4FJqSv+igvekNBZOgmySxyoxFfFzQP=grd9p=vg@mail.gmail.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
To:     "Walker, Benjamin" <benjamin.walker@intel.com>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikram.prakash@broadcom.com" <vikram.prakash@broadcom.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "hch@lst.de" <hch@lst.de>,
        "abhishek.shah@broadcom.com" <abhishek.shah@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much Alex and Ben for all the details.

Please find my comments in lined..


On Fri, Jun 15, 2018 at 1:34 AM, Walker, Benjamin
<benjamin.walker@intel.com> wrote:
> On Thu, 2018-06-14 at 08:50 -0600, Alex Williamson wrote:
>> On Thu, 14 Jun 2018 16:18:15 +0530
>> Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>
>> > Hi Sinan Kaya,
>> >
>> > Here are the details,
>> >
>> > The issue is, For CMB cards SQs are allocated inside device BAR memory
>> > which is different from normal cards.
>> > In Normal cards SQ memory allocated at host side.
>> > In both the cases physical address of CQ memory is programmed in NVMe
>> > controller register.
>> > This method works for normal cards because CQ memory is at host side.
>> > But in CMB cards pci bus address equivalent to CQ memory needs to program.
>> >
>> > More details are in the patch: nvme-pci: Use PCI bus address for
>> > data/queues in CMB.
>> >
>> > With the above patch issue is fixed in the NVMe kernel driver, But
>> > similar fix is required in SPDK library also.
>> > So, We need a mechanism to get pci_bus_address in user space libraries
>> > to address this issue.
>>
>> I don't understand the CQ vs CMB, but I think I gather that there's some
Sorry, It was mistake, I meant SQ not CQ.
>> sort of buffer that's allocated from within the devices MMIO BAR and
>> some programming of the device needs to reference that buffer.
>> Wouldn't you therefore use the vfio type1 IOMMU MAP_DMA ioctl to map
>> the BAR into the IOVA address space and you can then use the IOVA +
>> offset into the BAR for the device to reference the buffer?  It seems
>> this is the same way we'd setup a peer-to-peer mapping, but we're using
>> it for the device to reference itself effectively.  Thanks,
>
> SPDK already does this today. It's capable of placing submission and completion
> queues in the device's controller memory buffer (CMB) and will do all of the
> right things for both uio (look up physical address) and vfio (send
> IOMMU_MAP_DMA ioctl to set a iova and use that). It additionally already
> supports using the CMB as a target for peer-to-peer data transfers.
>
> This was just confirmed to work on the most recent SPDK release. If you are not
> on the most recent release, I recommend trying that first. If there is still
> some issue, please do take it to the SPDK mailing list.
>
We are using SPDK version 18.04.
Is fix available in 18.04? Please point me to the patch with which fix
was added.

> Thanks,
> Ben
