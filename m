Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 444C3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE3F208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IRj/exU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE3F208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbeFNKsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:48:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45531 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbeFNKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:48:17 -0400
Received: by mail-ot0-f195.google.com with SMTP id a5-v6so6508572otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F93tUNOxa3RYpZs+qw/6rPP++X4wHmpCAFRWx1g20Rg=;
        b=IRj/exU9xOA2i9KdXj9jBpi5zGZHym5iSYKWL2Nkj9Xqd4YzrET34/o+z2H/ZTGK2U
         vgJGWTgMP1iFV9+J82Jhb9TTvCEOWvQQtMVK20n1CEcKQNUO2aW1nR+40UDWFxzj16UP
         xT4MQNrR6Ag+xf0+WR4qVMZJLO48rPl4RDoUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F93tUNOxa3RYpZs+qw/6rPP++X4wHmpCAFRWx1g20Rg=;
        b=j6+D8fLbj3krXsrIio93bnTMHgJHr+vSXgg4jNl6qivxwyD34B7DIrku/IBl1HQhh2
         4Fwo6GYP3tXXBWh9t6dHIrBdYVX62fsc4/IiX0DFj6hpPstBBbkdaMhCSFXD1IKV6K3r
         j4jYblhLj912WID0CvakJuwXTSNG35capvRcLaUthzEb7dnavONyXuLweV/zWPw4ekyD
         bSeaggr56xqyYzmq0k0IRtwsS2dAzTflhvpYEhPRlHa2103HXhuxFarC20T1mTsS8Cqz
         KC2Y4mjxIWHcWExF/x8g3H2/dw2ILsNp5BmPE84EmJE67i307RCM5oCNraqFnWTVy6pl
         pX2g==
X-Gm-Message-State: APt69E2yoqg+y9shePKyXBEkFeeEFaGJPnG7MX2k6qS1Acfy7c20ln+X
        Zgbgi6fbqEVjF8YFignIuwDz7Fet4LwTc0Ney2uRGg==
X-Google-Smtp-Source: ADUXVKL+rRWgbW1OqKP2/mpy/Q1DhZlZlZVz2tdXq4HuB/Dg/uTs7qO8dMaZOym9SIv1so7I/7lHYMmMgiXB6sJURjw=
X-Received: by 2002:a9d:60d2:: with SMTP id b18-v6mr937378otk.305.1528973296503;
 Thu, 14 Jun 2018 03:48:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:48:15
 -0700 (PDT)
In-Reply-To: <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de> <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 14 Jun 2018 16:18:15 +0530
Message-ID: <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinan Kaya,

Here are the details,

The issue is, For CMB cards SQs are allocated inside device BAR memory
which is different from normal cards.
In Normal cards SQ memory allocated at host side.
In both the cases physical address of CQ memory is programmed in NVMe
controller register.
This method works for normal cards because CQ memory is at host side.
But in CMB cards pci bus address equivalent to CQ memory needs to program.

More details are in the patch: nvme-pci: Use PCI bus address for
data/queues in CMB.

With the above patch issue is fixed in the NVMe kernel driver, But
similar fix is required in SPDK library also.
So, We need a mechanism to get pci_bus_address in user space libraries
to address this issue.

Regards,
Srinath.


On Thu, Jun 14, 2018 at 4:03 PM,  <okaya@codeaurora.org> wrote:
> On 2018-06-14 06:29, Srinath Mannam wrote:
>>
>> ++ Alex Williamson, kvm,
>>
>> Hi Christoph,
>>
>> Thank you for quick reply.
>>
>> If we want to add this in vfio then I think we need to do the same in
>> uio case also.
>>
>> As I mentioned in previous mail, in the current implementation
>> resource information (address and size) is gathering from resource
>> named file created in /sys directory.
>> So I expect it would be better to have similar method as existing in
>> sysfs.
>>
>
> Can you give some info on why you need the actual bar address value?
>
>>
>> Regards,
>> Srinath.
>>
>> On Thu, Jun 14, 2018 at 3:50 PM, Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> The only safe way to use PCI(e) devices in userspace is through vfio.
>>> I think that is where you need to take your inquiries.
