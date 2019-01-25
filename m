Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56431218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfAYSmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:42:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56542 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYSmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:42:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gn6RH-0007gl-QC; Fri, 25 Jan 2019 18:42:51 +0000
Subject: Re: [PATCH] selftests/seccomp: Enhance per-arch ptrace syscall skip
 tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190125183359.GA8524@beast>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b4d7a57b-349b-d095-2f5e-3beef86cd2c0@canonical.com>
Date:   Fri, 25 Jan 2019 18:42:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125183359.GA8524@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2019 18:33, Kees Cook wrote:
> Passing EPERM during syscall skipping was confusing since the test wasn't
> actually exercising the errno evaluation -- it was just passing a literal
> "1" (EPERM). Instead, expand the tests to check both direct value returns
> (positive, 45000 in this case), and errno values (negative, -ESRCH in this
> case) to check both fake success and fake failure during syscall skipping.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Colin, does this end up working on s390? Based on your bug report, I
> suspect the positive value tests will fail, but the errno tests will
> pass. If that's true, I think something is wrong in the s390 handling.
> (And it may just be that the ptrace code to rewrite syscalls on s390
> in the test is wrong...) But splitting these tests up should tell us more.
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 72 +++++++++++++++----
>  1 file changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 496a9a8c773a..7e632b465ab4 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1608,7 +1608,16 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  #ifdef SYSCALL_NUM_RET_SHARE_REG
>  # define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(-1, action)
>  #else
> -# define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(val, action)
> +# define EXPECT_SYSCALL_RETURN(val, action)		\
> +	do {						\
> +		errno = 0;				\
> +		if (val < 0) {				\
> +			EXPECT_EQ(-1, action);		\
> +			EXPECT_EQ(-(val), errno);	\
> +		} else {				\
> +			EXPECT_EQ(val, action);		\
> +		}					\
> +	} while (0)
>  #endif
>  
>  /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
> @@ -1647,7 +1656,7 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
>  
>  /* Architecture-specific syscall changing routine. */
>  void change_syscall(struct __test_metadata *_metadata,
> -		    pid_t tracee, int syscall)
> +		    pid_t tracee, int syscall, int result)
>  {
>  	int ret;
>  	ARCH_REGS regs;
> @@ -1706,7 +1715,7 @@ void change_syscall(struct __test_metadata *_metadata,
>  #ifdef SYSCALL_NUM_RET_SHARE_REG
>  		TH_LOG("Can't modify syscall return on this architecture");
>  #else
> -		regs.SYSCALL_RET = EPERM;
> +		regs.SYSCALL_RET = result;
>  #endif
>  
>  #ifdef HAVE_GETREGS
> @@ -1734,14 +1743,19 @@ void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
>  	case 0x1002:
>  		/* change getpid to getppid. */
>  		EXPECT_EQ(__NR_getpid, get_syscall(_metadata, tracee));
> -		change_syscall(_metadata, tracee, __NR_getppid);
> +		change_syscall(_metadata, tracee, __NR_getppid, 0);
>  		break;
>  	case 0x1003:
> -		/* skip gettid. */
> +		/* skip gettid with valid return code. */
>  		EXPECT_EQ(__NR_gettid, get_syscall(_metadata, tracee));
> -		change_syscall(_metadata, tracee, -1);
> +		change_syscall(_metadata, tracee, -1, 45000);
>  		break;
>  	case 0x1004:
> +		/* skip openat with error. */
> +		EXPECT_EQ(__NR_openat, get_syscall(_metadata, tracee));
> +		change_syscall(_metadata, tracee, -1, -ESRCH);
> +		break;
> +	case 0x1005:
>  		/* do nothing (allow getppid) */
>  		EXPECT_EQ(__NR_getppid, get_syscall(_metadata, tracee));
>  		break;
> @@ -1774,9 +1788,11 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  	nr = get_syscall(_metadata, tracee);
>  
>  	if (nr == __NR_getpid)
> -		change_syscall(_metadata, tracee, __NR_getppid);
> +		change_syscall(_metadata, tracee, __NR_getppid, 0);
> +	if (nr == __NR_gettid)
> +		change_syscall(_metadata, tracee, -1, 45000);
>  	if (nr == __NR_openat)
> -		change_syscall(_metadata, tracee, -1);
> +		change_syscall(_metadata, tracee, -1, -ESRCH);
>  }
>  
>  FIXTURE_DATA(TRACE_syscall) {
> @@ -1793,8 +1809,10 @@ FIXTURE_SETUP(TRACE_syscall)
>  		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1002),
>  		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_gettid, 0, 1),
>  		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1003),
> -		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_openat, 0, 1),
>  		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1004),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
>  		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
>  	};
>  
> @@ -1842,15 +1860,26 @@ TEST_F(TRACE_syscall, ptrace_syscall_redirected)
>  	EXPECT_NE(self->mypid, syscall(__NR_getpid));
>  }
>  
> -TEST_F(TRACE_syscall, ptrace_syscall_dropped)
> +TEST_F(TRACE_syscall, ptrace_syscall_errno)
> +{
> +	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
> +	teardown_trace_fixture(_metadata, self->tracer);
> +	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
> +					   true);
> +
> +	/* Tracer should skip the open syscall, resulting in ESRCH. */
> +	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
> +}
> +
> +TEST_F(TRACE_syscall, ptrace_syscall_faked)
>  {
>  	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
>  	teardown_trace_fixture(_metadata, self->tracer);
>  	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
>  					   true);
>  
> -	/* Tracer should skip the open syscall, resulting in EPERM. */
> -	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
> +	/* Tracer should skip the gettid syscall, resulting fake pid. */
> +	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
>  }
>  
>  TEST_F(TRACE_syscall, syscall_allowed)
> @@ -1883,7 +1912,21 @@ TEST_F(TRACE_syscall, syscall_redirected)
>  	EXPECT_NE(self->mypid, syscall(__NR_getpid));
>  }
>  
> -TEST_F(TRACE_syscall, syscall_dropped)
> +TEST_F(TRACE_syscall, syscall_errno)
> +{
> +	long ret;
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret);
> +
> +	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
> +	ASSERT_EQ(0, ret);
> +
> +	/* openat has been skipped and an errno return. */
> +	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
> +}
> +
> +TEST_F(TRACE_syscall, syscall_faked)
>  {
>  	long ret;
>  
> @@ -1894,8 +1937,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
>  	ASSERT_EQ(0, ret);
>  
>  	/* gettid has been skipped and an altered return value stored. */
> -	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
> -	EXPECT_NE(self->mytid, syscall(__NR_gettid));
> +	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
>  }
>  
>  TEST_F(TRACE_syscall, skip_after_RET_TRACE)
> 
Works perfectly. Thanks Kees.

Tested-by: Colin Ian King <colin.king@canonical.com>
