Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELuofVIf3TY6h2/r3mibERRu5pP7jySrJIH3azXanvUMNEcqQNTH+RDsn4ml/m+yHK8Szlyt
ARC-Seal: i=1; a=rsa-sha256; t=1521190493; cv=none;
        d=google.com; s=arc-20160816;
        b=TxOZw0Qf6dbrnV29bwU+xNI90e6OKHO+m3ySGFTEIVe5x2kQUTXYmvvWMjArltYzeH
         MCHpRBckAxRV7jgALdVUFM9BqGrMNg7hJs2nCyb1/YRH7NlPgPEroza6TUtC0619jJzt
         UfuAI6cAsODK2CW8JhJFs0aphHYG0tY7BcHpdcHJ6mx4jLHzhDGTuC3nDTyG77Zp4REe
         LH0gA9IylTI9gVXEwVug8CxPkT6vvVXqwdG9b4SER3XuSSVrTFpmTT3/3gW/7pAemeby
         SIqqTvyzTBNuiYHB07uynIc6PblTCGfBH9OLC3R4+UBiWv+b4nKEgx4IN9Tstt1qNQMq
         XYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=6D3JB8vfiH0wrz8ssy8ASzWr/Ff1U9M1qHul9qfSFjc=;
        b=PbRpV62mzzgYmAL8I4G5Z0lp1aFqbTnjs1Mc7kwhl/07NiyX6HGdiuM/FRhsZP/eB+
         NZDjUX5N60PhBj4CT74CMmv8Zp1skqMgwwR6RjhK7Flb0izkjMt3V1qJWj1EuHDE3+Uy
         rojwWVCILKWhTNBtpO2Xg61buIx2eTXQ5pqCvsZw3QoCUGTvWqgXVcawzkyIimLDnpTK
         SpvA+2DrjM04UC3FnvTOZWTtzT+8iZ8JfhNgaZgqVuEnj4J6KbW9AqU+kzWXJT1EWOU/
         tia/ZDYiXRHfX6b+jgROCfKQtpd9iWEhP8fM9lxTfAfetrmHUjqtvhLqSg+oVqYCTU4m
         HtCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/8] Uprobe: Rename map_info to uprobe_map_info
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, huawei.libin@huawei.com, hughd@google.com,
        jack@suse.cz, jglisse@redhat.com, jolsa@redhat.com,
        kan.liang@intel.com, kirill.shutemov@linux.intel.com,
        kjlx@templeofstupid.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, milian.wolff@kdab.com,
        mingo@redhat.com, namhyung@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        pc@us.ibm.com, pombredanne@nexb.com, tglx@linutronix.de,
        tmricht@linux.vnet.ibm.com, willy@infradead.org,
        yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180315124449.7d92c06b@vmware.local.home>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:26:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315124449.7d92c06b@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031608-0020-0000-0000-00000405D970
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031608-0021-0000-0000-00004299E4F1
Message-Id: <e8d9fc29-62b2-95eb-d868-42df26c3212e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160110
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827147158689995?=
X-GMAIL-MSGID: =?utf-8?q?1595083842745062291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 10:14 PM, Steven Rostedt wrote:
> On Tue, 13 Mar 2018 18:25:58 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>> -static inline struct map_info *free_map_info(struct map_info *info)
>> +static inline struct uprobe_map_info *
>> +uprobe_free_map_info(struct uprobe_map_info *info)
>>  {
>> -	struct map_info *next = info->next;
>> +	struct uprobe_map_info *next = info->next;
>>  	kfree(info);
>>  	return next;
>>  }
>>  
>> -static struct map_info *
>> -build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
>> +static struct uprobe_map_info *
>> +uprobe_build_map_info(struct address_space *mapping, loff_t offset,
> Also, as these functions have side effects (like you need to perform a
> mmput(info->mm), you need to add kerneldoc type comments to these
> functions, explaining how to use them.
>
> When you upgrade a function from static to use cases outside the file,
> it requires documenting that function for future users.

Sure, will add a comment here.

Thanks for the review,
Ravi
