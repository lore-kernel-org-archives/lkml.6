Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZqim/KqALeUylKsTC8/Uciy2jjkxzNOMI8liirSjRu5tG6PrBVN9t0+1krmxAAIxW4HuRUP
ARC-Seal: i=1; a=rsa-sha256; t=1525807910; cv=none;
        d=google.com; s=arc-20160816;
        b=XQULv5h2am7irhHmAy7vP5T6eXciuiRh+mpYWXtn6lXeqS1pUPEODHgDOyUfnzmmyN
         xMwDay32A9I4aNKKFf7jwtqjClO6p/quM8mol9LSl7JLEjV6axExzzlny11mtnziKH+i
         /UZrgZPvVPMD2uwx3D3r0RtlgZ2xMN/rSvj6qtGGz0MR5sqQ1fVlnYa3ivSQfsh+eGp8
         e4epGPjq96XRIAGOvu8Xa/jeagGGRBLiA+hkyiU6P8gTgWEJghMzut6MpU954dCbmdcT
         TKlmic/anMrjBBQnHk/UzlOlAskMSkEtO3N1H+nGaQrLGbZgRyJNOTXnCxPND7IYWa9T
         WJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Mp0o4cFsGm0SbzYGOSSrlpWKJ6GVh2Y9zFkdGw23jmQ=;
        b=o7U6FLLRmAXA8FprruQktHWMXLdQ8lUlOIUZvZc7pwV8wrvErnxZ5nPRrCRn2Oyk9U
         CiOkGfUdxbNQxQf2NOsR7MExX9EKfG/+vO62xhXJieUCln6WYHXMA2kubuuqJ1SinFit
         UeI+sS/3l/3Xw+YKpNYa4rT79LwAyWtHQgPJY+YJ7LWDwIHrmdI4fAXkD872Q5SZGeEj
         o53oRmjorwmewnB49mETu34EahwUG1bGj7i8A7vwYpxSuxzkbhLdOUvx+RTFz5Df97GQ
         EtQM+Z5A1dsnfp6W2aITGmjU+/l4ytym5Ofbyk+DPOEnoj5BLrWqEGPobeVlld0+BB2b
         5E0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=fYn/N9wp;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=fYn/N9wp;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 3/4] coresight: allow to build as modules
To: Kim Phillips <kim.phillips@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai
 <ktkhai@virtuozzo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>,
 Todd Kjos <tkjos@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f299d0be-f1a6-46ca-3d8a-13d7d89a007d@infradead.org>
Date: Tue, 8 May 2018 12:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923984942793999?=
X-GMAIL-MSGID: =?utf-8?q?1599925555600271387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/08/2018 12:06 PM, Kim Phillips wrote:

> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---

>  drivers/hwtracing/coresight/Kconfig           | 63 +++++++++++++------
>  drivers/hwtracing/coresight/Makefile          | 28 ++++++---
>  .../hwtracing/coresight/coresight-cpu-debug.c |  2 +
>  .../coresight/coresight-dynamic-replicator.c  | 30 ++++++++-
>  drivers/hwtracing/coresight/coresight-etb10.c | 32 +++++++++-
>  .../hwtracing/coresight/coresight-etm-cp14.c  |  4 ++
>  .../hwtracing/coresight/coresight-etm-perf.c  | 13 +++-
>  .../hwtracing/coresight/coresight-etm-perf.h  |  2 +-
>  .../coresight/coresight-etm3x-sysfs.c         |  6 ++
>  drivers/hwtracing/coresight/coresight-etm3x.c | 37 ++++++++++-
>  .../coresight/coresight-etm4x-sysfs.c         |  6 ++
>  drivers/hwtracing/coresight/coresight-etm4x.c | 38 ++++++++++-
>  .../hwtracing/coresight/coresight-funnel.c    | 30 ++++++++-
>  drivers/hwtracing/coresight/coresight-priv.h  | 10 ++-
>  .../coresight/coresight-replicator.c          | 33 +++++++++-
>  drivers/hwtracing/coresight/coresight-stm.c   | 27 +++++++-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  2 +
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +
>  drivers/hwtracing/coresight/coresight-tmc.c   | 34 +++++++++-
>  drivers/hwtracing/coresight/coresight-tpiu.c  | 31 ++++++++-
>  drivers/hwtracing/coresight/coresight.c       | 49 ++++++++++++---
>  include/linux/coresight.h                     | 23 +------
>  22 files changed, 418 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c164e1..09a682013ea2 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -2,8 +2,8 @@
>  # Coresight configuration
>  #
>  menuconfig CORESIGHT
> -	bool "CoreSight Tracing Support"
> -	select ARM_AMBA
> +	tristate "CoreSight Tracing Support"
> +	depends on ARM_AMBA
>  	select PERF_EVENTS
>  	help
>  	  This framework provides a kernel interface for the CoreSight debug
> @@ -12,17 +12,24 @@ menuconfig CORESIGHT
>  	  specification and configure the right series of components when a
>  	  trace source gets enabled.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-core.
> +
>  if CORESIGHT
>  config CORESIGHT_LINKS_AND_SINKS
> -	bool "CoreSight Link and Sink drivers"
> +	tristate "CoreSight Link and Sink drivers"
> +	depends on CORESIGHT

The "if CORESIGHT" line serves as a "depends on CORESIGHT" for the entire "if"
block, so please don't repeat the "depends on" here.

>  	help
>  	  This enables support for CoreSight link and sink drivers that are
>  	  responsible for transporting and collecting the trace data
>  	  respectively.  Link and sinks are dynamically aggregated with a trace
>  	  entity at run time to form a complete trace path.
>  
> +	  To compile this code as modules, choose M here: the
> +	  modules will be called coresight-funnel and coresight-replicator.
> +
>  config CORESIGHT_LINK_AND_SINK_TMC
> -	bool "Coresight generic TMC driver"
> +	tristate "Coresight generic TMC driver"
>  	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Trace Memory Controller driver.
> @@ -31,8 +38,11 @@ config CORESIGHT_LINK_AND_SINK_TMC
>  	  complies with the generic implementation of the component without
>  	  special enhancement or added features.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-tmc-core.
> +
>  config CORESIGHT_SINK_TPIU
> -	bool "Coresight generic TPIU driver"
> +	tristate "Coresight generic TPIU driver"
>  	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Trace Port Interface Unit driver,
> @@ -42,57 +52,71 @@ config CORESIGHT_SINK_TPIU
>  	  connected to an external host for use case capturing more traces than
>  	  the on-board coresight memory can handle.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-tpiu.
> +
>  config CORESIGHT_SINK_ETBV10
> -	bool "Coresight ETBv1.0 driver"
> +	tristate "Coresight ETBv1.0 driver"
>  	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Embedded Trace Buffer version 1.0 driver
>  	  that complies with the generic implementation of the component without
>  	  special enhancement or added features.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-etb10.
> +
>  config CORESIGHT_SOURCE_ETM3X
> -	bool "CoreSight Embedded Trace Macrocell 3.x driver"
> -	depends on !ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
> +	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
> +	depends on !ARM64 && CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for processor ETM3.x and PTM1.x modules,
>  	  which allows tracing the instructions that a processor is executing
>  	  This is primarily useful for instruction level tracing.  Depending
>  	  the ETM version data tracing may also be available.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-etm3x-core.
> +
>  config CORESIGHT_SOURCE_ETM4X
> -	bool "CoreSight Embedded Trace Macrocell 4.x driver"
> -	depends on ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
> +	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
> +	depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for the ETM4.x tracer module, tracing the
>  	  instructions that a processor is executing. This is primarily useful
>  	  for instruction level tracing. Depending on the implemented version
>  	  data tracing may also be available.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-etm4x-core.
> +
>  config CORESIGHT_DYNAMIC_REPLICATOR
> -	bool "CoreSight Programmable Replicator driver"
> +	tristate "CoreSight Programmable Replicator driver"
>  	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for dynamic CoreSight replicator link driver.
>  	  The programmable ATB replicator allows independent filtering of the
>  	  trace data based on the traceid.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-dynamic-replicator.
> +
>  config CORESIGHT_STM
> -	bool "CoreSight System Trace Macrocell driver"
> +	tristate "CoreSight System Trace Macrocell driver"
>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
> -	select STM
> +	depends on STM && CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for hardware assisted software
>  	  instrumentation based tracing. This is primarily used for
>  	  logging useful software events or data coming from various entities
>  	  in the system, possibly running different OSs
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-stm.
> +
>  config CORESIGHT_CPU_DEBUG
>  	tristate "CoreSight CPU Debug driver"
> -	depends on ARM || ARM64
> -	depends on DEBUG_FS
> +	depends on CORESIGHT && DEBUG_FS

"depends on CORESIGHT" is not needed if this is still inside the
if CORESIGHT/endif block.  (I think it is but I can't tell from just looking
at the patch itself.)

>  	help
>  	  This driver provides support for coresight debugging module. This
>  	  is primarily used to dump sample-based profiling registers when
> @@ -103,4 +127,7 @@ config CORESIGHT_CPU_DEBUG
>  	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
>  	  for detailed description and the example for usage.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-cpu-debug.
> +
>  endif

> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 3ffc9feb2d64..8c49c7b82d84 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -54,7 +54,7 @@ struct etm_filters {
>  };
>  
>  
> -#ifdef CONFIG_CORESIGHT
> +#if IS_ENABLED(CONFIG_CORESIGHT)

Have you found (observed) that this change (above) is necessary (and others
like it below)?  I thought that they would be equivalent.

>From include/linux/kconfig.h:
/*
 * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
 * 0 otherwise.
 */
#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))



> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f1d0e21d8cab..335bca44b42d 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h

> @@ -143,7 +149,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
>  				       struct coresight_device *sink);
>  void coresight_release_path(struct list_head *path);
>  
> -#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)

ditto.

>  extern int etm_readl_cp14(u32 off, unsigned int *val);
>  extern int etm_writel_cp14(u32 off, u32 val);
>  #else

> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d950dad5056a..5863eb1a7335 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -243,7 +243,7 @@ struct coresight_ops {
>  	const struct coresight_ops_source *source_ops;
>  };
>  
> -#ifdef CONFIG_CORESIGHT
> +#if IS_ENABLED(CONFIG_CORESIGHT)

ditto.


thanks,
-- 
~Randy
