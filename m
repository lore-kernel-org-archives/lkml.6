Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF84420847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OTOfDRaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF84420847
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbeGDJoL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:44:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40809 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeGDJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:41:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so9561189oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dw9Q7H+ZIiCGgsTk4SExhIkP8qwNiLz0OUXUPL43YBE=;
        b=OTOfDRaaF65ryN2FC7AWuKOLhFaS7zAWrIj+pJF5g03y4382jJQ2DJHYMUJOZR9dIS
         Kf+bDm5In856+nznBJF0MCBIF+a+UVfaJxEcGML/BFFary5Y83wTM/AQwdSszbq8LCE1
         0lDFSyLCY1ZTmhyfgvj6ltJvoN+BJ7aGIiyCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dw9Q7H+ZIiCGgsTk4SExhIkP8qwNiLz0OUXUPL43YBE=;
        b=POa3vqOteJlJmNpuavVmnWc3+WVVMWRLm6DYMGwS6C7N3seaOa3Mx6bpIhV51SmJgV
         nCuWIkoKltNSRV4i8XfjdgnRyQvKnXdlAWrQDObU0ZXbQ0KtvP/DswUJ8Pgob/spMUyj
         YkwD6985XHkejSzi4mxWPf9t+wv+/EyjLeTu5Yw8BNQODozRspj3grub0byDe+V8kxoR
         XlksyzFYdtIFm4K2suttqokT0hfroVo1YRKiD1E4TNATf/hkjEM+MsIKKUOTNtkDX+rJ
         Hr6E9i6fRC7qpi6/yNuZkvjIBDQCkphMCRJOh4XcanEySy/5G/PMpqDKZ12HETxObt2i
         qzGg==
X-Gm-Message-State: APt69E0gsaPAHH8g3U2TuyWtXnizzYJq2W5ktLqE7VW4myIpyaaQTQzW
        io0/Ew3jUP8+d8xekjtVVTF72WOVcyOmmzbpoKTMNw==
X-Google-Smtp-Source: AAOMgpe2a9u53D9OXqZob4LTORgPo6kGbsyGt6w6wdkdNZ0Ru+a9ov0qnsTRp2zyL2fLYm6Sih3G4mKDTLj/6bPI2ZU=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr1217504oia.154.1530697284387;
 Wed, 04 Jul 2018 02:41:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:51d2:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 02:41:23 -0700 (PDT)
In-Reply-To: <8518137d-c859-657e-844f-51720f6ef8dd@arm.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com> <8518137d-c859-657e-844f-51720f6ef8dd@arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 4 Jul 2018 15:11:23 +0530
Message-ID: <CABe79T6dH7qmfmrT5nT4GYpMRocb5CZRnPWsscp7KtEwTZiYYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Andy,

Thank you for all the valuable information and knowledge.

Regards,
Srinath.

On Wed, Jul 4, 2018 at 3:08 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 04/07/18 10:32, Andy Shevchenko wrote:
>> On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
>> <srinath.mannam@broadcom.com> wrote:
>>> Hi Sudeep, Andy,
>>>
>>> Yes, This patch is to get of_device_id and then fetch data pointer.
>>>
>>> To add ACPI support in multiple drivers which are device-tree based
>>> and has list of of_device_ids, by using this function
>>> very minimal changes and can avoid acpi_device_id list in the driver.
>>> I will send driver changes where this function used to add ACPI
>>> support in following patches.
>>>
>>> Below are the changes added to add ACPI support in sdhci iproc driver
>>> using this function.
>>
>> So, did you get an ACPI ID for it?
>> That's how proper ACPI support should be done.
>>
>> P.S. What you are trying to do is being discussed with Nikolaus in [1].
>> I have to NAK your approach in any case. Sorry.
>>
>
> +1 on NACK for this and anything else that abuse PRP0001 as a short cut
> approach.
>
> --
> Regards,
> Sudeep
