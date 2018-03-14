Return-Path: <mhiramat@kernel.org>
X-Google-Smtp-Source: AG47ELuJoQbL2cNcNfCetn7F8KzTm4OkdCRKKnM3BYGzJfSfxiedILQ3HKgcHR1TssNss6i2zj8F
ARC-Seal: i=1; a=rsa-sha256; t=1521035429; cv=none;
        d=google.com; s=arc-20160816;
        b=dFXUJTtDKraaV/df7qTU7KQI24FBXAjABSDI+vYtrbkQkpyKoi7gaV5njbzzLh4w4e
         OCgLL2in2M+B0srDBLlEUuzYoPxtoi20Xyvp+HZUk3ApZX1fdfC+E4sA44+iL0vE7P2M
         GzcUfMitWl7CcuPu/a1g1riBBI02+cDrS7/hcE+MRsLwco9gjk5ncRnWYasbklS5WR+l
         kdO55Sc5hexSTPCsUnu+MXh/NTv8emZkVS4daE9inx9pOqw/VzJMbmkwyIf/eDyxWnUs
         7IT5QRJHbuvir9iQy4HY2C/nWP0d9khDb5y31wOxI/R3xeC5NiwHfpzFCLp7RL1eJjBw
         yThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=6wO2u6qkbzn2uIlGZTgQhyvNirxmQdpX+ZJDPJb4y30=;
        b=vg+CCmmxajPPxOaw8qF1gUc/nzZX9/ZihfTtaA55P0mklJPjJamTSHs7FfyQTIkC+X
         tUugWE6dfzPEySa3xaO/40UyMTB7HNfymMMqERxWY7afxJ8wMGH7f/6K6wRZ2q+U6UPx
         jRD7kepMSBagCWzyQ91RQLYIjGz7VXwGV7GKznuzkDMayipsSvoJrKfQQskIor7iBl19
         gln04kQSJ7yPy6pRvaJtyQpBFwIxO6w47EQw6ZAWTzC07kBL5X1CXeRusB2ggudFGaqI
         GFL82oMCsFHmiwkYdFtzBaqHk+1e1rUaXDWWLRd26dTTj5/XIANsZf2wsCfP6YjNzwGD
         0OJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE772176E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 14 Mar 2018 22:50:21 +0900
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
Subject: Re: [PATCH 8/8] trace_uprobe/sdt: Document about reference counter
Message-Id: <20180314225021.64109239de8b14b0aec1e1c5@kernel.org>
In-Reply-To: <20180313125603.19819-9-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-9-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827212550255650?=
X-GMAIL-MSGID: =?utf-8?q?1594921245975724087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:26:03 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> No functionality changes.

Please consider to describe what is this change and why, here.

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  Documentation/trace/uprobetracer.txt | 16 +++++++++++++---
>  kernel/trace/trace.c                 |  2 +-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.txt
> index bf526a7c..8fb13b0 100644
> --- a/Documentation/trace/uprobetracer.txt
> +++ b/Documentation/trace/uprobetracer.txt
> @@ -19,15 +19,25 @@ user to calculate the offset of the probepoint in the object.
>  
>  Synopsis of uprobe_tracer
>  -------------------------
> -  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
> -  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
> -  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
> +  p[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
> +  r[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]

Ah, OK in this context, [] means optional syntax :)

> +  -:[GRP/]EVENT
> +
> +  p : Set a uprobe
> +  r : Set a return uprobe (uretprobe)
> +  - : Clear uprobe or uretprobe event
>  
>    GRP           : Group name. If omitted, "uprobes" is the default value.
>    EVENT         : Event name. If omitted, the event name is generated based
>                    on PATH+OFFSET.
>    PATH          : Path to an executable or a library.
>    OFFSET        : Offset where the probe is inserted.
> +  REF_CTR_OFFSET: Reference counter offset. Optional field. Reference count
> +                  gate the invocation of probe. If present, by default
> +                  reference count is 0. Kernel needs to increment it before
> +                  tracing the probe and decrement it when done. This is
> +                  identical to semaphore in Userspace Statically Defined
> +                  Tracepoints (USDT).
>  
>    FETCHARGS     : Arguments. Each probe can have up to 128 args.
>     %REG         : Fetch register REG
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 20a2300..2104d03 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4604,7 +4604,7 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
>    "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
>  #endif
>  #ifdef CONFIG_UPROBE_EVENTS
> -	"\t    place: <path>:<offset>\n"
> +  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
>  #endif
>  	"\t     args: <name>=fetcharg[:type]\n"
>  	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
