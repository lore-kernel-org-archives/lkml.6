Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BA8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A2C216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDukFlN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A2C216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeI0VlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:41:25 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53545 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0VlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:41:25 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so8383928itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CwpYWVVDsJ09hliDlXTW/g2gU/NmLyJgoHavYMgav7U=;
        b=LDukFlN53m6ukrUOLUDbEDcPrY0ONPQA9yEaK3YZrbDDUghxChRGvyjMcvsZHnH5eH
         uKyy2Q1fxhROny/mffW/CelLAxFfgcVLUjjEHSXmTMUrwm7UPyevc/iacrwmsLhz1h9I
         KEWh/UJ4eHMD+NCTzNWXWKR3oGGI0r75U2s4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CwpYWVVDsJ09hliDlXTW/g2gU/NmLyJgoHavYMgav7U=;
        b=WlmbRtYVyVzCFrXBRQWWrUCjaSaKYUoXcnccxwPk+BOgtSqM0Y/klT4WkLyhfVh9Cd
         Iw7bxfEonZXdl+SRtG0K+9HXyvplroWTUgan2tFbBloZSu7FHvOuE1DgNNfoiE3fwJqf
         LbFN+McqHZIJZBI1bm9bW2CbOyvA964FWbpcRVnxXrS6WgO9h8zPxZ7G/z/LATwtwP2z
         bhcyIpSpAeG0JpDWvlGJqBs6h2peN7kh0cAWeWscN0J3vBHeb/bd/kCKWllKznZ3aO3X
         7AsPipgi/vky7piUb8rJWoZScPNGprDp3UKcMw4WrWjLGzji3Rs4cgLNjXXCLP+z6LwD
         FJyQ==
X-Gm-Message-State: ABuFfohNGwF1fT1P7yWckCK6gB2tiNm1Ru/AkvZBL9ZWV3c8aUktQtxa
        Hm5wPbC0l+knW/f6LlOZTC5KBKWo0ekeBGEY+9s4Tw==
X-Google-Smtp-Source: ACcGV61i+w01lwDg82Q41/CoDzsLmCqIHO+AMpaNaGaDW+Px69nP/ZNqxVi54v2h5t5ZK7DX8aIPhT95zVQLxql2x8A=
X-Received: by 2002:a02:4d1b:: with SMTP id l27-v6mr10268566jab.86.1538061759620;
 Thu, 27 Sep 2018 08:22:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 08:22:38
 -0700 (PDT)
In-Reply-To: <20180919130803.GH24124@hirez.programming.kicks-ass.net>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org> <20180919130803.GH24124@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 27 Sep 2018 17:22:38 +0200
Message-ID: <CAKv+Gu9NB8B0GrD0GZfF5mcgg4epokEBLFuSLz-1KQo=yh0d8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] add support for relative references in jump tables
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 September 2018 at 15:08, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Sep 18, 2018 at 11:51:35PM -0700, Ard Biesheuvel wrote:
>
>> Ard Biesheuvel (8):
>>   kernel/jump_label: abstract jump_entry member accessors
>>   kernel/jump_label: implement generic support for relative references
>>   arm64/kernel: jump_label: switch to relative references
>>   x86: add support for 64-bit place relative relocations
>>   x86: jump_label: switch to jump_entry accessors
>>   x86/kernel: jump_table: use relative references
>>   jump_label: annotate entries that operate on __init code earlier
>>   jump_table: move entries into ro_after_init region
>>
>> Heiko Carstens (1):
>>   s390/jump_label: switch to relative references
>
> This all looks good to me;
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Ingo, could you queue this?

I wouldn't mind if these could go in for the next cycle if there are
no remaining concerns.

Thanks,
Ard.
