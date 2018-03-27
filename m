Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48S5XdOEbpI9R10uVACsGSGh11w8xkXCoOjnWN6GpngizesZ1ravkmgXUp6zDTG81/oc386
ARC-Seal: i=1; a=rsa-sha256; t=1522185950; cv=none;
        d=google.com; s=arc-20160816;
        b=RtzzcCrXWEadv4rQD3jB8LZidG9zIQeK4odiiQ0mj0iuZkMMG3enMhGjlTuNf7ufqx
         9xTtWkvbjchTsTPV1Y6lXTPHHdI1XdezS+vMoXuWtPlt4/gpvaIygYpYHdcbjSbtT+nm
         d0aRhwK2Sn4/wEb7x3YEUTnFiGOy4/gJ3TdDciOJhv5nMuJj7jaQ3d5nul5APnsiL8T0
         lOrEPCQUxROFJ71nP6MGvC1wHeTeuX36GkZkByQRAfe+62MW0EbNXK9M/L8WDwqSyowF
         CBXjdpVpnAd9ppF2sn0dj+lehnYDCLudLAwfnpHstnw5AYpRPNREMnG0O6AWZznexAV0
         L3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=kLpyBdj04GMF81n2drFgDWk+zJu3Qn/Jyrxn97jC1C0=;
        b=SAW8D8+FDjnfcvC16Z9CZmHin/ScuXuGaXweGu/SC0uea19iDOoVVLhr1h/k+c+LCQ
         +ExTDcBNrwSLcUV5PBPm6FVfmHwvXuaquLBfasSzcBhIMwGVktOF8kQRfr9j9KiuDF/s
         by8jWbopOmGWKAM0kaQA7Ne0NSCulkwTsjKBurve1R6epi2QOXeYru+EgefgCcyKhjxa
         2kEcNoqEx+EEHzqrzAr8FXJVNCL21xCOWDbgg+Lsj8tP2sgjwvktTn5BtEylg5CL6dAt
         SkwrUclCSldB8sC3n2UTEySGIvqUFi7K9HNzIuHBYxWNcaMZzO2AIDoBfKGI6Xvn1vuJ
         H9ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeC0VZu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 17:25:50 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37775 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC0VZt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 17:25:49 -0400
Subject: Re: [PATCH v2 3/4] kselftest: install sanitized kernel headers before
 compiling
To: changbin.du@intel.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
 <1522120294-24926-4-git-send-email-changbin.du@intel.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <b6b9600d-5698-0b7e-7865-b77172510098@kernel.org>
Date: Tue, 27 Mar 2018 15:25:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522120294-24926-4-git-send-email-changbin.du@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596059460275146445?=
X-GMAIL-MSGID: =?utf-8?q?1596127655784261886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/26/2018 09:11 PM, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> There are test cases that require kernel headers. Some of this
> cases has put the dependency check into individual Makefiles,
> but some not. Let's sync the kernel headers at top level
> Makefile to avoid compiling errors like below.
> 
> make[1]: Entering directory '/home/changbin/work/linux/tools/testing/selftests/membarrier'
> gcc -g -I../../../../usr/include/    membarrier_test.c  -o /home/changbin/work/linux/tools/testing/selftests/membarrier//membarrier_test
> membarrier_test.c: In function ‘test_membarrier_global_success’:
> membarrier_test.c:64:12: error: ‘MEMBARRIER_CMD_GLOBAL’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
>             ^
> membarrier_test.c:64:12: note: each undeclared identifier is reported only once for each function it appears in
> membarrier_test.c: In function ‘test_membarrier_private_expedited_fail’:
> membarrier_test.c:80:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_register_private_expedited_success’:
> membarrier_test.c:103:12: error: ‘MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_private_expedited_success’:
> membarrier_test.c:120:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_private_expedited_sync_core_fail’:
> membarrier_test.c:137:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_register_private_expedited_sync_core_success’:
> membarrier_test.c:160:12: error: ‘MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_private_expedited_sync_core_success’:
> membarrier_test.c:177:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_register_global_expedited_success’:
> membarrier_test.c:194:12: error: ‘MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier_global_expedited_success’:
> membarrier_test.c:211:12: error: ‘MEMBARRIER_CMD_GLOBAL_EXPEDITED’ undeclared (first use in this function)
>   int cmd = MEMBARRIER_CMD_GLOBAL_EXPEDITED, flags = 0;
>             ^
> membarrier_test.c: In function ‘test_membarrier’:
> membarrier_test.c:253:15: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared (first use in this function)
>   if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
>                ^
> membarrier_test.c: In function ‘test_membarrier_query’:
> membarrier_test.c:296:14: error: ‘MEMBARRIER_CMD_GLOBAL’ undeclared (first use in this function)
>   if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
>               ^
> ../lib.mk:109: recipe for target '/home/changbin/work/linux/tools/testing/selftests/membarrier//membarrier_test' failed
> make[1]: *** [/home/changbin/work/linux/tools/testing/selftests/membarrier//membarrier_test] Error 1
> make[1]: Leaving directory '/home/changbin/work/linux/tools/testing/selftests/membarrier'
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/testing/selftests/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 7916aa2..656b674 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -67,13 +67,16 @@ ifndef BUILD
>  endif
>  
>  export BUILD
> -all:
> +all: headers_install
>  	@for TARGET in $(TARGETS); do		\
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
>  		mkdir $$BUILD_TARGET  -p;	\
>  		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET;\
>  	done;
>  
> +headers_install:
> +	make -C ../../../ headers_install
> +
>  run_tests: all
>  	@for TARGET in $(TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
> 

Sorry. headers_install should not be dependency to run "make kselftest".
Also this will compromise "make O=" use-case where objects are
built in a separate directory to keep the repo clean.

Individual test dependencies should be handled by test Makefiles.

thanks,
-- Shuah


