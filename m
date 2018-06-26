Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F626BED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gezv0TeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1F626BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935933AbeFZOWE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:22:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37311 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935914AbeFZOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:22:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so2111900oib.4;
        Tue, 26 Jun 2018 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HPNjzR4U7XLYu1cPOEWXlCADcfGulR3lOnGgoOhE26o=;
        b=Gezv0TeKdVKkOv/WAvQQt/vpRtVuZzi0bzJWBlLHNxp+U3U8TYKd1WCGM4UpJonDxX
         NQJ6gIYZWJjLjW0bz2qj3TfXHXzQSzrcOtOeuFJm4H69QJeGdaaC5T2oTdx1qrcL2cna
         qPeawrwyufbWm94xYhQOo7qdx8gunCeB4Pa5ccKJ+r/07P7YebAzf1OisLn8VXo7pu70
         ll5BvBs/zkioiBMm+AKtObgtlynnWiYHNgRJAwGgrQteyCV8wHhd08RQT9+TONXi92ac
         2YQwdBAfyhEyI5yWbWmebeX5HnPVw8yWFdSweLVXrdyboqslCh7vp1ret6k9s/i9RFdg
         HFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HPNjzR4U7XLYu1cPOEWXlCADcfGulR3lOnGgoOhE26o=;
        b=hBOjjrzAV29ZFUW8vgQnKkeFDvnMX5jNuLUrksH0058bk7b8JMJC2nw13s6kYMkzTP
         mGCBlugKvPQy3Nl2J/B1THZIZVvdNysdoOhmBhO6Nl1IXMbdBIDJu2c4hpbuFJV8tIFd
         30A7lHKTSv8bnep8TEKl4sGsnIAlgbMtY0vfOo7PO9MmACQZMMEXYM+tLD5vAU82xBGR
         lzGoq6aW9oC+tSGrvunXc/ZzRok8MbSbDDHBUNEUaIGvF1AypTlm5g1qzK3uF9w9vXcf
         v9Myi/kis9beSSIoj6nuH4i74uOmTKh4MimFhZ7b59x84poXVIRLs6ciMtosyKV8aJM1
         9Q+Q==
X-Gm-Message-State: APt69E2L6udygZsWRRmP9RlH1WFRaWtQqFMyxt+1YVoS8PA+wTD9+IUL
        daAPdHkurcda6lRby/3kpM6CTXdX9zzar7YzXB8=
X-Google-Smtp-Source: AAOMgpdieNrrYAjIYiZPvRsZz2mvh7yvQo6Z0i55tEyUPBkTwuMU5gMsOIYSkA6WDgggLmlmDL1qD+/Z1viUkBo8vHo=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr925107oig.282.1530022920631;
 Tue, 26 Jun 2018 07:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 07:22:00
 -0700 (PDT)
In-Reply-To: <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan> <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jun 2018 16:22:00 +0200
X-Google-Sender-Auth: n2lNDXxmDVNlm-zk1MXe_G7rqBU
Message-ID: <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
>> handling for devices with no callbacks) introduced a system suspend
>> regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
>> port) to stay in D3 over suspend-to-RAM, which is a side effect of
>> setting power.direct_complete for the children of that bridge that
>> have no PM callbacks.
>>
>> On the majority of systems PCI bridges are not allowed to be
>> runtime-suspended (the power/control sysfs attribute is set to "on"
>> for them by default), but user space can change that setting and if
>> it does so and a given bridge has no children with PM callbacks, the
>> direct_complete optimization will be applied to it and it will stay
>> in suspend over system suspend.  Apparently, that confuses the
>
> "stay in D3 over system suspend"? (just to be explicit about what "in
> suspend" means)

OK

>> platform firmware on the affected machine and that may very well
>> happen elsewhere, so avoid the direct_complete optimization for
>> PCI bridges with no drivers (if there is a driver, it should take
>> care of the PM handling) on suspend-to-RAM altogether (that should
>> not matter for suspend-to-idle as platform firmware is not involved
>> in it).
>>
>> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
>> Reported-by: n0000b.n000b@gmail.com
>> Tested-by: n0000b.n000b@gmail.com
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/pci/pci-acpi.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> Index: linux-pm/drivers/pci/pci-acpi.c
>> ===================================================================
>> --- linux-pm.orig/drivers/pci/pci-acpi.c
>> +++ linux-pm/drivers/pci/pci-acpi.c
>> @@ -638,6 +638,14 @@ static bool acpi_pci_need_resume(struct
>>       if (acpi_target_system_state() == ACPI_STATE_S0)
>>               return false;
>>
>> +     /*
>> +      * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
>> +      * confuses the platform firmware, so avoid doing that, unless the
>> +      * bridge has a driver that should take care of PM handling.
>> +      */
>> +     if (pci_is_bridge(dev) && !dev->driver)
>> +             return true;
>
> It sounds like the question of whether leaving a bridge in D3 confuses
> the firmware has a platform-specific answer.

Well, it may confuse the platform firmware in general.

> How does the driver PM handling know how to do the right thing?

For endpoints this is not an issue as they always have been expected
to be in D3 before passing control to the platform firmware on S3
entry, but we've never done that for bridges by default, except for
PCIe ports with PM enabled (in which case the driver decides whether
or not to enable it).

> Does it need to know whether
> it's safe to put the device in D3?  Or maybe a device is never put in
> D3 for system suspend if it has a driver?

As per the above, endpoints should be OK (or they are quirky if not),
but bridges are sort of a gray area.  PCIe ports for which we enable
PM should be fine, for the rest it's better to be conservative and
resume them IMO.

> But I'm just kibbitzing; since you merged c62ec4610c40, I'm happy if
> you also merge this:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>>       return !!adev->power.flags.dsw_present;
>>  }

Thanks!
