Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A001C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63AB2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im/Mlm+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbeLUTIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:08:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33478 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389409AbeLUTIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:08:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so4655386lfc.0;
        Fri, 21 Dec 2018 11:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jXFLTI8JHQDvVJR/RJzDh54rUI3Cr7wPyRKQV5m3vEg=;
        b=im/Mlm+c2j/AxAaz7es2VdN9/H1+kt9/iAqdOYY9SotYhfR2ToDieyP46bdUC3Yl/O
         3W64atjFM8q9HOs+wuAyewAzX7Y0y6e4dOK5BeWWII9jxvBRPqMeGSnypIpxmDx95sTT
         QRc2T/nahGo1nT6u3PTXITy44drVil/FmR+csv4nouQzJawoJFaWnNQSnCotKUqViGBA
         I390nT8mONQu15dxkpUSCHTrpi+Yflw9YJv/e4kbxrOQ4R03d0HvfK4MhW/dbN5rdTxN
         YSzAEKVq1oKoYApV3QdNEY5wswtq+K8dvt1SuS4X0wN+Mz3QEafxAgxxQB3UNTBzOvxM
         IjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jXFLTI8JHQDvVJR/RJzDh54rUI3Cr7wPyRKQV5m3vEg=;
        b=LPfyJBjSBBqghKfCl99GVhkyUri0dusHj4E0WrSPuZ0ImItBQnCT4x3+LIUV4zL1I8
         s2KoZlvMNtX5iAgkO8LfYSHaFKq0evok+MNs3TooyltFtbOKOJqW+8SnIHoU3taV/jlg
         oOmySEJ/xdrxhEs1PxIcko1LUbNZ8AOMCMDtm+ADwjkEssucPoA74aoIdHZNrLbS223P
         yZbf9KpVd8MBHWXufkr7A3yiA5Ijqm0hDBzoL4zfSpdG1QYV81Vb/BcOXTduSpY6WhFA
         FTmvALjpcz8XQ4piz+stm/okC1dQaC77OPZND4GdgRnlyfKvevw7SVvucY3n1M66zVRE
         LjbA==
X-Gm-Message-State: AA+aEWbMGFOVpVh49JoM6Br35E0tA2khy1ysXhZ9Pj50FoJvVABlIx6o
        TOtJmimd/EgjBTCicYOlPRQI4HqFPzs=
X-Google-Smtp-Source: AFSGD/USLps/3VikByvmsmlxstgZZfuLrFey2O+zLKgZErnqAgraGUnZxyKIdeZmZ0F0e1Vtpl4USQ==
X-Received: by 2002:a19:cfc6:: with SMTP id f189mr2249346lfg.102.1545419277138;
        Fri, 21 Dec 2018 11:07:57 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id u11sm5046544lfb.85.2018.12.21.11.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:07:56 -0800 (PST)
Subject: Re: [PATCH 03/12] __wr_after_init: generic functionality
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-4-igor.stoppa@huawei.com>
 <20181221184120.GG10600@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <14487401-dec3-6a7d-a0b1-e369e93aa9c4@gmail.com>
Date:   Fri, 21 Dec 2018 21:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221184120.GG10600@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2018 20:41, Matthew Wilcox wrote:
> On Fri, Dec 21, 2018 at 08:14:14PM +0200, Igor Stoppa wrote:
>> +static inline int memtst(void *p, int c, __kernel_size_t len)
> 
> I don't understand why you're verifying that writes actually happen
> in production code.  Sure, write lib/test_wrmem.c or something, but
> verifying every single rare write seems like a mistake to me.

This is actually something I wrote more as a stop-gap.
I have the feeling there should be already something similar available.
And probably I could not find it. Unless it's so trivial that it doesn't 
deserve to become a function?

But if there is really no existing alternative, I can put it in a 
separate file.

> 
>> +#ifndef CONFIG_PRMEM
> 
> So is this PRMEM or wr_mem?  It's not obvious that CONFIG_PRMEM controls
> wrmem.

In my mind (maybe still clinging to the old implementation), PRMEM is 
the master toggle, for protected memory.

Then there are various types and the first one being now implemented is 
write rare after init (because ro after init already exists).

However, the same levels of protection should then follow for 
dynamically allocated memory (ye old pmalloc).

PRMEM would then become the moniker for the whole shebang.

>> +#define wr_assign(var, val)	((var) = (val))
> 
> The hamming distance between 'var' and 'val' is too small.  The convention
> in the line immediately below (p and v) is much more readable.

ok, I'll fix it

>> +#define wr_rcu_assign_pointer(p, v)	rcu_assign_pointer(p, v)
>> +#define wr_assign(var, val) ({			\
>> +	typeof(var) tmp = (typeof(var))val;	\
>> +						\
>> +	wr_memcpy(&var, &tmp, sizeof(var));	\
>> +	var;					\
>> +})
> 
> Doesn't wr_memcpy return 'var' anyway?

It should return the destination, which is &var.

But I wanted to return the actual value of the assignment, val

Like if I do  (a = 7)  it evaluates to 7,

similarly wr_assign(a, 7) would also evaluate to 7

The reason why i returned var instead of val is that it would allow to 
detect any error.

>> +/**
>> + * wr_memcpy() - copyes size bytes from q to p
> 
> typo

:-( thanks

>> + * @p: beginning of the memory to write to
>> + * @q: beginning of the memory to read from
>> + * @size: amount of bytes to copy
>> + *
>> + * Returns pointer to the destination
> 
>> + * The architecture code must provide:
>> + *   void __wr_enable(wr_state_t *state)
>> + *   void *__wr_addr(void *addr)
>> + *   void *__wr_memcpy(void *p, const void *q, __kernel_size_t size)
>> + *   void __wr_disable(wr_state_t *state)
> 
> This section shouldn't be in the user documentation of wr_memcpy().

ok

>> + */
>> +void *wr_memcpy(void *p, const void *q, __kernel_size_t size)
>> +{
>> +	wr_state_t wr_state;
>> +	void *wr_poking_addr = __wr_addr(p);
>> +
>> +	if (WARN_ONCE(!wr_ready, "No writable mapping available") ||
> 
> Surely not.  If somebody's called wr_memcpy() before wr_ready is set,
> that means we can just call memcpy().


What I was trying to catch is the case where, after a failed init, the 
writable mapping doesn't exist. In that case wr_ready is also not set.

The problem is that I just don't know what to do in a case where there 
has been such a major error which prevents he creation of hte alternate 
mapping.

I understand that we still want to continue, to provide as much debug 
info as possible, but I am at a loss about finding the saner course of 
actions.

--
igor
