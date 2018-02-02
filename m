Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x2268wBdwqejBIiEnzWQsDSmCxkY6rMl9RxL1P60lgLATOnP5QL8aao6M3UlvK7SCI5X4x2AN
ARC-Seal: i=1; a=rsa-sha256; t=1517583678; cv=none;
        d=google.com; s=arc-20160816;
        b=UDDrjRanQhfTGtQLrl+58K73vXBCGtcV22YLb9weppI4FC8wdifrs84DtcVUEUHC7N
         nq2OmBxaRFf3/4LGE0rfSleJrNAFcjXB4v/jkILpo7hticlWmU1HFE9VgpcMMVpV2T/A
         cXn4IAT8eYwuOjpb6tZpzeGtviznedc1wezuAdRNLCvLzxRcsa2XY94d+hJ38QMCp22M
         kdhPziJkZrunp/uWPGPsGY5heAMFY14OP2ejswuwxJ4bGaQRCKsGeXqm1svyKbblu1qL
         fhR9PlovQgYdppY/3fXCKcDHX7/PkoehOhz2G5STAZkRedz37MmebpqbKtgeR7q/1ONI
         CSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=THbGEkTK4KM0jZ4st5ttnjwlbXSnnOqwtPYkd5uZTEs=;
        b=aUzlIte+3/1WWfS715T1RFt32AXGobmq6kcDXeKHcR874e9SHSNx/YXuFLQ/S7NNYJ
         j0W0hl9TEjfj6Ldo2QNKklo7VzzdOwkaFpbbMrbb6oIF9tVaqPHLKr2EcickLzdrQDZN
         cVy+z5ienZdg6q6naWZY5Og9C8a621qKQWpwiAE2JoNcUhULblgv57Duj/1PRGRVuyhQ
         wC0mYqa7ZGgVZA/yx8eECwoGKCEq43jWrKmRcT6K4i/Pbq/eCEAmaw+eHQ2whWXbzrMB
         s1UTy4BmMKPLBD0qrmggumWXyF0oEcKE72sji09zwZ32+JiOSEWlnkGZw3aediq/MuR1
         O8ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=noFy5UQd;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=noFy5UQd;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced
 by SPARC M7
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, allen.pais@oracle.com,
        anthony.yznaga@oracle.com, arnd@arndb.de, babu.moger@oracle.com,
        benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com,
        david.j.aldridge@oracle.com, elena.reshetova@intel.com,
        glx@linutronix.de, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        hillf.zj@alibaba-inc.com, hpa@zytor.com, hughd@google.com,
        imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
        jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
        khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
        kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
        ktkhai@virtuozzo.com, liam.merwick@oracle.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net, me@tobin.cc,
        mgorman@suse.de, mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, minchan@kernel.org, mingo@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, nadav.amit@gmail.com,
        nagarathnam.muthusamy@oracle.com, nborisov@suse.com,
        n-horiguchi@ah.jp.nec.com, nick.alcock@oracle.com,
        nitin.m.gupta@oracle.com, ombredanne@nexb.com,
        pasha.tatashin@oracle.com, paulus@samba.org, pombredanne@nexb.com,
        punit.agrawal@arm.com, rob.gardner@oracle.com,
        ross.zwisler@linux.intel.com, shannon.nelson@oracle.com, shli@fb.com,
        sparclinux@vger.kernel.org, steven.sistare@oracle.com,
        tglx@linutronix.de, thomas.tai@oracle.com, tklauser@distanz.ch,
        tom.hromatka@oracle.com, vegard.nossum@oracle.com,
        vijay.ac.kumar@oracle.com, willy@infradead.org, x86@kernel.org,
        zi.yan@cs.rutgers.edu
References: <cover.1517497017.git.khalid.aziz@oracle.com>
 <87wozwi0p1.fsf@xmission.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <0f1bdb63-60d5-467c-a6a4-c06ba62b1f6e@oracle.com>
Date: Fri, 2 Feb 2018 07:59:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <87wozwi0p1.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=840
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020184
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223715312130121?=
X-GMAIL-MSGID: =?utf-8?q?1591301823912883287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 07:29 PM, ebiederm@xmission.com wrote:
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> V11 changes:
>> This series is same as v10 and was simply rebased on 4.15 kernel. Can
>> mm maintainers please review patches 2, 7, 8 and 9 which are arch
>> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
>> and ack these if everything looks good?
> 
> I am a bit puzzled how this differs from the pkey's that other
> architectures are implementing to achieve a similar result.
> 
> I am a bit mystified why you don't store the tag in a vma
> instead of inventing a new way to store data on page out.

Hello Eric,

As Steven pointed out, sparc sets tags per cacheline unlike pkey. This 
results in much finer granularity for tags that pkey and hence requires 
larger tag storage than what we can do in a vma.

> 
> Can you please use force_sig_fault to send these signals instead
> of force_sig_info.  Emperically I have found that it is very
> error prone to generate siginfo's by hand, especially on code
> paths where several different si_codes may apply.  So it helps
> to go through a helper function to ensure the fiddly bits are
> all correct.  AKA the unused bits all need to be set to zero before
> struct siginfo is copied to userspace.
> 

What you say makes sense. I followed the same code as other fault 
handlers for sparc. I could change just the fault handlers for ADI 
related faults. Would it make more sense to change all the fault 
handlers in a separate patch and keep the code in 
arch/sparc/kernel/traps_64.c consistent? Dave M, do you have a preference?

Thanks,
Khalid
