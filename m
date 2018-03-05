Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AG47ELsG7ObR3zD6DqS5FxRFsbqYDGhRWeZFD2kyJ0/3xQ1l3O9L5eu3YJXoul3mtJ3+jIR4E9c/
ARC-Seal: i=1; a=rsa-sha256; t=1520286188; cv=none;
        d=google.com; s=arc-20160816;
        b=Y8aleutjSSTWL+YXCyT9web2dvXxU1610Gs7zoEiT1Q+xj8ceXdbdqObg3Jt4RMgC2
         +KRKrcMdkxQaWLFTS5mKoyG3SkqTHUYH6LpGs29EHZtEzIgI8RaWiwA+35ljpPbKAqzg
         6tI2S78D4ViIvpTgeDjsu+CEByhELaCL/Awm8500Uk3SNa1OQxsvjdiE6IoS1noTHpUR
         LslvuqA44YFh9jlo23CajCrp/PDS7kp2tZChoXKVJJsGiKQHJVAKHDSQhl8AuIW6iQeN
         Keebqg2svh+1gVw19wyMe7RNkwv6WuXUrd4OTT4luQ+HvsaW4ucoxfJTT/tJGW2zkxLI
         5isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=zkbCMJDLPLQoDizzaJ4h33qsF4WO/bPfUGNByg+HeWs=;
        b=Qd/IByqef1VQK+uWuNnAPhEcxWtZzzg4qIw+nIL/r0sD5EUlSew6+J1lYfJVDgYkoW
         dLOvCJp0c8WJx9T6AiO8qt1YhJzCY7dsSJpzJiN5YoKQ3kU/EI/Ms9QddTLN8Zz5juC8
         vS7BlA09B2NHz5DyUhsLKiwmI9rX3T+wMqYgLFeVoHou24/1hu0nPaJBhdRqrH/9Vff3
         8zF+sTU1Z67P/cjiABiXWqLmdPixEqOF/zCp+dzRaCjde48OSrJ+VIlbJX8MY2SX21Mi
         AaJkIqeEBju/+09Iicc8Ga22/Dd+sSnFKLWHixywWkT/VEj/lzbjv9jRm/IJ6lsvLSIx
         1vSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=go1AewbW;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=go1AewbW;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: Dave Hansen <dave.hansen@linux.intel.com>, davem@davemloft.net,
        akpm@linux-foundation.org
Cc: corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com,
        pasha.tatashin@oracle.com, mike.kravetz@oracle.com,
        rob.gardner@oracle.com, mingo@kernel.org, nitin.m.gupta@oracle.com,
        anthony.yznaga@oracle.com, kirill.shutemov@linux.intel.com,
        tom.hromatka@oracle.com, allen.pais@oracle.com, tklauser@distanz.ch,
        shannon.nelson@oracle.com, vijay.ac.kumar@oracle.com, mhocko@suse.com,
        jack@suse.cz, punit.agrawal@arm.com, hughd@google.com,
        thomas.tai@oracle.com, ross.zwisler@linux.intel.com,
        dave.jiang@intel.com, willy@infradead.org, minchan@kernel.org,
        imbrenda@linux.vnet.ibm.com, aarcange@redhat.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com,
        linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com,
        jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <b241c894-7751-bd01-2658-4cb6b89f7454@oracle.com>
Date: Mon, 5 Mar 2018 14:37:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050248
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594135610724581248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 02:26 PM, Dave Hansen wrote:
> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>> +tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
>> +				    struct vm_area_struct *vma,
>> +				    unsigned long addr)
> ...
>> +	tags = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
>> +	if (tags == NULL) {
>> +		tag_desc->tag_users = 0;
>> +		tag_desc = NULL;
>> +		goto out;
>> +	}
>> +	tag_desc->start = addr;
>> +	tag_desc->tags = tags;
>> +	tag_desc->end = end_addr;
>> +
>> +out:
>> +	spin_unlock_irqrestore(&mm->context.tag_lock, flags);
>> +	return tag_desc;
>> +}
> 
> OK, sorry, I missed this.  I do see that you now have per-ADI-block tag
> storage and it is not per-page.
> 
> How big can this storage get, btw?  Superficially it seems like it might
> be able to be gigantic for a large, sparse VMA.
> 

Tags are stored only for the pages being swapped out, not for the pages 
in entire vma. Each tag storage page can hold tags for 128 pages (each 
page has 128 4-bit tags, hence 64 bytes are needed to store tags for an 
entire page allowing each page to store tags for 128 pages). Sparse VMA 
does not cause any problems since holes do not have corresponding pages 
that will be swapped out. Tag storage pages are freed once all the pages 
they store tags for have been swapped back in, except for a small number 
of pages (maximum of 8) marked for emergency tag storage.

--
Khalid
