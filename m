Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3BAC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FAD25378
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhlJ7hxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FAD25378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeF3VPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 17:15:41 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34200 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeF3VPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 17:15:34 -0400
Received: by mail-ot0-f195.google.com with SMTP id i17-v6so13565064otl.1;
        Sat, 30 Jun 2018 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0TNTgPDkGFcgi5uaGMWmn05899ZzNSzqUJ9K0A8V/l8=;
        b=VhlJ7hxG7Zsfclumfpyp/gAGyg6YoMjxSUbLVhUIdP/t8/Pf4asPkmdcRXsrNFV9cf
         GBCaOSm208HeUUuX2KlHIpRlIrsVU5jCb6qs4OyUE1xNy3FNuRgMw70ijv2aMKBSQ0+6
         VmUayyQkcyPxPtcnGBmYrRVxcCB6z16n3+Ja39azeB+x6maUJ4u5GJQ/8YrYvML+Dwbu
         NuQSzNgM0iBlowZnnkHRrO6f+xbxNumUa58ZSpqRuSFf0X0IalWNm8gOUc8h1i0lsP3h
         SPbdrK4ar/Ua8ce9M275f9An2qsxsAtwJk1zYsbMz/2eZPnkTwFj/JJBz0td60Gt1mhP
         MdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0TNTgPDkGFcgi5uaGMWmn05899ZzNSzqUJ9K0A8V/l8=;
        b=GLVGeCcyojOl8g/z1vUAs5xMNjTBjz/vm5UCogSbqb5oNCcAhK/rvsU5pjoPVEKxqQ
         Jl78Spqfall2TMxwQQZ3lOO5digoz0y5mIpLQ9566Sw9qQVkTpWRIJ/6ibApBTtm7F37
         fMzKi1r01C7Da2/AC44lewfUV17F2mepinzAZ+9VNRDb9c7KCSCII3gNgt8/dmE7mb9u
         t8+OR+zycZZgzcGW0q6twmtfZvJrI85iFtdCoc4oPnaZYj3IMP78AYdOLkFDVjK943yw
         3SXRxjxM0x3pDoyFAqXqFeNCohPKcRzLRHQckIOaqba6U6QTcXDpcl+DXWr9atnJ9Vdn
         Ml5A==
X-Gm-Message-State: APt69E1pi1wV8V//zA0rfBLlhDRXxReJrigfGRxT9IM/O1d0Lz5tX3hv
        B7UUohaER/qNYZIsf3xq9f37bpyFYh3fs1mTErw=
X-Google-Smtp-Source: AAOMgpcMWJLxPJ5D/uaW5wH154Ll0PtGflFWcTK3qVOuGOfE3rXFNaogZNyyZP+Sc8VoGfsJPiiPcJUkKVu6V/K/ZXo=
X-Received: by 2002:a9d:cee:: with SMTP id o43-v6mr9705575otd.291.1530393334042;
 Sat, 30 Jun 2018 14:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 14:15:33
 -0700 (PDT)
In-Reply-To: <20180629191930.GA40928@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan> <2518711.SfHWAsyaFM@aspire.rjw.lan>
 <20180629191930.GA40928@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 30 Jun 2018 23:15:33 +0200
X-Google-Sender-Auth: yxYB58l8upRnX8whfLVShtA2of4
Message-ID: <CAJZ5v0gmfVWA51Rxk8=veA5UmFD4rCEUba7fq=SwTVY-WDjofQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        n0000b.n000b@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:19 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jun 29, 2018 at 10:34:40AM +0200, Rafael J. Wysocki wrote:
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
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: Make the patch work for PCI bridges without ACPI companion objects.
>>
>> Since that doesn't really change the idea etc, but only makes the check
>> to be made earlier, I've added the Reviewed-by and Acked-by tags given to
>> the previous version.  If that's not right, please let me know.
>
> Keeping my ack is fine, and I assume you'll apply this.

I will, thanks!

> It would be nice to see that ACPI spec reference (the spec version and
> section number, not necessarily all the text) in the changelog or
> maybe even a comment in the code.

OK
