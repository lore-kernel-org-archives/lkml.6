Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965336AbeE2RGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:06:03 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:39906 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965154AbeE2RGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:06:00 -0400
Subject: Re: [PATCH] selftests: intel_pstate: notification about privilege
 required to run intel_pstate testing script
To: Jeffrin Jose T <ahiliation@gmail.com>, kstewart@linuxfoundation.org,
        daniel.diaz@linaro.org, pombredanne@nexb.com, thomas@m3y3r.de,
        gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180526170135.3340-1-ahiliation@gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <80da5a3b-fb1b-a9e5-5c4b-38b485fde688@kernel.org>
Date: Tue, 29 May 2018 11:05:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180526170135.3340-1-ahiliation@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26/2018 11:01 AM, Jeffrin Jose T wrote:
> The intel_pstate related testing script need root level privileges
> when trying to access certain file for the successful execution of
> the script.But this is not the case always like when using evaluation
> only mode, which only require user level privilege.
> 
> This patch is to notify the user about the privilege the script
> demands for the successful execution of the test.
> 
> Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
> ---
>  tools/testing/selftests/intel_pstate/run.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index 6ded61670f6d..4ddd389c2cb9 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -33,6 +33,12 @@ EVALUATE_ONLY=0
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
>  
> +msg="skip all tests:"
> +if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
> +    echo $msg please run this as root >&2
> +    exit $ksft_skip
> +fi
> +
>  if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
>  	echo "$0 # Skipped: Test can only run on x86 architectures."
>  	exit $ksft_skip
> 

Why not do the arch check first and then do the root check? The order of
arch followed by root on non-x86 arch definitely better than root first
check.

thanks,
-- Shuah
