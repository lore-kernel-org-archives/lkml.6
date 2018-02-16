Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518773014; cv=none;
        d=google.com; s=arc-20160816;
        b=YD2Szc0Cq0cHW6O/8wAJ6nZujo4/78NlnA25skKqN3SFZ6TD9vXMbaQl+YxRmuV7rd
         gue2GErMK3TDw4RpkceK4Xo8m4ylt+tAraEj14gQNGeIDrDIuzI2LDhADcUpwoy3ztI7
         CnwP0l8TWm9KF8LRsH9NSQvvXbTGtCh9/WsNeiXtQhd7dpIL30+GE2DxvikTkfsbkS5H
         W6eD8LifmQgQto6iJvYukN5odkP0xjI60+XHBhOIgErXceuQO6oe59DIvpau0viJSAUr
         ZeMBrqbBFuMrRzQuMKlBqP/efuC3HXh1RARpXA8CN+3AMo8gTiGR0KC9oB9F02dUpoh2
         +W0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=u+MA+OK32Csc/wmGajKbJD/sRB7VRkno5TojvebLEM0=;
        b=0agDxV8b0DkXlByknf8LhQ6Rrd5dkCK034nbKU9mPAhwAtt6INUBH7VqxwGioFO+co
         bq3oiHNh2GcyjonxUU5Z6Jmjnm51/pVY/j7Q60X+KppujYxKJZmUF7fa44N+Yt9ej+V7
         yRFct8wdu6q9JDvwtkgr7dv+K1+8wfgb3fCcesT3ohDV8us295+rZOS6/t6mEghOuGDQ
         ke2sb42TADMzjevBxE1AeqV6K1SsehOV2q1PgNjMbxjwZItGDByYo32I9XqeLMvQs8DU
         0/o1B/G9FzUuRQwfcm4QC/JLw5I4P6qsKgpSNaN2iOZfF8fXzUN29wsnMpQ1wcpoGODY
         7DSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AhBrlS2W;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AhBrlS2W;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x2274MICIwCIVbimJC8ATtxBhcduSnvrY/u+3F0eA0mCfqECkC/mTlGvBc34ZArdsMKpoinQhgQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 16 Feb 2018 10:23:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 3/6] mm: uninitialized struct page poisoning sanity checking
Message-ID: <20180216092330.k7hutkvjmy7nope3@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-4-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-4-pasha.tatashin@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446423253504?=
X-GMAIL-MSGID: =?utf-8?q?1592548931976600703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> During boot we poison struct page memory in order to ensure that no one is
> accessing this memory until the struct pages are initialized in
> __init_single_page().
> 
> This patch adds more scrutiny to this checking by making sure that flags
> do not equal the poison pattern when they are accessed.  The pattern is all
> ones.
> 
> Since node id is also stored in struct page, and may be accessed quite
> early, we add this enforcement into page_to_nid() function as well.
> Note, this is applicable only when NODE_NOT_IN_PAGE_FLAGS=n
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>

Please always start patch titles with a verb, i.e.:

 mm: Add uninitialized struct page poisoning sanity check

or so.

Thanks,

	Ingo
