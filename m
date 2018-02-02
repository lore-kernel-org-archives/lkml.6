Return-Path: <steven.sistare@oracle.com>
X-Google-Smtp-Source: AH8x224DMPFwFQPyvH0F++E0PefOrMzJwNMAHjaZr0sxDUjO0jIwZPy08IIJbiWXJNQE8YPrVRXf
ARC-Seal: i=1; a=rsa-sha256; t=1517580879; cv=none;
        d=google.com; s=arc-20160816;
        b=qbbLccYafjNulkBmtQg/4fxnukxGhd8IgXHULwd7TJcqT/7xDkFTw5VxHNuOcpUsZb
         II7/Q+sCedPN72Jw1w2/4yCtplcEGBUCnvJKDKI+VIntCP82aazTBNipKGn1WCgrVO3+
         skvIZRSfC3X/7l4gpxV1vAdb9QLgJaxQjCDGJV1ULVMP6ZCSYu88YRknFVZfihhkeYpM
         7HrLTCDHWX1RE8++o47jVlmJ4b+Y7RCjzhQXfY5yyE9OlcpdDUgu3FYEe9tNcuXUeA/u
         +e+CbihESY1CZMOBWKzPnxkJES0yvUiSYjjQ61jy3uWTM/9AtZovHU/wvWgTRIihiblf
         beSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=983DPL+lxfCCHSEHyRShkoMlHApkj9lq0wSXGtSICwI=;
        b=rJtOMbO960qvEWKFHVK2DrDQVduaQx5TWad8t/BihfSXoAISYs/Pz6tBD6b7JtVy7c
         iAX/L7fuLeQ+W2Y+HBRj20iMwoFfwnuiuxdotugjFJOUeM1m0fMPBiVLLKycIN8CNSOU
         vNYmlrFeWa5QeeIu2UYz8FqHt62nbDWN2h355/PB5guEoOCbbwaOIQXjnleygWftUJQO
         I2O5S6J+hNLht2JrSK3SMUF12PtKZkiddzh8Q19nfSv+jskkIGSK40D2771t0yNxbTkR
         XjyCq+5WXp/IGxKRO8sTh3hBFcYcYrCSxzDy2KUumn24E2fFxNoWDu7L39wp0oSgciJN
         Aauw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OiFeKzhp;
       spf=pass (google.com: domain of steven.sistare@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=steven.sistare@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OiFeKzhp;
       spf=pass (google.com: domain of steven.sistare@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=steven.sistare@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced
 by SPARC M7
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
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
        sparclinux@vger.kernel.org, tglx@linutronix.de, thomas.tai@oracle.com,
        tklauser@distanz.ch, tom.hromatka@oracle.com, vegard.nossum@oracle.com,
        vijay.ac.kumar@oracle.com, willy@infradead.org, x86@kernel.org,
        zi.yan@cs.rutgers.edu
References: <cover.1517497017.git.khalid.aziz@oracle.com>
 <87wozwi0p1.fsf@xmission.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <59fb3a0c-0163-0ec2-9757-cc5969601fa7@oracle.com>
Date: Fri, 2 Feb 2018 09:13:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87wozwi0p1.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020176
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223715312130121?=
X-GMAIL-MSGID: =?utf-8?q?1591298888281636905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/1/2018 9:29 PM, ebiederm@xmission.com wrote:
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
> 
> Can you please use force_sig_fault to send these signals instead
> of force_sig_info.  Emperically I have found that it is very
> error prone to generate siginfo's by hand, especially on code
> paths where several different si_codes may apply.  So it helps
> to go through a helper function to ensure the fiddly bits are
> all correct.  AKA the unused bits all need to be set to zero before
> struct siginfo is copied to userspace.
> 
> Eric

The ADI tag can be set at a cacheline (64B) granularity, as opposed
to the per-page granularity of pkeys.  This allows an object allocator
to color each object differently within a page (rounding to 64B boundaries),
such that a pointer overrun bug from one object to the next will cause a
fault.  When pages are paged out, the tags must be saved, hence the
new scheme for storing them.  One tag per vma is too coarse.

The combination of fine granularity and pageability makes for a powerful
memory-reference error-detection framework.

This was discussed in more detail when earlier patches were submitted,
but it's been a while, and the distribution was probably narrower.

Khalid can respond to the sig_fault comment.

- Steve
