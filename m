Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B26C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67291213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEv8URUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67291213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIMAE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:04:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44346 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIMAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:04:29 -0400
Received: by mail-io1-f67.google.com with SMTP id 75-v6so1068008iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CQBcntXPhW89xzmDYbeuUovNoPKs9+2AeK+QqeLD4Vo=;
        b=VEv8URUqldiCOOPsjW/Gu+vQczJ/YD1S3CzFdzrf4dgldu837lN8pYgkbbUcG5UCZ0
         s3XSkE3nrtM9NIttZwtyiy7I1ugHB3iPHRDY90d5HOWN9enZSHGFgN0+xwGo3aBbErDx
         blq8QQiVR0gVzIqMWvKMQcBRUm1iSDZZATU8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CQBcntXPhW89xzmDYbeuUovNoPKs9+2AeK+QqeLD4Vo=;
        b=sadlfVX6A3WzzSPll1ciz6m5qxoUdm7vStv0uvL175GhO59rEuW/N+luwiqPrK4LGX
         GArCVKkmlwS0G5S/d1+lD6CX4+4KXeetfT/gMEZ1TW9uI6GmLUBEbXYrPEd9OoNohUc6
         jwd5AQcScBqpP2Yd0oGfho6Gg/UfMsmr7vzXv4PUQTIKeDx8GV97yiOP2Wpz7RB4ziH7
         tsbewBi1RGsQDBXT7E3Wve+XpOUfbHPGOWPQM2rNa1qrTPLRaYcrdj6Zuqmc2FG24GuJ
         eOn4pPgYglID4PgWABX9GLsAQjczwdvjsahe0DrrIJ3n77WBodDkh+0ckh2MJ9jt79rI
         6ACQ==
X-Gm-Message-State: APzg51Bo/93EVcEVIf/KA7/si92umN0Xr3mAPa2siZ/MPmUXhJi+AGVV
        CrBLe/g8aX5E3nLnKIxf2RmD5dBb/XxTQvzTpJVt2Q==
X-Google-Smtp-Source: ANB0VdZGYL3129A545xkpddKy4+Z36SbswUNeCqg1khzw1QIf2QZSnvn01NKxomx8iDr2sTMmyYyaqSfm2CdWu0908k=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr3241510ioa.60.1536778717204;
 Wed, 12 Sep 2018 11:58:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 11:58:36
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1809122055190.1473@nanos.tec.linutronix.de>
References: <1536693322-8335-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536693322-8335-3-git-send-email-sai.praneeth.prakhya@intel.com> <alpine.DEB.2.21.1809122055190.1473@nanos.tec.linutronix.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Sep 2018 20:58:36 +0200
Message-ID: <CAKv+Gu9yDEfUFkTK0orYLjRfs+=WXwPvr44a2q0ALiWMNEpmDg@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2018 at 20:56, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 11 Sep 2018, Sai Praneeth Prakhya wrote:
>> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
>> index b18b2d864c2c..7455277a3b65 100644
>> --- a/drivers/firmware/efi/runtime-wrappers.c
>> +++ b/drivers/firmware/efi/runtime-wrappers.c
>> @@ -61,6 +61,11 @@ struct efi_runtime_work efi_rts_work;
>>  ({                                                                   \
>>       efi_rts_work.status = EFI_ABORTED;                              \
>>                                                                       \
>> +     if (!efi_enabled(EFI_RUNTIME_SERVICES)) {                       \
>> +             pr_info("Aborting! EFI Runtime Services disabled\n");   \
>
> This probaby wants to be pr_info_ince().
>

I can fix that up when applying.

> Other than that:
>
>       Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks! I will queue this up in efi/next
