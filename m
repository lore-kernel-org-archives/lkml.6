Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCD7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2843220A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kECkC1co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2843220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHYABH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:01:07 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39208 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeHYABH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:01:07 -0400
Received: by mail-pg1-f180.google.com with SMTP id m3-v6so3868899pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vQ7YkvZDBEk0QYXp/hSQnQMhPW+zEyToXWO8rFBSm/w=;
        b=kECkC1coZk5PSz64P+ABtgtOtZ0yGc+W+gYyO/rfNUqE+pBxIBANswdQ94W3ExPHYt
         AZatevfqSYmAig6DlzB1GaQ8S2TiTbgrCb7C7UXc/0ztaT2CjqlHTIhg0LgJt4fX+Z4u
         6NLTgjX/5RwcSgtAkG705ePbR/wX1XLMTskYg7O2xBAfI2DZAfaab2/30PafoMMRfZZU
         3IpWogJMqEIPqYwi/mFPz0eoufRxzO//Is2SU+fZB8QpaRnSc6AhBRjIOKzvBsUEAcYm
         56lAbIm5050e+ufj0QTVLROhoVy6GB8WLSDEnuvwoCOLL4HWvDXtzTgxyZPvVsEYhcvT
         aegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vQ7YkvZDBEk0QYXp/hSQnQMhPW+zEyToXWO8rFBSm/w=;
        b=IA7Iz+q3pT0XhMB7MDbItoJtINwPAyviUYtWvqjUJRRHeIQ1BNTNqMuaKOQVd2WgnU
         WvTgfEfBpLPmIKVXmkKYCReYWc55qQc5Pm9NDF5E/o7oFmg/1ON4QVG98A0Un2zTzPRX
         ZJmhDdLt3fYPGJ4JLE6sRyTG518i50dd2uDaRxsk6TyC+l5qxtTJQpqUBMeDWIQjo4RL
         4ctWITAea3WulRY8OR6iY4hA17DLkfCcbwvYieghFVUpiZsj8iMv7vzpRnTwW4KQd7qL
         h1txR+h0GqgZeOZaw4qMHCks1i+WD/dfVh3qUW0tzE9Yry7aO6YNzoSMCZCwly1Fcssf
         8BsQ==
X-Gm-Message-State: APzg51ByTasJWGyEXBQNo4YKTZxup3fG7A/z4abbDAsigeCL0vv010y/
        aqE3xw3n/A9Jj2OlTBd7Lb8=
X-Google-Smtp-Source: ANB0VdaIdg4/OktQwAlny42uC9MkmOcb+Im1Sqodwg8qwpi7KqlvgQ/qIVKHSZILImKiazMLnuDrmA==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr3034600pgu.260.1535142297361;
        Fri, 24 Aug 2018 13:24:57 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id c128-v6sm7854662pfa.177.2018.08.24.13.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:24:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: TLB flushes on fixmap changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
Date:   Fri, 24 Aug 2018 13:24:54 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Transfer-Encoding: 7bit
Message-Id: <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:31 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Aug 24, 2018 at 11:36 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>>> Urgh.. weren't the fixmaps per cpu? Bah, I remember looking at this
>>> during PTI, but I seem to have forgotten everything again.
>> 
>> [ Changed the title. Sorry for hijacking the thread. ]
>> 
>> Since:
>> 
>> native_set_fixmap()->set_pte_vaddr()->pgd_offset_k()
> 
> The fixmaps should be entirely fixed after bootup to constant
> mappings, except for the KMAP ones, and they are indexed per-cpu.
> 
> That's what my mental model is, at least.
> 
> Can you actually find something that changes the fixmaps after boot
> (again, ignoring kmap)?

At least the alternatives mechanism appears to do so.
 
IIUC the following path is possible when adding a module:

	jump_label_add_module()
	->__jump_label_update()
	->arch_jump_label_transform()
	->__jump_label_transform()
	->text_poke_bp()
	->text_poke()
	->set_fixmap()
	
And a similar path can happen when static_key_enable/disable() is called.

