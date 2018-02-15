Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518721205; cv=none;
        d=google.com; s=arc-20160816;
        b=RpDEYp2jLOshozrUgFZ6DHCtdLAQjKfpc69ahrCE7tq6bYR9Oi7k4uLQbNqUFhvgv1
         boDuYmEevo2nwwsaSavU8YK1XLGK2U7Betgb8SYz+b766DUHkRlMl1bXX8UqmPEfzft1
         0JCE0QofTg4gwGHIadm9Ob9iq6JIbi2mr9BxItOHXr8ZJ/X0Xa7h/TASOfHBz6BRDLZP
         3Ctlst3xJpcSZhevziGVilU71LWcTWxqdgm84y+hv4bQfeL8WcCueJ5C0ZGzynDlUy6R
         k+snyH8cGis/osE6orBa2QAZbJdYHt766hPo2+aPzkGAZqweCyMLK3FiL+s1o1Pz45vO
         Ohzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=cK03mt6sgEV8OJnWfsb+TPCgve0vT6yoh/hQcnViDoc=;
        b=RbADPNR+6f2fji9LmmAKUfFbq2i2RpCKCh6PCX1mc020Z4Ngld5gdg9HIjsILmBO2E
         bTkGWVI7W0Oo1EEQg+5kQeB6mNjtSchODvlXDdEUlPcQ3/t/fGFi/6u9vdIJiTMBFzdQ
         q4wJ/JAnU4iuGNbGtWRb0x2NhjCC5t+NewLUhfVYc8GCBbEkscl9dHfj3B6en9TrJdY0
         snFyblLJ3afhuzhoYqe8NayAXQ5XZrNz6q5d//xZflwtrB26prPi7eU+m19Qxogoy+sC
         KeANqgaN5CbDjgrIFohJxaxUBqNOVIKWuOB4wn+q2QhALkG5SiIA4Lr/pbDNH2SnUnnV
         tW9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sSAxcv0t;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sSAxcv0t;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x225kr8MwKJNcLvMRyRaYmI2+1X0LH6qvoVQAvIperlycZZZXGCxltSYl5Plp1f1+eSdC1SYyDQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 15 Feb 2018 20:00:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Steve Sistare <steven.sistare@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Bharata B Rao <bharata@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v3 2/4] x86/mm/memory_hotplug: determine block size based
 on the end of boot memory
Message-ID: <20180215190001.rbvrb74jxpvs6vrz@gmail.com>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-3-pasha.tatashin@oracle.com>
 <20180215113725.GC7275@dhcp22.suse.cz>
 <CAOAebxu5EM1qhC=pS2cCqjGfBabFEj0aQQNon1nAz5_3YPOsCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAebxu5EM1qhC=pS2cCqjGfBabFEj0aQQNon1nAz5_3YPOsCw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446070110278?=
X-GMAIL-MSGID: =?utf-8?q?1592494607564304892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> > I dunno. If x86 maintainers are OK with this then why not, but I do not
> > like how this is x86 specific. I would much rather address this by
> > making the memblock user interface more sane.
> >
> 
> Hi Michal,
> 
> Ingo Molnar reviewed this patch, and Okayed it.

But I'd not be against robustifying the whole generic interface against such 
misconfiguration either.

But having the warning should be enough in practice, right?

Thanks,

	Ingo
