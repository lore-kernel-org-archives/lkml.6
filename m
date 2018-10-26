Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF26ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EECB2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EECB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gydle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJZXmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:42:12 -0400
Received: from mail.gydle.com ([64.18.173.180]:57776 "EHLO mail.gydle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJZXmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:42:11 -0400
X-Received: from [192.168.1.136] (unknown [69.70.179.254])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboisvert@gydle.com)
        by mail.gydle.com (Postfix) with ESMTPSA id CA56841ACA;
        Fri, 26 Oct 2018 11:04:45 -0400 (EDT)
Subject: Re: [PATCH] perf/stat: Handle different PMU names with common prefix
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kan.liang@linux.intel.com,
        stable@vger.kernel.org
References: <20181023151616.78193-1-tmricht@linux.ibm.com>
From:   =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sboisvert@gydle.com; keydata=
 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
 vnOzfc5OOiR/D+lE
Message-ID: <7b3b23b7-1c73-66bf-611b-8dd9fb274694@gydle.com>
Date:   Fri, 26 Oct 2018 11:04:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023151616.78193-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-23 11:16 a.m., Thomas Richter wrote:
> On s390 the CPU Measurement Facility for counters now supports
> 2 PMUs named cpum_cf (CPU Measurement Facility for counters) and
> cpum_cf_diag (CPU Measurement Facility for diagnostic counters)
> for one and the same CPU.
> 
> Running command
> 
>  [root@s35lp76 perf]# ./perf stat -e tx_c_tend \
> 	 -- ~/mytests/cf-tx-events 1
> 

Is tx_c_tend related to these ?

  tx-abort OR cpu/tx-abort/                          [Kernel PMU event]
  tx-capacity OR cpu/tx-capacity/                    [Kernel PMU event]
  tx-commit OR cpu/tx-commit/                        [Kernel PMU event]
  tx-conflict OR cpu/tx-conflict/                    [Kernel PMU event]
  tx-start OR cpu/tx-start/                          [Kernel PMU event]


>  Measuring transactions
>  TX_C_TABORT_NO_SPECIAL: 0 expected:0
>  TX_C_TABORT_SPECIAL: 0 expected:0
>  TX_C_TEND: 1 expected:1
>  TX_NC_TABORT: 11 expected:11
>  TX_NC_TEND: 1 expected:1
> 
>  Performance counter stats for '/root/mytests/cf-tx-events 1':
> 
>   2      tx_c_tend
> 
>       0.002120091 seconds time elapsed
> 
>       0.000121000 seconds user
>       0.002127000 seconds sys
> 
>  [root@s35lp76 perf]#
> 
> displays output which is unexpected (and wrong):
> 
>   2      tx_c_tend
> 
> The test program definitely triggers only one transaction, as shown
> in line 'TX_C_TEND: 1 expected:1'.

OK, something is done twice in perf stat, but should be done once.

> 
> This is caused by the following call sequence:
> 
> pmu_lookup() scans and installs a PMU.
> +--> pmu_aliases() parses all aliases in directory
> 		.../<pmu-name>/events/* which are file names.
>      +--> pmu_aliases_parse() Read each file in directory and create
>                       an new alias entry. This is done with
>           +--> perf_pmu__new_alias() and
> 	       +--> __perf_pmu__new_alias() which also check for
> 	                   identical alias names.
> 
> After pmu_aliases() returns, a complete list of event names
> for this pmu has been created. Now function
> 
> pmu_add_cpu_aliases()   is called to add the events listed in the json
> |                       files to the alias list of the cpu.
> +--> perf_pmu__find_map()  Returns a pointer to the json events.
> 
> Now function pmu_add_cpu_aliases() scans through all events listed
> in the JSON files for this CPU.

Are these JSON files temporary in nature ?

> Each json event pmu name is compared with the current PMU being
> built up and if they mismatch, the json event is added to the
> current PMUs alias list.
> To avoid duplicate entries the following comparison is done:
> 
> 	if (!is_arm_pmu_core(name)) {
> 	     pname = pe->pmu ? pe->pmu : "cpu";
> 	     if (strncmp(pname, name, strlen(pname)))
> 		     continue;
>      }

Is this the test to know whether a PMU event must be added or not ?

> 
> The culprit is the strncmp() function.
> 
> Using current s390 PMU naming, the first PMU is 'cpum_cf'
> and a long list of events is added, among them 'tx_c_tend'
> 
> When the second PMU named 'cpum_cf_diag' is added, only one event
> named 'CF_DIAG' is added by the pmu_aliases()  function.
> 
> Now function pmu_add_cpu_aliases() is invoked for PMU 'cpum_cf_diag'.
> Since the CPUID string is the same for both PMUs, json file events
> for PMU named 'cpum_cf' are added to the PMU 'cpm_cf_diag'
> 
> This happens because the strncmp() actually compares:
>>      strncmp("cpum_cf", "cpum_cf_diag", 6);

I fail to see how these argument values can be generated by this code:

 	     pname = pe->pmu ? pe->pmu : "cpu";
 	     if (strncmp(pname, name, strlen(pname)))

The 3rd argument is the length of the first argument, pname.

With "cpum_cf", it should be 7, not 6.



> 
> The first parameter is the pmu name taken from the event in
> the json file. The second parameter is the pmu name of the PMU
> currently being built.
> They are different, but the length of the compare only tests the
> common prefix and this returns 0(true) when it should return false.
> 

The 6 comes from strlen(pname). In that case, it is neither the length of
"cpum_cf" (7) or "cpum_cf_diag" (12).

> Now all events for PMU cpum_cf are added to the alias list for pmu
> cpum_cf_diag.
> 
> Later on in function parse_events_add_pmu() the event 'tx_c_end' is
> searched in all available PMUs and found twice, adding it two
> times to the evsel_list global variable which is the root
> of all events. This results in a counter value of 2 instead
> of 1.

The counter value of 2 is 1 + 1 since both PMU events 'tx_c_end' that
were added got a +1.

> 
> Output with this patch:
> 
>  [root@s35lp76 perf]# ./perf stat -e tx_c_tend \
> 			-- ~/mytests/cf-tx-events 1
>  Measuring transactions
>  TX_C_TABORT_NO_SPECIAL: 0 expected:0
>  TX_C_TABORT_SPECIAL: 0 expected:0
>  TX_C_TEND: 1 expected:1
>  TX_NC_TABORT: 11 expected:11
>  TX_NC_TEND: 1 expected:1
> 
>  Performance counter stats for '/root/mytests/cf-tx-events 1':
> 
>                   1      tx_c_tend
> 

OK, now that's 1, like in your expected test value:

  TX_C_TEND: 1 expected:1

>       0.001815365 seconds time elapsed
> 
>       0.000123000 seconds user
>       0.001756000 seconds sys
> 
>  [root@s35lp76 perf]#
> 
> Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 7799788f662f..7e49baad304d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -773,7 +773,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>  
>  		if (!is_arm_pmu_core(name)) {
>  			pname = pe->pmu ? pe->pmu : "cpu";
> -			if (strncmp(pname, name, strlen(pname)))
> +			if (strcmp(pname, name))
>  				continue;
>  		}
>  
> 
