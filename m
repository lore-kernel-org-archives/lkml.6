Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519895468; cv=none;
        d=google.com; s=arc-20160816;
        b=U/r1aHp6EnLuG+jqpPdFT6yg9qLGNx1imxHUeuzj9VOWfqz8LxvtnMz8j/dZo0WU91
         5ofbCTxPHvvcYbA5Sn5xUCt8h8mT5LqRN4hL68pyt1KRXiPGLJiLEFgCVltZPpdttnYc
         /RTsDE/3Jhu6x18EBoAOt4Ra5JsDUVsB+Rs8FkznGNe9TqdnxLF7Pb6MOhSWVZBCJJgi
         vRfn5XCKAJTD5FnCAJRtKqZotOhDSxvJ93n7VAjEHMVfasT2z93RrzzdlsJU61AvRNbG
         bW3Gi7c75NqZfVkxYBAY66DvCd9VwdVh41W0YI8zBIounrzYYAX9CbUTd/VccPHK0s90
         Qt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mGUUcEMp7VW9o8+6n5+TIAMZCljC3+MTqRGE4mHW/z0=;
        b=QprcKIyLXRNmdXJGOoBhYoXlyW9+SCtWOkZ7uKtmAUW8iaREDXHXN4Re2r8Cm05iNa
         MlKmlpBaKdOzvuckizJ+dMPY2A/M/cAL6lgPtgX1gqrrXGcDwDOY8Pb15g2Agzaw5ZKO
         UIovCYoinR4/Ti1vri/15mOmEeZDIVu1S4MrgfzA0mIU6o3ZWtAw0N5+xo5+5V+JCT+1
         sCU3b6eAJIBltNY4luPAcCpDF6V44ZS2/WoKXSf6Id4LvP+BY71HdLWpCQz/eNofErjG
         F8AFA5MCL2PMQGYfWuDFbmjxsrzA+VaDDXQLvL+R1F+4HrBPyIr+bVCfwwFPoQD1jizX
         jP/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TusQ7nE+;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TusQ7nE+;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvbBTnDjedABpiOAPHFwr+o5GaeZUlADTPIpKIsu5KJc8V9wKoGO+Yu9gh1pbeApXoPX+0MLe4IEoSo1PME+u0=
MIME-Version: 1.0
In-Reply-To: <20180213214407.21717-1-shuahkh@osg.samsung.com>
References: <20180213214407.21717-1-shuahkh@osg.samsung.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 1 Mar 2018 14:41:06 +0530
Message-ID: <CA+G9fYsE0w00aeE3jxJU3Q01Yz_C95zn+kguMHqg6M9PRmhemg@mail.gmail.com>
Subject: Re: [PATCH] selftests: memory-hotplug: silence test command echo
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Shuah Khan <shuah@kernel.org>, lyang0 <lei.yang@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592323763418926951?=
X-GMAIL-MSGID: =?utf-8?q?1593725910702915610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 February 2018 at 03:14, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> Silence the following command being printed while running test.
>
> ./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" ||
> echo "selftests: memory-hotplug [FAIL]"
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  tools/testing/selftests/memory-hotplug/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
> index 86636d207adf..183b46883875 100644
> --- a/tools/testing/selftests/memory-hotplug/Makefile
> +++ b/tools/testing/selftests/memory-hotplug/Makefile
> @@ -4,7 +4,7 @@ all:
>  include ../lib.mk
>
>  TEST_PROGS := mem-on-off-test.sh
> -override RUN_TESTS := ./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
> +override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
>  override EMIT_TESTS := echo "$(RUN_TESTS)"
>
>  run_full_test:

The test execution broken due to this patch ?

Running tests in memory-hotplug
========================================
./run_kselftest.sh: line 121: @./mem-on-off-test.sh: No such file or directory
selftests: memory-hotplug [FAIL]

LAVA job id:
https://lkft.validation.linaro.org/scheduler/job/132699#L2526

- Naresh

> --
> 2.14.1
>
