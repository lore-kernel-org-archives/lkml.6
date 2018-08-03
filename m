Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613BFC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EAD21723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tin8EhR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EAD21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeHCDwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:52:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42944 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbeHCDwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:52:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so1838858plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq1VQoVVQixzT7BlIBafkklgysvHm1C1nOPMM61m1kQ=;
        b=Tin8EhR0zPrDREZp5/yTe2rBCj/fMeNKnTiXsyruFbB+g4MrNQZ0aotQ+AZc/Obt20
         Y1Xc1TTOTM4Z7250WgK2xYNwiu9zjo9tjt6ms6wg6OA/0miaWzMFpQs7pETGeNDv0/Fv
         lbbgXpHdAKUEFXph2eKngCnPoAhycwXT5NSSq6/nW7n6wmSzCMpUFPnrPCEUckMf+FFS
         1asVT9KM3Qa/9jFHLPUIGIWPLS41fJ7ZGQtj870rS5fQp4H8cpoEfB++izlrbw9OOc/u
         vA5xtQGygpqefxm78CQ2fUoCMgpo+WfVz/V/x6a8nrwzoRqeamCRN3hLw0nHp0f0O1v3
         fTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Fq1VQoVVQixzT7BlIBafkklgysvHm1C1nOPMM61m1kQ=;
        b=iP9pLHOoWHrfQsEbqPfPft9mHdKfduCZ+OTGGyw6r70hih0uBObO/oVjA+scOcPSJa
         cocENHfl3k+bSe5jGw+5OsEz9tPgml3p1VLLoilMU5U1lo8kQ+8WHOTRO8aa8ckIojib
         idYCs3gjNobCMKsTY+vNOv5iMrr1JJO9Evq94LgQJfyN0Mw+WBXEPErvlFJya7SlLdGj
         PBmg88D7aO8TiHINyxMX2q3Q85OUHCjBCVIIPD6cBalnRJVNAcNjXaEbXG1UkFQLDSu7
         sqJf62qkMLk0n+1jyn8F1h+/m5LvR5H0Wg/nRldlgGYj46oot9opwNdRiHOiZjJgHnxv
         aEPA==
X-Gm-Message-State: AOUpUlHPVCPp3twLEpYF6UzsGHsmvqSdXQxhqdemjLbjB7W2O/K6vDg9
        tGWiFoiOZuCuTGTAcsw659VX5oSo3ndVmQ==
X-Google-Smtp-Source: AAOMgpcN4hj16nrXkCnwHLjebRbBnTxfIVlmtvEVTsVO+gLkXJID0YX6AcWo23dn2iIaACN5v4ZftA==
X-Received: by 2002:a17:902:7488:: with SMTP id h8-v6mr1654595pll.41.1533261509588;
        Thu, 02 Aug 2018 18:58:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w72-v6sm9693553pfa.26.2018.08.02.18.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:58:28 -0700 (PDT)
Date:   Thu, 02 Aug 2018 18:58:28 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 18:57:51 PDT (-0700)
Subject:     Re: [PATCH] riscv: remove unnecessary of_platform_populate call
In-Reply-To: <CAL_JsqJKwtxDck67QHrZSKKrEXt-ERxH6W0srdw2H5A24CdSKA@mail.gmail.com>
CC:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh@kernel.org
Message-ID: <mhng-3bfbca5d-24d1-4d39-a84b-d1b0ec6708aa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018 08:50:05 PDT (-0700), robh@kernel.org wrote:
> On Tue, Jun 19, 2018 at 3:41 PM Rob Herring <robh@kernel.org> wrote:
>>
>> The DT core will call of_platform_default_populate, so it is not
>> necessary for arch specific code to call it unless there are custom
>> match entries, auxdata or parent device. Neither of those apply here, so
>> remove the call.
>>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  arch/riscv/kernel/setup.c | 5 -----
>>  1 file changed, 5 deletions(-)
>
> Ping?

Sorry for not saying anything, I don't have a good scheme for automatically 
tracking patches as they flow through my tree and my inbox is a bit backed up.  
This landed as part of b19b9282093588e73401f9d4981310a8de975f7d.

Thanks for the fix!

>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index ee44a48faf79..f0d2070866d4 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -220,8 +220,3 @@ void __init setup_arch(char **cmdline_p)
>>         riscv_fill_hwcap();
>>  }
>>
>> -static int __init riscv_device_init(void)
>> -{
>> -       return of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> -}
>> -subsys_initcall_sync(riscv_device_init);
