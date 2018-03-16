Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELt4plLPJRnmLWkwp0tJipH9cng/yKZ6s1fWveoU9WDOhm0fnrOhJMOnbnPDtyiE2eJDYoyE
ARC-Seal: i=1; a=rsa-sha256; t=1521192101; cv=none;
        d=google.com; s=arc-20160816;
        b=mL7k1OvM/yKTgZaKY4RepZLxjmfLY+TKrVsj7J63gHqbCzI9lFCC3wT0b1E/d7ZPen
         R5kDUIJSWv47y3hKTJxYf2rgXrnOn5zVMY2xvMrcVWchdBEV9rcYRYLJ+VKUWKmseXEv
         k/pwD2aHGLiA3UX8Arn4FYCFbePWI9zabz9DmQd4QqPiOMAMdx3N9hVKvFfmuFhSltft
         WH7VSq+VJybmK1oycoj0nWuJjSg2GoKwX7/winwFhxXFtMGD5h7KByZykVSElDbXVNgR
         HFHZ/KiYkmiqMau/1zjMhHrehhlZd6xlsdFquDrwjwTkpHejoNJXoebvOhg5nMs0VI3o
         xAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=l6ioP42jvsOFvJmlvsLlrdjrZnsFtNJOkW6YKVjVnC4=;
        b=c+IoMHII3rkqJsTAcT2FoH8zja8pLtChHAZhcUAHTlWcFDnaJo4BwkArYkk3QbTAz4
         fA68qpiCMUGL8tvAwZ3ITyGN4N3Hb0TbNxlkpcGQ7Gl4rZZkZK3Gscng0S9Zn9tHgops
         kNAjvfzBu6SC01baBsrjp8AjPKk+iTW7uRyu04VRdNByYt5V+8ePyHTdlb0LVTjgwj7k
         JP7MX+jilqKYtlSIGcoMWTsgexVQsmVreQcCbqcrS8D04buYhC1WKKnM9h4H4FqolEnJ
         38W2REnm6Q+uNoA5nltTkYGl/EX56N6jqlkWxJGMW7FKBw5jAJn/h8mP8sbEA0rOm3te
         pZdQ==
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
 <20180315142120.GA19218@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:51:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315142120.GA19218@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031609-0020-0000-0000-00000405DCA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031609-0021-0000-0000-00004299E842
Message-Id: <56ae982d-2fbf-09c4-989b-57bce5a1cb04@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160114
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595085529397175942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 07:51 PM, Oleg Nesterov wrote:
> On 03/13, Ravi Bangoria wrote:
>> @@ -1053,6 +1056,9 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>  	struct uprobe *uprobe, *u;
>>  	struct inode *inode;
>>
>> +	if (uprobe_mmap_callback)
>> +		uprobe_mmap_callback(vma);
>> +
>>  	if (no_uprobe_events() || !valid_vma(vma, true))
>>  		return 0;
> probe_event_enable() does
>
> 	uprobe_register();
> 	/* WINDOW */
> 	sdt_increment_ref_ctr();
>
> what if uprobe_mmap() is called in between? The counter(s) in this vma
> will be incremented twice, no?

I guess, it's a valid issue with PATCH 5 but should be taken care by PATCH 6.

>
>> +static struct vm_area_struct *
>> +sdt_find_vma(struct mm_struct *mm, struct trace_uprobe *tu)
>> +{
>> +	struct vm_area_struct *tmp;
>> +
>> +	for (tmp = mm->mmap; tmp != NULL; tmp = tmp->vm_next)
>> +		if (sdt_valid_vma(tu, tmp))
>> +			return tmp;
>> +
>> +	return NULL;
> I can't understand the logic... Lets ignore sdt_valid_vma() for now.
> The caller has uprobe_map_info, why it can't simply do
> vma = find_vma(uprobe_map_info->vaddr)? and then check sdt_valid_vma().

Yes. that should work. Will change it.

Thanks for the review,
Ravi
