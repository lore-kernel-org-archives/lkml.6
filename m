Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeBZKIw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:08:52 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:34321 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeBZKIu (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:11:1>);
        Mon, 26 Feb 2018 05:08:50 -0500
Message-Id: <5A93EABD02000078001AB9EC@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 26 Feb 2018 03:08:45 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Andrey Ryabinin" <aryabinin@virtuozzo.com>
Cc: <bp@alien8.de>, <brgerst@gmail.com>, <dvyukov@google.com>,
        <glider@google.com>, <peterz@infradead.org>, <luto@kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>,
        <torvalds@linux-foundation.org>, <boris.ostrovsky@oracle.com>,
        <dvlasenk@redhat.com>, <jpoimboe@redhat.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [tip:x86/mm] x86/mm: Consider effective protection
 attributes in W+X check
References: <5A8FDE8902000078001AABBB@prv-mh.provo.novell.com>
 <tip-672c0ae09b33a11d8f31fc61526632e96301164c@git.kernel.org>
 <cd48304c-4317-6b5a-bde3-113645df8f81@virtuozzo.com>
In-Reply-To: <cd48304c-4317-6b5a-bde3-113645df8f81@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 26.02.18 at 11:00, <aryabinin@virtuozzo.com> wrote:
> On 02/26/2018 11:48 AM, tip-bot for Jan Beulich wrote:
>> @@ -351,7 +362,7 @@ static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
>>  	    (pgtable_l5_enabled && __pa(pt) == __pa(kasan_zero_p4d)) ||
>>  	    __pa(pt) == __pa(kasan_zero_pud)) {
>>  		pgprotval_t prot = pte_flags(kasan_zero_pte[0]);
>> -		note_page(m, st, __pgprot(prot), 5);
>> +		note_page(m, st, __pgprot(prot), 0, 5);
> 
> Isn't this disables W+X check for kasan page table?
> Methinks it should be 'prot' here.

Might well be - I actually did ask the question before sending v3,
but didn't get any answer (yet). The kasan_zero_p?d names
suggested to me that this is a shortcut for mappings which
otherwise would be non-present anyway, but that was merely a
guess. As to W+X checks - I can't see how the result could be
any better if the protections of kasan_zero_pte[0] would be
used: Those can't possibly be applicable independent of VA.

Jan
