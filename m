Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522689997; cv=none;
        d=google.com; s=arc-20160816;
        b=MUiqaJV4RogIuoUPCyrckKlDt/4FjH08kZfkra5rr7v6mSQuDH7QHBhiDsWMX8m9pZ
         PqFVsJbFDLaHom4WDehmJQkuIUhxXt4pt+GLpjEqTlnBYh7djHwwyaDO0cO6jbjTKhX3
         EluTDKS/OlNTaUttd4ZqaeLFESBeevIaexkUa4CGUHTuE/PBrjHQkfEHCN8flk7DpKvN
         pDoZRzDLldFQ5mzOJjS/ke/24zTZr79OS8WXsfUNfUEQ88qFc2Ek1nnzawXGXYqqGV4j
         Lsnueg1Uxb9Yno6HOMjWCP9uj3HWc6B0UJRIwHqZ2zP5kG7agJmsRsQudcnhyBdYVjzG
         P2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=1SXa+tLY6wDNnhkxsgcyZbEGIaCrkvNGnUjFANqgmDM=;
        b=zDQ1Pgw+IvYp36pT4nEyc/TfdvyR19U7Jvofi2f9flQm/1sZA2TXXEVqhRpQ325tSS
         ilr+83iFLmezYqdxEhg984uE2XgOZnFC/1kIzGBelVrPIMjpi8d+9iouh4wpE8/6ItuT
         CdV/wghUiOB5O7uQ0AC4ir6im7RBV+DaVvf6RmkSKUQEMBlBGZ5Y3u1t1UnOVJ1StRne
         qFe8F+fbSQ7nrqBgkbs7d51QYFDvsR+VryW32gQKukqNyRGupyQJHMOp24uzgVkUm7gx
         sHvkUMVR1p33A8itXLWRtwNVfgAh0G+SwQbFZ+EWPHymWCVPOcqDlw9M3CTvN6gYi7oL
         X+gw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LxpeJwKt;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LxpeJwKt;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49GvXc/EViciGAXMNVuf3IdGecjwWSctEUb/w8sxrBzEXqHoEJTPqsuvi0RUSGxGjl2uTkCrQ==
Date: Mon, 2 Apr 2018 11:26:34 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 2/6] doc: Add documentation for Coresight panic kdump
Message-ID: <20180402172634.GB15452@xps15>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
 <1522379724-30648-3-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522379724-30648-3-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330875461151635?=
X-GMAIL-MSGID: =?utf-8?q?1596656187437258695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:15:20AM +0800, Leo Yan wrote:
> Add detailed documentation for Coresight panic kdump, which contains
> the idea for why need Coresight panic kdump and introduce the
> implementation of Coresight panic kdump framework; the last section is
> to explain what's usage.
> 
> Credits to Mathieu Poirier for many suggestions since the first version
> patch reviewing.  The suggestions include using an array to manage dump
> related info, this makes code scalable for more CPUs; the Coresight
> kdump driver and integration kdump flow with other Coresight devices
> also have many ideas from Mathieu.

Please remove the above paragraph.

> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

And the above line too.

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../trace/coresight/coresight-panic-kdump.txt      | 130 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/trace/coresight/coresight-panic-kdump.txt
> 
> diff --git a/Documentation/trace/coresight/coresight-panic-kdump.txt b/Documentation/trace/coresight/coresight-panic-kdump.txt
> new file mode 100644
> index 0000000..c02e520
> --- /dev/null
> +++ b/Documentation/trace/coresight/coresight-panic-kdump.txt
> @@ -0,0 +1,130 @@
> +		Coresight Panic Kdump
> +		=====================
> +
> +   Author:   Leo Yan <leo.yan@linaro.org>
> +   Date:     March 29th, 2018
> +
> +Introduction
> +------------
> +
> +Coresight has different sinks for trace data, the trace data is quite useful
> +for postmortem debugging.  Embedded Trace Buffer (ETB) is one type sink which
> +provides on-chip storage of trace data, usually uses SRAM as the buffer with
> +several KBs size; if the SoC designs to support 'Local ETF' (ARM DDI 0461B,
> +chapter 1.2.7), every CPU has one local ETB buffer so the per CPU trace data
> +can avoid being overwritten by each other.  Trace Memory Controller (TMC) is
> +another kind sink designed as a successor to the CoreSight ETB to capture trace
> +into DRAM.

I don't think details about the sinks themselves is worth adding here.  In my
opinion we can simply stick with the abstract notion of a sink and achieve the
same result. 

> +
> +After Linux kernel panic has occurred, the trace data keeps the last execution
> +flow before issues happen.  We could consider the trace data is quite useful for
> +postmortem debugging, especially when we can save trace data into DRAM and rely on

Even in documentation files please keep line wrapped to 80 characters (note that
checkpatch won't complain).  Console text from the command line (as added below)
is exempt from this rule.

> +kdump to preserve them into vmcore file; at the end, we can retrieve trace data
> +from vmcore file and "offline" to analyze the execution flow.
> +
> +
> +Implementation
> +--------------
> +
> +Coresight panic kdump is a simple framework to support Coresight dump
> +functionality when panic happens, it maintains an array for the dump, every array
> +item is dedicated to one specific CPU by using CPU number as an index.  For
> +'offline' recovery and analysis Coresight tracing data, except should to recovery

This paragraph as a whole is hard to read and the usage of the word 'except'
above doesn't not work in this context.  Please consider reviewing and/or get in
touch with me if you want to work on it together.  

> +tracing data for sinks, we also need to know CPU tracer configurations; for this
> +purpose, the array item is a structure which combines source and sink device
> +handlers, the device handler points to Coresight device structure which contains
> +dump info: dump buffer base address and buffer size.  Below diagram is to
> +present data structures relationship:
> +
> +  array: coresight_kdump_nodes
> +  +------+------+----------------------+
> +  | CPU0 | CPU1 |   ...                |
> +  +------+------+----------------------+
> +     |
> +     V
> +  coresight_kdump_node              coresight_device
> +  +-------------------+             +-------------------+
> +  |    source_csdev   | ----------> |    kdump_buf      |
> +  +-------------------+      /      +-------------------+
> +  |    sink_csdev     | ----'       |    kdump_buf_sz   |
> +  +-------------------+             +-------------------+
> +
> +Every CPU has its own tracer, we need save tracer registers for tracer ID and
> +configuration related information as metadata, the metadata is used by tracing
> +decoder.  But the tracer has the different configuration at the different phase,
> +below diagram explains tracer configurations for different time points: at the
> +system boot phase, the tracer is disabled so its registers have not been set;
> +after tracer has been enabled or when panic happens, tracer registers have been
> +configured, but we need to consider if there has CPU is locked up at panic phase
> +then this dead CPU has no chance to handle inter-processor interrupt for panic
> +dump; thus we choose tracer enabling phase to save tracer metadata.  Coresight
> +panic kdump provides API coresight_kdump_source() as helper function for
> +recording tracer metadata.
> +
> +                     Boot         Enabling     Panic
> +
> +  Timeline:  ------->|----------->|----------->|----------->
> +
> +  Tracer:            Disabled     Configured   Configured
> +  Sink:              Disabled     Enabled      Enabled with tracing data
> +                                    |            |
> +                                    |            `--> Tracing data dump
> +                                    |
> +                                    `--> Tracer metadata dump
> +
> +After enabling Coresight sink device, function coresight_kdump_sink() is used to
> +set sink device handler for related CPU; sink device handler points to Coresight
> +device structure, furthermore we can retrieve its ops structure and panic
> +callback 'panic_cb' in the ops structure. Coresight panic notifier takes panic CPU
> +tracing data with high priority to firstly invoke panic CPU sink callback function,
> +then the notifier iterates dump array and invoke callback functions one by one
> +for other CPUs.

Same comment as above - this last sentence needs reviewing.  While doing so
please avoid using "high priority" as it can confuse a reader in thinking that
scheduling classes are involved, which isn't the case.

> If one sink device is shared among CPUs, the sink panic
> +callback is invoked for the first traversed CPU node and other sequential CPUs
> +are skipped.
> +
> +
> +Usage
> +-----
> +
> +Build Linux kernel with enabling 'CONFIG_CORESIGHT_PANIC_KDUMP' configuration.
> +
> +After system booting up, we need firstly prepare dump-capture kernel, this can
> +refer doc [1] chapter 'Load the Dump-capture Kernel' for detailed steps.  Then
> +we need enable the Coresight tracer, this can use either perf framework method
> +or sysFS interface, please refer doc [2] chapter 'How to use the tracer modules'
> +for detailed steps.
> +
> +When kernel panic happens, the panic kdump records trace data and launches
> +dump-capture kernel, we can utilize the dump-capture kernel to save kernel dump
> +file, this can refer doc [1] chapter 'Write Out the Dump File'.
> +
> +After get kernel dump file, we can use 'crash' tool + csdump.so extension to
> +extract trace data and generate 'perf.data' file:
> +
> +  ./crash vmcore vmlinux
> +  crash> extend csdump.so
> +  crash> csdump output_dir
> +
> +  We can see in the 'output_dir' there will generate out three files:
> +  output_dir/
> +  ├── cstrace.bin       -> trace raw data
> +  ├── metadata.bin      -> meta data
> +  └── perf.data         -> 'perf' format compatible file

Humm... Saying that perf.data is a "perf format compatible file" is not
accurate as it can't be processed by "perf report".  This is because it doesn't
containt the PERF_RECORD_AUX event notifications and the mechanic for indexing
CS trace data lumps in the perf.data file.

This will likely lead to confusion and calls from many angry users.  As such I
suggest to:

1) Rename perf.data cskdump.data (unless you have a better name).
2) Add a comment to makes it clear that only "perf script" can be used with
cskdump.data

On my side I will review the crash extensions you referred to in the cover
letter.  I may have more comments once I've done so.

> +
> +Finally use 'perf' tool for offline analysis:
> +
> +  ./perf script -v -F cpu,event,ip,sym,symoff -i perf.data -k vmlinux --kallsyms /proc/kallsyms
> +  [001]         instructions:  ffff000008559ad0 pl011_console_write+0x90
> +  [001]         instructions:  ffff000008559230 pl011_read+0x0
> +  [001]         instructions:  ffff00000855924c pl011_read+0x1c
> +  [001]         instructions:  ffff000008559ae0 pl011_console_write+0xa0
> +  [001]         instructions:  ffff000008559ad0 pl011_console_write+0x90
> +  [001]         instructions:  ffff000008559230 pl011_read+0x0
> +  [001]         instructions:  ffff00000855924c pl011_read+0x1c
> +  [001]         instructions:  ffff000008559ae0 pl011_console_write+0xa0
> +  [001]         instructions:  ffff000008559ad0 pl011_console_write+0x90
> +  [001]         instructions:  ffff000008559230 pl011_read+0x0
> +  [001]         instructions:  ffff00000855924c pl011_read+0x1c
> +
> +[1] Documentation/kdump/kdump.txt
> +[2] Documentation/trace/coresight/coresight.txt
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ee1fdc..cc1243b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1333,6 +1333,7 @@ S:	Maintained
>  F:	drivers/hwtracing/coresight/*
>  F:	Documentation/trace/coresight/coresight.txt
>  F:	Documentation/trace/coresight/coresight-cpu-debug.txt
> +F:	Documentation/trace/coresight/coresight-panic-kdump.txt
>  F:	Documentation/devicetree/bindings/arm/coresight.txt
>  F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>  F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
> -- 
> 2.7.4
> 
