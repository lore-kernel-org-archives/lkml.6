Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09453C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C726B217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="pkYPn7hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfAHRxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:53:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52255 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfAHRxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:53:10 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so7520349itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3GIfi0mzd1YkTFPgjUVAySFXLfZF+qx0yiYs0H4m74=;
        b=pkYPn7hqf5wOwvcPOJbZPrk8dWV9YqJ1RcwVsQbc0QkSD2nl7owcwhEn/K59KrbNwl
         C6zQ87KmjsBOwWgDZDs9QbExAw+XAf/BUYz5ppUCYnTOjHmlEKU2ofu2X/NkOFTSugAW
         gpEBBrUynlkGTUjSUSmQBrcxBf7YEvdVrFLVQe0jTV0HG4OQusTya/cYQmx8dNcjQzVs
         U4WUkPNMzIHEZMrYPrmDHB7WGOsqLMj9Mg1o19QbIep+vbqP7Ig1Pqh0ZeipcFjys9Nr
         +QT0r9V/k4Y3j/k2yIQUrozTZ4TDKU0uFF6hyUjKuU6bLoarEG/ut279268fmqoQqTCF
         dq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3GIfi0mzd1YkTFPgjUVAySFXLfZF+qx0yiYs0H4m74=;
        b=IwiLp0KpCclN+fdupFtI1XHPxZ6CnWhlADDZIkdfHvYP1m1cqZJLaoTlEtckC7Rfbw
         VdHBtLCLcQsKV1k5CDSEMyJEgUyoQ66P2ImSpuhOUHDfdcULWHd1HpOoyom3rXxza7W1
         sbG13ClDF0EER2uuScjvjZ1t20bWW/FqCQKLShPdR3HNvRHYXWeTbD8VfwgtBqmcUifx
         RNPFezyRXZN0xdcrXbjH+/pn0L1xw+JEHW9XfGjzh3r8P2hJ8ELsTbcLU5Mx8GDpafPG
         /JR2HOf9iGZCURQpAEmuas9QbfhMZrWMh4jplDyXLuGQWZmQfXfOvXVVOaw2CmayacfS
         7BFA==
X-Gm-Message-State: AJcUukcFrndjg/HCwiwny8vyKCTiU1GVR1DV1XsbxPdx8V2J0+6K0h4s
        mV5PxHusy7ZVbqvEY6UPIVJhlw==
X-Google-Smtp-Source: ALg8bN6tAI2U9meHeNSsA7qaOA+8P5ucCSsMyEfYHmvUdS6jDYBN8WDFwzLAbGpgf3VIVJLayMqT9A==
X-Received: by 2002:a05:660c:1cc:: with SMTP id s12mr1835632itk.33.1546969989435;
        Tue, 08 Jan 2019 09:53:09 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c092:9114:ac14:211f])
        by smtp.gmail.com with ESMTPSA id b25sm8199316iot.10.2019.01.08.09.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 09:53:08 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:53:06 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com,
        keescook@chromium.org, akpm@linux-foundation.org, jannh@google.com,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v7 2/2] selftests: add tests for pidfd_send_signal()
Message-ID: <20190108175306.GF29009@cisco>
References: <20190102161654.9093-1-christian@brauner.io>
 <20190102161654.9093-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102161654.9093-2-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 05:16:54PM +0100, Christian Brauner wrote:
> +			/*
> +			 * Stop the child so we can inspect whether we have
> +			 * recycled pid PID_RECYCLE.
> +			 */
> +			close(pipe_fds[0]);
> +			ret = kill(recycled_pid, SIGSTOP);
> +			close(pipe_fds[1]);
> +			if (ret) {
> +				(void)wait_for_pid(recycled_pid);
> +				_exit(PIDFD_ERROR);
> +			}

Sorry for being late to the party, but I wonder if this whole thing
couldn't be simplified with /proc/sys/kenrel/ns_last_pid?

Tycho
