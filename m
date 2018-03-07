Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbeCGOcH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:32:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbeCGOcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:32:06 -0500
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, mingo@redhat.com, john.garry@huawei.com,
        Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
From: William Cohen <wcohen@redhat.com>
Message-ID: <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
Date: Wed, 7 Mar 2018 09:32:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 06:08 AM, Ganapatrao Kulkarni wrote:
> There is MIDR change on ThunderX2 B0, adding an entry to mapfile
> to enable JSON events for B0.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index e61c9ca..93c5d14 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -13,4 +13,5 @@
>  #
>  #Family-model,Version,Filename,EventType
>  0x00000000420f5160,v1,cavium,core
> +0x00000000430f0af0,v1,cavium,core
>  0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
> 

Hi,
Like the cortex-a53 the last digit '0' of the match for the MIDR should be replaced with [[:xdigit:]] to allow for possible future revisions of chip:

0x00000000430f0af[[:xdigit:]],v1,cavium,core


-Will Cohen
