Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AG47ELs04jlMlI+VaF7/UVuXIYxVYGnyhdmwtF+9/YBwg1rNtf/5oyxSt2dI5Q55oLzpKflirHQD
ARC-Seal: i=1; a=rsa-sha256; t=1520284835; cv=none;
        d=google.com; s=arc-20160816;
        b=iqDzWpPRdammRkmEZHZAVMbRgtpfFxb6qpyze1qY12IumqHowKIx2ZoiQB83Rj3fU/
         AlSa8nz7F+t0i45RXKLL1SReamzPUg/G0Dk9issrOPS7v3Nz0F9jqySKMexDLj2FRJ9y
         EXAROHtw3+dOe9KJivUqw9o4n+bZn602g1RUk6YaCqWTOMgAocrO/FCrLKYBih+yFNNv
         bDjTvaNb4kEnXnt/lpbUEnIH23d6Qx/TCE7Q34kNzuVEBjZihGSjShRkboyF5n4dSEQS
         sHLNTFWyD/olaMSbqUkUc9kc7gshOgKUgEs0oMUxznC/YiQpleizI3FqswZXy6ir/+eD
         hbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=MolPSDfS403T0RrSU7LEx6mK0RI1L49XN8lxBKQouNo=;
        b=gczWxBetPjVo9u5nfSRvvh2iyZIqSKQ+Tc5P49eeZpSTKhytzGYeSZCcEPTIDeDsiT
         584PUznT401g9sziXfkLaumSfQEvXQqfSSfRu6hVCRrNZPRwBSRLof2jw3uSIRTGCiYm
         GzKE37lPJzoHmB959nNALviDtoqRpT2OzRSK7RluGHI3vmkOOvXWDDlfKveP1SDPygG5
         a/ELdkC9EUHy5howp0c3N5ybZfqa3fwoagiwQQOnazdrNWQ4tpjfSxzS0NziDkhKV8KB
         g8Ujm+z4gUPcDCPR7VjgAYfgmif3hWj/ZNiVLe1e8z4sstcEvefnk9ITHyNtlSF9LYWs
         EbrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qC8N4zr1;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qC8N4zr1;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
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
 <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <84931753-9a84-8624-adb8-95bd05d87d56@oracle.com>
Date: Mon, 5 Mar 2018 14:14:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=973
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050243
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594134191456715102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 12:22 PM, Dave Hansen wrote:
> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>> +#define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
>> +static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>> +{
>> +	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>> +		return 0;
>> +	if (prot & PROT_ADI) {
>> +		if (!adi_capable())
>> +			return 0;
>> +
>> +		if (addr) {
>> +			struct vm_area_struct *vma;
>> +
>> +			vma = find_vma(current->mm, addr);
>> +			if (vma) {
>> +				/* ADI can not be enabled on PFN
>> +				 * mapped pages
>> +				 */
>> +				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> +					return 0;
> 
> You don't hold mmap_sem here.  How can this work?
>

Are you suggesting that vma returned by find_vma() could be split or 
merged underneath me if I do not hold mmap_sem and thus make the flag 
check invalid? If so, that is a good point.

Thanks,
Khalid
