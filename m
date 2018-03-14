Return-Path: <mhiramat@kernel.org>
X-Google-Smtp-Source: AG47ELttOIYwr+nY/3D8ZPPujZVHpKvHcmTpRumHrm/x9tsT9QhHD1PhOejdKNJcazmY/yoGHfyN
ARC-Seal: i=1; a=rsa-sha256; t=1521036555; cv=none;
        d=google.com; s=arc-20160816;
        b=Ht8B0uENK2MZ42M5/0vbkJfplI4KJvdKFwizqOoI5MQ+/qKOVgXpl7l8g5078j0jNe
         3dMGvJeB3iGswAKOl9pr8c9eCHEsoyGLMlzRzS6iP2FJ3UxmKPOglZJ/mvwVitIbS1BQ
         8dlJlI2wuT4tD6GT3qE7Sdhe1nyp30xmo/Otg3mhGv+duRMbSOI1pO/J0WYZJC8Gj1hc
         Yb/KBAqb4od4UxHFwQtT4WVEl9iK3YNke5/PivvQlPMcPbSo99tLHLX0RL4qBdvgwUkF
         ELYpHdpSrmQs9Wxn1Ee47+ux/WchI/NZOS6bqetCPUvPO3oa8PkkxmdoTzfB9OTScZRO
         00LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=6a85RVUenE7kz+30DFisSy/yVmP8rAHCWel4nvW40Ww=;
        b=qIVhR44adCQF2GWRJsARntR4CQqNOpQYEiD5q05kH9Sz1VOl76SULKTsowatAjiwW3
         g8v89MYX1BroAexyPaSwTd243BZhPOYZz3KLysq6IFyHgOSruzbk+qBqkkFsIwl0WuiE
         qeaQJBI5kE7sTTcz1usc/RMwLIlmhMxrD7JogT2BQ1r4FY2qub7Nzs7mGlSPwwzQZOkC
         zzhQXhLEqZV/EeE3oZwnUFvtmRBktLxAWP03aIk4zXCSYxe5cG9DGztamC8YTHHOXepi
         bwbR32ghFIlXdm6HeXABy6q9FaB+aqvSXf+Yk5EGDMlANPHZulWubMo+EDLEiLIW9Fl8
         rjRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80752214D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 14 Mar 2018 23:09:09 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
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
 willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 7/8] perf probe: Support SDT markers having reference
 counter (semaphore)
Message-Id: <20180314230909.52963a161210294ea2fc0420@kernel.org>
In-Reply-To: <20180313125603.19819-8-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-8-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827200789621673?=
X-GMAIL-MSGID: =?utf-8?q?1594922427913657951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ravi,

This code logic looks good. I just have several small comments for style.

On Tue, 13 Mar 2018 18:26:02 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index e1dbc98..2cbe68a 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1832,6 +1832,12 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
>  			tp->offset = strtoul(fmt2_str, NULL, 10);
>  	}
>  
> +	if (tev->uprobes) {
> +		fmt2_str = strchr(p, '(');
> +		if (fmt2_str)
> +			tp->ref_ctr_offset = strtoul(fmt2_str + 1, NULL, 0);
> +	}
> +
>  	tev->nargs = argc - 2;
>  	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
>  	if (tev->args == NULL) {
> @@ -2054,15 +2060,22 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
>  	}
>  
>  	/* Use the tp->address for uprobes */
> -	if (tev->uprobes)
> -		err = strbuf_addf(&buf, "%s:0x%lx", tp->module, tp->address);
> -	else if (!strncmp(tp->symbol, "0x", 2))
> +	if (tev->uprobes) {
> +		if (tp->ref_ctr_offset)
> +			err = strbuf_addf(&buf, "%s:0x%lx(0x%lx)", tp->module,
> +					  tp->address, tp->ref_ctr_offset);
> +		else
> +			err = strbuf_addf(&buf, "%s:0x%lx", tp->module,
> +					  tp->address);
> +	} else if (!strncmp(tp->symbol, "0x", 2)) {
>  		/* Absolute address. See try_to_find_absolute_address() */
>  		err = strbuf_addf(&buf, "%s%s0x%lx", tp->module ?: "",
>  				  tp->module ? ":" : "", tp->address);
> -	else
> +	} else {
>  		err = strbuf_addf(&buf, "%s%s%s+%lu", tp->module ?: "",
>  				tp->module ? ":" : "", tp->symbol, tp->offset);
> +	}

What the purpose of this {}?

> +
>  	if (err)
>  		goto error;
>  
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 45b14f0..15a98c3 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -27,6 +27,7 @@ struct probe_trace_point {
>  	char		*symbol;	/* Base symbol */
>  	char		*module;	/* Module name */
>  	unsigned long	offset;		/* Offset from symbol */
> +	unsigned long	ref_ctr_offset;	/* SDT reference counter offset */
>  	unsigned long	address;	/* Actual address of the trace point */
>  	bool		retprobe;	/* Return probe flag */
>  };
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 4ae1123..08ba3a6 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -701,6 +701,12 @@ static unsigned long long sdt_note__get_addr(struct sdt_note *note)
>  		 : (unsigned long long)note->addr.a64[0];
>  }
>  
> +static unsigned long long sdt_note__get_ref_ctr_offset(struct sdt_note *note)
> +{
> +	return note->bit32 ? (unsigned long long)note->addr.a32[2]
> +		: (unsigned long long)note->addr.a64[2];
> +}

Could you please introduce an enum for specifying the index by name?

e.g.
enum {
	SDT_NOTE_IDX_ADDR = 0,
	SDT_NOTE_IDX_REFCTR = 2,
};

> +
>  static const char * const type_to_suffix[] = {
>  	":s64", "", "", "", ":s32", "", ":s16", ":s8",
>  	"", ":u8", ":u16", "", ":u32", "", "", "", ":u64"
> @@ -776,14 +782,24 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>  {
>  	struct strbuf buf;
>  	char *ret = NULL, **args;
> -	int i, args_count;
> +	int i, args_count, err;
> +	unsigned long long ref_ctr_offset;
>  
>  	if (strbuf_init(&buf, 32) < 0)
>  		return NULL;
>  
> -	if (strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
> +	ref_ctr_offset = sdt_note__get_ref_ctr_offset(note);
> +
> +	if (ref_ctr_offset)
> +		err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx(0x%llx)",
>  				sdtgrp, note->name, pathname,
> -				sdt_note__get_addr(note)) < 0)
> +				sdt_note__get_addr(note), ref_ctr_offset);
> +	else
> +		err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
> +				sdtgrp, note->name, pathname,
> +				sdt_note__get_addr(note));

This can be minimized (and avoid repeating) by using 2 strbuf_addf()s, like

	err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
			sdtgrp, note->name, pathname,
			sdt_note__get_addr(note));
	if (ref_ctr_offset && !err < 0)
		err = strbuf_addf("(0x%llx)", ref_ctr_offset);


> +
> +	if (err < 0)
>  		goto error;
>  
>  	if (!note->args)
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 2de7705..76c7b54 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1928,6 +1928,16 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
>  		}
>  	}
>  
> +	/* Adjust reference counter offset */
> +	if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_PROBES_SCN, NULL)) {
> +		if (shdr.sh_offset) {
> +			if (tmp->bit32)
> +				tmp->addr.a32[2] -= (shdr.sh_addr - shdr.sh_offset);
> +			else
> +				tmp->addr.a64[2] -= (shdr.sh_addr - shdr.sh_offset);

Here we should use enum above too.

Thank you,

> +		}
> +	}
> +
>  	list_add_tail(&tmp->note_list, sdt_notes);
>  	return 0;
>  
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 70c16741..ad0c4f2 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -384,6 +384,7 @@ struct sdt_note {
>  int cleanup_sdt_note_list(struct list_head *sdt_notes);
>  int sdt_notes__get_count(struct list_head *start);
>  
> +#define SDT_PROBES_SCN ".probes"
>  #define SDT_BASE_SCN ".stapsdt.base"
>  #define SDT_NOTE_SCN  ".note.stapsdt"
>  #define SDT_NOTE_TYPE 3
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
