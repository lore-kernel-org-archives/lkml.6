Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525890301; cv=none;
        d=google.com; s=arc-20160816;
        b=mDQS4yQS1xCr/3QetGvQo4k2lAOfl0ec4X/FT3GzOfr6uSsb+Qi/vYi9F00lmTkK4S
         p7MsW8W46G9nTTagtyTGdPpDiVKhCSq50piZriiO391khU2Qx5GM3HeALXuG0pgXK3s2
         XxbXhGQnOmvooWTOach/gGIOUcF2SrFX7eIYA+r5S+EAZ/eNoKlRPUP/IN9KdBY7Nayd
         wH5PLodmECK99TH27FcWO0gQGQYMMFUeQ2PucjUADAnCAqy+GiEsChq1gZ4Xb1sVo+qj
         xMO4ZUmUFo0NmdAaLLw9Sj2dcD3DEF/S/54d8Z5SIBCtjlFZAdJk4SBVyVTSNR4kx6D8
         /zog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=W56posItM8Udl8TrkR8CpLJ19dNK+jfnVKzovDZiGVE=;
        b=GSorZRaMToL63GaIuTLSOdqZymbUft5EMplSH+1GECDI6n/LfaFDovRtzQVSvf9IPT
         Uhezcq3txmhRg+i/o99AVkhvOS11TwcKZd0yAU+Du+p2Vux9leBZtEPmqh96uY+j1SWh
         KuOTEofeLq/33qNHNidYqnWYhkSdWJs6UIPcyIoCxnWpCugYoGXykfy4EoDS13pEJ/RF
         l011TccSWzrGzlqD3XPd89bPBK/8LXsFAKRqKaaMtclKBqXOkPVsr4kTA//OgeAnV9ML
         KMcAbQ36g0dP+q6gHFoP1a101nR4huEvo730IIOM0fqwM3HhvaR2EElfeWQlBM/ewCh9
         rgcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=USs7g1PE;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=USs7g1PE;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqVFerctz1ZiSuRil8pDFhSzTEj7cKy4LtEl+DME3TW681bzpJnRUlK+JC8cj4umc4bFRgvdQ==
Subject: Re: [PATCH] selftests: intel_pstate: Fix a condition which does not
 notify user that root permission is useful
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, shuah@kernel.org,
 kstewart@linuxfoundation.org, pombredanne@nexb.com,
 gregkh@linuxfoundation.org, thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
References: <20180509173819.8017-1-ahiliation@yahoo.co.in>
From: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.diaz@linaro.org; prefer-encrypt=mutual; keydata=
 xsBNBFgJLEgBCACas3n7CMRz6aCoYkf+odaRNQGt/2ubmS5o6fC1FxtTrJWZibh2JAWv8CWq
 ZLwOZVZoARv3QS3BrjPg9jAN9nJxq+6h8Sj2phaYVk0LIek4hoJaOoMz3gXhfwnE/rUCpf9c
 9n8FGJBGIKN1MC7JeWa31lSBwQ6DuQ8rufGmxJbf9aXIzOm/K5oHlXfwVC2S1YzLSP98MTJF
 /hMdjC0neVnKMKVQQ7KX/IGOTyGSA5XqFeKCMWH95YZyBBbGJ3Q8nHpQcwmMrkJIDC5tqDj3
 t5AegI/pHO69kHWhJYmS+HHKP0RLdXTn9gYYilZr7fiViuG42IxhKQoemFrND/38CBwBABEB
 AAHNJURhbmllbCBEw61heiA8ZGFuaWVsLmRpYXpAbGluYXJvLm9yZz7CwHcEEwEIACEFAlgJ
 LEgCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQKOrJYn+xsM9BEQf/T1+NVzj4reaU
 CLEaJxh5N3sw0emfWevIzmS1ixz2MmBC3Zd6SZhytQLa/KFCnPcOtSHd1IxwOwjjeI9SnHAG
 KyUl4LrtPu2dvLS96ZtVApq1rJEylnMBBnCKkS005ut96b06JXplZAYnRyb/z9iguttNbSN1
 vOMCoiIq855+ZnIJmuYD96YMi8O3mxM4LXjRraeH3xTRXjFDNHxbt6oBKK3qS8YKwR3LoIqW
 1AM0OOeo0MLxrQRHyOVj3YNzrp1z9lMN9Weg6iRG6x+gknMjnZs0cGjjz2R7cqFNw8yDI9E1
 4Rg4LaBptC9HbVf/PmnFq0znv3ktZy7LxDMzwDVML87ATQRYCSzcAQgAzQ285w7jEagcyZxt
 Az79LI2YM0HjzufegxXOEMayU1dSS0UAKp6GlrSYIdB5GJ+KmREYHFVCez1B5aU2uyIpB4K/
 MOCeN9WFeUTAOTZ0Lfr4lK7lPLb6LwkPJyHAQIZhrZRPLfsI5kfcevBNwKjIeXDSMRhDdiQu
 alZ2JLN5YCmK4mTV6RacKTqXOFjd1OMRBr1JqC/oT8fh6DltqTNxgiuygrKg04uCcC2eQl3W
 B9FmG/o3OsuxkNnXpJfxznVthA8FBUlWOYeNfzhfEoz1hmrWTSmAAPXXR1ub6Cuw4rU1KGde
 /7tFYWIN1KSZw/WUWmwmax/E8ULx4Vw0aOLkIwARAQABwsBfBBgBCAAJBQJYCSzcAhsMAAoJ
 ECjqyWJ/sbDPYfcH/iZ+I8V55Vvt0lWtkAC9S94HezAycw+0imGZwQibq+8cjzFGu8tEDHLZ
 Q3ZuHsIQ4grBfCAtVv6PjvjAukE8lEw2mxzfiGOwx36XE8OcyhRfxT3BTfaop5o2AYfMTmZO
 qSuiIaRNA7Qrp//RKmmuxnIYeomn8oNCtddNekPeKLMq5TROJICoV69kHCO4K7wzJUoJrFoP
 0dv796Js0ZDhhZ6Y8fcBhDvL5ujMsxazqeWoBFnbGV0QWxk+XNNSYpBLVi/2jJAWcRA2ALzX
 tu/HC/5WXCGrJPFCF2pvRqNV/p+3j0fQkQ2G3+QCPO0MWBXfb6hdhuCOguHfo98vHP0lMnw=
Message-ID: <a16db020-045d-a5ba-9106-5f4b4e4920a4@linaro.org>
Date: Wed, 9 May 2018 13:24:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509173819.8017-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600009088111663295?=
X-GMAIL-MSGID: =?utf-8?q?1600011948971791171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!


On 05/09/2018 12:38 PM, Jeffrin Jose T wrote:
> aperf program uses /dev/cpu which is normally a root only
> access area. so in that case to successfully run thet test,
> root permissions are required.This patch is in the file run.sh.
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  tools/testing/selftests/intel_pstate/run.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index 23a2e4e9880e..05d35392dcfd 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -31,6 +31,14 @@
>  
>  EVALUATE_ONLY=0
>  
> +uid=$(id -u)
> +if [ $uid -ne 0 ]; then
> +    echo     "-----------------------"
> +    echo $msg please run this as root >&2
> +    echo     "-----------------------"
> +    exit 0
> +fi
> +

Other tests simply use $UID. See:
  cpufreq/main.sh
  cpu-hotplug/cpu-on-off-test.sh
  efivarfs/efivarfs.sh
  gpio/gpio-mockup.sh
  memory-hotplug/mem-on-off-test.sh

This doesn't take into account the conditions for EVALUATE_ONLY: When
it's set non-zero, neither aperf nor cpupower run at all.

While this is under review, you might want to base your change on
Shuah's patch for skipping:

https://lists.linaro.org/pipermail/linux-kselftest-mirror/2018-May/001074.html


>  if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
>  	echo "$0 # Skipped: Test can only run on x86 architectures."
>  	exit 0

I'd leave this check at the forefront, as this "hurdle" is
insurmountable in other architectures, whereas becoming root is attainable.

Thanks and greetings!

Daniel Díaz
daniel.diaz@linaro.org
