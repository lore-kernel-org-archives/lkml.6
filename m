Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E73A214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndppcDYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E73A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbeKOXu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:50:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51742 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeKOXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:50:58 -0500
Received: by mail-it1-f195.google.com with SMTP id f84-v6so8111878ita.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cI0/70tj+Fz0dv9vc6u4Hbc50xDUnJCH9C9jIgbl64k=;
        b=ndppcDYSVsa+Pr7xBlpTUk8LpvMGYSHw6puUpr1OWID/NJ0JLXC0bEPkS0/zWfmmUZ
         XuX19ujj39HLMpGl075hQPRwtjby3tRhL/cQTTP5ccAAQju92Gbl5vVCq7+jeuu/LBh5
         OI/FuT7F/+ZK0oa4nlj3A1rO4DIrQVhILzOv/Evjr1zqLRl1RZUY7Jq6q68UDy4sFcTd
         JjnFss7BPtItYkQWLebt5XnPhDaw8x+XcW+bRnV+02TKd8ukEv+i+BH+D8rEYfyYE+A9
         YyeYVrO/SWseKdnTjjsTSs91LmrjExR9MP8/DN23LILJWaq4XbH9vOS2an2HWMzhOIWL
         U1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cI0/70tj+Fz0dv9vc6u4Hbc50xDUnJCH9C9jIgbl64k=;
        b=rhldaa1ak9Rfk+rMRLAXiiSE2UaSjmRwdoFPtBUs+8CW3T8WYpeWilPU47hwaRNZ+W
         T0mkb9HwLt+rxkFaf2n4P5wtfj5c6LxfTEMF0NAkAM8pFN+3VaJOV/OEdt+NzwWrMudH
         CJb6Fe+hjNfAqvwin7zcckjd56MhUWoGdj1bSn8+6V9PvVoodme8SPCMwgXjL/YdMD49
         8PoEsmwwOF8VPFuPcab3w48yn2qqNJFeyESJbaJ1rwq1mt6ufsAWJ/jNnsNLot1lmml2
         ERG87peJEVuwm7je4U5p9c8/8A/FxBS5s1AoFVrZNU2JT33qPtxAbyuHr3ySbp0lu6Re
         w8yQ==
X-Gm-Message-State: AA+aEWbYxNQS4d4rJHP5Ee1B86x+WuiQLaQPVY8HRRBt1A2vLajtoJiE
        ReuroXLA6b4i/nU12nyQ6pOvu4tbscowqlU50rdPgw==
X-Google-Smtp-Source: AJdET5fg0UanWtZiQgn05adpP6gDOLgjnwzdxZ2BuWiWW2zOOmgcF6Gqrxm4fuD3oydoJYenXBcamKa2KV/o1kHPg1o=
X-Received: by 2002:a24:1642:: with SMTP id a63mr5351372ita.40.1542289383258;
 Thu, 15 Nov 2018 05:43:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 05:43:02
 -0800 (PST)
In-Reply-To: <CAAeHK+yAve4fBg_UZQsNdVJ5W-7v8tQnRa=amQMyBeE_yHcq5g@mail.gmail.com>
References: <cover.1541525354.git.andreyknvl@google.com> <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
 <20181107165200.oaou6cx2lmjzmjyl@lakrids.cambridge.arm.com> <CAAeHK+yAve4fBg_UZQsNdVJ5W-7v8tQnRa=amQMyBeE_yHcq5g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 15 Nov 2018 14:43:02 +0100
Message-ID: <CAAeHK+yaYc4gOxWdvJALwUffAFDVwQe7+4Rwx=Ux936c_LtBFw@mail.gmail.com>
Subject: Re: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys
 and _virt_addr_is_linear
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 8:23 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Wed, Nov 7, 2018 at 5:52 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>  /*
>>> @@ -232,7 +241,7 @@ static inline unsigned long kaslr_offset(void)
>>>  #define __is_lm_address(addr)        (!!((addr) & BIT(VA_BITS - 1)))
>>>
>>>  #define __lm_to_phys(addr)   (((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
>>> -#define __kimg_to_phys(addr) ((addr) - kimage_voffset)
>>> +#define __kimg_to_phys(addr) (KASAN_RESET_TAG(addr) - kimage_voffset)
>>
>> IIUC You need to adjust __lm_to_phys() too, since that could be passed
>> an address from SLAB.
>>
>> Maybe that's done in a later patch, but if so it's confusing to split it
>> out that way. It would be nicer to fix all the *_to_*() helpers in one
>> go.
>
> __lm_to_phys() does & ~PAGE_OFFSET, so it resets the tag by itself. I
> can add an explicit __tag_reset() if you think it makes sense.

Hi Mark,

I think I've addressed all of your comments except for this one. Do
you think it makes sense to add explicit __tag_reset() calls to
__lm_to_phys() and a few other macros, that already set the tag to 0
by doing & ~PAGE_OFFSET?

Thanks!
