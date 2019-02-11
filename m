Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C3C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CA42173C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874750;
	bh=Qfkz17n6olhrae+s/cFWU755MEEZiKxaLHZ1EVMeOQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K+UI6QxgMwbv9+/aJTn9w1iuZmw+S2D2rZxLrXuB+mKNj/ls5KQ2GG72wg9FAm622
	 bKmpuQ04hQjLH4AiVDJh7xNFJHSb1D/Bf24NR/B7AqYvufV6pNva2xDdb7zi7O3Spl
	 HRwSCJ2OwBxWg0Nmz6DmDeRELITXam2oE8Ia/RW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBKIpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:45:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35418 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKIps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:45:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so15474417wmt.0;
        Mon, 11 Feb 2019 00:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JRKy4taTM4QJQjspOqNaz3J3mz7heehQq3+CMjxazpA=;
        b=iv5HMlQ2DpMdOzv0QI3PLiYoKWwIwj7oXeURqfwv0AArKgg9ywNweDFLYTEBkt3mTf
         osOVORBVxup0DtIy7VjcbTp0oQDyzR6Y1FggPfw72TmGnZOK1HKgE+qNIEgjUemY+lsb
         F/yuuwaCYix0D1sY+XPlXNiCTgIyaH+I4hlNTiuyzkoTHblXVmWmvrmuoCPaeopvIdYg
         xQ90uxr9GYXkVCugzPjgRGPeYqDZYZeS+gEFbVdaMXurdeM9HWYx/vIZfWfncUzTEhHE
         F+8j7QSFl4M9gFE6v9ENOqNfnjMmcHrx+dFh7hSJqIDEIryWUlQueOXLcDaicy4sSXTk
         t43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JRKy4taTM4QJQjspOqNaz3J3mz7heehQq3+CMjxazpA=;
        b=M8Xk6cFAM3uAl72TNuxmwDaYGFJGl7QtkzWG4N1SyXLVa+geKp2YNxIuQJ4UVeMy24
         BFIBUenuL1NdajoSaJu7pi2aYW36k2EsX9vBEouLOpd4eghfjCF9GlMBpkP/vk3hSxFe
         46M2o12EygKhqiUb9R97OyRtOXz+Prqre2rqarq2DRZmgECShmean/6JndRI76NFt7cx
         N/I5sYCceRwVEIFeUgR+TcYF6uUcykwU6VUOHYOKuk8LawI1aWPI255C8A3VbkxMtbhI
         fDOou8M6dy48t+JQy3jf7bN4lwES3304YB3Cu+haeixZCcGyankNA+Ddcyc6ZvSwy2F3
         q1Xw==
X-Gm-Message-State: AHQUAuZqizFPVYEG5WnlyFaEF3yySOQq1xMWyyLzSYqSPPJkjsDC7rtj
        AKRx8V7yFQO6ndxtsFaS6VA=
X-Google-Smtp-Source: AHgI3Iboi/ErRzZ8eJyqL8hYEviuk0egC4q3NLhWiyjRmYDYaTAxnWKpYGQ+DKP64BzTn9a+3lfSzg==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr7424716wmb.24.1549874746100;
        Mon, 11 Feb 2019 00:45:46 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z18sm10362027wml.36.2019.02.11.00.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 00:45:45 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:45:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/x86/fsgsbase: Indirect output through a
 wrapper function
Message-ID: <20190211084543.GA62722@gmail.com>
References: <20190203134017.9375-1-broonie@kernel.org>
 <20190203134017.9375-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203134017.9375-2-broonie@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Brown <broonie@kernel.org> wrote:

> In preparation for a change to make this test run repeatedly which
> would generate huge amounts of output as is indirect all the printf()
> calls in the program through a wrapper and add a quiet flag which can
> be used to suppress the output.  This is fairly quick and dirty, I'm not
> 100% sure what would be idiomatic here.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/x86/fsgsbase.c | 52 ++++++++++++++++----------
>  1 file changed, 32 insertions(+), 20 deletions(-)

So this really loses useful output when there is a failure. After this 
patch I get:

  dagon:~/tip/tools/testing/selftests/x86> ./fsgsbase_64 -vv
  [FAIL] 24 errors detected in 1 tries

Not very helpful, and no real command-line way to see the failures.

While previously it would tell me what's going on:

 dagon:~/tip/tools/testing/selftests/x86> ./fsgsbase_64  | grep FAIL
 [FAIL]	GS/BASE changed from 0x1/0x1 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x1 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x1 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x1 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x1 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x1 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x1 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x1 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x1 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x1 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x1 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x1 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x200000000 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x200000000 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x200000000 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x200000000 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x200000000 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x200000000 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x200000000 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x200000000 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x200000000 to 0x3/0x0
 [FAIL]	GS/BASE changed from 0x1/0x200000000 to 0x1/0x0
 [FAIL]	GS/BASE changed from 0x2/0x200000000 to 0x2/0x0
 [FAIL]	GS/BASE changed from 0x3/0x200000000 to 0x3/0x0

So I believe at least failure messages need to be preserved.

Thanks,

	Ingo
