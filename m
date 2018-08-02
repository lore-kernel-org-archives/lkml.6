Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3382C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9AC2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjloKgKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9AC2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbeHBQwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:52:00 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36088 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbeHBQwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:52:00 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so3696782itp.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+6+ZVXBDS+MdjbGlZis5tLN4pZnRxLkrlq2TxOkZY64=;
        b=rjloKgKxvf6gtZAosHUG/a2cex4b8sIGoe/SPjdisBLSa/1LTwU8Pp7PEL9DZF12nm
         5HsF5EEs4v+bGTtkTHd5mQLu81g9jhdIG9oKcqsYZQUtSMVeWYSFAieEeRF23qm1OFN8
         QRE3VyiS596B35XT31EV27ODwX/ymugFpHYzQAAidCuYSDnlKa4CHRhcOy71BTE3dGoO
         pvbvt5NBAnJVRkPqkB40LvmSv5UutT7QSPREXPL2V9jR9vOZyTjVNuaNGiWj0DFFcFRw
         lBHq4k/9EmEIUgmaJI5WjPuLFDpZFLKUuC0YBjFtTpqcxcZVS7ELm21h/GsEIOoyrLm7
         2iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+6+ZVXBDS+MdjbGlZis5tLN4pZnRxLkrlq2TxOkZY64=;
        b=PKb9DXWCheH3QKp9VGyVxsif0t336LdAhGdjyDt//IfsMcyE4JOmjm+PRcFPZ8mc8j
         kRsGbAwhdQiK5lB++FpnXQELCmKejWCPJZIGWA2wP/8bwMzX7VWmMzaJfTrJko95CX0M
         ++24glVqOaISHabMkbDdbvvf7AFHNK4zJDNy83bdYFUnqfkVKNDD/pzWJ4oxZep4g7Sw
         evDtjHmcbIMrr/at88tfm/jKVutlfI7EH5xgchfNfXLj3jh0ttzF7Ok548VatKBvCc47
         0U5XVXLzMZHYX5LT8aAyxmxyR/TIGVwH+Hqsx3ndk96xdedpe1xdTcabFxvhdU6nujuG
         ib+g==
X-Gm-Message-State: AOUpUlFrjqQIVRyp6T05gvNdjqrdrx4hQL+FAwqluSai+erx8K8NnevQ
        hpWaMmlejYNVF4kzn9WzjfNZ4SpH/O58Wl4feUcZYA==
X-Google-Smtp-Source: AAOMgpfVwDqyoEOewzkNDe3n/znU8SXglGI/4RhK+n/piEqUOJDiavwKUcdbki2OcbxRalg/vULNN+1Gwk4Hswp9IGU=
X-Received: by 2002:a02:ac8f:: with SMTP id x15-v6mr2815342jan.132.1533222025880;
 Thu, 02 Aug 2018 08:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 08:00:25 -0700 (PDT)
In-Reply-To: <20180801174256.5mbyf33eszml4nmu@armageddon.cambridge.arm.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com> <20180801174256.5mbyf33eszml4nmu@armageddon.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 Aug 2018 17:00:25 +0200
Message-ID: <CAAeHK+zb7vcehuX9=oxLUJVJr1ZcgmRTODQz7wsPy+rJb=3kbQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 7:42 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Jul 16, 2018 at 01:25:59PM +0200, Andrey Konovalov wrote:
>> On Thu, Jun 28, 2018 at 9:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> So the checker reports ~100 different places where a __user pointer
>> being casted. I've looked through them and found 3 places where we
>> need to add untagging. Source code lines below come from 4.18-rc2+
>> (6f0d349d).
> [...]
>> I'll add the 3 patches with fixes to v5 of this patchset.
>
> Thanks for investigating. You can fix those three places in your code

OK, will do.

> but I was rather looking for a way to check such casting in the future
> for newly added code. While for the khwasan we can assume it's a debug
> option, the tagged user pointers are ABI and we need to keep it stable.
>
> We could we actually add some macros for explicit conversion between
> __user ptr and long and silence the warning there (I guess this would
> work better for sparse). We can then detect new ptr to long casts as
> they appear. I just hope that's not too intrusive.
>
> (I haven't tried the sparse patch yet, hopefully sometime this week)

Haven't look at that sparse patch yet myself, but sounds doable.
Should these macros go into this patchset or should they go
separately?
