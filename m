Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224OzOJ9IjTRZ2HH2OTuaEYG1hzizMkxedRoKe6An87Xm6EVRoIiHwA6TfTa7XMgpVd4UWKJ
ARC-Seal: i=1; a=rsa-sha256; t=1518557423; cv=none;
        d=google.com; s=arc-20160816;
        b=lXR2fT1fr203pbxbIbmw+qWUaqkugWncCUoQjeeHgDDJUFHm5dvVO8Cl7EBRTRtFuO
         ZNVQIlzD/oOkRud6xNGqfKnj+oQQSEbaQkXrYSubOUnUhLbWTjzPhmcpMmqbSvUVM85t
         oKoME7w/UgRJ7jkmENQN4cJCM8gxvPyZ9Cqehh6e6hlBPkC0gH8AMbMIhxLq0rRrRyix
         FCevAwAaXAfRUlHi10rUB3cjszmujd6fNC3etir66KoYKSQzUWEvS5CDPT/m2HJ+Q38T
         CwQ7fy8PjeRuUrho28PaR1ru1EgP1qhQtsuS8UeOpMEuEL4aTtpC8+71LUduqqCToQ93
         q+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:reply-to
         :arc-authentication-results;
        bh=0QZjdpJ/lhE47PW/Zv7YR5BloSd/ObyeM2JrtbtIGyY=;
        b=qpBEMmXeOUg8SyG23j9bFZJOYnefx/fLf/Qnff3fpyW6UVcpXMVpzPlQxNamDNfCQm
         VgBFDaBaI+QMoQxSNn/yzd56jlJVSBYia/J7Yy+GALUJaw2yjSL2VupvK0wBBJXKG+HZ
         P33qugGhkgldzfRoSZ0GvO8vbDUFxYhRQXRMwlNvFGYNzF6hg5VGxI5wU2RUllmxVtqv
         cnIgH99W/JHhBl6VLKuNKNcIEOoZhvxdPYCOlXHRKcwRadbFtJd+QYeCi13ItTsrbTiU
         cHfGEn9iOfgDq9B5yIyLEoK5a+Q14P8iHgcPDWtqR9HWmMTyflPar4weAyUxcBs6xpUy
         3GuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965814AbeBMVaW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 16:30:22 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:57434 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965749AbeBMVaW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 16:30:22 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] selftest/vDSO: fix O=
To: Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180211105950.14720-1-linux@dominikbrodowski.net>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <03fc8983-8ed2-0a49-4268-6dd1f79d22fa@kernel.org>
Date: Tue, 13 Feb 2018 14:30:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211105950.14720-1-linux@dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102802145440139?=
X-GMAIL-MSGID: =?utf-8?q?1592322868644324396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/11/2018 03:59 AM, Dominik Brodowski wrote:
> The vDSO selftests ignored the O= or KBUILD_OUTPUT= parameters. Fix it.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  tools/testing/selftests/vDSO/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 3d5a62ff7d31..f5d7a7851e21 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> +include ../lib.mk
> +
>  ifndef CROSS_COMPILE
>  CFLAGS := -std=gnu99
>  CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> @@ -6,16 +8,14 @@ ifeq ($(CONFIG_X86_32),y)
>  LDLIBS += -lgcc_s
>  endif
>  
> -TEST_PROGS := vdso_test vdso_standalone_test_x86
> +TEST_PROGS := $(OUTPUT)/vdso_test $(OUTPUT)/vdso_standalone_test_x86
>  
>  all: $(TEST_PROGS)
> -vdso_test: parse_vdso.c vdso_test.c
> -vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
> +$(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
> +$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
>  	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
>  		vdso_standalone_test_x86.c parse_vdso.c \
> -		-o vdso_standalone_test_x86
> +		-o $@
>  
> -include ../lib.mk
> -clean:
> -	rm -fr $(TEST_PROGS)
> +EXTRA_CLEAN := $(TEST_PROGS)
>  endif
> 

Thanks for the patch. Applied to linux-kselftest fixes for 4.16-rc3

thanks,
-- Shuah
