Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BD62083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2xcfarI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BD62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756158AbeFSHbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:31:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39114 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755614AbeFSHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:31:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id f1-v6so10467689plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3nA5XfMpvLeaTLcn03ISzJGduCGaoI+gJkp3sLaeBw=;
        b=t2xcfarIbMls2ey7GpnVEBGGXytIDSX2bEXxApv657LUNm2oYpZL0dqWjdijLP7YcQ
         4j5845/M+c3UxTdlgXlU6R5vBdovvP8E2RfCE1BxGOKZHiU0nYxh+Er6qEaQghC9WCus
         guPZVffC9QEeXG0gvwoWJrfBtMlzDYXh81wmDlR1FdzhQPqM7c2xhyOYRw+/cnQ5BZ6/
         8Fz6IfkrcKyjsQluI50q49YIsN16/CpW2ZtOO6269EpHO+hN5Jsb88eIsr2rg6ZZxVVQ
         gZGwliqJa7mktYRvqYyjBJV3ktZWAQcPPDBqf+hxo99/m0bf7MAb2LFHH7QyqUZza62K
         oBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3nA5XfMpvLeaTLcn03ISzJGduCGaoI+gJkp3sLaeBw=;
        b=FmJyhRzpxIDE31ljN4nBUvdNd9JurWw56H31Usti6Lj30zXsHyCkcl90E2hI0/ysfN
         S/kg12hfRwM9tL4Kao8oAAqVL5lpfDvxuxMfcCv2wXjWQQtnyhWilk5Vz4NaT9WqriWA
         1kAhK05SoeoaWOherHIaR/nawEpfix3PzOriFrrG6xGYe7xSdCz3h6zXlJf4Q8RMrVum
         Hmp9M/2pu2TQHWbtSBEqBEGOYajZKlprnEORAbbmSmBwkWEHDtV8sO+iLF6LNmT4ioRe
         3FBrqLUQukCxPL+68N1Nb2J8BeaSoSD/pJKwJ/fMaAKgF1/kZHtobALtW2c14wNuEdRm
         H6eA==
X-Gm-Message-State: APt69E1OlrrIEWYHbXQ6C+X1lknwTh5+o/gfC7dpJtIjm11jFUZFmDCU
        yIGW9wO41yQNJm0HgXl5OdK15g==
X-Google-Smtp-Source: ADUXVKJV/qYdAdxx8HWV9Nv6SKrUOcY/ra4YjmLg3ZtyY9wSI676+6U0kqgOoCFYLkISVzK/ZJR0fw==
X-Received: by 2002:a17:902:7e42:: with SMTP id a2-v6mr17472806pln.151.1529393476983;
        Tue, 19 Jun 2018 00:31:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id w7-v6sm19612565pgs.68.2018.06.19.00.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 00:31:15 -0700 (PDT)
Date:   Tue, 19 Jun 2018 00:31:15 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH 2/2] rcutorture: Fix rcu_barrier successes counter
Message-ID: <20180619073115.GA241700@joelaf.mtv.corp.google.com>
References: <20180619062215.221564-1-joel@joelfernandes.org>
 <20180619062215.221564-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619062215.221564-2-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:22:15PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> rcutorture currently increments both successes and error counters for
> the rcu_barrier test incase of errors. It should only increment the
> error counter incase of errors so make it do so.
> 
> Test: Introduced rcu_barrier errors by returning from the barrier
> callback without incrementing the callback counter.

Hi Paul,
Think some more about this counter, I think you mean 'successes' as in
'successful attempts' than 'successful test' ? If so, then perhaps you can
drop this patch. It wasn't clear to me what the 'successes' meant so I may
have been a bit misled into changing its meaning. If on the other hand, it
means 'successful test', then yes this patch would be Ok then. thanks! -Joel
 
