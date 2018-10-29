Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CB7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DD62054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPsRGMN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DD62054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeJ2U7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:59:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33274 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbeJ2U7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:59:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id i15-v6so8849088qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LkSym710dhbXJ+qA0PXYOCzvXqoMmpZWVpKKwzIQAeI=;
        b=tPsRGMN5xZqQdMbvIkUhvjQ96uX71je3k4oSLF4xX83wsL+twsvlIijwQSMwmffXPQ
         /FRBfKBxcRsZkvbX1UoP05ZgNZWhopgzLgY6K33+bby8lybYWM4b4750CiZciiLMPJby
         O2pjlZrQD5mBH2RcQo2UNR/ytBaL8j1ndnjXJKjy8zcQZnkE9dFz08rgKpspOQeShQ7N
         xKTAhRKfqkxMO+aacA5s7g9Fh+ZXqgPhz4NPxxQFpTsEBpdBUFNlI8Zno5WnfNuEgEMx
         BVZxblbzxwJ3wQsdRYyev11CptEqdsCzKvCnXgObdbrgi1iIn40ReVlMIXDB4LPdFjGH
         lLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LkSym710dhbXJ+qA0PXYOCzvXqoMmpZWVpKKwzIQAeI=;
        b=gydbEbXTErN2NPQgKEzAYYdUKZHhqMZUqIo7M4nSqMWpcq+YUZuDAecKPGNPTwE9VX
         MnXLweB9Tz3fum/py2Hd8COudMp7LnnpvaMb0hEo0xnHouOKGqMM79xhYL7wIpgkla34
         Hhcgb7/Drlr0OgtjMDWq9gkzxHY/UXLgxzHJuKuMqw6Uknzu+QgV+/kyK19ZLoK2LRMU
         xQXU2qWIp83a6nRJynMDwQt2YqIQyij1ASzMJVd6bVHnCeazqP6theZh3dfIej4ucFtj
         YQIMbj8ZEwu+auyho4dKhjZX/PMCaWXjCZrF1FgLqFud24sYuANMgpCHMLXQi2beZbkw
         BOeg==
X-Gm-Message-State: AGRZ1gKWj2G45Dwo7vktf9eaooR9uXzItvRygiju/oRSkI3C5wXSzSli
        q3gDxF7Gk0OeZgNroaimONDpfhcSZvjMa4fxw9s=
X-Google-Smtp-Source: AJdET5eHx7ma0fv1YZpagQRKtolnyHnPS8CfAKaFrRoSOh05BePXwtH3KyhrVSCJxxvnEFCEMTlGTE/lmT8JwdISpGU=
X-Received: by 2002:a0c:8d4b:: with SMTP id s11mr12538580qvb.161.1540815084717;
 Mon, 29 Oct 2018 05:11:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 05:11:24
 -0700 (PDT)
In-Reply-To: <20181029120434.GA15446@arm.com>
References: <20181015111600.5479-1-anders.roxell@linaro.org> <20181029120434.GA15446@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 13:11:24 +0100
X-Google-Sender-Auth: UFEws_gRvEFSJ_13WIzOuGkjXO4
Message-ID: <CAK8P3a0oSn8Z6wJT1X2si8+A2wttkh7EjqD_MZYt4+L5a_XKLg@mail.gmail.com>
Subject: Re: [PATCH] arm64: kprobe: make page to RO mode when allocate it
To:     Will Deacon <will.deacon@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Oct 15, 2018 at 01:16:00PM +0200, Anders Roxell wrote:

>> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>> +void *alloc_insn_page(void)
>>  {
>> -	void *addrs[1];
>> -	u32 insns[1];
>> +	void *page;
>>
>> -	addrs[0] = (void *)addr;
>> -	insns[0] = (u32)opcode;
>> +	page = vmalloc_exec(PAGE_SIZE);
>> +	if (page)
>> +		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
>
> This looks a bit strange to me -- you're allocating PAGE_SIZE bytes so
> that we can adjust the permissions, yet we can't guarantee that page is
> actually page-aligned and therefore end up explicitly masking down.
>
> In which case allocating an entire page isn't actually helping us, and
> we could end up racing with somebody else changing permission on the
> same page afaict.
>
> I think we need to ensure we really have an entire page, perhaps using
> vmap() instead? Or have I missed some subtle detail here?

I'm fairly sure that vmalloc() and vmalloc_exec() is guaranteed to be page
aligned everywhere. The documentation is a bit vague here, but I'm
still confident enough that we can make that assumption based on

/**
 *      vmalloc_exec  -  allocate virtually contiguous, executable memory
 *      @size:          allocation size
 *
 *      Kernel-internal function to allocate enough pages to cover @size
 *      the page level allocator and map them into contiguous and
 *      executable kernel virtual space.
 *
 *      For tight control over page level allocator and protection flags
 *      use __vmalloc() instead.
 */
void *vmalloc_exec(unsigned long size)


       Arnd
