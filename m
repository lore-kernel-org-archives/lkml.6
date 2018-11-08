Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C5ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE212086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE212086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKHXew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:34:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35866 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeKHXev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:34:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so26557422qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HEbdqYE9zkR4dfr2fg3xE2ZDioBzmagWmjY0LRTGCNI=;
        b=hAD5fclDMy4+jqL9Zma6tXCUrF2WjR31N6ZUivfh9+dmxokmUggJHAnV4ZZbl75qds
         1ZS700BQWwryH0aQUw5hIoCl2UX8Efz3FibvhLXn2lBZM5iFTjH6T86ToqZVgjcvW0CO
         qWGwJlqvCqHFz3X/xGTV/j99qEfBzi3kV/Ynmz9fZg35zLY+IQUA3UW0KzGBj0lXz28A
         WlqefU69h/pP+rXUA2IMHcuMkmYWj17qn3Jqkons6vDRGezAcgar3er+YkQQspTfgFKK
         LmZg8+enhep+gtOSfWqh2KdMYhcEXdPipPJFGv/QPSwovPKELQTbMYSKdilDjLThDT3f
         8nIA==
X-Gm-Message-State: AGRZ1gI9U5gBJyZ25SAg4+v0ZaM9OdL2LQHrnNGmC/oG3R/4hRVjmlRi
        OYjbUaGjzBiIIOI574et9vo=
X-Google-Smtp-Source: AJdET5fqR83DeT0n89SK+4jwnLbLnD0YjV8D6yuAnKJDnVaECsf5T2i+GrTN1P28r6qOOgdCW+8IIg==
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr4467119qti.336.1541685554456;
        Thu, 08 Nov 2018 05:59:14 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.243])
        by smtp.gmail.com with ESMTPSA id z8-v6sm1962298qto.71.2018.11.08.05.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:59:13 -0800 (PST)
Subject: Re: [PATCH] powerpc: Mark variable `cpumsr` as unused
To:     Mathieu Malaterre <malat@debian.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Neuling <michael.neuling@au1.ibm.com>
References: <20181107202641.7865-1-malat@debian.org>
 <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
 <CA+7wUsz8TVtOuSvmWVGeZmPKGvxFhHy2mVSKex4REFs9uGb_xQ@mail.gmail.com>
From:   Breno Leitao <leitao@debian.org>
Message-ID: <1b62012a-1c59-ef62-117f-ec04fa47a815@debian.org>
Date:   Thu, 8 Nov 2018 11:59:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz8TVtOuSvmWVGeZmPKGvxFhHy2mVSKex4REFs9uGb_xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Christophe

Thanks for spotting and fixing this bug.

On 11/08/2018 05:25 AM, Mathieu Malaterre wrote:
> On Thu, Nov 8, 2018 at 7:09 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>
>>
>> On 11/07/2018 08:26 PM, Mathieu Malaterre wrote:
>>> Add gcc attribute unused for `cpumsr` variable.
>>>
>>> Fix warnings treated as errors with W=1:
>>>
>>>    arch/powerpc/kernel/process.c:231:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
>>>    arch/powerpc/kernel/process.c:296:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>
>> I don't think this is the good way to fix that. This problem was
>> introduced by commit 5c784c8414fb ("powerpc/tm: Remove
>> msr_tm_active()"). That commit should be reverted and fixed.
> 
> I see, it makes sense.
> 
>> That commit should have removed the macro and kept the inline function.
> 
> Breno, what do you think ?

Turning this macro into a function might cause the code to be more confused,
since all the other TM states bits are checked using a macro, for example:

 MSR_TM_SUSPENDED     Checks if the MSR has Suspended bits set
 MSR_TM_TRANSACTIONAL Checks if the MSR has the transactional bits set
 MSR_TM_RESV          Checks if the MSR has the TM reserved bits set	

That said, I understand that it makes sense to have an uniform way to check
for TM bits in MSR, thus having a MSR_TM_ACTIVE macro to check for the active
bits. Using a non-uniform function just to fix this warning seems to be an
overkill. Reverting the patch seems to bring back the old style, which is
having a macro and a function with the same name, where the function just
calls the macro.

Anyway, I think it might have other ways to fix warning, as I can think now:

 1) Avoid setting cpumsr if CONFIG_PPC_TRANSACTIONAL_MEM is not enabled

 2) If !CONFIG_PPC_TRANSACTIONAL_MEM, redefine MSR_TM_ACTIVE(x) to something
as (x & 0) instead of 0.

 3) Avoid double definition of MSR_TM_ACTIVE, i.e, have the same definition
independent of PPC_TRANSACTIONAL_MEM being set or not.

Anyway, I would like to try option 3), which is the hardest one to implement
and validate, but it seems to be the most correct option, once it checks for
a MSR bit configuration, and the caller should have the logic.
