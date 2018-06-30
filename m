Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE4FC6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298E627CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9DipE4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298E627CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965642AbeF3CiX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:38:23 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39063 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965153AbeF3CiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:38:10 -0400
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so11913365oth.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BXhAU5oFwCqKyf49nwqDkKNVQZonXOg4Y/SELWyvXzE=;
        b=n9DipE4CCr5OkM2Y2F666mzCAfvUBdAPtgWWiaPSfHtaQxImY0muVNdphuvpylKHZR
         mcmAZXdy8/mFgCr8xlN33LH4Mpikz+TQFZVZsuG15oDKjl8oY5SK1e+qD35BTQbWu+mW
         aFMmUJ4xx31p2gi+i7CvyTjCzzO6H58OFp/k8ak52tZWg0ETwh+srb0IQ7y1cvyq5y3z
         RH839UOTPE+BMwcEVNp/JESsCuD6LeiEYJj4R19IGZh/uU+zS3SPRzNxWDX3En/tnm0X
         Gvl2n/0K8EyT4+AcrZ8dat6sXsCnoEX3WiuqVE9Nf82MciFvE/PNmnRSxn7QioTQOryM
         of6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXhAU5oFwCqKyf49nwqDkKNVQZonXOg4Y/SELWyvXzE=;
        b=tLDPKpU2TA7+vXqL2Ppg3Wnyd6MIGABPzOiRkSa53fRcDPXkgZ+NZwsBVPR6NScX8F
         NJIoSn++YQwu7/EUm0ZHJxsq/ubuZAuOOrQDAgbrwngePLwOzUdr8VzNeqcpTetO42Aj
         KseugzJF4gMBOPWEKYjyR9OT96puPjVyAd9l6HtK6qJbjLwjns+7jlKN5+gBLN/FIGGF
         hak7IL0uWVXxHRkR5p/wjyI6lT1bxPeW8IISmwOnuMI1X5Nikv860WmT2v3s1sV6VFKn
         qcBpTSt+dquYxNVuJayvqqRMoOd41dTR5Kztk7ymh+aWHH4CUmYoUXJLilNW8MSdQX3E
         TkiA==
X-Gm-Message-State: APt69E3Dr696yu5k5ZxCu2HZV8E2zCab9QWOKZ1NpMiuTz782wXqA2/+
        nbrLHrDp+7FisUtay6MDmQe+Pw==
X-Google-Smtp-Source: AAOMgpeBT1TTCqNFoI+6qq5c7NGaSe0CyeISjGbMq/J5wimIea1zZFQ/n2RBcGTlQAZNFn4TOsDYsA==
X-Received: by 2002:a9d:5c0c:: with SMTP id o12-v6mr9471089otk.83.1530326289758;
        Fri, 29 Jun 2018 19:38:09 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id 91-v6sm5569494otr.74.2018.06.29.19.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 19:38:09 -0700 (PDT)
From:   Denise Finger <Larry.Finger@lwfinger.net>
X-Google-Original-From: Denise Finger <dwanderer@lwfinger.net>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Message-ID: <e9712f15-21fd-79a1-0292-8ca88d710c92@lwfinger.net>
Date:   Fri, 29 Jun 2018 21:38:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 04:01 PM, Linus Torvalds wrote:
> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>> page->page_type. The routine was called twice. The first had page_type of
>> 0xfffffbff, which would have been expected for a . The second call had
>> 0xffffffff, which led to the BUG.
> 
> So it looks to me like the tear-down of the page tables first found a
> page that is indeed a page table, and cleared the page table bit
> (well, it set it - the bits are reversed).
> 
> Then it took an exception (that "interrupt: 700") and that causes
> do_exit() again, and it tries to free the same page table - and now
> it's no longer marked as a page table, because it already went through
> the __ClearPageTable() dance once.
> 
> So on the second path through, it catches that "the bit already said
> it wasn't a page table" and does the BUG.
> 
> But the real question is what the problem was the *first* time around.
> I assume that has scrolled off the screen? This part:
> 
>    _exception_pkey+0x58/0x128
>    ret_from_except_full+0x0/0x4
>    --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>         LR = free_pgd_range+0x19c/0x30c
>    free_pgtables+0xa/0xb
>    exit_mnap+0xf4/0x16c
>    mmput+0x64/0xf0
> 
> Does reverting that commit 1d40a5ea01d5 make everything work for you?
> Because if so, judging by the deafening silence on this so far, I
> think that's what we should do.
> 
> That said, can some ppc person who knows the 32-bit ppc code and maybe
> knows what that "interrupt: 700" means talk about that oddity in the
> trace, please?

The deafening silence may be due to my having an old Microsoft address for 
Matthew Wilcox in my first posting. He should now have received the BUG report, 
and he may have some suggestions. Yes, reverting commit 1d40a5ea01d5 does permit 
the box to boot.

Kirill's patch also works, which seems like a better solution. If any other 
architecture bugs on boot, at least we will know where to look. :)

@Kirill: You may add a Reported-by: and Tested-by: Larry Finger 
<Larry.Finger@lwfinger.net> to the patch.

Thanks for the help,

Larry

