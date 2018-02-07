Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AH8x226Jm+CaIpWfEBYmmZY4XjobmM4Kqeac6MGZwptlzb9y5xF6qXpPML6brSjR/FPpbDccUkH0
ARC-Seal: i=1; a=rsa-sha256; t=1517989159; cv=none;
        d=google.com; s=arc-20160816;
        b=FDTHmZCp+/HhbXRjxkUy4K1GVZdJzwpWdrqkea6VV0wKnzusFRtiH4nxCcSJMaKr35
         Yo1FQkPr/sqCMg051eWPmia1W9wlNAYebJ3/o/CrzFm7C+8gDSEIMwiQMwqYczgSvGvQ
         dNmG9zl0cubM0OzAInJjyn4ldjEWmAK2JSKrIxxWNJ932LXdbKT5NEHUXN/79++zOakm
         UfFDRZ+eKw7PTa6y1n66486oRlThE4xUPWROn27kpVYMdSZvukDc6UrTJNZSynLL2wNt
         hudejZRG7NiKSIO5jfYr5bsRhOt+eMf0/mB+9n0Qxs/xG/TYCRKRplodaMvZHn6WEJ1H
         blbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=eznAuNs6D+ciygWLsehHKn3q7G0RQ+TirQXx84+JoL0=;
        b=BhkuUO1pv4swCwnsqPbYr3lqpaxGldYv6ZMnqgfwRyOAL5IZDrPmbFfbjxPDWEJBo6
         bv7jYXDzvQ73YGqUBkQPlf+CCRUZ6iXsOyhHDP1eZx8CY/GBfSqOmxLyJwe/yPK4ZpcL
         9qa37PxV7H+f2B12ozXJ+a6wljiFiieyP+TtqXHi0hMk05JhtPI/Vb6RkzgLE1fUQefx
         Y1tlyd1+oNf6HDbTbUroTJvuywT3eXarSs/QUQJetN3dhjtQ6GKLPC1RwRwVgUvtCA++
         X4IlvB55WPTdIwvBuTbeZn6MYyUcVJMks61XUY1lvepA00LGSuY1UUEVVYhZUe9SNBdr
         spxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net,  dave.hansen@linux.intel.com,  aarcange@redhat.com,  akpm@linux-foundation.org,  allen.pais@oracle.com,  anthony.yznaga@oracle.com,  arnd@arndb.de,  babu.moger@oracle.com,  benh@kernel.crashing.org,  bob.picco@oracle.com,  bsingharora@gmail.com,  corbet@lwn.net,  dan.j.williams@intel.com,  dave.jiang@intel.com,  david.j.aldridge@oracle.com,  elena.reshetova@intel.com,  glx@linutronix.de,  gregkh@linuxfoundation.org,  hannes@cmpxchg.org,  hillf.zj@alibaba-inc.com,  hpa@zytor.com,  hughd@google.com,  imbrenda@linux.vnet.ibm.com,  jack@suse.cz,  jag.raman@oracle.com,  jane.chu@oracle.com,  jglisse@redhat.com,  jroedel@suse.de,  khalid@gonehiking.org,  khandual@linux.vnet.ibm.com,  kirill.shutemov@linux.intel.com,  kstewart@linuxfoundation.org,  ktkhai@virtuozzo.com,  liam.merwick@oracle.com,  linux-arch@vger.kernel.org,  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  linuxppc-dev@lists.ozlabs.org,  linux@roeck-us.net,  me@tobin.cc,  mgorman@suse.de,  mgorman@techsingularity.net,  mhocko@suse.com,  mike.kravetz@oracle.com,  minchan@kernel.org,  mingo@kernel.org,  mingo@redhat.com,  mpe@ellerman.id.au,  nadav.amit@gmail.com,  nagarathnam.muthusamy@oracle.com,  nborisov@suse.com,  n-horiguchi@ah.jp.nec.com,  nick.alcock@oracle.com,  nitin.m.gupta@oracle.com,  ombredanne@nexb.com,  pasha.tatashin@oracle.com,  paulus@samba.org,  pombredanne@nexb.com,  punit.agrawal@arm.com,  rob.gardner@oracle.com,  ross.zwisler@linux.intel.com,  shannon.nelson@oracle.com,  shli@fb.com,  sparclinux@vger.kernel.org,  steven.sistare@oracle.com,  tglx@linutronix.de,  thomas.tai@oracle.com,  tklauser@distanz.ch,  tom.hromatka@oracle.com,  vegard.nossum@oracle.com,  vijay.ac.kumar@oracle.com,  willy@infradead.org,  x86@kernel.org,  zi.yan@cs.rutgers.edu
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	<87wozwi0p1.fsf@xmission.com>
	<0f1bdb63-60d5-467c-a6a4-c06ba62b1f6e@oracle.com>
Date: Wed, 07 Feb 2018 01:38:40 -0600
In-Reply-To: <0f1bdb63-60d5-467c-a6a4-c06ba62b1f6e@oracle.com> (Khalid Aziz's
	message of "Fri, 2 Feb 2018 07:59:25 -0700")
Message-ID: <87h8qtfdvj.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ejKJl-0004EF-BL;;;mid=<87h8qtfdvj.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+LSvv75M8gXGlW1mkIQ7pD/fxQVQdzauI=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Khalid Aziz <khalid.aziz@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 417 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 4.2 (1.0%), b_tie_ro: 2.8 (0.7%), parse: 1.47 (0.4%),
	extract_message_metadata: 22 (5.2%), get_uri_detail_list: 3.1 (0.8%),
	tests_pri_-1000: 12 (3.0%), tests_pri_-950: 1.71 (0.4%), tests_pri_-900: 1.64
	(0.4%), tests_pri_-400: 44 (10.6%), check_bayes: 43 (10.2%), b_tokenize: 17
	(4.0%), b_tok_get_all: 13 (3.1%), b_comp_prob: 5 (1.3%), b_tok_touch_all: 4.8
	(1.1%), b_finish: 0.74 (0.2%), tests_pri_0: 319 (76.4%),
	check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 2.8 (0.7%),
	tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced by SPARC M7
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223715312130121?=
X-GMAIL-MSGID: =?utf-8?q?1591727001073625045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> On 02/01/2018 07:29 PM, ebiederm@xmission.com wrote:
>> Khalid Aziz <khalid.aziz@oracle.com> writes:
>>
>>> V11 changes:
>>> This series is same as v10 and was simply rebased on 4.15 kernel. Can
>>> mm maintainers please review patches 2, 7, 8 and 9 which are arch
>>> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
>>> and ack these if everything looks good?
>>
>> I am a bit puzzled how this differs from the pkey's that other
>> architectures are implementing to achieve a similar result.
>>
>> I am a bit mystified why you don't store the tag in a vma
>> instead of inventing a new way to store data on page out.
>
> Hello Eric,
>
> As Steven pointed out, sparc sets tags per cacheline unlike pkey. This results
> in much finer granularity for tags that pkey and hence requires larger tag
> storage than what we can do in a vma.

*Nod*   I am a bit mystified where you keep the information in memory.
I would think the tags would need to be stored per cacheline or per
tlb entry, in some kind of cache that could overflow.  So I would be
surprised if swapping is the only time this information needs stored
in memory.  Which makes me wonder if you have the proper data
structures.

I would think an array per vma or something in the page tables would
tend to make sense.

But perhaps I am missing something.

>> Can you please use force_sig_fault to send these signals instead
>> of force_sig_info.  Emperically I have found that it is very
>> error prone to generate siginfo's by hand, especially on code
>> paths where several different si_codes may apply.  So it helps
>> to go through a helper function to ensure the fiddly bits are
>> all correct.  AKA the unused bits all need to be set to zero before
>> struct siginfo is copied to userspace.
>>
>
> What you say makes sense. I followed the same code as other fault handlers for
> sparc. I could change just the fault handlers for ADI related faults. Would it
> make more sense to change all the fault handlers in a separate patch and keep
> the code in arch/sparc/kernel/traps_64.c consistent? Dave M, do you have a
> preference?

It is my intention post -rc1 to start sending out patches to get the
rest of not just sparc but all of the architectures using the new
helpers.  I have the code I just ran out of time befor the merge
window opened to ensure everything had a good thorough review.

So if you can handle the your new changes I expect I will handle the
rest.

Eric
