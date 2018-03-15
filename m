Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsLeIU00JGncPH2qlYU2ntQj6qgheYJ2jCY4/AT4gX5ZfqTNuqiS6mHcpe2WnV/sPIxz9WB
ARC-Seal: i=1; a=rsa-sha256; t=1521134102; cv=none;
        d=google.com; s=arc-20160816;
        b=gbRKHPfE/DVq9MrGrGOklYBeYskm3vlA3jL0BmqHEFpk+Bct9K0TJ7qORc0QWJbJ1O
         dQylrnfHlS8+nQmZYhsODpvRIAgRJi4zG+lFL/47p39p0A+0xXohQfUyxtEWNmnqTDdM
         OXJqWueK2iqSxxEyAPHOR+0M9Y7UIFVs/36xxgSH6jbeXOV+gAYmVl+LQFo4eQruQvJg
         Xxdn7dRiM2kxl0sZlVPfUXMkrXD4RIUT+gdNXvbCyOmfvoizGxyUysanhWlyoBdkhHLg
         IjX9B72ETtQqboP3BUHGVwSFNVTu3BVJy37q7cnMGc/qlZ9s4xvi6ThnpdMDNNYgggB7
         y4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=FEmFmM0D+vS3xvjUUj6Vl3fnk8daH8lUUiF8kbEIJVU=;
        b=gK7chA0v3Syi2mWwbctVqt133ZZBdd2yVKpxUTs6mgpNqTENzGi4L8+A28G8ioH8o7
         kyDPdMZuclGReREwZinrICjUrZM3hrWtWeqLYTuv1muhLaexTzUSLj1FEGevks7VqE1u
         4WqhghKi/EZ6vTKpKRj3gif6ayZL9xXmm+WZTRvZWjTpYgvDo8DO73Tm9wwTfiVeSdRj
         1a0f1OfmVVMpTpHy9jhptuorVaLZCumCsrdQCPiWB95UrW02kVup/XH8DCLSa3dmcg+9
         hERJHPwLiefFAcYHO0IH3K5gbHhnLo8weH0/y4kq64PoNHfzzLNTa7irDadodyKucbbj
         yVRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=uCFUtDCZ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=uCFUtDCZ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeCOROu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Mar 2018 13:14:50 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42172 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeCOROs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Mar 2018 13:14:48 -0400
Date: Thu, 15 Mar 2018 11:14:45 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] selftests/seccomp: Allow get_metadata to XFAIL
Message-ID: <20180315171445.fv53cmgboucbf6m3@smitten>
References: <20180315165916.GA31072@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315165916.GA31072@beast>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595023726325314850?=
X-GMAIL-MSGID: =?utf-8?q?1595024712934289488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 09:59:16AM -0700, Kees Cook wrote:
> Since seccomp_get_metadata() depends on CHECKPOINT_RESTORE, XFAIL the
> test if the ptrace reports it as missing.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Tycho Andersen <tycho@tycho.ws>

Thanks, Kees.

> ---
>  tools/testing/selftests/kselftest_harness.h   | 26 +++++++++++++++++++++++++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
>  2 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index e81bd28bdd89..6ae3730c4ee3 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -107,6 +107,27 @@
>  			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
>  
>  /**
> + * XFAIL(statement, fmt, ...)
> + *
> + * @statement: statement to run after reporting XFAIL
> + * @fmt: format string
> + * @...: optional arguments
> + *
> + * This forces a "pass" after reporting a failure with an XFAIL prefix,
> + * and runs "statement", which is usually "return" or "goto skip".
> + */
> +#define XFAIL(statement, fmt, ...) do { \
> +	if (TH_LOG_ENABLED) { \
> +		fprintf(TH_LOG_STREAM, "[  XFAIL!  ] " fmt "\n", \
> +			##__VA_ARGS__); \
> +	} \
> +	/* TODO: find a way to pass xfail to test runner process. */ \
> +	_metadata->passed = 1; \
> +	_metadata->trigger = 0; \
> +	statement; \
> +} while (0)
> +
> +/**
>   * TEST(test_name) - Defines the test function and creates the registration
>   * stub
>   *
> @@ -198,7 +219,7 @@
>  
>  /**
>   * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
> - * *_metadata* is included so that ASSERT_* work as a convenience
> + * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
>   *
>   * @fixture_name: fixture name
>   *
> @@ -221,6 +242,7 @@
>  		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
>  /**
>   * FIXTURE_TEARDOWN(fixture_name)
> + * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
>   *
>   * @fixture_name: fixture name
>   *
> @@ -253,6 +275,8 @@
>   * Defines a test that depends on a fixture (e.g., is part of a test case).
>   * Very similar to TEST() except that *self* is the setup instance of fixture's
>   * datatype exposed for use by the implementation.
> + *
> + * Warning: use of ASSERT_* here will skip TEARDOWN.
>   */
>  /* TODO(wad) register fixtures on dedicated test lists. */
>  #define TEST_F(fixture_name, test_name) \
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 92db48825dc1..d7e54031e26b 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2860,6 +2860,7 @@ TEST(get_metadata)
>  	int pipefd[2];
>  	char buf;
>  	struct seccomp_metadata md;
> +	long ret;
>  
>  	ASSERT_EQ(0, pipe(pipefd));
>  
> @@ -2893,16 +2894,26 @@ TEST(get_metadata)
>  	ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid));
>  	ASSERT_EQ(pid, waitpid(pid, NULL, 0));
>  
> +	/* Past here must not use ASSERT or child process is never killed. */
> +
>  	md.filter_off = 0;
> -	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
> +	errno = 0;
> +	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
> +	EXPECT_EQ(sizeof(md), ret) {
> +		if (errno == EINVAL)
> +			XFAIL(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
> +	}
> +
>  	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
>  	EXPECT_EQ(md.filter_off, 0);
>  
>  	md.filter_off = 1;
> -	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
> +	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
> +	EXPECT_EQ(sizeof(md), ret);
>  	EXPECT_EQ(md.flags, 0);
>  	EXPECT_EQ(md.filter_off, 1);
>  
> +skip:
>  	ASSERT_EQ(0, kill(pid, SIGKILL));
>  }
>  
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security
