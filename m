Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrCbR0c16VS1mv9fjQcZcuw8rd3KmhmusY364Bul71JkS9wKg+TruxiEEmgCVc4BS0vDBOK
ARC-Seal: i=1; a=rsa-sha256; t=1525894076; cv=none;
        d=google.com; s=arc-20160816;
        b=ZYUMt56efciKG/Mrxqo520Lqt9QugrsndOJCXiiRTsnmZCYXcgH5qX0B4CmzuWoToT
         VCDrDSGaQpxs9l+stsauPkuUU4g1cQG1Dg6mrER1KMdZDhlaE6+uSBiqP32Sfj3ky55z
         1uZWYTZjLpSA8uZGfpTVUiTchMt53EQPJxI3B4mkdRPrfh3h2eBS+HIxLIFCehVC6kzJ
         ezW8Lbn38FE9UvOw+ehqbE8qxqWZ6ojKlVao/LPLe3YCmrvqdkNUTO1VDRMStP50cgXz
         A5xbr7FZ0fO0zSzViPy8t3QaM7nH1hiIR3Fy9O55bSokeFoWeyB+pla+bRGSOzhjUcfd
         oBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VJ7KV2CdoslBDXTp8Qrad6DvAUuqM1fNfMz8s/s9kiw=;
        b=OPorTTnwq2jrx+1rlRtjcvjCWr10eyvF379wRBqF4UCdkq9jkSJBMVWEjGdEDArJ/g
         Vm/QE0QvbC/fUlGAoUKAG9QDMWzH579cvkXbj9conrUVMRdT0HSbA7EUlmOu4+mdX9m2
         Zb4pDKvl1Kxqqc0YMc9myfYbiUiQe/Ho1yooQ5KXTp5hZo/SeJCOXYPKmf8dVh19FC3R
         WAnrjd9dmrLw1amGhsvYUVXoi4hB9Lp3GOFCR+iayrPVllIxY3RE+EOhoHPHxRnAb3Uz
         QgawM01t3noFoVlHVO+0XpH+I+fGCG3YiUHnyjOh6PPsWFjuH2QbEO1jO/adsp7RSvuW
         pXbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 19:27:54 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, keescook@chromium.org,
	tglx@linutronix.de, sumit.semwal@linaro.org, amit.pundir@linaro.org,
	ben.hutchings@codethink.co.uk, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/24] selftests: firmware: return Kselftest Skip code
 for skipped tests
Message-ID: <20180509192754.GS27853@wotan.suse.de>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-8-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505011328.32078-8-shuah@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584767566317189?=
X-GMAIL-MSGID: =?utf-8?q?1600015906780179105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 07:13:12PM -0600, Shuah Khan (Samsung OSG) wrote:
> When firmware test(s) get skipped because of unmet dependencies and/or
> unsupported configuration, it returns 0 which is treated as a pass
> by the Kselftest framework. This leads to false positive result even
> when the test could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis

> ---
>  tools/testing/selftests/firmware/fw_fallback.sh   | 4 ++--
>  tools/testing/selftests/firmware/fw_filesystem.sh | 4 +++-
>  tools/testing/selftests/firmware/fw_lib.sh        | 7 +++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
> index 8e2e34a2ca69..70d18be46af5 100755
> --- a/tools/testing/selftests/firmware/fw_fallback.sh
> +++ b/tools/testing/selftests/firmware/fw_fallback.sh
> @@ -74,7 +74,7 @@ load_fw_custom()
>  {
>  	if [ ! -e "$DIR"/trigger_custom_fallback ]; then
>  		echo "$0: custom fallback trigger not present, ignoring test" >&2
> -		return 1
> +		exit $ksft_skip
>  	fi
>  
>  	local name="$1"
> @@ -107,7 +107,7 @@ load_fw_custom_cancel()
>  {
>  	if [ ! -e "$DIR"/trigger_custom_fallback ]; then
>  		echo "$0: canceling custom fallback trigger not present, ignoring test" >&2
> -		return 1
> +		exit $ksft_skip
>  	fi
>  
>  	local name="$1"
> diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> index 6452d2129cd9..a4320c4b44dc 100755
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -30,6 +30,7 @@ fi
>  
>  if [ ! -e "$DIR"/trigger_async_request ]; then
>  	echo "$0: empty filename: async trigger not present, ignoring test" >&2
> +	exit $ksft_skip
>  else
>  	if printf '\000' >"$DIR"/trigger_async_request 2> /dev/null; then
>  		echo "$0: empty filename should not succeed (async)" >&2
> @@ -69,6 +70,7 @@ fi
>  # Try the asynchronous version too
>  if [ ! -e "$DIR"/trigger_async_request ]; then
>  	echo "$0: firmware loading: async trigger not present, ignoring test" >&2
> +	exit $ksft_skip
>  else
>  	if ! echo -n "$NAME" >"$DIR"/trigger_async_request ; then
>  		echo "$0: could not trigger async request" >&2
> @@ -89,7 +91,7 @@ test_config_present()
>  {
>  	if [ ! -f $DIR/reset ]; then
>  		echo "Configuration triggers not present, ignoring test"
> -		exit 0
> +		exit $ksft_skip
>  	fi
>  }
>  
> diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> index 962d7f4ac627..6c5f1b2ffb74 100755
> --- a/tools/testing/selftests/firmware/fw_lib.sh
> +++ b/tools/testing/selftests/firmware/fw_lib.sh
> @@ -9,11 +9,14 @@ DIR=/sys/devices/virtual/misc/test_firmware
>  PROC_CONFIG="/proc/config.gz"
>  TEST_DIR=$(dirname $0)
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  print_reqs_exit()
>  {
>  	echo "You must have the following enabled in your kernel:" >&2
>  	cat $TEST_DIR/config >&2
> -	exit 1
> +	exit $ksft_skip
>  }
>  
>  test_modprobe()
> @@ -88,7 +91,7 @@ verify_reqs()
>  	if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
>  		if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
>  			echo "usermode helper disabled so ignoring test"
> -			exit 0
> +			exit $ksft_skip
>  		fi
>  	fi
>  }
> -- 
> 2.14.1
> 
> 

-- 
Do not panic
