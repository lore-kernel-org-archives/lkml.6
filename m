Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AH8x227iMbYiuybZhUDOBEJJs1sz42DguNaQNyru7USdqv0ZVGcSm8jahi3uyOslxg9NlLRzYTF5
ARC-Seal: i=1; a=rsa-sha256; t=1518557087; cv=none;
        d=google.com; s=arc-20160816;
        b=jPu6GXvl2r5FQz9gzd4a6xd7lo/mRr3XcYQlFfawCWIDyXMdEjn01F4w6mCisvT/Rj
         tYNtN0/v0sw49izNsThDm/GccUjizY9DcgHVRk/qE+Aw9Dy4WeBOhssFgxJxw+Ba4JKe
         L4GM73X2Gn9O7mJorDcimtGYSYrpOLd4XhLXKz42mIVowAWpwjnJh3H/xFKjtlIhRe5m
         MUi59ocg/gRlYhdCMS7sy7slTt4CnG4coR+8NH67ywU2EhzHEyDTiIi6eqtoIp2Jv5ME
         e/RtrXPcKhNtlxjzLufbnTsULpIFQ1OTLtLWb6JI3ZPG+5uPl611Z8aJNslnF0QuylJG
         xLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=CiRmszO550eogyIvpNVr+iiKps5GOXpJyG2acrmPQfk=;
        b=YvsYWH4BQlRnrXgIwm+uKkbeOL6MQnyPgdBYP+Cb/h8FYt//ZTNSTdGSiS30A6CK6z
         +1WVaLcGYPUO/9F0JzLb4RzjljO2pKYsFFP8ucq4lXgUidctNAr55p4wvccqZKpyWaU0
         GmTVgE210CHcIl+ibU3NborPd3Gi7NfH6qol8t/Qo66A6dzO3iy5Z+AnOzl7yq3ZFjue
         zPkyxvst9PnS+C3J7M5hX75lWM2LX1QSYiyZboy+JViDRXY1wvTFpXreEnAoI+RGOGvE
         e7J4iR4gla3V6SdibL6HgxgaX2H4GAT/zcj48l9+fbnE22Q4dg3rmUBgF7T9kGeAOUag
         3zOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] selftests/memfd: add run_fuse_test.sh to TEST_FILES
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
 linux-kselftest@vger.kernel.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 SeongJae Park <sj38.park@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <1517955779-11386-1-git-send-email-daniel.diaz@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <de659f18-cba6-daeb-3289-b6b36cae1dbb@osg.samsung.com>
Date: Tue, 13 Feb 2018 14:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517955779-11386-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591692011940276570?=
X-GMAIL-MSGID: =?utf-8?q?1592322516680561520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/06/2018 03:22 PM, Daniel Díaz wrote:
> From: Anders Roxell <anders.roxell@linaro.org>
> 
> While testing memfd tests, there is a missing script, as reported by
> kselftest:
> 
> ./run_tests.sh: line 7: ./run_fuse_test.sh: No such file or directory
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/memfd/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
> index a5276a9..0862e6f 100644
> --- a/tools/testing/selftests/memfd/Makefile
> +++ b/tools/testing/selftests/memfd/Makefile
> @@ -5,6 +5,7 @@ CFLAGS += -I../../../../include/
>  CFLAGS += -I../../../../usr/include/
>  
>  TEST_PROGS := run_tests.sh
> +TEST_FILES := run_fuse_test.sh
>  TEST_GEN_FILES := memfd_test fuse_mnt fuse_test
>  
>  fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
> 

Looks like Andrew applied this mm. It will go through mm tree.

thanks,
-- Shuah
