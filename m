Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42288208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nv6rTMm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbeLNUoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:44:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55858 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbeLNUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:44:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBEKe4AA067227;
        Fri, 14 Dec 2018 20:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=zXybBHEUHY2nv3USi7NFeVIowy+66xETXjHCotBzVac=;
 b=Nv6rTMm7h8EVGdlZOy8d+pW2y3abASo5lqvj0UYs6cURg1DPl6WUkuqr9gj2qMmZDC4H
 AgqbYF6MgNk/DAvJqrGhr7o1qVtFy4l/WAXbsCsRGwqNS8fG79J6shwa6hYIPnC3/MPI
 jY3c1KNMSpkJAOnY9ZHcVpNNii8eHq1raEa2t+T/NFfR3y3gCrEcDpSEgWbT1OL3v6C4
 0eCiR+NoMRL5jjwcnrewuQ06D9exXxEcjzKsXZPPU5/6gYkXO8Bu0heDKdnxB4bOMntE
 DoicdHZEDq3gC7aCNLFPFJ8+F3T6WD8gbpKsexR6UHX6Ex5srSltUHP9sCCGIj0dF8Pp yQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pb3n7d97t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 20:43:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBEKhn3G001416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 20:43:50 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBEKhmXt004247;
        Fri, 14 Dec 2018 20:43:48 GMT
Received: from [10.154.160.74] (/10.154.160.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Dec 2018 12:43:48 -0800
Subject: Re: [PATCH] selftests: Fix test errors related to lib.mk khdr target
To:     shuah@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, bamv2005@gmail.com,
        brgl@bgdev.pl, fathi.boudra@linaro.org, anders.roxell@linaro.org,
        daniel.diaz@linaro.org, pintu.ping@gmail.com, pbonzini@redhat.com,
        drjones@redhat.com, hofsass@google.com, peterx@redhat.com,
        peng.hao2@zte.com.cn, wei@redhat.com, davem@davemloft.net,
        dcaratti@redhat.com, akpm@linux-foundation.org, mhocko@suse.com,
        mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
        dima@arista.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, stable@vger.kernel.org
References: <20181213200011.10779-1-shuah@kernel.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <ccfefc44-c750-8691-17e0-269237d2fe2a@oracle.com>
Date:   Fri, 14 Dec 2018 13:43:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213200011.10779-1-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9107 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 1:00 PM, shuah@kernel.org wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Commit b2d35fa5fc80 ("selftests: add headers_install to lib.mk") added
> khdr target to run headers_install target from the main Makefile. The
> logic uses KSFT_KHDR_INSTALL and top_srcdir as controls to initialize
> variables and include files to run headers_install from the top level
> Makefile. There are a few problems with this logic.
> 
> 1. Exposes top_srcdir to all tests
> 2. Common logic impacts all tests
> 3. Uses KSFT_KHDR_INSTALL, top_srcdir, and khdr in an adhoc way. Tests
>     add "khdr" dependency in their Makefiles to TEST_PROGS_EXTENDED in
>     some cases, and STATIC_LIBS in other cases. This makes this framework
>     confusing to use.
> 
> The common logic that runs for all tests even when KSFT_KHDR_INSTALL
> isn't defined by the test. top_srcdir is initialized to a default value
> when test doesn't initialize it. It works for all tests without a sub-dir
> structure and tests with sub-dir structure fail to build.
> 
> e.g: make -C sparc64/drivers/ or make -C drivers/dma-buf
> 
> ../../lib.mk:20: ../../../../scripts/subarch.include: No such file or directory
> make: *** No rule to make target '../../../../scripts/subarch.include'.  Stop.
> 
> There is no reason to require all tests to define top_srcdir and there is
> no need to require tests to add khdr dependency using adhoc changes to
> TEST_* and other variables.
> 
> Fix it with a consistent use of KSFT_KHDR_INSTALL and top_srcdir from tests
> that have the dependency on headers_install.
> 
> Change common logic to include khdr target define and "all" target with
> dependency on khdr when KSFT_KHDR_INSTALL is defined.
> 
> Only tests that have dependency on headers_install have to define just
> the KSFT_KHDR_INSTALL, and top_srcdir variables and there is no need to
> specify khdr dependency in the test Makefiles.
> 
> Fixes: b2d35fa5fc80 ("selftests: add headers_install to lib.mk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> 
> ---

Looks reasonable to me. Commit 7e0cf1c983b5 ("selftests/powerpc: Fix 
Makefiles for headers_install change") probably should be redone after 
this change.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

>   tools/testing/selftests/android/Makefile                 | 2 +-
>   tools/testing/selftests/futex/functional/Makefile        | 1 +
>   tools/testing/selftests/gpio/Makefile                    | 6 +++---
>   tools/testing/selftests/kvm/Makefile                     | 2 +-
>   tools/testing/selftests/lib.mk                           | 8 ++++----
>   tools/testing/selftests/networking/timestamping/Makefile | 1 +
>   tools/testing/selftests/tc-testing/bpf/Makefile          | 1 +
>   tools/testing/selftests/vm/Makefile                      | 1 +
>   8 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
> index d9a725478375..72c25a3cb658 100644
> --- a/tools/testing/selftests/android/Makefile
> +++ b/tools/testing/selftests/android/Makefile
> @@ -6,7 +6,7 @@ TEST_PROGS := run.sh
>   
>   include ../lib.mk
>   
> -all: khdr
> +all:
>   	@for DIR in $(SUBDIRS); do		\
>   		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>   		mkdir $$BUILD_TARGET  -p;	\
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index ad1eeb14fda7..30996306cabc 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -19,6 +19,7 @@ TEST_GEN_FILES := \
>   TEST_PROGS := run.sh
>   
>   top_srcdir = ../../../../..
> +KSFT_KHDR_INSTALL := 1
>   include ../../lib.mk
>   
>   $(TEST_GEN_FILES): $(HEADERS)
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> index 46648427d537..07f572a1bd3f 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -10,8 +10,6 @@ TEST_PROGS_EXTENDED := gpio-mockup-chardev
>   GPIODIR := $(realpath ../../../gpio)
>   GPIOOBJ := gpio-utils.o
>   
> -include ../lib.mk
> -
>   all: $(TEST_PROGS_EXTENDED)
>   
>   override define CLEAN
> @@ -19,7 +17,9 @@ override define CLEAN
>   	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
>   endef
>   
> -$(TEST_PROGS_EXTENDED):| khdr
> +KSFT_KHDR_INSTALL := 1
> +include ../lib.mk
> +
>   $(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
>   
>   $(GPIODIR)/$(GPIOOBJ):
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 01a219229238..52bfe5e76907 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -1,6 +1,7 @@
>   all:
>   
>   top_srcdir = ../../../..
> +KSFT_KHDR_INSTALL := 1
>   UNAME_M := $(shell uname -m)
>   
>   LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/ucall.c lib/sparsebit.c
> @@ -44,7 +45,6 @@ $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
>   
>   all: $(STATIC_LIBS)
>   $(TEST_GEN_PROGS): $(STATIC_LIBS)
> -$(STATIC_LIBS):| khdr
>   
>   cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
>   cscope:
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 0a8e75886224..8b0f16409ed7 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -16,18 +16,18 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>   TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>   TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>   
> +ifdef KSFT_KHDR_INSTALL
>   top_srcdir ?= ../../../..
>   include $(top_srcdir)/scripts/subarch.include
>   ARCH		?= $(SUBARCH)
>   
> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> -
>   .PHONY: khdr
>   khdr:
>   	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   
> -ifdef KSFT_KHDR_INSTALL
> -$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
> +all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> +else
> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>   endif
>   
>   .ONESHELL:
> diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
> index 14cfcf006936..c46c0eefab9e 100644
> --- a/tools/testing/selftests/networking/timestamping/Makefile
> +++ b/tools/testing/selftests/networking/timestamping/Makefile
> @@ -6,6 +6,7 @@ TEST_PROGS := hwtstamp_config rxtimestamp timestamping txtimestamp
>   all: $(TEST_PROGS)
>   
>   top_srcdir = ../../../../..
> +KSFT_KHDR_INSTALL := 1
>   include ../../lib.mk
>   
>   clean:
> diff --git a/tools/testing/selftests/tc-testing/bpf/Makefile b/tools/testing/selftests/tc-testing/bpf/Makefile
> index dc92eb271d9a..be5a5e542804 100644
> --- a/tools/testing/selftests/tc-testing/bpf/Makefile
> +++ b/tools/testing/selftests/tc-testing/bpf/Makefile
> @@ -4,6 +4,7 @@ APIDIR := ../../../../include/uapi
>   TEST_GEN_FILES = action.o
>   
>   top_srcdir = ../../../../..
> +KSFT_KHDR_INSTALL := 1
>   include ../../lib.mk
>   
>   CLANG ?= clang
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 6e67e726e5a5..e13eb6cc8901 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -25,6 +25,7 @@ TEST_GEN_FILES += virtual_address_range
>   
>   TEST_PROGS := run_vmtests
>   
> +KSFT_KHDR_INSTALL := 1
>   include ../lib.mk
>   
>   $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> 

