Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeEUJed (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:34:33 -0400
Received: from foss.arm.com ([217.140.101.70]:45608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeEUJeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:34:31 -0400
Subject: Re: [PATCH v3 4/5] ARM: perf: Allow the use of the PMUv3 driver on
 32bit ARM
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <20180518143913.26306-5-marc.zyngier@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <f40d8620-eb57-37be-a2f0-b7bf7a74c087@arm.com>
Date: Mon, 21 May 2018 10:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180518143913.26306-5-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 15:39, Marc Zyngier wrote:
> +static inline int read_pmuver(void)
> +{
> +	/* PMUVers is not a signed field */
> +	u32 dfr0 = read_cpuid_ext(CPUID_EXT_DFR0);
> +	return (dfr0 >> 24) & 0xf;
> +}

Should we rule out versions prior v3 here or in __armv8pmu_probe_pmu()?

Thanks
Vladimir
