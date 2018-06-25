Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32775C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C8525DF7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ3DCVgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C8525DF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbeFYQPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:15:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33252 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeFYQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:15:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id b7-v6so4074674lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YlqUJssjDb8lzobufeprd8vdQx/JcXvZ1MP3br1OLIQ=;
        b=ZQ3DCVgiW9okNbnmw4D+boHZ1AeC31PEJLKnNGS5iGdbkK3nU8UIU1joLUu1XN9FFn
         nKU2fkEYvFvDuNiMC5eT4FQ97kO/7+FqsmpuzIbF6olhbGdpqZXy/zRwu3M30xuOZEYH
         XHFxizWLsv46i/VnIk6OxygA9QyASI9/uojZyUr2YLp6Zo/sNRQRYmEpatvDosoITqE0
         iDJxQEBqXtAFhh0nbRH2W1mOJVVPrK6T3+981WckpndaJh+ZRPwZh3RseerDPoUqvXk1
         5hc1Yh/3SEmtlmbiIDqtA5ZyXf/5u5+sIpWvArnZvCz+GxTCab2AeQe6i+U9pqSECGT+
         XecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YlqUJssjDb8lzobufeprd8vdQx/JcXvZ1MP3br1OLIQ=;
        b=SP+9PRuQz7WNX5AIyjL9jPyFIsFnBlMRnX4GwwJ2tcyQIW+iaoErof2ZPW6dxKsPxT
         Ugohv8K1VbNfzyADbth1LtG8tJES+1m0HEiM3258Qv9rBB7mAAeYR2DpvBGnoqc3kqY5
         7YA1d4fPwRU64JQWVUsagAAduF2H7cnE1xM4bpATDLDws9QsQDTitTVO3dZzvR8vohr2
         tZBOcSXI9AnPxcyirAGDO3vIs5O5oalZwtSbybhtAnjBLyJ1HZnAC5xgYhu8HdAcobp5
         9rYRLhkgldxrTXNFQ2BVRBx25Wyx/fdjTvKS6SqqOCNvWKJV6o2pRSvYtEuBKYKoAlUq
         S5oQ==
X-Gm-Message-State: APt69E3rD9v2sdBx6D05E9kB4RQEv7OpulMYDzy4UtoCqtO3tl1iNLBr
        VgT9pzNUPAVIpr91hw1VQxUiQlTbSQB0hpqltk8=
X-Google-Smtp-Source: ADUXVKIt70xPYek0BioyEnf9CnHK6YiWnMBBrYpOEdP89mWXnii3NqyGD+7zE9h73exyzbSFC+6ak5DYtAcWh9crl/w=
X-Received: by 2002:a19:20c1:: with SMTP id g184-v6mr6580813lfg.96.1529943351117;
 Mon, 25 Jun 2018 09:15:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 09:15:50
 -0700 (PDT)
In-Reply-To: <CALCETrU3dS5t714BYqkxEYgkbJaESK6NP1Rsn3xq3En38yjJzQ@mail.gmail.com>
References: <20180625155750.GA14306@jordon-HP-15-Notebook-PC> <CALCETrU3dS5t714BYqkxEYgkbJaESK6NP1Rsn3xq3En38yjJzQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 25 Jun 2018 21:45:50 +0530
Message-ID: <CAFqt6zZHo3frivz0Qjj7v2ifF-p+6530Bb8HZqO3iPrL9kemuA@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: Change return type to vm_fault_t for fault handlers
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 9:41 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jun 25, 2018 at 8:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>
> Whoa there..  Your commit message makes it sound like you're just
> changing the return type, but:
>
>>                 if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
>> -                       ret = vm_insert_pfn(vma, vmf->address,
>> +                       ret = vmf_insert_pfn(vma, vmf->address,
>>                                             vmalloc_to_pfn(tsc_pg));
>>         }
>>
>> -       if (ret == 0 || ret == -EBUSY)
>> -               return VM_FAULT_NOPAGE;
>> -
>> -       return VM_FAULT_SIGBUS;
>> +       return ret;
>
> You're refactoring the code, too.
>
> Please fix your changelog.


I have mentioned it.

********************
Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_pfn() returns err which has to
mapped into VM_FAULT_* type. The new function
vmf_insert_pfn() will replace this inefficiency by
returning VM_FAULT_* type.
*********************
