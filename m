Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELv0yWE3vF9KViktp06qAWX83MyvQ90mBg94A1uYM0DtOXb28Wc+GjHca63VieE6svznoByt
ARC-Seal: i=1; a=rsa-sha256; t=1521433585; cv=none;
        d=google.com; s=arc-20160816;
        b=bQLbGvm1ZW9HNUn7WzUZai14Fl5XMR+/sjBaDLNDL+dfWm6qbIk7Aw1AoyIdLJ0o5r
         J/jeP/Nmjm+CiSzx/9ahG1V/xiKbeBEgEeEpU57vvBfWSIhU3aMpP50JtJ8YLHa9s95t
         M92kGg6mmsxOIeG082GyCMf7uT+Wg83mJahiJMXZiFjgRMpVFZy/HGApkcjPQW5KFiAX
         6kgi2i27a8WUGQdDvIxDvDZx50JoJt6TkLB6afnGlPbDcSFqFxXxUQ0GJgejro3mtVra
         b7SC8Tx0Z9KwUWdp+2u43SCYvQVn5UbFsgiRb8t9eGAczuxSPsuDgpDz4Lj2rKZZ8Bpf
         xE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=e+D1JS9V4PZV2gBAcATLL+nKHg8kvq3ra5978pfMNyk=;
        b=hL8ailv6C66jJ6kr7CdvMsf17Q9vd3ABfo9QHautCS4QwXpZRj9xAiz2EitSxxIWXf
         yRnKVpCdT+26BL2qelYtaynIEXEK24dXaWAcmGvPZbUhpYnjcl0KfUfiKAuQOJ1O+2tx
         fT/pDvVJoWomfY8jXyRFd24sEG3k9hZFn9+3XADZrmcay01s4Q9NAZqp3W0TWfTOC51p
         wrFap7Uvv2L/VZ/W328ZEAdZEYsnKdxW4f4S5SE/6F4Gwd+XsmMU0wJX/cvsD9AybIVy
         IeCRrbGDzos1hEjRqXtUaSYeOSdyaK1BxaV1GaoTa7k+srtziaXJ+kEJ97+svNEeXzeJ
         /Z9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
To: Oleg Nesterov <oleg@redhat.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180314165943.GA5948@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 19 Mar 2018 09:58:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314165943.GA5948@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031904-0012-0000-0000-000005C0A229
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031904-0013-0000-0000-0000193CB7BE
Message-Id: <9cb068f7-0996-6e24-a95b-771006559318@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803190055
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595338743357537770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oleg,

On 03/14/2018 10:29 PM, Oleg Nesterov wrote:
> On 03/13, Ravi Bangoria wrote:
>> +static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
>> +{
>> +	unsigned long vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
>> +
>> +	return tu->ref_ctr_offset &&
>> +		vma->vm_file &&
>> +		file_inode(vma->vm_file) == tu->inode &&
>> +		vma->vm_flags & VM_WRITE &&
>> +		vma->vm_start <= vaddr &&
>> +		vma->vm_end > vaddr;
>> +}
> Perhaps in this case a simple
>
> 		ref_ctr_offset < vma->vm_end - vma->vm_start
>
> check without vma_offset_to_vaddr() makes more sense, but I won't insist.
>

I still don't get this. This seems a comparison between file offset and size
of the vma. Shouldn't we need to consider pg_off here?

Thanks,
Ravi
