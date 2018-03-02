Return-Path: <anders.roxell@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519979474; cv=none;
        d=google.com; s=arc-20160816;
        b=pnpvxBOsTeDLCbxI1cJDAvWLUvQTMDrUDmJ2xs39xL/LF52EM2Vh2licsUcgFuhRrQ
         Xq6fwA1fo2DcDCbFLd8tdPvyERi8YbbSYxMdMnBi7dbYyGJ2uaIZ/8tC75ynBtBs3WSn
         4/ZcCABUSb1fpVH5O7Bsxvn6BH2R/WN0Mst/Xd36bddp3FXgmILAqKRBUTtuI+Pjmqfg
         FcnejoxycwGe98/O4sPo5MwZLwKBfe0qPjDXFDXcweklTGVy8XnmwIQFCqMPQFFnD7rC
         S9qifi4ShT37Ik5aRWKoAy/N4eNEQI8GTr/Jepv4ll4rI8CWWaY/mWbLVz43lKInWmyw
         44pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=SFZb7os1Cxr8rxK6DLU9N6Sl6gHT6UNVHg3jbG36KHg=;
        b=YkDFuM9gxE/Jfl0SrRKg0zimnG+nP5BncAZAWfph6CjA58PWUo7FjnJBlbJ2+Hg2IE
         W8Dp6hds4Xve8KS7Nf3fUXOmlEMCmZjImFAD7QRv1biRtrzMRPtEmL+79JRnKI7IyBg4
         RYsO8SMkUllkO1V1KpVk3Dcysjcfzg+AMHn87WIZy0mnyx/KcopkPp/m13rMymELaZLc
         CB4kiQx74E/Nbx3tQCHcSuVNbpvaOTuIxkoHZ2n3GtrTB4UKfgATpNRFsCS/j9sijlm+
         p8WOEQFiLjnWjrMWqH2jZfkKGNIVI8wdZqkUTGQgvQjI3L2WKjIjfsCymhzua6Wqn8YQ
         /B8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CPcrNLsm;
       spf=pass (google.com: domain of anders.roxell@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=anders.roxell@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CPcrNLsm;
       spf=pass (google.com: domain of anders.roxell@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=anders.roxell@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvZkDu2XVMy8cmNX/wiKE2pIyyobfSLtjXivuR9oxpZc0tpZTLpbQAiq4u5XytTrft81rkUVqLAc1JdayMmJMg=
MIME-Version: 1.0
In-Reply-To: <20180301201626.17347-1-shuahkh@osg.samsung.com>
References: <20180301201626.17347-1-shuahkh@osg.samsung.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 2 Mar 2018 09:31:13 +0100
Message-ID: <CADYN=9LGPa+rfnuGJ-nrpxPvw+tuAYNjxCCqefxAuRe-B_tq4w@mail.gmail.com>
Subject: Re: [PATCH] selftests: memory-hotplug: fix emit_tests regression
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: shuah@kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>, tglx@linutronix.de,
	gregkh@linuxfoundation.org, Philippe Ombredanne <pombredanne@nexb.com>, lei.yang@windriver.com,
	linux-kselftest@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593767802289906258?=
X-GMAIL-MSGID: =?utf-8?q?1593813997335425168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 1 March 2018 at 21:16, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> Commit 16c513b13477
> ("selftests: memory-hotplug: silence test command echo")
>
> introduced regression in emit_tests and results in the following
> failure when selftests are installed and run. Fix it.
>
> Running tests in memory-hotplug
> ========================================
> ./run_kselftest.sh: line 121: @./mem-on-off-test.sh: No such file or
> directory
> selftests: memory-hotplug [FAIL]
>
> Fixes: 16c513b13477 (selftests: memory-hotplug: silence test command echo")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  tools/testing/selftests/memory-hotplug/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
> index 183b46883875..686da510f989 100644
> --- a/tools/testing/selftests/memory-hotplug/Makefile
> +++ b/tools/testing/selftests/memory-hotplug/Makefile
> @@ -5,7 +5,8 @@ include ../lib.mk
>
>  TEST_PROGS := mem-on-off-test.sh
>  override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
> -override EMIT_TESTS := echo "$(RUN_TESTS)"
> +
> +override EMIT_TESTS := echo "$(subst @,,$(RUN_TESTS))"
>
>  run_full_test:
>         @/bin/bash ./mem-on-off-test.sh && echo "memory-hotplug selftests: [PASS]" || echo "memory-hotplug selftests: [FAIL]"
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kselftest" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
