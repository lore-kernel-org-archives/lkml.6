Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AG47ELvSQGheNK7IiHwQVs32Pseise1PsPWZpc2mB/prm7C0he/SWFkNyvSw8ebw+27Hd4uifMuv
ARC-Seal: i=1; a=rsa-sha256; t=1520290568; cv=none;
        d=google.com; s=arc-20160816;
        b=gWEEkzTFPQsTZVwiH2rOyUtdW3VGkoCjM0p2jCP8RqfElKh4uKW7SuKK968l7+56zc
         hdADuuR8bt6VM/Y3EknerxfhiR4qk8eqGn1Km2nYqKD6EiFwKdNGZyZ25ub7tjrnuQip
         v2Y6k2p6wIVC3NmDplWq1Nk7A2JeCN3E41CyPvUPEiaoHMqz1eCyJ8KjlTGHjp2RSVFG
         maxrUk6jwe/IGGozOYYqxEkbipDbSHW5sGWQRB8/HAK5Va8SnUU1rRMlMYk9osaWX7P2
         yL4y0tZuvTg0wZOrgsAmuP32gONyA5bwFD6Ei4in/A5wVxvbh+8R9a+Q411SLKVaxtDE
         XBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=Ln22tMs8xb8ENpuiVbMbmg77nceMSQboGN5t913OGPo=;
        b=BHq0PzKoGZZWzsEucxocwGdEEEXS1OyzNmq3cNuYDLaRKzU9CvLhqEfV3Ex/FjZns8
         tVJJ84xe34CdgSommQlR182+NzMSfpwY918GBK4QPVlabp+DfaI9g8HqrBWF7Jo9B6ZW
         mrnPPZPuuT8OdbBTze/IT++ryNWONb0iQ+CtFn5NTh+a+qGUoRLSOAnv6R6UTCCK4Wax
         ukxpb3BZiH4EO2lNbpe8uCoCgUHi88twOtN6Ojs6/sY50xMTeCFmietz/Ejg32qFv4Ny
         Tlp02nIOVwuQrlK9qDVz3VcVCh5vz1QTMO/I7HEi1/WgUeRKqyQfvqIzCWOIswwuvY9x
         OhDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=dLyOWoJK;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=dLyOWoJK;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: Dave Hansen <dave.hansen@linux.intel.com>, davem@davemloft.net,
        akpm@linux-foundation.org
Cc: corbet@lwn.net, steven.sistare@oracle.com, pasha.tatashin@oracle.com,
        mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org,
        nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com,
        kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com,
        allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com,
        vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz,
        punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com,
        ross.zwisler@linux.intel.com, dave.jiang@intel.com,
        willy@infradead.org, minchan@kernel.org, imbrenda@linux.vnet.ibm.com,
        aarcange@redhat.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org,
        nagarathnam.muthusamy@oracle.com, linux@roeck-us.net,
        jane.chu@oracle.com, dan.j.williams@intel.com, jglisse@redhat.com,
        ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
 <84931753-9a84-8624-adb8-95bd05d87d56@oracle.com>
 <8b0edd2e-3e9b-1148-6309-38b61307a523@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <fabf221c-02e2-f968-d107-b028701dd837@oracle.com>
Date: Mon, 5 Mar 2018 15:55:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <8b0edd2e-3e9b-1148-6309-38b61307a523@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050260
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594140203226792679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 02:31 PM, Dave Hansen wrote:
> On 03/05/2018 01:14 PM, Khalid Aziz wrote:
>> Are you suggesting that vma returned by find_vma() could be split or
>> merged underneath me if I do not hold mmap_sem and thus make the flag
>> check invalid? If so, that is a good point.
> 
> This part does make me think that this code hasn't been tested very
> thoroughly.  Could you describe the testing that you have done?  For MPX
> and protection keys, I added something to tools/testing/selftests/x86,
> for instance.

This code was tested by a QA team and I ran a number of tests myself. I 
wrote tests to exercise all of the API, induce exceptions for 
invalid/illegal accesses and swapping was tested by allocating memory 
2-4 times of the system RAM available across 4-8 threads and 
reading/writing to this memory with ADI enabled. QA team wrote unit 
tests to test each API with valid and invalid combinations of arguments 
to the API. Stress tests that allocate and free ADI tagged memory were 
also run. A version of database server was created that uses ADI tagged 
memory for in-memory copy of database to test database workload. 100's 
of hours of tests were run across these tests over the last 1+ year 
these patches have been under review for. Cover letter includes 
description of most of these tests. This code has held up through all of 
these tests. It is entirely feasible some race conditions have not been 
uncovered yet, just like any other piece of software. Pulling this code 
into mainline kernel and having lot more people exercise this code will 
help shake out any remaining issues.

Thanks,
Khalid
