Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A738A20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pUKZvAqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A738A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeLEToL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:44:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YcnEeVDcnmR0NE1AXM6cJ5Lqip4SnNBAcVKcf7vWLd4=; b=pUKZvAqPB+fOWrUgm2YHT4HYX3
        x5PW1iisGLe9sKt9m9OaQJSqH+gtJYXKajHbFAjYdAClCD+zA4pU37+0m5LjjKD0qG4SxjuWjixCx
        FIKZhpNruuXrEa5jnbu8oM0hNe8x3QNDVBcwFFCKyYpCuiQJCE/bAg8g3gvcSEtIAHAfH+DumpT1f
        9koJWirtAgYkdmSk8j9ZPGK7oXwffn1yFiiPG/da7gUC6dwamXzCU0pzvYdZbq53LRzS8+9Lw7f/L
        VEkXqLntoAuz/A06jz51Mg1Fn+pRBqL8/7gMKKwklSUqUI76QnFfrHhWUxmTimcfez6J0kT3ALvYZ
        xqjp53HQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUd5Y-0007mZ-Gf; Wed, 05 Dec 2018 19:44:04 +0000
Subject: Re: [PATCH v9 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
To:     "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
References: <20181205105853.15154-1-ganapatrao.kulkarni@cavium.com>
 <20181205105853.15154-2-ganapatrao.kulkarni@cavium.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <04e97a22-bf60-0b3d-9923-aa679a395bfd@infradead.org>
Date:   Wed, 5 Dec 2018 11:44:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205105853.15154-2-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have some documentation edits for you to consider:


On 12/5/18 2:59 AM, Kulkarni, Ganapatrao wrote:
> The SoC has PMU support in its L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  Documentation/perf/thunderx2-pmu.txt | 93 ++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
> 
> diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
> new file mode 100644
> index 000000000000..f8835bf1068c
> --- /dev/null
> +++ b/Documentation/perf/thunderx2-pmu.txt
> @@ -0,0 +1,93 @@
> +
> +Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
> +==========================================================================
> +
> +ThunderX2 SoC PMU consists of independent system wide per Socket PMUs, such
> +as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).
> +
> +The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles. Events
> +are counted for default channel(i.e channel 0) and prorated to total number of

               for the default channel (i.e. channel 0) and

> +channels/tiles.
> +
> +DMC and L3C supports up to 4 counters. Counters are independently programmable

               support

> +and can be started and stopped individually. Each counter can be set to
> +different event. Counters are 32 bit and do not support overflow interrupt;

 a different event.

> +they are read every 2 seconds.
> +
> +PMU UNCORE (perf) driver:
> +
> +The thunderx2_pmu driver registers per socket perf PMUs for DMC and L3C devices.
> +Each PMU can be used to count up to 4 events simultaneously. PMUs provide
> +description of its available events and configuration options
> +in sysfs, see /sys/devices/uncore_<l3c_S/dmc_S/>; S is the socket id.
> +
> +The driver does not support sampling, therefore "perf record" will
> +not work. Per-task perf sessions are not supported.
> +
> +Examples:
> +
> +perf stat -a -e uncore_dmc_0/cnt_cycles/ sleep 1
> +
> +perf stat -a -e \
> +uncore_dmc_0/cnt_cycles/,\
> +uncore_dmc_0/data_transfers/,\
> +uncore_dmc_0/read_txns/,\
> +uncore_dmc_0/write_txns/ sleep 1
> +
> +perf stat -a -e \
> +uncore_l3c_0/read_request/,\
> +uncore_l3c_0/read_hit/,\
> +uncore_l3c_0/inv_request/,\
> +uncore_l3c_0/inv_hit/ sleep 1
> +
> +
> +L3C events:
> +============
> +
> +read_request:
> +	Number of Read requests received by the L3 Cache.
> +	This include Read as well as Read Exclusives.

	     includes

> +
> +read_hit:
> +	Number of Read requests received by the L3 cache that were hit
> +	in the L3 (Data provided form the L3)
> +
> +writeback_request:
> +	Number of Write Backs received by the L3 Cache. These are basically
> +	the L2 Evicts and writes from the PCIe Write Cache.
> +
> +inv_nwrite_request:
> +	This is the Number of Invalidate and Write received by the L3 Cache.

	Number of Invalidate and Write requests received by the L3 Cache.

> +	Also Writes from IO that did not go through the PCIe Write Cache.
> +
> +inv_nwrite_hit
> +	This is the Number of Invalidate and Write received by the L3 Cache

	Number of Invalidate and Write requests received by the L3 Cache

> +	That were a hit in the L3 Cache.

	that

> +
> +inv_request:
> +	Number of Invalidate request received by the L3 Cache.

	                     requests

> +
> +inv_hit:
> +	Number of Invalidate request received by the L3 Cache that were a

	                     requests

> +	hit in L3.
> +
> +evict_request:
> +	Number of Evicts that the L3 generated.
> +
> +NOTE:
> +1. Granularity of all these events counter value is cache line length(64 Bytes).

                               event counter values               length (64 bytes).

> +2. L3C cache Hit Ratio = (read_hit + inv_nwrite_hit + inv_hit) / (read_request + inv_nwrite_request + inv_request)
> +
> +DMC events:
> +============
> +cnt_cycles:
> +	Count cycles (Clocks at the DMC clock rate)
> +
> +write_txns:
> +	Number of 64 Bytes write transactions received by the DMC(s)
> +
> +read_txns:
> +	Number of 64 Bytes Read transactions received by the DMC(s)
> +
> +data_transfers:
> +	Number of 64 Bytes data transferred to or from DRAM.
> 


-- 
~Randy
