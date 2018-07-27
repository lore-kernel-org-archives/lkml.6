Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37044C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BA120893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AXh1aBq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BA120893
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbeG0J5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:57:37 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42832 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbeG0J5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:57:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so7741345oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gyZnUd9eCTbBfiMhn2IOOWhzdL3ZyUhm0TbnafSaQIA=;
        b=AXh1aBq9Rkpgx/tyFfovHTbKZrWTx27iBjzT5oJAi/bEfcpUbHmMKp9IUoMUmNsCC6
         ttIW/dlfbtLeCbsAoOixJAycbRYqZaJhW7wx1g+gXCFbwcnOppTNwHyoNVCNHbVWFjq0
         ghn3ohdbfgbMYEG0FWHjr6BLhBwjOwmHxNwmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gyZnUd9eCTbBfiMhn2IOOWhzdL3ZyUhm0TbnafSaQIA=;
        b=PpqRLaXCriuGSOG4ETojPfedaCvQydYHIpYZHyrn9GcB4CFDYWOEoa7Vd3rxeDPHJ9
         zo/qZSF0lFz+OC8AlbqswpDiRePdhXwbZR720EhdgSvWOnGR1Ixtu3AYw6wp6kKrMrxS
         VDD8dCHpJj45CPy+yQggRdcOeugHqlGkDFEQfWcYoNCXJuA2gSWumHCx71tcnRxwzH0r
         jkm1f+qzdR643pkZSUy3BkwWxEHNUls38xdx/Im5lam3HFrgW2m78tlyJZGZoz7asFqZ
         9EeCddPHOwLGk8nr2J/SDFvJ6TyMfslS2VHBqUC+rOIZU9bHKD5JlGBy4VheMjnrj5t+
         PXWw==
X-Gm-Message-State: AOUpUlGbSzmhqv3dg5nXrv3uJ0+4TyIM9++jR/lPmqVpifFc3lgBF9zq
        CY+mN15oadR/1/ZsIqra05I0u/YNmu7pgjtFwJP2bA==
X-Google-Smtp-Source: AAOMgpffff3BEXVzDjN65BZ6GcqfwAGe1SOUzPwavipKfNTOuGDl4npqFmxPhmbMZCC/XDekpjQC7oL1Pnb+qWtJZKU=
X-Received: by 2002:aca:1802:: with SMTP id h2-v6mr5107694oih.353.1532680606978;
 Fri, 27 Jul 2018 01:36:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 01:36:46
 -0700 (PDT)
In-Reply-To: <3e17e519a59e2a23669be054a44ded9ea90de088.camel@linux.intel.com>
References: <1532664066-30056-1-git-send-email-srinath.mannam@broadcom.com> <3e17e519a59e2a23669be054a44ded9ea90de088.camel@linux.intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 27 Jul 2018 14:06:46 +0530
Message-ID: <CABe79T5Mi3A7dVBuZVkYSYtY-U5cCvd4b088mSjhkcCANbrwQg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Andy,

Thank you very much for quick review.
I will address your comment and send next patch set.

Regards,
Srinath.

On Fri, Jul 27, 2018 at 2:04 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2018-07-27 at 09:31 +0530, Srinath Mannam wrote:
>> Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
>> to match the HID passed through ACPI tables to enable
>> UART controller.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com
>> >
>> Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>
> One comment below, after addressing it,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c
>> b/drivers/tty/serial/8250/8250_dw.c
>> index aff04f1..7ea94ec 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -708,6 +708,7 @@ static const struct acpi_device_id
>> dw8250_acpi_match[] = {
>>       { "AMD0020", 0 },
>>       { "AMDI0020", 0 },
>>       { "HISI0031", 0 },
>> +     { "BRCM2032", 0 },
>
> Let's keep this in order (yes, I know about INT* ones above, but that is
> not related to this patch right now)
>
>>       { },
>>  };
>>  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
