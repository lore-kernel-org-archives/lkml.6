Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A61C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8320878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBL8IWDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA8320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeGJIHC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:07:02 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46083 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeGJIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:06:59 -0400
Received: by mail-vk0-f66.google.com with SMTP id b14-v6so11931110vke.13;
        Tue, 10 Jul 2018 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YELPnNnzJnT6/A7lKHCzWA/4HT0wnij4pmhjBqKQnHs=;
        b=iBL8IWDTGNF9uBx/4l7ILoxd0YXOolcDjQFedloWJr9m7ms1ZbrBrs3dcRDogdQgQU
         KrEgWXkq1oudyavYKbUAh6zOhRdoK7Zp8q0LuyCuyQp7OFvZvTPyWpXSQKyuSt3zLNus
         Qe+5VkG0vV5VqF9JJw7qyG+xmf2mWKuaiByAFoQSnEV+P3yDOw4wX+TxArZmW/ywlunP
         HRGscxZMMvMSiyStwQULrDDNMNOsfosu5ugHG82bEEflg9FprqdQgmyCrA2gukrFqWFQ
         OJcshzYhMGQK0hsGyeMMI8jWZp6YN0+W4ydvV71hdVkUWh9/C5sAQdu2e0nakIjAJyVx
         8GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YELPnNnzJnT6/A7lKHCzWA/4HT0wnij4pmhjBqKQnHs=;
        b=Xge6Q2Xkui1OsE8b7VdTJNL14DbpR9M1GpcitN5TqsCaMf8fmzc2786FIwmXhpN977
         HArXgyTXRGhcNgKtIuLwNFZ6G0vjFogLfbix6JFsdken7wTnuTI7Cs8IZUr+XpVMngFI
         WLDtRLwWyr9bVPx6aKPdVFDU9s7z6EKzYEFWxmsFlEFtoqvnCZJ2esCRye8Lf349OXGL
         UsfetNnysjvCgegvvnYNhaMQ+gQKYoP8me1eu2dM9V9LQIKY0DulIgqlu4Begof9zRmV
         3C4lOC3rO7EPQibLRQm8G6MBq3GzUuuRCUdOzXfIHvvj8Lhqs9LYN3MrOHTZQ70GDnzQ
         r5uA==
X-Gm-Message-State: APt69E1aTMMlD7m4PX+14AABBCXch5vFYv+8Soo3L9NHUUdowIxl7Ao9
        Iq1jca5kSjH2AVww6VsrqMXVUZTFuYIMFeUdHOQ=
X-Google-Smtp-Source: AAOMgpf0NBWCN0Reut3UFbwUhjSxoXS5bMRCiwAIB/3UYyJwxBp/FU9BhKz2ac1nsuJcjxKidqJ2Um6bkBz2VMR2d+Y=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr13477829vkc.15.1531210018385;
 Tue, 10 Jul 2018 01:06:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 01:06:57
 -0700 (PDT)
In-Reply-To: <E666884A-3EED-426E-BAB1-FA23C57BA5B9@zytor.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com> <f9fe78ca-0ff4-814c-3681-a2366be01337@intel.com>
 <20180705200912.GA10701@linux.intel.com> <E666884A-3EED-426E-BAB1-FA23C57BA5B9@zytor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Jul 2018 11:06:57 +0300
Message-ID: <CAHp75Vf-P6FhBLwWbAcU2z48+y5+uMTPKMLU6dRHBBKkbremeA@mail.gmail.com>
Subject: Re: [PATCH v12 05/13] x86/sgx: architectural structures
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:50 AM,  <hpa@zytor.com> wrote:
> On July 5, 2018 1:09:12 PM PDT, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>>On Thu, Jul 05, 2018 at 08:31:42AM -0700, Dave Hansen wrote:
>>> On 07/03/2018 11:19 AM, Jarkko Sakkinen wrote:
>>> > +struct sgx_secs {
>>> > +  uint64_t size;
>>> > +  uint64_t base;
>>> > +  uint32_t ssaframesize;
>>> > +  uint32_t miscselect;
>>> > +  uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
>>> > +  uint64_t attributes;
>>> > +  uint64_t xfrm;
>>> > +  uint32_t mrenclave[8];
>>> > +  uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
>>> > +  uint32_t mrsigner[8];
>>> > +  uint8_t reserved3[SGX_SECS_RESERVED3_SIZE];
>>> > +  uint16_t isvvprodid;
>>> > +  uint16_t isvsvn;
>>> > +  uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
>>> > +} __packed __aligned(4096);
>>>
>>> Why are the uint* versions in use here?  Those are for userspace ABI,
>>> but this is entirely for in-kernel-use, right?
>>>
>>> We've used u8/16/32/64 in arch code in a bunch of places.  They're at
>>> least a bit more compact and easier to read.  It's this:
>>>
>>>      u8      foo;
>>>      u64     bar;
>>>
>>> vs. this:
>>>
>>>      uint8_t  foo;
>>>      uint64_t bar;
>>
>>The reason was that with in-kernel LE these were in fact used by
>>user space code. Now they can be changed to those that you
>>suggested.

> For things exported to user space use __u* and __s* types... the _t types would actually violate the C standard with respect to namespace pollution.

Hmm... Coding style 5(d) allows to use uintNN_t in new code (as a
variation of uNN choice).


-- 
With Best Regards,
Andy Shevchenko
