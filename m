Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeEGFB2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 01:01:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37458 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeEGFBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 01:01:25 -0400
X-Google-Smtp-Source: AB8JxZovhcBd1QzHXiORneNVF1icc22IPGydnEPKDOK92TyuzL8kshqaiQSusNnbq6vLRrMxako6Lw==
Date: Mon, 7 May 2018 10:31:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: rjw@rjwysocki.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/24] selftests: cpufreq: return Kselftest Skip code for
 skipped tests
Message-ID: <20180507050121.lzgjzbgsigisvgqj@vireshk-i7>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-4-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505011328.32078-4-shuah@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-18, 19:13, Shuah Khan (Samsung OSG) wrote:
> When cpufreq test is skipped because of unmet dependencies and/or
> unsupported configuration, it exits with error which is treated as
> a fail by the Kselftest framework. This leads to false negative
> result even when the test could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  tools/testing/selftests/cpufreq/main.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
> index d83922de9d89..31f8c9a76c5f 100755
> --- a/tools/testing/selftests/cpufreq/main.sh
> +++ b/tools/testing/selftests/cpufreq/main.sh
> @@ -13,6 +13,9 @@ SYSFS=
>  CPUROOT=
>  CPUFREQROOT=
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  helpme()
>  {
>  	printf "Usage: $0 [-h] [-todg args]
> @@ -38,7 +41,7 @@ prerequisite()
>  
>  	if [ $UID != 0 ]; then
>  		echo $msg must be run as root >&2
> -		exit 2
> +		exit $ksft_skip
>  	fi
>  
>  	taskset -p 01 $$

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
