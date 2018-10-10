Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1922087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpzz+9Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1922087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJJWH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:07:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46904 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:07:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id d8-v6so5893782qtk.13;
        Wed, 10 Oct 2018 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eA3ZXVDe5KZScdNi6zZznruiaf/EJARBIvs1HXmuJ1g=;
        b=lpzz+9Fpew6jOMPVsQCHrQ4p8/XRzfslYgEmTDMpCsxvglthQkCmyuMbI5YIo/ttB8
         PKWEFelWItxwILr1skJfDYBYQKV2LemWOky9e4GeJWJKdKY6TVspYd8rzqWEqlFX6d3C
         tsTqLHuU/NzuIP4rhzv8c3v007BAFRovuazgbn724oHHT71ppG8KUDHzK2gQpBWWu0n6
         ymDYOdrFceU3/CcgIv5DeQUqcYHJ+9IaobPyuzvj1+eCb2gfSbFbq/Pb7rXua7AkuPGO
         6b9N/bvk5bil0CCRWKiBbvarFu4dzKEfu/wjzkKO1z5vDP85OdHZF63/N7GS9vL8EZQZ
         +zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eA3ZXVDe5KZScdNi6zZznruiaf/EJARBIvs1HXmuJ1g=;
        b=VaA/+u531DNZig7zsf1puPw495UIAdcwsF5mI9biLK1J/5saNUv/stBz/L1xnANZSn
         I4BnZv3GcHTset4JppU0ApgNxJGYD//Uqjf4hdW9YvJ06ZayDP/3Xt2y4RXilS0kCrOe
         v7DDu2ocW8xCwNDCw7xEefAA0NAeqixEWpK2nzUfYFPH1ItV92MCiVrTKZdjT1qfkjhx
         z4yvGijW3IgVL2N9wtj2mgebNFi9xRpJNb7PuCvNmksdBdc+vdTMGTibEZ69ejnZcacs
         oLEOZ2SgJKSjbQhlaFvGXPpAJollySvvQpvtV/n8IYms3FPnNjaWKjPW3XRaTiffoTFJ
         GJQg==
X-Gm-Message-State: ABuFfohw5uwYS9gV/EkqMnIVTvylcliOCwzYkqiXolz4W5qva0HpUisS
        eByv8ZzfsKNi7oLevc45nMJXDueF4ke9GKxODsI=
X-Google-Smtp-Source: ACcGV62H7tK1OtPyEAh8G8912Y2KS+KGBH0aSODN5Ax/o3UcAacudCJ6VNJdHikulvyoQ2rLpPLxGWsSslFQ17D/+CE=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr5782524qvl.40.1539182724765;
 Wed, 10 Oct 2018 07:45:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:45:24
 -0700 (PDT)
In-Reply-To: <20181010144026.GB5924@zn.tnic>
References: <20181010143306.2051406-1-arnd@arndb.de> <20181010144026.GB5924@zn.tnic>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 16:45:24 +0200
X-Google-Sender-Auth: 1U3N2shssR_bzW-TuvR3Ft3WatQ
Message-ID: <CAK8P3a1qzSjt5jPyf7HT-6aJLJdL_ON07y0H+jjy58gKGxdm4A@mail.gmail.com>
Subject: Re: [PATCH] kdump, proc/vmcore: fix building without CONFIG_ARCH_HAS_MEM_ENCRYPT
To:     Borislav Petkov <bp@suse.de>
Cc:     Lianbo Jiang <lijiang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Oct 10, 2018 at 04:32:45PM +0200, Arnd Bergmann wrote:
>> We get a link failure when calling copy_oldmem_page_encrypted()
>> when the compiler fails to do constant-propagation of the
>> sme_active() result into read_from_oldmem:
>>
>> fs/proc/vmcore.o: In function `read_from_oldmem.part.0':
>> vmcore.c:(.text+0xb7): undefined reference to
>> `copy_oldmem_page_encrypted'
>>
>> Adding an IS_ENABLED() check means the compiler will always
>> know when it cannot be enabled.
>>
>> Fixes: 992b649a3f01 ("kdump, proc/vmcore: Enable kdumping encrypted memory
>> with SME enabled")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> There may be a better way of doing this, not sure what kinds
>> of assumptions we want to make here.
>> ---
>>  fs/proc/vmcore.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index d469ce9d8c0c..92e1e520a52d 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -123,7 +123,9 @@ static ssize_t read_from_oldmem(char *buf, size_t
>> count,
>>  		if (pfn_is_ram(pfn) == 0)
>>  			memset(buf, 0, nr_bytes);
>>  		else {
>> -			if (encrypted)
>> +			if (IS_ENABLED(CONFIG_X86_64) &&
>> +			    IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
>> +			    encrypted)
>>  				tmp = copy_oldmem_page_encrypted(pfn, buf,
>>  								 nr_bytes,
>>  								 offset,
>> --
>
> Doesn't that fix it?
>
> https://git.kernel.org/tip/cf089611f4c446285046fcd426d90c18f37d2905

Sorry, my mistake. I noticed this patch was still in my queue and not marked
as 'submitted'. I forgot we had already discussed it.

      Arnd
