Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E8AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E8820823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874963;
	bh=um5uqUz21APFJO6cV2nUXOWCtcN0yssB+uHF23h8jHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QFgY/My7ydPWheSrNLkg6h/eKpyXQmXJS8APpIlKPiQLPEkaKYgaKk37UuIFFKm46
	 FK3jWuKayuFV9Rp/CNWjiAANM7DQd6KhTC0XbrtgyXSi3vf7YzeM+L8eMM9YX3aVAb
	 A2OrYzQbI6yHnqIlFVbOjpwX2fkDqo0K+lC5rA80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBKItW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:49:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36641 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfBKItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:49:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so482696wmj.1;
        Mon, 11 Feb 2019 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G7zRHbQ9cFMYdjS7FpNUHVk1m7aUjV5Ubu/1eFZxeRs=;
        b=a/ePGA1i6/jZYUxxLbFi4jFZKStaoIHUbmf/pzytoxJpVd3tC0fkwXuj1LF0n7tE+J
         a6qGnx1xjAn5dbMr/Zen27ma+2N9zlslRGPQTOehD6gRYqvI/iBXHzEQMDiYXP5ddSLd
         ZXWlIb7o2m3obeNSO9mp4JnJIAIJeVD3jdYX+w1sS9OZUfodxTeIxNkrAHg6IDTQAoSm
         2uFRlW3oqmg/GpISxfqxxS9le79ZmoNmvNAVoWgWVEgHHkDPjMXkErAWeiNZ3UdEDhh5
         ny6Pa3GmmIOocX3//LBOPEKVSC1Rs85WXeXPFPYS5B6oBAQBSwzMr2iQE996XV885MmS
         h/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G7zRHbQ9cFMYdjS7FpNUHVk1m7aUjV5Ubu/1eFZxeRs=;
        b=K591zYfZpZ9nJV4K3y60ty4l89A1+RhdShskNbKpMnbmw9fRhek0XU0/CExB8Kj4X8
         Lv2W2PPQDEOqVcz5VyaOqEUYiIPJe+pmk4IAGwi7d+trgJrsupTQ8P2O12Db+AweTlo8
         1lIH0kHhd+RqfUA44b7eJCFp5GFcTSe1aspULgY/NQstmRtcsRzy8KQqxZAa7VZ+qwMI
         Fagh3kcYJYzdNPCG0ib+QzdimATGccmyTzMgl1EF/4g4IMJVmYaTS4fnRVPvEr4kFGfv
         fdGBH9l1HlT9ZYhv6+lp+ebA+Rt7RYP3qpF4GSVfIooQ6pCWh88FGODwMJnCNlL6eSzd
         yYvw==
X-Gm-Message-State: AHQUAuYxxjGyte/giB1hcx0aan3oXDPhAJW2DtKXLhcuZu4SzTXKPYzX
        jZRLbouxWWoLmGdTrbipcjg=
X-Google-Smtp-Source: AHgI3Ial7Of73f8V9tftwVRblmCVFF48kZfmGGI89d2BrTXdQe9LQQdXPFWSnHKvlFigOfkhljnHTA==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr4049441wrr.174.1549874959730;
        Mon, 11 Feb 2019 00:49:19 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h13sm292841wrs.42.2019.02.11.00.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 00:49:18 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:49:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Dan Rue <dan.rue@linaro.org>
Subject: Re: [PATCH 2/2] selftests/x86/fsgsbase: Default to trying to run the
 test repeatedly
Message-ID: <20190211084916.GB62722@gmail.com>
References: <20190203134017.9375-1-broonie@kernel.org>
 <20190203134017.9375-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203134017.9375-3-broonie@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Brown <broonie@kernel.org> wrote:

> In automated testing it has been found that on many systems the fsgsbase
> test fails intermittently.  This was reported and discussed a while
> back:
> 
>     https://lore.kernel.org/lkml/20180126153631.ha7yc33fj5uhitjo@xps/
> 
> with the analysis concluding that this is a hardware issue affecting a
> subset of systems but no fix has been merged as yet.  As well as the
> actual problem found by testing the intermittent test failure is causing
> issues for the people doing the automated testing due to the noise.
> 
> In order to make the testing stable modify the test program to iterate
> through the test repeatedly, choosing 5000 iterations based on prior
> reports and local testing.  This unfortunately greatly increases the
> execution time for the selftests when things succeed which isn't great,
> in my local tests on a range of systems it pushes the execution time up
> to approximately a minute when no failures are encountered.
> 
> Reported-by: Dan Rue <dan.rue@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/x86/fsgsbase.c | 27 +++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
> index 6cda6daa1f8c..83410749ff1f 100644
> --- a/tools/testing/selftests/x86/fsgsbase.c
> +++ b/tools/testing/selftests/x86/fsgsbase.c
> @@ -379,7 +379,7 @@ static void test_unexpected_base(void)
>  	}
>  }
>  
> -int main()
> +int test()
>  {
>  	pthread_t thread;
>  
> @@ -437,3 +437,28 @@ int main()
>  
>  	return nerrs == 0 ? 0 : 1;
>  }
> +
> +int main()
> +{
> +	int tries = 5000;
> +	int i;
> +
> +	if (tries > 1)
> +		quiet = true;
> +
> +	for (i = 0; i < tries; i++) {
> +		if (test() != 0)
> +			break;
> +	}
> +
> +	if (quiet) {
> +		if (nerrs) {
> +			printf("[FAIL] %d errors detected in %d tries\n",
> +				nerrs, i + 1);
> +		} else {
> +			printf("[PASS] %d runs succeeded\n", i);
> +		}
> +	}
> +
> +	return nerrs == 0 ? 0 : 1;
> +}

So this isn't very user-friendly either, previously it would run a 
testcase and immediately provide output.

Now it's just starting and 'hanging':

  galatea:~/linux/linux/tools/testing/selftests/x86> ./fsgsbase_64 

I got bored and Ctrl-C-ed it after ~30 seconds.

How long is this supposed to run, and why isn't the user informed?

Also, testcases should really be short, so I think a better approach 
would be to thread the test-case and start an instance on every CPU. That 
should also excercise SMP bugs, if any.

Thanks,

	Ingo
