Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225WORBN69Hr7YT0rUlFk84FiGFEFSdKqGK+Rj4WYOGuAT4y5n4ntF7NlEd7k/+LHCvnOgkV
ARC-Seal: i=1; a=rsa-sha256; t=1518557216; cv=none;
        d=google.com; s=arc-20160816;
        b=qCLevpAsCj8LhsK3V8bcQ4sWidlEYLm4Gow7HNy0fEdEuzLMNfcCJ/DLDIPTIiTnPA
         La9nOtTb0TMqqnItlYKYWuLqRCaFoEuk3F56Q7syo7sMZxTuPVvtvivtbI46c78Xfuqs
         e+Nf3dKtRAqN7xkMWBx8okf/Lq0XUG0nM68aNzn1gfmF4yMGHyseIlBsr5BYfk9HsVXT
         afbAScn4Q6AkTXqla6+5geHssUdg+/4i0GUXtpTglLWCDhXqRji5vYh3P5MOHmTRkIjA
         Qfd1VeTI2cuse+6Dm8oiknbXQiQdKEGNdQ0M/1L4GoUJEe2TKFI+LYPNBbAOhQip0i2v
         9sKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=mEc4VbrvtNXTpCZ2s9X6Qg46NxPxeTvQ4c4OrB7SWDw=;
        b=etodJRkNO6rRgBG3SsBDn/IYD2xoX/Es0/Byxya7E0te0MigNmDYAzLKFpdqHlXbaU
         nAOGieZTwfTmiFxjjBM+U+AiFJemXV+9GnZGIg2kRLxyBSb7aHFYfunBu+JUXKokvsp4
         gWz/pJgOhggirB8M43Bl/ljuthvvTvBcnrhlt0tmPITMtubypHCV2bbiYGylQygllXBY
         7HG7g3UJdWgIEdUo2Tn+QXwCK3l+DF7G58MNP97Gxg+F+J0YjMNi5qL4MCLrMf7nvjiw
         fqhv+wbpa3jFxDDRdyUxgsWE7bcSq0Or5HRsB6chVwxVafXBwJHsDM2CGXxwcm4Uo47u
         r0Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965811AbeBMV04 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 16:26:56 -0500
Received: from osg.samsung.com ([64.30.133.232]:54057 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965776AbeBMV0z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 16:26:55 -0500
Subject: Re: [PATCH] selftests/futex: Fix line continuation in Makefile
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com>
Date: Tue, 13 Feb 2018 14:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1592322651680657269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/2018 10:24 AM, Daniel Díaz wrote:
> The Makefile lacks a couple of line continuation backslashes
> in an `if' clause, which produces an error while make'ing:
> 
>   $ make
>   make[1]: Entering directory `/[...]/linux/tools/testing/selftests/futex'
>   /bin/sh: -c: line 5: syntax error: unexpected end of file
>   make[1]: *** [all] Error 1
>   make[1]: Leaving directory `/[...]/linux/tools/testing/selftests/futex'
>   make: *** [all] Error 2
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/futex/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index cea4adc..a63e845 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -12,9 +12,9 @@ all:
>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>  		mkdir $$BUILD_TARGET  -p;	\
>  		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
> -		if [ -e $$DIR/$(TEST_PROGS) ]; then
> -			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/;
> -		fi
> +		if [ -e $$DIR/$(TEST_PROGS) ]; then \
> +			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
> +		fi \
>  	done
>  
>  override define RUN_TESTS
> 

Thanks for the patch. Applied to linux-kselftest fixes for 4.16-rc3

thanks,
-- Shuah
