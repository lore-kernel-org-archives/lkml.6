Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8CC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D68E21C69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D68E21C69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeHIIww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:52:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45433 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeHIIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:52:52 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1fneRw-0000CA-Gm
        for linux-kernel@vger.kernel.org; Thu, 09 Aug 2018 06:29:32 +0000
Received: by mail-wr1-f71.google.com with SMTP id z13-v6so3862733wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 23:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UksJvPBvsxySK/XZfsJaYOi5Y+WXgAxVtElUTL7ZzGY=;
        b=Mo3hEX8v0WsLM3i5wfYirFL2CIo8wgs5xgmb+XPukej5WU3ElXF21GWDBNvveyZIy5
         bVkJzBLuD4UlbNtleDzArE7BIxCwulNWuj/UctIysiBPRdyCYaqe0WoCzVkRZs39aPC8
         MdPvn4DRbPY7eRNbGfgIf5MjzM1+l1RPZxqtwUJLB+oFGFKxY6Qb031FPthWRLqC7dYZ
         r4a1xZ6T6bJQXW/sUUpLn7PE7nrTxZia/B5xF4TQxtWkvkQENAyiQ/l8TanrUoCrehB1
         Y0dk9MgpeLNnNsX+QyHuXI3RYX2PlO8H04byQeGd8kD31gPbMG14CHGW00c3t6l0ISx9
         3J/Q==
X-Gm-Message-State: AOUpUlHz1vMgeLbBzr3jwQZodBFKf3tq1LqB6pbkzwD8AykjgmwIKTKW
        I+1HUZDpC01Zv3Mk08fg3oKUMq1YXO64IBRgiQsWvxdJiKHhg1vPYWPcIgEIjoAsqV0jS5kt/LN
        2ZAC4wjXRocpZjHDeSCN9Xj3k7t4VQg7pSfGG3AlJ1zA+vJtGZKInBukQcA==
X-Received: by 2002:a1c:ca0f:: with SMTP id a15-v6mr650635wmg.102.1533796172205;
        Wed, 08 Aug 2018 23:29:32 -0700 (PDT)
X-Google-Smtp-Source: AA+uWPzFGWdn84ySuDJ4hesXXVKKP3YnDmjufB+S4oy+SzEBSb9Zyc/QBL251/fR2W9RLVYhf7DyuzHKJTFHEgoFG/Y=
X-Received: by 2002:a1c:ca0f:: with SMTP id a15-v6mr650631wmg.102.1533796171945;
 Wed, 08 Aug 2018 23:29:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4e18:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 23:29:31 -0700 (PDT)
In-Reply-To: <20180808180019.GE49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180808054837.19717-1-acelan.kao@canonical.com> <20180808180019.GE49411@bhelgaas-glaptop.roam.corp.google.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 9 Aug 2018 14:29:31 +0800
Message-ID: <CAFv23QmqwgS-wcO+RWMKb9Ejo4zjqmWTvKorar1uJuZzfJ1iHw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix calculation of bridge window's size
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Here is the public bug.
https://bugzilla.kernel.org/show_bug.cgi?id=200769

Best regards,
AceLan Kao.

2018-08-09 2:00 GMT+08:00 Bjorn Helgaas <helgaas@kernel.org>:
> On Wed, Aug 08, 2018 at 01:48:37PM +0800, AceLan Kao wrote:
>> There are some 0 resource size pci devices, and it leads to the
>> accumulator fails to maintain the correct value.
>> It results in a strange issue on my machine that xhci_hcd failed to init.
>>    [    2.437278] xhci_hcd 0000:05:00.0: init 0000:05:00.0 fail, -16
>>    [    2.437300] xhci_hcd: probe of 0000:05:00.0 failed with error -16
>
> I don't think it's possible for a PCI device to have a BAR of zero
> size.  Bits 0-3 of memory BARs are read-only, leading to a minimum BAR
> size of 16 bytes; similarly, bits 0-1 of I/O BARs are read-only,
> giving a minimum size of 4 ports.
>
> My guess is that if you have a pci_dev with a resource that looks like
> it's valid but has zero size, that resource came from OF or device
> tree.  If that's the case, I'd say we should fix the OF or DT parsing
> code to reject those resources.  If we do that, we shouldn't need the
> patch below.
>
> Can you open a bugzilla.kernel.org report and attach the complete
> dmesg log leading up to this, as well as the "sudo lspci -vv" output
> for this device?  It should have clues about how we got here.
>
>> To fix this, check if the resource size equals to 0, doesn't increase size.
>>
>> Fixes: c9c75143a596 ("PCI: Fix calculation of bridge window's size and alignment")
>> CC: stable@vger.kernel.org # 4.14+
>>
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>> ---
>>  drivers/pci/setup-bus.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 79b1824e83b4..ae05dde8c6e3 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1061,7 +1061,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>                               r->flags = 0;
>>                               continue;
>>                       }
>> -                     size += max(r_size, align);
>> +                     if (r_size != 0)
>> +                             size += max(r_size, align);
>>                       /* Exclude ranges with size > align from
>>                          calculation of the alignment. */
>>                       if (r_size <= align)
>> --
>> 2.17.1
>>
