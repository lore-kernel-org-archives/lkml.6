Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C747EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6771420862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JcHNKG35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6771420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeG1Qjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:39:53 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37677 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbeG1Qjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:39:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so14176258oib.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NoctcdrA5vFySsbogTfpHzuEbEdWI5Y6cQTWRWkRH7A=;
        b=JcHNKG35imd1XfGWbM7mcKB0/THaNzn3pW52SXtMW1ZWUjm4kNxwNsH+SwWmVHd0fg
         s4Hreboi3G3yai8IQdRh/d0LRKyEMLE7XEnyWMTeVJYmHt2/Gkehc51HNwXcdEeayvCl
         IUkjDVyYU8+hcn6qyqFC6loqNGhiJvKki9aCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NoctcdrA5vFySsbogTfpHzuEbEdWI5Y6cQTWRWkRH7A=;
        b=rBIt3nHWrAcdm6KfOw4J8ghhbohxlCPuenAMY3irE1O0gTChzOCa371NnzJl/T+SFz
         Pd0WUFxtMVzFD9G53PjEc+ovPh2b8CMuddmjzJ6Q3VcpBE7QI5fWUaLLMxP6ZRk1wpNS
         jDIOIW9rf94stQp5226q5mESx7ggqlq7cmMzql8Ayi09OpaKUjuxoo4QKdBX6rLi+vx/
         C5sgWJkeu3i+hXvOO0bp6o6RF+OzR950JLF88C8ctGgDGeH7fs5h8LWir689oVsTg5kX
         d6N2Ep6dz3PjG8L4xU/VQMFfEm5ajPtL51XCZfV6YfX8icn7euNsN6LUZw1CDMJ4S4qX
         F3Qw==
X-Gm-Message-State: AOUpUlFRNWDt02mZmKjMbKgkpI0CqV8m66qOv+6NVQ4QHKVmEBvmtGDz
        iL2GozRYEau8gA1runICohkBtkIc/BcJsVTMp9SaLw==
X-Google-Smtp-Source: AAOMgpeC9rhE0KlHwPpvIl4KjqoFP9FdEag5sVBFKb34rWoPE0lFhMv6xeLs7NUhBNvnajGnSC/+muAKOOh2Rr3oPVY=
X-Received: by 2002:aca:afcc:: with SMTP id y195-v6mr11516588oie.322.1532790782826;
 Sat, 28 Jul 2018 08:13:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 08:13:02
 -0700 (PDT)
In-Reply-To: <20180728145412.GA19385@kroah.com>
References: <1532680970-5703-1-git-send-email-srinath.mannam@broadcom.com> <20180728145412.GA19385@kroah.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Sat, 28 Jul 2018 20:43:02 +0530
Message-ID: <CABe79T7sTu1SfmAW=ZyELkd_aRxYWs8D-KBaXaP-b328eQe=1A@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg k-h

Sorry for my mistake, I will send v3 patchset with details of V1 and V2 changes.

Regards,
Srinath.

On Sat, Jul 28, 2018 at 8:24 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Jul 27, 2018 at 02:12:50PM +0530, Srinath Mannam wrote:
>> Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
>> to match the HID passed through ACPI tables to enable
>> UART controller.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> WHat changed from v1?  ALways put that below the --- line.
>
> v3?
>
> thanks,
>
> greg k-h
