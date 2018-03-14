Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsJIArwgrFd3/UMoA2AkTzndgQU6Nbof3zoESsL1aQ4KrJm2pofSfcO0k3gETQS1RsHlsB/
ARC-Seal: i=1; a=rsa-sha256; t=1521040772; cv=none;
        d=google.com; s=arc-20160816;
        b=WezHMm8izvY+zjPeKgZffqkhy/L5ah1k2Fe3tTG3L2h3/8sIoRIxrpVbdqjhnZ2SO6
         c7cWOiwL3lrzVW0LV6jxR7dsnKYRffbc/iQ2oYROBKc4JaGeGfVKLcK23jMbuk3O2978
         /gyjCFcBeemLq83qwNy7qs5ROzfLT81HVOzGa6zWZx4MdMSR1ukJwT6VwGGZ3vfe29tW
         ZwC5lDRRVwow/7/pKKDpzYwXq2E70uX9NFNd8vrHG55pWLfZiff7xanp+TMZ2zgqEPtS
         n4LW0fQFOL7lVdAlwUcUCGbaPqWyzIdPiQlc/3IB7SsVFF258qPzfjQMlu7iuooy+Lnu
         91FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+i1Wt4CvyAglQoccKHAAuxJrWRDfABltcuaqDxwJOzI=;
        b=SRyXcFJYvkxMq2I96J/Qc0R7ypWq1MnRzMo670rRcr2d3te7UKM/i8I2jHkirhE8eA
         GJfgtSmLBUl3Oght01YpiYuUsJ+NBAkBIGIWzG2hL7wXkXqlulynf21pq1Hm6f/xhNSo
         40HSywe+l10SHTwh57eO0LR8N2rSbrZR/SOkouEPiu4KAHWN5FWtfaydtkWmQ4No0Uco
         GQ3QS9Vnwqg5mHtOG8AeLE2Tq+pZpAn42Iz+LVcx+GSL28zLNWjAoa9u1ziMOzmLwiaF
         CVM19I3g8FqhNeEuHKqHfx9PruNpvG6YfHQU/1Kkrw3LgndOBCwjirZbPcX2hc8Vn6QA
         NgLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 7/8] perf probe: Support SDT markers having reference
 counter (semaphore)
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
 <20180313125603.19819-8-ravi.bangoria@linux.vnet.ibm.com>
 <20180314230909.52963a161210294ea2fc0420@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 20:51:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314230909.52963a161210294ea2fc0420@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031415-0020-0000-0000-000004046E72
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031415-0021-0000-0000-00004298730E
Message-Id: <60a29e08-c4a4-4f9e-aca1-8dafdd064956@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827200789621673?=
X-GMAIL-MSGID: =?utf-8?q?1594926848992847137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/14/2018 07:39 PM, Masami Hiramatsu wrote:
> Hi Ravi,
>
> This code logic looks good. I just have several small comments for style.
>
> On Tue, 13 Mar 2018 18:26:02 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
>> index e1dbc98..2cbe68a 100644
>> --- a/tools/perf/util/probe-event.c
>> +++ b/tools/perf/util/probe-event.c
>> @@ -1832,6 +1832,12 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
>>  			tp->offset = strtoul(fmt2_str, NULL, 10);
>>  	}
>>  
>> +	if (tev->uprobes) {
>> +		fmt2_str = strchr(p, '(');
>> +		if (fmt2_str)
>> +			tp->ref_ctr_offset = strtoul(fmt2_str + 1, NULL, 0);
>> +	}
>> +
>>  	tev->nargs = argc - 2;
>>  	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
>>  	if (tev->args == NULL) {
>> @@ -2054,15 +2060,22 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
>>  	}
>>  
>>  	/* Use the tp->address for uprobes */
>> -	if (tev->uprobes)
>> -		err = strbuf_addf(&buf, "%s:0x%lx", tp->module, tp->address);
>> -	else if (!strncmp(tp->symbol, "0x", 2))
>> +	if (tev->uprobes) {
>> +		if (tp->ref_ctr_offset)
>> +			err = strbuf_addf(&buf, "%s:0x%lx(0x%lx)", tp->module,
>> +					  tp->address, tp->ref_ctr_offset);
>> +		else
>> +			err = strbuf_addf(&buf, "%s:0x%lx", tp->module,
>> +					  tp->address);
>> +	} else if (!strncmp(tp->symbol, "0x", 2)) {
>>  		/* Absolute address. See try_to_find_absolute_address() */
>>  		err = strbuf_addf(&buf, "%s%s0x%lx", tp->module ?: "",
>>  				  tp->module ? ":" : "", tp->address);
>> -	else
>> +	} else {
>>  		err = strbuf_addf(&buf, "%s%s%s+%lu", tp->module ?: "",
>>  				tp->module ? ":" : "", tp->symbol, tp->offset);
>> +	}
> What the purpose of this {}?

The starting if has multiple statements and thus it needs braces. So I added
braces is all other conditions.

>> +
>>  	if (err)
>>  		goto error;
>>  
>> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
>> index 45b14f0..15a98c3 100644
>> --- a/tools/perf/util/probe-event.h
>> +++ b/tools/perf/util/probe-event.h
>> @@ -27,6 +27,7 @@ struct probe_trace_point {
>>  	char		*symbol;	/* Base symbol */
>>  	char		*module;	/* Module name */
>>  	unsigned long	offset;		/* Offset from symbol */
>> +	unsigned long	ref_ctr_offset;	/* SDT reference counter offset */
>>  	unsigned long	address;	/* Actual address of the trace point */
>>  	bool		retprobe;	/* Return probe flag */
>>  };
>> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
>> index 4ae1123..08ba3a6 100644
>> --- a/tools/perf/util/probe-file.c
>> +++ b/tools/perf/util/probe-file.c
>> @@ -701,6 +701,12 @@ static unsigned long long sdt_note__get_addr(struct sdt_note *note)
>>  		 : (unsigned long long)note->addr.a64[0];
>>  }
>>  
>> +static unsigned long long sdt_note__get_ref_ctr_offset(struct sdt_note *note)
>> +{
>> +	return note->bit32 ? (unsigned long long)note->addr.a32[2]
>> +		: (unsigned long long)note->addr.a64[2];
>> +}
> Could you please introduce an enum for specifying the index by name?
>
> e.g.
> enum {
> 	SDT_NOTE_IDX_ADDR = 0,
> 	SDT_NOTE_IDX_REFCTR = 2,
> };

That will be good. Will change it.

>> +
>>  static const char * const type_to_suffix[] = {
>>  	":s64", "", "", "", ":s32", "", ":s16", ":s8",
>>  	"", ":u8", ":u16", "", ":u32", "", "", "", ":u64"
>> @@ -776,14 +782,24 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>>  {
>>  	struct strbuf buf;
>>  	char *ret = NULL, **args;
>> -	int i, args_count;
>> +	int i, args_count, err;
>> +	unsigned long long ref_ctr_offset;
>>  
>>  	if (strbuf_init(&buf, 32) < 0)
>>  		return NULL;
>>  
>> -	if (strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
>> +	ref_ctr_offset = sdt_note__get_ref_ctr_offset(note);
>> +
>> +	if (ref_ctr_offset)
>> +		err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx(0x%llx)",
>>  				sdtgrp, note->name, pathname,
>> -				sdt_note__get_addr(note)) < 0)
>> +				sdt_note__get_addr(note), ref_ctr_offset);
>> +	else
>> +		err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
>> +				sdtgrp, note->name, pathname,
>> +				sdt_note__get_addr(note));
> This can be minimized (and avoid repeating) by using 2 strbuf_addf()s, like
>
> 	err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
> 			sdtgrp, note->name, pathname,
> 			sdt_note__get_addr(note));
> 	if (ref_ctr_offset && !err < 0)
> 		err = strbuf_addf("(0x%llx)", ref_ctr_offset);

Sure. Will change it.

>
>> +
>> +	if (err < 0)
>>  		goto error;
>>  
>>  	if (!note->args)
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 2de7705..76c7b54 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -1928,6 +1928,16 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
>>  		}
>>  	}
>>  
>> +	/* Adjust reference counter offset */
>> +	if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_PROBES_SCN, NULL)) {
>> +		if (shdr.sh_offset) {
>> +			if (tmp->bit32)
>> +				tmp->addr.a32[2] -= (shdr.sh_addr - shdr.sh_offset);
>> +			else
>> +				tmp->addr.a64[2] -= (shdr.sh_addr - shdr.sh_offset);
> Here we should use enum above too.

Sure.

Thanks for the review :)
Ravi
