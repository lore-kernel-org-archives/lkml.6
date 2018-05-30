Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbeE3Xmp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:42:45 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45816 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeE3Xmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:42:42 -0400
Subject: Re: [RESEND PATCH] selftests: intel_pstate: notification about
 privilege required to run intel_pstate testing script
To: Jeffrin Jose T <ahiliation@gmail.com>, daniel.diaz@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de, thomas@m3y3r.de,
        gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180530220339.6107-1-ahiliation@gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <16b7c1d5-3fe8-2bc9-6037-1fd61624f992@kernel.org>
Date: Wed, 30 May 2018 17:42:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530220339.6107-1-ahiliation@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 04:03 PM, Jeffrin Jose T wrote:
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

I will take this patch and apply it to linux-kselftest next for 4.18-rc1.

For next time, this patch should have been tagged v2 not RESEND. Also please
include changes made since the last version in this spot after the Signed-off-by
line.

>  tools/testing/selftests/intel_pstate/run.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index 8576f6564307..e7008f614ad7 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -38,6 +38,12 @@ if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
>  	exit $ksft_skip
>  fi
>  
> +msg="skip all tests:"
> +if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
> +    echo $msg please run this as root >&2
> +    exit $ksft_skip
> +fi
> +
>  max_cpus=$(($(nproc)-1))
>  
>  function run_test () {
> 

thanks,
-- Shuah
