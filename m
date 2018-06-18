Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9818FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2E620852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcBgN8sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2E620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934454AbeFRLhh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:37:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33928 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933381AbeFRLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:37:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id v84-v6so941750lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sPRAYsvOqEIwaFZ7HqbNM3xUioW/YX3ziDYFcYTN9/Y=;
        b=AcBgN8sNwEGxMWTJO3ljDimJ07wpnhRpTMZbuZBSh17ncQ54kJ2XtX7YheGsDlKosu
         G57QkuWrdpZG2KW7B6WsKEEZcbO63FKfuynIV497hRyp3584IQQkG/btV6UQQYg8FGTA
         9hHiTPr2AMXYpdBmVymfrJhHNSBwAzF6WEh1KGuvMofvl61PGfyaYF4kgz9yKvpQjQWO
         08AO02Y/vw9fiU5bx6RF8HbDnT4aCQ0MNl2OmH2Ur+zIa+r9f1koz2TMe7I+dt8x7Bi3
         sBRWThH/tmXfI46mpou15shtjb7YA1VKCJ57RTXk2fhbCB8T4hwr/pI4AYhxEPuQnx+E
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sPRAYsvOqEIwaFZ7HqbNM3xUioW/YX3ziDYFcYTN9/Y=;
        b=QAq3iCr6wZ3cuEXaJ35/D2k7pFFabGp9SnvpvWlYa5/ICCnBaUhM1jjCj1kloiIYu8
         ITJKAkPZRXG5hjians1INDGmQwZYcepBg+j0Szcb9zUTrTcu8FdVaMyEbj+JogrwOCEy
         vD8wShVYFyMuK8GcQgH/DaqObDbVySD2BOj3tucFrGFc1IrNnAv5e89O8CZzlr/Oj1Eg
         UPwut8iRJGEiPgNWdKSnx+fsHTdenjOJiFnfIjbYunXxQrEsGfIE8hi6sfIy/MmcmXJU
         Myt3LfDSgSIKz6XBUELg5WHEc8YQ+weZayE0Ewl+LEXlnEijktYJqBe/T0sFPUemmE7s
         /OCA==
X-Gm-Message-State: APt69E3MDOEzOvUmezs9rhwQyNtfsXX/jCLuF84KwwyRopnr2HojY5FB
        jHOg35SA5JksIbTGv5ofQICUAPSWB+C1Q5Gz+2I=
X-Google-Smtp-Source: ADUXVKKsDJSR3kyZf9cIC9IvL32K/EIlYTmMri/YX/mZnNRFYS6RQ6RP5c40E6yBJFYX9K352vTzI4t4DHEECQy6px8=
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr7624140lfe.60.1529321854820;
 Mon, 18 Jun 2018 04:37:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:37:34
 -0700 (PDT)
In-Reply-To: <CAFqt6zZdb5+32CvvU_4Pmb1u-d15-iAFb3ab0ftBLP95257Z-Q@mail.gmail.com>
References: <20180521181704.GA19646@jordon-HP-15-Notebook-PC> <CAFqt6zZdb5+32CvvU_4Pmb1u-d15-iAFb3ab0ftBLP95257Z-Q@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 18 Jun 2018 17:07:34 +0530
Message-ID: <CAFqt6zYX-BsGsTHzEzWHWTLGA=7VtSMWYy7w8dBx+hTzxyhyfw@mail.gmail.com>
Subject: Re: [PATCH v2] char: agp: Change return type to vm_fault_t
To:     airlied@linux.ie, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:38 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Mon, May 21, 2018 at 11:47 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For now,
>> this is just documenting that the function returns a
>> VM_FAULT value rather than an errno. Once all instances are
>> converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to
>> vm_fault_t") was added in 4.17-rc1 to introduce the new
>> typedef vm_fault_t. Currently we are making change to all
>> drivers to return vm_fault_t for page fault handlers. As
>> part of that char/agp driver is also getting changed to
>> return vm_fault_t type from fault handler.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>>  drivers/char/agp/alpha-agp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
>> index 53fe633..c9bf2c2 100644
>> --- a/drivers/char/agp/alpha-agp.c
>> +++ b/drivers/char/agp/alpha-agp.c
>> @@ -11,7 +11,7 @@
>>
>>  #include "agp.h"
>>
>> -static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
>> +static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
>>  {
>>         alpha_agp_info *agp = agp_bridge->dev_private_data;
>>         dma_addr_t dma_addr;
>> --
>> 1.9.1
>>
>
> Any comment for this patch ?

Any further comment on this patch ?
