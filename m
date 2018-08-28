Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8313C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE642087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bERC36OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE642087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH1Un6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:43:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40666 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeH1Un6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:43:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so971297pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+5OzEVheTPrXM1UrnfzO3M0cz2qMU0nrsN+pFLYL2To=;
        b=bERC36OEyMBeps5LqWhC+dZRpDckJWozy78r7V/fNP5j582RZTipL3N2LW1ZSyG115
         Neq8tvWWpRCizfDgUsL/Ls3gIeWvwhiTcvzIyPGIYs8yDgWTorBnYwTdziAu3ip0+KTV
         gaSlT8DYRPAQPvnOfwZ5CRVlrYBMWnJo5q0cpyQBcYfn3ICuf+rNUw60gYnmsED3pxHO
         fw0+IKexQacgeV02dVEFmBwLOipNmqXhzYp07e24zSKcS7N67ecM/w6Lj+dn4ud3Xssh
         Jg1zZSj+55Wu6+cglIDZrgfDcpJozNV/rluvMg3Cdy8kGoFMAAxXnlit/EJTJT4sUC+Y
         fvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+5OzEVheTPrXM1UrnfzO3M0cz2qMU0nrsN+pFLYL2To=;
        b=heuBk5iftvHAbRwVBeO966l5/8uofWqk1Azn0dN6ylP/yckmR3mGXU34LeOBKhq6OC
         SzI5Q+ZTMaEvJIRm9vESD7PwdLz2T19/HhvCMEsfqxi5Po5NK5hvAAxilsZgCi5WEUJM
         gqdpLdNON13jbK2jbcwWp7OSA3lhOA6CBVD7q4TbUxsQ/bRWT3jV8uDiU/JrsYO6gLsA
         Hyj5sPEHvOt5c9nFOPyXrpCzovQnt5Q6qhCQlCo4WE00EKwJQubFtCar6Zd1PqvrWx/a
         GBVxviA3UfdqSM0gc0WXk+Q7d06newdfazHmjrGXxPZZQdbQb/WuSuLwmpC72ZRldomU
         P05w==
X-Gm-Message-State: APzg51BiIgQzEX/yKfeJZorau3K2cTLVjKOvRnn/ZaqPUwoq7OQ3O9v6
        mPmKYIcFc52z3upRbgQBYhVAwnEQ6AI=
X-Google-Smtp-Source: ANB0VdbNDFvmKhMDDFUqNH03KzRLU0Act3v1pHGNf/ENQfNy8H0ULwVS5ZJfZN3nznfNPviAENcuwA==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr2345699pgq.382.1535475086813;
        Tue, 28 Aug 2018 09:51:26 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n79-v6sm7836808pfh.2.2018.08.28.09.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:51:25 -0700 (PDT)
Date:   Tue, 28 Aug 2018 09:51:25 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Aug 2018 09:41:29 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Mask out the F extension on systems without D
In-Reply-To: <20180828071032.GA16806@andestech.com>
CC:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, greentime@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-0c98c74e-8a51-435a-ae29-b95a56075dee@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 00:10:32 PDT (-0700), alankao@andestech.com wrote:
> Hi Palmer,
>
> On Mon, Aug 27, 2018 at 03:03:52PM -0700, Palmer Dabbelt wrote:
>> The RISC-V Linux port doesn't support systems that have the F extension
>> but don't have the D extension -- we actually don't support systems
>> without D either, but Alan's patch set is rectifying that soon.  For now
>> I think we can leave this in a semi-broken state and just wait for
>> Alan's patch set to get merged for proper non-FPU support -- the patch
>> set is starting to look good, so doing something in-between doesn't seem
>> like it's worth the work.
>>
>> I don't think it's worth fretting about support for systems with F but
>> not D for now: our glibc ABIs are IMAC and IMAFDC so they probably won't
>> end up being popular.  We can always extend this in the future.
>>
>> CC: Alan Kao <alankao@andestech.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>  arch/riscv/kernel/cpufeature.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 17011a870044..652d102ffa06 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -57,5 +57,12 @@ void riscv_fill_hwcap(void)
>>  	for (i = 0; i < strlen(isa); ++i)
>>  		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>>
>> +	/* We don't support systems with F but without D, so mask those out
>> +	 * here. */
>> +	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
>> +		pr_info("This kernel does not support systems with F but not D");
>> +		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
>> +	}
>> +
>
> The commit message does address the problem and this patch does provide checks
> and helpful information to users, but I wonder if we really need this patch, for
> two reasons:
>
> * Just as you mentioned, current glibc ABI does not support such a thing as
>   IMAFC, so probably no one has had trouble with this.  To be honest, I suppose
>   that anybody (RISC-V enthusiasts or vendors) who really need F-only support
>   in kernel should get themself involved in the development by sending patches
>   to improve.
>
> * There are corner cases to let a F-only machine to pass the check in this
>   patch.  For instance, a vendor decides to name her extension ISA as doom,
>   and supports single-precision FP only, so her ISA string would be
>
>     IMAFCXdoom.
>
>   The variable elf_hwcap is calculated at the loop in line 57,58, the 'd'
>   from Xdoom would bypass the check, while the underlying machine does not
>   support double-precision FP.

Ah, yes, that makes sense.  I'd go the other way here and just be strict about 
parsing the ISA string: it's defined to be listed in a particular order, so we 
should really only be accepting legal ISA strings.

I'll submit a second patch to fix this behavior.

>
>>  	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
>>  }
>> --
>> 2.16.4
>>
>
> I don't know if the reasons make sense to you, but anyway that's all I
> would like to say about this patch.
>
> Alan
