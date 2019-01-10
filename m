Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1434214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfAJMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:32:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfAJMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:32:19 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ghZVQ-00019r-Un; Thu, 10 Jan 2019 12:32:17 +0000
Subject: NACK: [PATCH] selftests: cpu-hotplug: fix case where CPUs offline >
 CPUs present
From:   Colin Ian King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190110113725.12369-1-colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <49c597d3-65e6-3cde-ee43-906d8951aa90@canonical.com>
Date:   Thu, 10 Jan 2019 12:32:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110113725.12369-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2019 11:37, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The cpu-hotplug test assumes that we can offline the maximum CPU as
> described by /sys/devices/system/cpu/offline.  However, in the case
> where the number of CPUs exceeds like kernel configuration then
> the offline count can be greater than the present count and we end
> up trying to test the offlining of a CPU that is not available to
> offline.  Fix this by testing the maximum present CPU instead.
> 
> Also, the test currently offlines the CPU and does not online it,
> so fix this by onlining the CPU after the test.
> 
> Fixes: d89dffa976bc ("fault-injection: add selftests for cpu and memory hotplug")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  .../selftests/cpu-hotplug/cpu-on-off-test.sh      | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> index bab13dd025a6..8670fb38a40e 100755
> --- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> +++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> @@ -31,12 +31,17 @@ prerequisite()
>  	echo "CPU online/offline summary:"
>  	online_cpus=`cat $SYSFS/devices/system/cpu/online`
>  	online_max=${online_cpus##*-}
> +	echo "online_cpus = $online_cpus online_max = $online_max"

Bother, forgot to remove this debug.

>  
>  	if [[ "$online_cpus" = "$online_max" ]]; then
>  		echo "$msg: since there is only one cpu: $online_cpus"
>  		exit $ksft_skip
>  	fi
>  
> +	present_cpus=`cat $SYSFS/devices/system/cpu/present`
> +	present_max=${present_cpus##*-}
> +	echo "present_cpus = $present_cpus present_max = $present_max"
> +
>  	echo -e "\t Cpus in online state: $online_cpus"
>  
>  	offline_cpus=`cat $SYSFS/devices/system/cpu/offline`
> @@ -46,6 +51,7 @@ prerequisite()
>  		offline_max=${offline_cpus##*-}
>  	fi
>  	echo -e "\t Cpus in offline state: $offline_cpus"
> +

Ugh, I added a whitespace

>  }
>  
>  #
> @@ -151,6 +157,8 @@ online_cpus=0
>  online_max=0
>  offline_cpus=0
>  offline_max=0
> +present_cpus=0
> +present_max=0
>  
>  while getopts e:ahp: opt; do
>  	case $opt in
> @@ -190,9 +198,10 @@ if [ $allcpus -eq 0 ]; then
>  	online_cpu_expect_success $online_max
>  
>  	if [[ $offline_cpus -gt 0 ]]; then
> -		echo -e "\t offline to online to offline: cpu $offline_max"
> -		online_cpu_expect_success $offline_max
> -		offline_cpu_expect_success $offline_max
> +		echo -e "\t offline to online to offline: cpu $present_max"
> +		online_cpu_expect_success $present_max
> +		offline_cpu_expect_success $present_max
> +		online_cpu $present_max
>  	fi
>  	exit 0
>  else
> 

