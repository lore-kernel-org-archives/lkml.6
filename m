Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D52C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4923520855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167999;
	bh=5Y16C3wHMO6LwaU2A5key1kdchYstN0ztZqtVLxOAsw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-ID:From;
	b=nVigLTuTLjERihVtN+UouvkYUqYvhVSXOdiKSKBzD7fdLNIWm1+i1zZCEznsP2VMW
	 8JC/Q3E0Mn+wV4yqPBnOeJmdEHko9FLDBzQcdJiWJgkrXU5KfQ/uhlx4WDbl7wLUSX
	 eeCisNVUpxnczQ+DEuklU7AXa2qbIqr5MXkzvrrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfAVOj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfAVOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:39:56 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5C9217D6;
        Tue, 22 Jan 2019 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167995;
        bh=5Y16C3wHMO6LwaU2A5key1kdchYstN0ztZqtVLxOAsw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bTRoqVE0TKnxOfZmdDwe0rSqlEyEPT5ClSqAjBS0oq49h5fNLQ8XBg+8tejdvJVv4
         +n+5L17wXISNteyCRf51VeTRSOFmJgEAxXDsyyjvASwsJcgpCfkF0clTykePbHO+HI
         CtraKjd1y8nmbxOeh9R1kCi7/bS2795sTKDuyF7o=
Received: by mail-ot1-f50.google.com with SMTP id w25so23769312otm.13;
        Tue, 22 Jan 2019 06:39:55 -0800 (PST)
X-Gm-Message-State: AJcUukcKfLciF9POe/tFAEUCcWVg/Qv4EW66yOjpCd7gu8P76sL6lo8Z
        bES+sKkbKH5vXmfSKNvGFuwC+vkp7XIJcYP0WcI=
X-Google-Smtp-Source: ALg8bN6F3pvORJl8e5B1T8gv/BhJ7suD2CBAwsmzJ+EnTHnmDnNSh163KNbRDGrvEG9rjg5e7L0PgtrhHJhzVv/Pe1k=
X-Received: by 2002:a9d:22a:: with SMTP id 39mr23287632otb.354.1548167995005;
 Tue, 22 Jan 2019 06:39:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:2755:0:0:0:0:0 with HTTP; Tue, 22 Jan 2019 06:39:54
 -0800 (PST)
In-Reply-To: <20190122125440.GG26587@zn.tnic>
References: <20190121231958.28255-1-okaya@kernel.org> <20190121231958.28255-2-okaya@kernel.org>
 <20190122125440.GG26587@zn.tnic>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 22 Jan 2019 09:39:54 -0500
X-Gmail-Original-Message-ID: <CAK9iUCPiyPQQt++cYs79KdMZ0hXkz02XPuyVEpOPnWbjS+KWLA@mail.gmail.com>
Message-ID: <CAK9iUCPiyPQQt++cYs79KdMZ0hXkz02XPuyVEpOPnWbjS+KWLA@mail.gmail.com>
Subject: Re: [for next][PATCH 2/2] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if
 PCI is enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jan 21, 2019 at 11:19:58PM +0000, Sinan Kaya wrote:
>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>> specified directly.
>>
>> PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
>> mentioned in the Kconfig.
>>
>> Add an explicit dependency here.
>>
>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI
>> set")
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>  arch/x86/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 568f339595ed..0519da6f8ee4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -199,7 +199,7 @@ config X86
>>  	select IRQ_FORCED_THREADING
>>  	select NEED_SG_DMA_LENGTH
>>  	select PCI_DOMAINS			if PCI
>> -	select PCI_LOCKLESS_CONFIG
>> +	select PCI_LOCKLESS_CONFIG		if PCI
>>  	select PERF_EVENTS
>>  	select RTC_LIB
>>  	select RTC_MC146818_LIB
>> --
>
> AFAICT, this is not really fixing a random config build issue but only
> correcting the dependency, right?
>

This is fixing a warning found by randconfig on this thread
'linux-next: Tree for Jan 16 (PCI config warning?)'

> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
>
