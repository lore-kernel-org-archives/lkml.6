Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB7C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 02:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B135217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXVS+6nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B135217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeHEEh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 00:37:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34656 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeHEEh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 00:37:56 -0400
Received: by mail-ua0-f196.google.com with SMTP id r15-v6so42263uao.1;
        Sat, 04 Aug 2018 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XaK02h39axL+dHaD7cGJzDAeNWTCLBgBUDsmQ8WiAoU=;
        b=gXVS+6nLIx1j+LCl8juHIbAs04cFm8rZcjn4gstam+LG1qY9RRCI5visq7Fcr9Op5p
         KNLrTeqiWu6A54A34d1ZrNdPg7Dl0kDkTwMQJYX0w1m4t+cvED2MaLm8L7USg8gREVhy
         2onmyKk1IEPgBPcSX9Dh5Eb/EKQtIohmbpHnmGIfaaN7TWqLLD0hNDZorJyUUiqcTRMO
         ciWcQD8GHwsIRh3cmFTfTMv7bdkbmuCsHs5mDsWA8lxOyeBTqcvUIG2HotT96lo9EJHK
         V1YvWBDf9MBKzxk9xVWCrT6kSY0ASH8oT0WerUCtWZWFa72LUuIStl11drPy8RI3zGkj
         038A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XaK02h39axL+dHaD7cGJzDAeNWTCLBgBUDsmQ8WiAoU=;
        b=gJEBsfWv47lJ5utDTVvKOnJhcvhnr3geFtpGKsjojRBBlMlGKZfVqzC87Fkxvt6aRW
         WhAhyrVreb1O9zssTM1VWUfF7RCRh/k+l21TUPf46q1UC1RgLduYdw3z3/EBEhjNMVm4
         RUJHL6asXQ4lYtk4XL4xxDkc8LRzR0B6cWsz5B0b8LWl9JkHDPmAZUM0pWGgLfNIspru
         yUqO6VsE8zlFxyprht/IuoQ8EmeOWCCdCpuAz5OG95bxBq4Youj63K0Bq1sjsrpTcm+5
         YikrE4lHy2v75hE1UnCN1G0mvQUpAkdmRQey3rMrSC4XTnQLMAXzFAhe542apP57VZaX
         2dPw==
X-Gm-Message-State: AOUpUlEhH2TfQrw3/fb7HxM92aMEasTFfQpXIur5PMiqmG0WS6Yqp7S2
        TQbIU4v96uST9Q4NsdS2CgGnledUWq9PcucruyY=
X-Google-Smtp-Source: AAOMgpfood1iSuwKPrYMFX/Ofdg3dn/LdXu/EDYX4CzD6kQ5rnO2VHwI+fbYSwIDieYKCnmhkAMtXsacIZBxI/YGSm4=
X-Received: by 2002:a1f:bd2:: with SMTP id 201-v6mr6099041vkl.165.1533436504190;
 Sat, 04 Aug 2018 19:35:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:3f0f:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 19:35:03 -0700 (PDT)
In-Reply-To: <20180727100617.GB25592@arm.com>
References: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com> <20180727100617.GB25592@arm.com>
From:   gengdongjiu <gengdj.1984@gmail.com>
Date:   Sun, 5 Aug 2018 10:35:03 +0800
Message-ID: <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: clean the additional checks before calling ghes_notify_sea()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        mark.rutland@arm.com, Len Brown <lenb@kernel.org>,
        rafael.j.wysocki@intel.com, erik.schmauss@intel.com,
        robert.moore@intel.com,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-27 18:06 GMT+08:00 Will Deacon <will.deacon@arm.com>:
> On Thu, Jul 26, 2018 at 05:01:47PM -0400, Dongjiu Geng wrote:
>> In order to remove the additional check before calling the
>> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>
> Acked-by: Will Deacon <will.deacon@arm.com>

Will,
     This patch will be applied, right? thanks

>
> Will
>
>> This cleanup is ever mentioned by Mark Rutland in [1]
>>
>> [1]:
>> https://lkml.org/lkml/2018/5/31/289
>> ---
>>  arch/arm64/mm/fault.c | 7 +------
>>  include/acpi/ghes.h   | 4 ++++
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index b8eecc7..9ffe01d 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>
>>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
>>  {
>> -     int ret = -ENOENT;
>> -
>> -     if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
>> -             ret = ghes_notify_sea();
>> -
>> -     return ret;
>> +     return ghes_notify_sea();
>>  }
>>
>>  asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
>> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
>> index 1624e2b..82cb4eb 100644
>> --- a/include/acpi/ghes.h
>> +++ b/include/acpi/ghes.h
>> @@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
>>            (void *)section - (void *)(estatus + 1) < estatus->data_length; \
>>            section = acpi_hest_get_next(section))
>>
>> +#ifdef CONFIG_ACPI_APEI_SEA
>>  int ghes_notify_sea(void);
>> +#else
>> +static inline int ghes_notify_sea(void) { return -ENOENT; }
>> +#endif
>>
>>  #endif /* GHES_H */
>> --
>> 1.9.1
>>
