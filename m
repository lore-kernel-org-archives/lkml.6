Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD267C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FB123FAC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np2Vx7PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FB123FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeGEVpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:45:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50708 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeGEVpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:45:07 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so13991146itg.0;
        Thu, 05 Jul 2018 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ddf/rFbJBEQ6ElMBY5szVRS+PkcLvC9ufyEFCfGrpF0=;
        b=Np2Vx7PFPLEHM7izmyDV+I34+dFagN6e4kg/cmq4KfJYmGw5nFiCHwftlJtxeayDpq
         1WhzQ24kfpPTL68lEtIsIcohjdTRdJEEnPZ6IyF2xLWLvBGifT6C/uARh6f4ynoPJsjp
         JV46dweFO67aAj9P4wEwAoxeo6tbRH9fpf9Mw2L8SD4AJi936D+2OG6VxDRMt1+XRr8O
         wDFOGaTJz7UpaU0GjaF3LWfO18StZ/6nVWiLFWinNoRV71ZA7BhYxp2IOZYXMqoJ/bR7
         dh6PsNNVQx9vXQE3LDLK7Qv0NmCXI+lJGq8HZZDfvreDdTOj6DMnpXH9597VNfUeQV+3
         TPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ddf/rFbJBEQ6ElMBY5szVRS+PkcLvC9ufyEFCfGrpF0=;
        b=AiEPOiM+Zik7LSvI88MCXHkDdj3ZWPlzdpJ/LHfr0fnxRG+lzmTv9hRH5Qo7XeKYBH
         0oB9qE6JY9Q3SWhDydjr1rP0OmpUIArQicrRGkZhsDYkiqvPXFVY4rcrRJi3kmlbgVHe
         HAPD7Z0eC/4ehmCkF9DEqAtZA8Kf2mhsoPVslZgpJxZYNZ0bQ6Mx6cMP4dyenN96GrW/
         pUyJMFzDC8m5OQ4CwPYMkc/JfnrmAs5cwwSxESHLdk8+fqtMe7MDj8iDO+FHn3IGwqQN
         08K05e3mTUbm5UZNXfdQdtwj1c4yNZUThACcTG6NCu+eKsSl6MFdF8Y78pqGpWx/gxTy
         eSLQ==
X-Gm-Message-State: APt69E28l+DbIfS3JBHckF60KhHiZfQcOxKPqFRAARAGqpuWChniMKxD
        kx3pfDjR+qhGAIiaejB05BfMBRTpHZoMuJ+yj2A=
X-Google-Smtp-Source: AAOMgpfg9mcXZQm6VfdIqqel12XjF50MvquFdQYQbCcZ/vbqFwJ0ucs1Ne+aRmh3KU7b++NNkAlF4JG+0gmLfuXSNaM=
X-Received: by 2002:a24:c506:: with SMTP id f6-v6mr6162209itg.3.1530827106734;
 Thu, 05 Jul 2018 14:45:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6801:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 14:45:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
References: <20180703054422.12089-4-deepa.kernel@gmail.com>
 <201807051322.sUohKhUO%fengguang.wu@intel.com> <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
 <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 5 Jul 2018 14:45:05 -0700
Message-ID: <CABeXuvpa6GtEOEn5HbYPnAVqqweTXLBH0KUXssGpFBzUNeayZA@mail.gmail.com>
Subject: Re: [PATCH 3/6] timex: prepare compat helpers for y2038 changes
To:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <fengguang.wu@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>, palmer@sifive.com,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posted v2 now.

Fengguang,

Also the make.cross script pointed to by the kernel test bot is broken
for riscv.

I applied the following fix to compile it.

Pull request: https://github.com/intel/lkp-tests/pull/11

Thanks,
Deepa

On Thu, Jul 5, 2018 at 1:33 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 5 Jul 2018, Deepa Dinamani wrote:
>
>> The error is fixed with the following patch that goes in before patch
>> 3/6 above in the series.
>> Let me know if I should post a v2 instead.
>>
>> Thanks,
>> Deepa
>>
>>
>> commit bfe4b046ed7f01154aef44fcb77d3f172929ccc2
>> Author: Deepa Dinamani <deepa.kernel@gmail.com>
>> Date:   Thu Jul 5 11:47:25 2018 -0700
>>
>>     riscv: Include asm-generic/compat.h
>>
>>     riscv does not enable CONFIG_COMPAT in default configurations:
>>     defconfig, allmodconfig and nomodconfig.
>>     And hence does not inlude definitions for compat data types.
>>
>>     Now that time syscalls are being reused in non CONFIG_COMPAT
>>     modes, include asm-generic definitions for riscv.
>>
>>     Alternative would be to make compat_time.h to be conditional on
>>     CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
>>     asm/compat.h include the generic version instead.
>>
>>     Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>>     Cc: palmer@sifive.com
>>     Cc: linux-riscv@lists.infradead.org
>
> Post a real patch please instead of something which I have to cleanup
> manually. A V2 of the series is probably the simplest way.
>
> Thanks,
>
>         tglx
