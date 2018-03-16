Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsC3oi0aDlLOH7PyfZwKo2A8A3Z7cU12Bo5rvZwdT9D5o5vqpmpFPnS/Li8fiJAEC0cnP38
ARC-Seal: i=1; a=rsa-sha256; t=1521192535; cv=none;
        d=google.com; s=arc-20160816;
        b=Zx5Zgo6akmRAHh1JDccSy0IFJ+y2PF6fzUQO6EFMjTzrgz0vp4xeZ5bEodtWOTmkOS
         +6cAamouSD0qN5TxLStyjNrpw8BlbTdQjviSiRkpxPEzPaxYL8Niq8kX72DwieKc/d7V
         4vFeJn4WB4nHTyq2urh91AMHm50QMa4XsuWYL/CblN8YntfE0zE5hMbRSfX2R/y+2eFQ
         fmvWb70pkKaGb6wfJT+M6GpzYRoWZazIPr035AXE5Fdze3qToKK0JrP2l2MRJA0WkNLV
         bkpVT1W8zNAHLgD2BOaV02L4QBShjuB8nz3ZHqh+5g58ZP64aWKQx1fuiV66WEXsRJcu
         yLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=CF2deXUZQC4hVmLH6Om+jCxiSMS+ZbH8zAyKqPJZ1ww=;
        b=NT4A720Aqm+Kzht5Wnn8ykcuKtwr3l3rKJqc5qg0MIDvCjZhYjkBA2MbtbzxOGcRw1
         XTq5GHxxjv9+7V6Y31tfLVsAhKTKeAl+1yJcA6f3G0tRx7AMxHWqeWU8xSklwiEZ4NPE
         V57L4QGsrLY87SJSuVpp7qxzBsG0k9qPvxrlIOLTnBDGepxPX8sAliqfsLuT3AqDMNea
         +SuuTyWFBT6b1xgQKQgzNapi4bkAWvhzjbP0vhLPd35HM1OK+TXNPNdAg5eVV4RQ492T
         yx6UunpRElXp7MicnZh/eZ0HVrKdFNYACijwCN4+mPyfaNLArh8+pf0Phh9MkBi3On7z
         dMSQ==
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
 <20180315150156.GA19767@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 15:01:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315150156.GA19767@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031609-0020-0000-0000-00000405DDE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031609-0021-0000-0000-00004299E987
Message-Id: <ec30042b-da4b-a02b-ee37-6bd99c179e2b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160115
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595085983807901177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 08:31 PM, Oleg Nesterov wrote:
> On 03/13, Ravi Bangoria wrote:
>> +sdt_update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>> +{
>> +	void *kaddr;
>> +	struct page *page;
>> +	struct vm_area_struct *vma;
>> +	int ret = 0;
>> +	unsigned short orig = 0;
>> +
>> +	if (vaddr == 0)
>> +		return -EINVAL;
>> +
>> +	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
>> +		FOLL_FORCE | FOLL_WRITE, &page, &vma, NULL);
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	kaddr = kmap_atomic(page);
>> +	memcpy(&orig, kaddr + (vaddr & ~PAGE_MASK), sizeof(orig));
>> +	orig += d;
>> +	memcpy(kaddr + (vaddr & ~PAGE_MASK), &orig, sizeof(orig));
>> +	kunmap_atomic(kaddr);
> Hmm. Why memcpy? You could simply do
>
> 	kaddr = kmap_atomic();
> 	unsigned short *ptr = kaddr + (vaddr & ~PAGE_MASK);
> 	*ptr += d;
> 	kunmap_atomic();

Yes, that should work. Will change it.

Thanks for the review,
Ravi
