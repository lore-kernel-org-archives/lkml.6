Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527010304; cv=none;
        d=google.com; s=arc-20160816;
        b=dfmXcL16OsaiuXLpo10YXC7ZpB+CfES6uGVUsew8esiKcSY0oGAXiyDlzY+YJ7M1MF
         045OCj8joCO/s1Pa8qc+SEtIwFHazErkuuLhsOVNQmOLQujoDCAOCYsDW8h/9W5OIqWq
         OandDdYp3wpYSUVdrPt4lYZRMUFt3tHNQi8E/OqmK2qPS3PNsKIjbv5Ng0eRiXhs4Q2K
         25fsZQIlo7foY7cvBvwklIPrvKf7bywcztMFWvt24aDzI2snAw3wnO4bB7W5hRD2R7gn
         YdG1h0WQ6rEMj5LLwwv2c6pmwdAeUxJuJMIlbfvJqMqiql22clDo9IFvADlCKV5lWl9/
         DqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=UwK2GcYi3wh4TVb+aBC9gpB3+4kmvzuNPFc8v7BXzII=;
        b=BdsDf6mg6pVcpRF6d6g3DFLb1juvf5Zk0njAo/YIrchLu1ASTggxF6haozn9ft7zah
         0zvkECUsObf0CmAwuU/Xf2HEV1LqNoDGdScDmXKiPt3NCgk0HViLVRNalW0eGWnlprl0
         702pnPjUX7VpQVR1xgAjRBrIBdKWkltulu/pvmZeADxzUqd9VsmM62GzyG8XiW3aMhSj
         MD6ctjX90JwE/DzxROQT81Cn5GGE0uZ08RC46ibA7zl3Fk1gdLHm0KZ5M9E6nuxDzwry
         LCuiWSqDvAGuxZYhadc8ws01mhJDd/xzOefrcTMjH8huNcifAWk1gE/MYfaZ9S7Dp7D6
         rQ4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iIX4N2mc;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iIX4N2mc;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp3x3aM0+zdBgDZ8354HpcmcCQQxkVfP2os2Ka3lse5PEU+1ZBzUHvmUB074Nh3OrC/p7/X1w==
Date: Tue, 22 May 2018 11:31:40 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS
 dependencies and selections
Message-ID: <20180522173140.GA25658@xps15>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762901299441866?=
X-GMAIL-MSGID: =?utf-8?q?1601186356595827064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 08:20:19PM -0500, Kim Phillips wrote:
> A coresight topology doesn't need to include links, i.e., a source can
> be directly connected to a sink.  As such, selecting and/or depending on
> LINKS_AND_SINKS is no longer needed.

I'm good with this patch but now the help text for CORESIGHT_LINKS_AND_SINKS no
longer match what the config does.  I see two ways to fix this:

1) Rework the help text.

2) Rework CORESIGHT_LINKS_AND_SINKS to be CORESIGHT_FUNNEL and move
coresight-replicator.o under CORESIGHT_DYNAMIC_REPLICATOR in the Makefile. I
really liked your idea of making the replicator driver intelligent enough to
deal with both DT and platform declaration, which merges two driver into one.

I'm obviously favouring the second option but recognise it doesn't have to be
part of this patchet.  So for this set please rework the help text for
CORESIGHT_LINKS_AND_SINKS.  Once we've dealt with this topic we can refactor the
replicator driver.

Thanks,
Mathieu 

> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c164e1..83fb78651ef9 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -23,7 +23,6 @@ config CORESIGHT_LINKS_AND_SINKS
>  
>  config CORESIGHT_LINK_AND_SINK_TMC
>  	bool "Coresight generic TMC driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Trace Memory Controller driver.
>  	  Depending on its configuration the device can act as a link (embedded
> @@ -33,7 +32,6 @@ config CORESIGHT_LINK_AND_SINK_TMC
>  
>  config CORESIGHT_SINK_TPIU
>  	bool "Coresight generic TPIU driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Trace Port Interface Unit driver,
>  	  responsible for bridging the gap between the on-chip coresight
> @@ -44,7 +42,6 @@ config CORESIGHT_SINK_TPIU
>  
>  config CORESIGHT_SINK_ETBV10
>  	bool "Coresight ETBv1.0 driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Embedded Trace Buffer version 1.0 driver
>  	  that complies with the generic implementation of the component without
> @@ -53,7 +50,6 @@ config CORESIGHT_SINK_ETBV10
>  config CORESIGHT_SOURCE_ETM3X
>  	bool "CoreSight Embedded Trace Macrocell 3.x driver"
>  	depends on !ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for processor ETM3.x and PTM1.x modules,
>  	  which allows tracing the instructions that a processor is executing
> @@ -63,7 +59,6 @@ config CORESIGHT_SOURCE_ETM3X
>  config CORESIGHT_SOURCE_ETM4X
>  	bool "CoreSight Embedded Trace Macrocell 4.x driver"
>  	depends on ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for the ETM4.x tracer module, tracing the
>  	  instructions that a processor is executing. This is primarily useful
> @@ -72,7 +67,6 @@ config CORESIGHT_SOURCE_ETM4X
>  
>  config CORESIGHT_DYNAMIC_REPLICATOR
>  	bool "CoreSight Programmable Replicator driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for dynamic CoreSight replicator link driver.
>  	  The programmable ATB replicator allows independent filtering of the
> @@ -81,7 +75,6 @@ config CORESIGHT_DYNAMIC_REPLICATOR
>  config CORESIGHT_STM
>  	bool "CoreSight System Trace Macrocell driver"
>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
>  	select STM
>  	help
>  	  This driver provides support for hardware assisted software
> -- 
> 2.17.0
> 
