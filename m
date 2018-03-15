Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELuQ7lOidavcwqM4OSwrVCCPpRoHGn2mAZsCqpwPnTzPLWi4FOMlI0B8I/ucp/Gj0D15A2LE
ARC-Seal: i=1; a=rsa-sha256; t=1521112893; cv=none;
        d=google.com; s=arc-20160816;
        b=0/DqcCj+R4Jnf+R/r7ib/p90rOtex3eNfdM2i+a5T0asd1QxrXCeXuQg/19tU4Ymh6
         s47U3cywIm/54YhUKyd2jDZhY0g6jiPXt6CZms+yuz9DaXRzqsYWyg0qFJq7JzXHr7ro
         S3ApDVS1cD/PybFM7BjvBflstz+SLHpjocfyYfrG7pbX3RXXX++EiMI6BkoXyTtTuxde
         6VMOEzxNO+Y1OUIs/A1xx91u9QcrY/5shmz16IS/VOkyGF5CRKdo0rwEDC3iS+T/iq7y
         1tvxJzh8UBB+RF3MghgL0KKSEjIvYySGYmwof0jsAT2bIdXnXAuiTiXERdEbwQjjx8Tm
         PxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fVqZjI9uQGp3pYO5Wztmznk1dYYb5lTMEqJMnAnByrg=;
        b=Y0Ca89yvZerdZlj11jJkseZyLVDorFSeCcA3RRAkEt23zujC+3FFCyM6Q+AaSP9fgR
         izTxbn6V2iB5GUFI7cjN53qfeFd0N7NUnwJbxfNrYXe/X8+c+ywoCMojHXrSscpJ7KVj
         6KQG/+ZjkC5+DyaHcnBHoge8Djl2fovdA7ro6lcSgwdwNDXSuBCFd2Krc7V1J71sgqwp
         uP1pz82F60jqlbWFFhok22VsiHlVzxBwAUvS0CaaEXFFyUtphZdq5trMgCzXpxY7DDOA
         Diz2snmi5ZNz32QvOk4fF7Q1KyJl9nBufeWAKpJDF50Xq4GSE4x4z0WUNW+x0o3OPThL
         NFKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
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
Date: Thu, 15 Mar 2018 16:53:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314165943.GA5948@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031511-0040-0000-0000-00000441150B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031511-0041-0000-0000-000020E41E7C
Message-Id: <e802ce35-7134-ea12-774b-512546953c47@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150129
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595002473678810030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



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

Hmm... I'm not quite sure. Will rethink and get back to you.

>
>> +static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
>> +{
>> +	struct uprobe_map_info *info;
>> +	struct vm_area_struct *vma;
>> +	unsigned long vaddr;
>> +
>> +	uprobe_start_dup_mmap();
>> +	info = uprobe_build_map_info(tu->inode->i_mapping,
>> +				tu->ref_ctr_offset, false);
> Hmm. This doesn't look right.
>
> If you need to find all mappings (and avoid the races with fork/dup_mmap) you
> need to take this semaphore for writing, uprobe_start_dup_mmap() can't help.

Oops. Yes. Will change it.

Thanks for the review :)
Ravi
