Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3025F208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKC8CYkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3025F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeGaOe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:34:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33725 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbeGaOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:34:27 -0400
Received: by mail-it0-f67.google.com with SMTP id d16-v6so12332380itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z24zFD+cTzqrWGCX5gWwKcJhQJFL4kzbms6ybMugcFA=;
        b=mKC8CYkZhG6rYItHtFNYNwvkm6TV0jvVko5bMcmkX/bHNcfUQYmB8taHKLOd8MMU/g
         ScC6iYTBvmp3umtcN67ej6YBuoFkcc+Vah6q9WHGqfHui0SPMcYWdQoJTPqmblABIjPC
         hHwLXIAW/0u2FUXLkzKm/aMJ6TACBnpYKk6BV2gAc/SXeN/Byl92A1wzwKhyQAmyPhBO
         Ay4WKXzbK6qw6Jap3+JceDIv3sZmNCKdmk0N77uU8pXWs9r85ZdJPXSHINHwWrxWPeiR
         YYC1vBMUupn9Z9aQoDFZVwI/Qe83Aikbg/slheWSX1tomhMvZFHqDB1GvbPyJzRkff3O
         tGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z24zFD+cTzqrWGCX5gWwKcJhQJFL4kzbms6ybMugcFA=;
        b=e0bTFDJ7zw4A1LmN/KxIQrzheIPCqr+xmGJxTXS23EhWkvHwkl7K7quiJ+A2Ykkt/5
         6CJSi/g5prlYCKf5V+2LIUuvVkKAoEMwhj/vTt6LCn3CbVho4ndqnQwXrDlXA7yqpAxG
         PARRDr63RU4COIgEP+mHaDuaNTKwSd5JMjsLur78O1RfCGGpBnLRVmKk3NX1mR0xpsCP
         uE0Daz8KWLRgvjMFpd59/9QjZbPb4awwOIIcmHa5sgU+8d2LQHMPLck7x0FwiFULhS8Y
         DTJNTThlFQ4lQG0ePaOAZ42chakROA1nby/WQKSHB/427uQvHB8LU5d1gM74DFvEDJQg
         umZQ==
X-Gm-Message-State: AOUpUlFcFGuSWRgzUWAMy/t+zTlD9IJ9xxjTVECefkCYDGrCKyrY0BmX
        Bi60kQ6uq4qoEE4GDXmRwdz0Jevzbzw=
X-Google-Smtp-Source: AAOMgpeQYz9pa+4SXcqyMeWuQEs1DlCC1ge5qQfC9iqpiSBO48uWZBzj5bFODYdB5KD3nWndCnoMwA==
X-Received: by 2002:a24:d485:: with SMTP id x127-v6mr2953359itg.82.1533041655144;
        Tue, 31 Jul 2018 05:54:15 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id v82-v6sm5366417iod.14.2018.07.31.05.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 05:54:14 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     Will Deacon <will.deacon@arm.com>, Alexei Colin <acolin@isi.edu>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
Date:   Tue, 31 Jul 2018 08:54:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731084143.GA4680@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 04:41 AM, Will Deacon wrote:
> On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>
>> Tested that kernel builds for arm64 with RapidIO subsystem and
>> switch drivers enabled, also that the modules load successfully
>> on a custom Aarch64 Qemu model.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: John Paul Walters <jwalters@isi.edu>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org,
>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>> ---
>>   arch/arm64/Kconfig | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> Thanks, this looks much cleaner than before:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> unconditionally in the arm64 Kconfig. Does selecting only that option
> actually pull in new code to the build?
> 
HAS_RAPIDIO option is intended for SOCs that have built in SRIO 
controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core 
is required during RapidIO port driver initialization, having separate 
option allows us to control available build options for RapidIO core and 
port driver (bool vs. tristate) and disable module option if port driver 
is configured as built-in.

> Will
> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a8f0c74e6f7f..5e8cf90505ec 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -308,6 +308,8 @@ config PCI_SYSCALL
>>   
>>   source "drivers/pci/Kconfig"
>>   
>> +source "drivers/rapidio/Kconfig"
>> +
>>   endmenu
>>   
>>   menu "Kernel Features"
>> -- 
>> 2.18.0
>>
