Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELtB8VEIfLIVrygGrd0pbCAq9QG4yyNfMp2l16GOTWpJjSDN1p8kzJ2KhS2AqLirnb4usAyF
ARC-Seal: i=1; a=rsa-sha256; t=1521040225; cv=none;
        d=google.com; s=arc-20160816;
        b=e0tk6sYseZmn/Ee6t2ihcO3TupoJQVBCY7I7/HcD4Lvt1zzaYdpemMi3BeYVZ3K5tf
         s2tPRrECw7uqjzF9y9TFCwQt4DFZucaMaIPuobk9DCQVBW+w0UoYXnfDqFI5OmffO97F
         Rk94taSNOZNEoRXRKXu14MPTFuFbcb891+oyG3QE3B8q2VJtNBT+w1ooXerFIsVCcZWS
         JcpKGxJMISHUPOdHbfeqYTwp6E20rozIEmGUDLYj+PA908tLcZs7CBlfhoUO1rq7/qVf
         v3l/aEZwrkF9SF9YFClHgl8/fp3vmt/+Xd/xRRFcJHLIaHrQFmSTABqCeaRlx0YMuiEy
         CjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bGF2rDxQ06JOZ4hcrEC6ZxOcGT8sJvL4xJ8Lqa8TR2c=;
        b=W5ghTg0fqEW+ztHo+9sgDEj7BzGekKGOOI5qCXiM/nqkw3zRcrOXRKBUIS5kXhDHRV
         38rymLDAGTq+6lYZ4IHqvb9wlQItXTutTh7fO1llq6DpPLFNBkZE44gfCZbth49mCFxa
         l6pes+rr0etoBMsg3ziHRpjaDa0P3dpTzOIAVPJZ9jMi6/114L6sX/9Z1wvi+DwfHbjK
         OllKPSXrvoUfatYi0bp7WVQ2mYKGYJPQFiz2aTFHkiIbp/pzILL9rrc5o5xYByz3TTGg
         k3e1MOB/FF0+48MEGJNp44eR6N6kmxouE48Qd9kWM+gw3wSvyCJxe+jt9lojzOUHvegu
         D+Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: oleg@redhat.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
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
 <20180314224809.5ee4c8834bb366faa398e342@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 20:42:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314224809.5ee4c8834bb366faa398e342@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031415-0008-0000-0000-000004DD6B61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031415-0009-0000-0000-00001E70707E
Message-Id: <fabfad9d-a75e-0b18-1558-ce738b46e538@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1594926276047362324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami,

On 03/14/2018 07:18 PM, Masami Hiramatsu wrote:
> Hi Ravi,
>
> On Tue, 13 Mar 2018 18:26:00 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> Userspace Statically Defined Tracepoints[1] are dtrace style markers
>> inside userspace applications. These markers are added by developer at
>> important places in the code. Each marker source expands to a single
>> nop instruction in the compiled code but there may be additional
>> overhead for computing the marker arguments which expands to couple of
>> instructions. In case the overhead is more, execution of it can be
>> ommited by runtime if() condition when no one is tracing on the marker:
>>
>>     if (reference_counter > 0) {
>>         Execute marker instructions;
>>     }
>>
>> Default value of reference counter is 0. Tracer has to increment the
>> reference counter before tracing on a marker and decrement it when
>> done with the tracing.
>>
>> Implement the reference counter logic in trace_uprobe, leaving core
>> uprobe infrastructure as is, except one new callback from uprobe_mmap()
>> to trace_uprobe.
>>
>> trace_uprobe definition with reference counter will now be:
>>
>>   <path>:<offset>[(ref_ctr_offset)]
> Would you mean 
> <path>:<offset>(<ref_ctr_offset>)
> ?
>
> or use "[]" for delimiter?

[] indicates optional field.

> Since,
>
>> @@ -454,6 +458,26 @@ static int create_trace_uprobe(int argc, char **argv)
>>  		goto fail_address_parse;
>>  	}
>>  
>> +	/* Parse reference counter offset if specified. */
>> +	rctr = strchr(arg, '(');
> This seems you choose "()" for delimiter.

Correct.

>> +	if (rctr) {
>> +		rctr_end = strchr(arg, ')');
> 		rctr_end = strchr(rctr, ')');
>
> ? since we are sure rctr != NULL.

Yes. we can use rctr instead of arg.

>> +		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
>> +			ret = -EINVAL;
>> +			pr_info("Invalid reference counter offset.\n");
>> +			goto fail_address_parse;
>> +		}
>
> Also
>
>> +
>> +		*rctr++ = 0;
>> +		*rctr_end = 0;
> Please consider to use '\0' for nul;

Sure. Will change it.

Thanks for the review :)
Ravi
