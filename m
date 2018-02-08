Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1263884-1518053320-2-13606739811263797146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518053319; b=boPIhgJ8nmE/rympODLbbbPYXHC/vPTf7G5t5V1+DYScDbd
    hyM9IQmkEaf4B45AjWNLuf0XsJDDu678UQA16r1TKFX1DOcnyHy3HcRJgU5xNKuz
    8i6GiBNezYCKE2hb6dl0pWoc2DHWvSjwgYOhVk72b4sPDmtPzOt63jhAQMefGsvj
    j50V/5f/O3g7rEweacpITqpxI5cQeg0GQMoeMt2vXW7FXBjYzdEUVgaDZD9aEH89
    9RYcIIng6quZAbEJWf3ohQF0r1AoY39NnTbJCBTRDf1Ot2L9LwZ3znKCHNaHXpm2
    GgckbssiU6AYmjUuOWqA2ruZKtXpICZ9vVlcsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1518053319; bh=jvbUNzE8i8PYpvqCheVQUue4cX
    kB1Fu1BoSLsb2qcmU=; b=mkvqM86oEcxW67rEQsv31MBNvibwhNiw3AjMsYb1G8
    AsKhU2DIhT+ywStDON4YA8WK8X5KQKs1hOKKlnWQW3bH/BKYzyO9x7jGb4FBieqD
    pR1O8/hVtipm5QAxl7zpoZhoy8offHV9c3jARzkSCZDeo7HqDriUccp/isIaMgDf
    eiYsNAm0JuMBT70+iqjCvWSoBhGZ4cYmZgVa64nwOQ5DlCUOQpmcTd2sD7NX+vgO
    ZebeMLwHKpjdwDR3eVjx47GRmHTsDnEtkP3hWh114kVup+2JeoP9OvmcXK8roiJA
    gHQuIDtbGcuiGKiXX4P1hTWbbJqtDTaA8K2rl8RUqUBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeBHB2h (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 20:28:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:39706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeBHB2g (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Feb 2018 20:28:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,476,1511856000";
   d="scan'208";a="29747987"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, "Michal Hocko" <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, <stable@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH -mm -v2] mm, swap, frontswap: Fix THP swap if frontswap enabled
References: <20180207070035.30302-1-ying.huang@intel.com>
        <20180207130534.259cd71a595c6275b2da38d3@linux-foundation.org>
Date: Thu, 08 Feb 2018 09:28:31 +0800
In-Reply-To: <20180207130534.259cd71a595c6275b2da38d3@linux-foundation.org>
        (Andrew Morton's message of "Wed, 7 Feb 2018 13:05:34 -0800")
Message-ID: <877ero1d8g.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed,  7 Feb 2018 15:00:35 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> From: Huang Ying <huang.ying.caritas@gmail.com>
>> 
>> It was reported by Sergey Senozhatsky that if THP (Transparent Huge
>> Page) and frontswap (via zswap) are both enabled, when memory goes low
>> so that swap is triggered, segfault and memory corruption will occur
>> in random user space applications as follow,
>> 
>> kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
>>  #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
>>  #1  0x00007fc08889c2f3 malloc (libc.so.6)
>>  #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
>>  #3  0x0000560e6005e75c n/a (urxvt)
>>  #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
>>  #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
>>  #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
>>  #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
>>  #8  0x0000560e6005cb55 ev_run (urxvt)
>>  #9  0x0000560e6003b9b9 main (urxvt)
>>  #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
>>  #11 0x0000560e6003f9da _start (urxvt)
>> 
>> After bisection, it was found the first bad commit is
>> bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
>> out").
>> 
>> The root cause is as follow.
>> 
>> When the pages are written to swap device during swapping out in
>> swap_writepage(), zswap (fontswap) is tried to compress the pages
>> instead to improve the performance.  But zswap (frontswap) will treat
>> THP as normal page, so only the head page is saved.  After swapping
>> in, tail pages will not be restored to its original contents, so cause
>> the memory corruption in the applications.
>> 
>> This is fixed via splitting THP before writing the page to swap device
>> if frontswap is enabled.  To deal with the situation where frontswap
>> is enabled at runtime, whether the page is THP is checked before using
>> frontswap during swapping out too.
>>
>> ...
>>
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -250,7 +250,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>  		unlock_page(page);
>>  		goto out;
>>  	}
>> -	if (frontswap_store(page) == 0) {
>> +	if (!PageTransHuge(page) && frontswap_store(page) == 0) {
>>  		set_page_writeback(page);
>>  		unlock_page(page);
>>  		end_page_writeback(page);
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 006047b16814..0b7c7883ce64 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -934,6 +934,9 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
>>  
>>  	/* Only single cluster request supported */
>>  	WARN_ON_ONCE(n_goal > 1 && cluster);
>> +	/* Frontswap doesn't support THP */
>> +	if (frontswap_enabled() && cluster)
>> +		goto noswap;
>>  
>
> hm.  This is assuming that "cluster==true" means "this is thp swap". 
> That's presently true, but is it appropriate that get_swap_pages() is
> peeking at "cluster" to work out why it is being called?
>
> Or would it be cleaner to do this in get_swap_page()?  Something like
>
> --- a/mm/swap_slots.c~a
> +++ a/mm/swap_slots.c
> @@ -317,8 +317,11 @@ swp_entry_t get_swap_page(struct page *p
>  	entry.val = 0;
>  
>  	if (PageTransHuge(page)) {
> -		if (IS_ENABLED(CONFIG_THP_SWAP))
> -			get_swap_pages(1, true, &entry);
> +		/* Frontswap doesn't support THP */
> +		if (!frontswap_enabled()) {
> +			if (IS_ENABLED(CONFIG_THP_SWAP))
> +				get_swap_pages(1, true, &entry);
> +		}
>  		return entry;
>  	}
>  

Sure.  I will do this.

Best Regards,
Huang, Ying
