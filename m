Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqh/MmTcO+GmSjSTwNp6S5qJlEr2jhM3DAJ11e0TRtRPmO+7iifbXtEBZDIl3NCoPPmzHq1
ARC-Seal: i=1; a=rsa-sha256; t=1525966599; cv=none;
        d=google.com; s=arc-20160816;
        b=kRw38HmF1TNjwAZsh+KO5rHeUl2eAlC9bAEi5ssYQsF6KDAY7IwNijZQq9ZtYhwYgn
         QAsvleYczD6XDYKG51N15W5aB85MEUpl8cSDE4/3j1dcOy5Q2ZpKRIxJ7x2kJJqvn1uB
         mGeVyzqLkeEGpXMcEpA4QE1tirBe7vNFWKTc/kikAK5fh+MdfkweorNuiZ6VrfHw+etd
         XD+X3VmYNk+LlO02CuL3ivxRioTQx8pLYM5mxSq04jAz+fokD8wGlRpyM+lfDKvc//sP
         xnqsYn6K5zdgXg6XZbwQy7MXi7BSv0lWue6RM4WuRz5KCCrqiiuw5iAZm3/3lkXfEYus
         9FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ToiHQLstw74ona8vFQYBOFA6qP6Z190oN/iOb9iEpGg=;
        b=qw4PRi1KJFq/G9qzRjnYxMuSb1DBvlx8v+jAUBlyn4xeIFmrWDD/5bznxsBYUhRyUH
         FIwQJiJnuxTnxUWACFtNCD4VwZXu0/MgTCBQm4F1/yCj+VU3/ktRGeu7s7zOjdhNA6jW
         BJtVoosbZokcIoyRHJBBJkQyAaluxpojAQQw65ySoETl5DMvpZvdRcZi8PpWBTdPmzEE
         uFKTm2l6gg+EnVDieHcO6rPN0WWsBSAUhhiWwK1C+o5TDwgP/T/PU7M4RrS2po3s4c8Y
         lp+mG/v0Es+KsAncFyeL7JqbiNJBuWslyt1gN1KYOl7VtmM34HUtdvzE6xZb0X1voK4c
         RpCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH] selftests: intel_pstate: Fixes for the testing script
 run.sh
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, kstewart@linuxfoundation.org,
 daniel.diaz@linaro.org, pombredanne@nexb.com, gregkh@linuxfoundation.org,
 thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>, Shuah Khan <shuah@kernel.org>
References: <20180509221733.15182-1-ahiliation@yahoo.co.in>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <3530a166-8c57-6bd4-e4e2-b6019b492598@kernel.org>
Date: Thu, 10 May 2018 09:36:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509221733.15182-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600026599814016657?=
X-GMAIL-MSGID: =?utf-8?q?1600091953406910991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/09/2018 04:17 PM, Jeffrin Jose T wrote:
> fix for notification of permission requirement to run test.
> fix for exit status value for test skipped.
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  tools/testing/selftests/intel_pstate/run.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index c670359becc6..74983f74a9a1 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -30,6 +30,13 @@
>  
>  EVALUATE_ONLY=0
>  
> +msg="skip all tests:"
> +
> +if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
> +    echo $msg please run this as root >&2
> +    exit $ksft_skip
> +fi
> +
>  if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
>  	echo "$0 # Skipped: Test can only run on x86 architectures."
>  	exit 0
> 

I have a patch out for this and your change conflicts with it. I am in the process
of pushing patches into linux-kselftest next. Please rebase this patch on top
of that.

thanks,
-- Shuah
