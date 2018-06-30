Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B0AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD8823D06
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNvOdGqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8823D06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeF3QZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 12:25:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39916 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeF3QZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 12:25:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so2422839oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IBsesTxYbpdfX9P3QFgdsqi1d5yu/tuP3GYLnArbARk=;
        b=kNvOdGqikX3A6719n/UKWNFPnHRhp8YMGCFAOb5J20YnNYqvxfbP3NxV55n15f/Acz
         gWmEnBDKkpvIB7j7xjhH0R25wQzqxIxY8oMAJZWDtkqNIPkFK2Mqf3gflEiYVzzy7pFJ
         Bnv/LURao+79vqPgoHSNUmT/FgTaZ1C3UpogrSgYKOa3B9niTnDtI1eoj1w5uq4vPkU0
         3QfGFlyqNcRwXc5hirmFyO1JPIUdZ0rBmn9+U8nSnC1XhwIFUKuXvVnuFs9Jf24zQCqF
         1SACIcGGj/yx8ZQVl0A1fJvb83rWMvh7gKzTloQthorU+TocFMVI1PIKws8+LVAgWzOu
         cOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IBsesTxYbpdfX9P3QFgdsqi1d5yu/tuP3GYLnArbARk=;
        b=ssinPZ5NHEnQvbGZze+yFO892UAMThFJGX8TgZj8LROgxYIss2ivMImtpGAjxLthuK
         KZwUWq8M66l2ZrspeLJB6JyEHEI76uBwJvC0qi30HXuIsKl9SX4MeNq94EUCdFvsvT61
         Fs4V2KHANjNEg58dAfyRzmW9fTdS6aiph3MreK/+quV9ZFx7rskR+6w0Nv855WaiHhIC
         oO1VRdK6ACO2HcEwo3KQnwHbAzhICBmMTA8dtFBzU0Ne/SYxFNcW/ijnkUUHVBUS7Ksy
         3VzvqPaDY/N3mrOKsyV6Echw+Wbk/WntuuWSMj5Cf2YGzXOXdqvg9gZWtqVvbM1jWa9+
         yCFQ==
X-Gm-Message-State: APt69E1cqQPrlXZiSlIuwtKgZZBV1prJLsjfl4F3MdRlD4S3YOPvyyti
        O/s4ASwQirQ9TOjSzl6WNJiGog==
X-Google-Smtp-Source: AAOMgpcrsR8MWU7h/K3DbH2Y3IejM23mII6pIjIWPagHuRaea4vWaST8hPuO9XPdX+0q34pgRf8wzA==
X-Received: by 2002:aca:758c:: with SMTP id q134-v6mr3683749oic.334.1530375917572;
        Sat, 30 Jun 2018 09:25:17 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id t7-v6sm5737494oth.12.2018.06.30.09.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 09:25:16 -0700 (PDT)
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     christophe leroy <christophe.leroy@c-s.fr>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <1a73e92a-f77d-ba1e-ebf8-b469db3c465e@c-s.fr>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b721b0c9-a802-2296-fc82-5c11c2698327@lwfinger.net>
Date:   Sat, 30 Jun 2018 11:25:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1a73e92a-f77d-ba1e-ebf8-b469db3c465e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2018 04:31 AM, christophe leroy wrote:
> 
> 
> Le 29/06/2018 à 22:42, Larry Finger a écrit :
>> My PowerBook G4 Aluminum crashes on boot with 4.18-rcX kernels with a kernel 
>> BUG at include/linux/page-flags.h:700! The problem was bisected to commit 
>> 1d40a5ea01d5 ("mm: mark pages in use for page tables"). It is not possible to 
>> capture the bug with anything other than a camera. The first few lines of the 
>> traceback are as follows:
>>
>> free_pgd_range+0x19c/0x30c (unreliable)
>> free_pgtables_0xa0/0xb0
>> exit_pmap+0xf4/0x16c
>> mmput+0x64/0xf0
>> do_exit+0x33c/0x89c
>> oops_end+0x13c/0x144
>> _exception_pkey+0x58/0x128
>> ret_from_except_full+0x0/0x4
>> --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>>      LR = free_pgd_range+0x19c/0x30c
>> free_pgtables+0xa/0xb
>> exit_mnap+0xf4/0x16c
>> mmput+0x64/0xf0
>> flush_old_exec+0x490/0x550
>>
>> I have more information regarding this BUG. Line 700 of page-flags.h is the 
>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded 
>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), 
>> page) in routine __ClearPageTable(), which is called from pgtable_page_dtor() 
>> in include/linux/mm.h. I also added a printk call to PageTable() that logs 
>> page->page_type. The routine was called twice. The first had page_type of 
>> 0xfffffbff, which would have been expected for a . The second call had 
>> 0xffffffff, which led to the BUG.
>>
> 
> Oh, seems to be the one I noticed and told Aneesh about 
> (https://patchwork.ozlabs.org/patch/922771/)
> 
> Aneesh provided the patch https://patchwork.ozlabs.org/patch/934111/ for it, 
> does it help ?

Yes, those changes fix the problem.

Larry

