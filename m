Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DACC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B95925BDC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9vspKkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B95925BDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeGBUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:51:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35538 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeGBUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:51:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so14538854oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uSUNWgJNcZny1PlnKw1TGxfE94BxO4cminFklKedxd8=;
        b=C9vspKkHGf3NDw5M5GSP0w91vZ2Lo+B3mPLPCjpZP+aqRcz/qOTCLi8gXB3CKBcyym
         lBjWRRruojEUHg1pFhtA4Sexp70dfHPY0rcw/06aBx3pH/cRA4UbKqU+R8xDeiQrhIDy
         TPDGxSY5cWZTfzgDH9jCo+KNe8DKUdP4Gx+xuBgTSEUbbYAmkeqfxQ5/nWhyKdMj+Kxr
         8IxbyYgzs/Ix7Bu5RdRUeoaCwMU5iXUo+YnhdqFnELvrNYM2dqcouARn6Et75rPkBCeh
         bq+lqu5Js0skVUerYp+SVBb+zeYGRXOm2NJnMbhNqLDAK1G9FWVYIXSWyHqfYx5hriF8
         +W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uSUNWgJNcZny1PlnKw1TGxfE94BxO4cminFklKedxd8=;
        b=Ty2WKgDqyrOLZePbunX07Mhql346IBSmollOPhoFkncRyY4Ohdqm1zW8YkDlHo0X3l
         qPWsneaxjv6MCc1/Le6kE6LK7e17VUJIddFa4w9wV+Xc1Ck9m9G9FVE6NzqW53rMLqoi
         SGtq4C8lDzni3f97AmxWWwQaGYThrMczWhfqOSltV7sQ/L6dTzvPiEQakcTo6c7kwFnD
         XDST8/dLfAgIkyzOp8+I67iKouqdUPxPZs3kXFE+PT4m1scFyNkpc63lo0oyMWw7NYdo
         4nvIHvy7Xa5+YEEF8Kx7ET+PU7p9lhOgs/HUZ2ZAR5lBWVBZ51mFA96VPM+UnfZhhBNS
         yzJg==
X-Gm-Message-State: APt69E2Jci/sLMXGc45mGiEM9GkhgVJ8L8Dv0bLvIu1d946U3iXdUMMu
        M9NSZalTrrYMArq7LJtBaULgxg==
X-Google-Smtp-Source: AAOMgpcSkLLn7BoZnaTK7IjVuRA4d1LqNHiz3iVx7UVexB1zdKgbO+tBBHd5Qzk9+Pe8W9Xy9QzifA==
X-Received: by 2002:aca:cd41:: with SMTP id d62-v6mr16112878oig.207.1530564665770;
        Mon, 02 Jul 2018 13:51:05 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id w13-v6sm11685005otw.25.2018.07.02.13.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:51:05 -0700 (PDT)
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
 <87d0w6mfvi.fsf@concordia.ellerman.id.au>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <574d8619-1f1a-cad7-a33b-5c8296757fda@lwfinger.net>
Date:   Mon, 2 Jul 2018 15:51:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87d0w6mfvi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2018 11:16 PM, Michael Ellerman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>
>>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>>> page->page_type. The routine was called twice. The first had page_type of
>>> 0xfffffbff, which would have been expected for a . The second call had
>>> 0xffffffff, which led to the BUG.
>>
>> So it looks to me like the tear-down of the page tables first found a
>> page that is indeed a page table, and cleared the page table bit
>> (well, it set it - the bits are reversed).
> ...
>>
>> That said, can some ppc person who knows the 32-bit ppc code and maybe
>> knows what that "interrupt: 700" means talk about that oddity in the
>> trace, please?
> 
> I think everyone else answered your questions here, and it should be
> fixed now in your tree.
> 
> Larry let me know if you're still seeing a crash with 4.18-rc3.

The problem is fixed in 4.18-rc3. Thanks to all that helped.

Larry

