Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1458FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4232206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eSoKoFwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBVLVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:21:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50916 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBVLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:21:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so1623981wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DOe342s05jtJ9dglrdQN0RDWh6bDULJiWV28ZrJBYWo=;
        b=eSoKoFwalpmaGFsWEpplXQfNHbN1CWaOvUWcjJT18aU++hr3v4yQTsoLlq4F8zxI1O
         Xe+cRRfxSn9XUXQ9ldo0t0P8gy6YxwRpQyvzOLYfs61lAY4wpQhYMn7vWiArIwrnxZfF
         BQrytGO8Kr4pgHkwoqr2QCH6S7dWM8KOvDVc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOe342s05jtJ9dglrdQN0RDWh6bDULJiWV28ZrJBYWo=;
        b=jkCh9lTFy+XYRyRyWva+WdivGH5v86tqsWgXk3YJhQTHwh4JSyHa1alcnCipNf160E
         weTwywAkzZgWaEIisauaa1S2xyB9Y2n9snjKHDRB1wqLMwDVVrPihpJnanBCo4EEBDaR
         1cM7zZcxhluxIGG+6SqLo59swDNeaGW5FUpIWrULlFBF6gHFrjVV13l4HkDhFqTFxaqC
         Y7cpdGHzWd63FifDBuUMMcPmNMViCzJaAcdSha8seQkdUKJFiyeU0l0AU7glky5oXl8Q
         oo7cNf+hZ9XO6o3lkHDjWD6RWoWml2LPKdkv+10kqfh8d3NnmlZ1z8N+uxDFWAWn/9an
         ccvA==
X-Gm-Message-State: AHQUAubkD3rRTXU4LpZQwJ+00QdbKs7OVQJw3/RsKPqxkJwSoc1c6H5u
        d6o1vYqSRTN+uuC+QGUf+Jk6kg==
X-Google-Smtp-Source: AHgI3Ibph9yR6rdJ0vtNV9S/m2NeM9Z1d4aaw1qJovb8CFmN/BASWAmQZ3E/dv5v9AYwBG7fRVRh3g==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr2042633wmk.47.1550834494959;
        Fri, 22 Feb 2019 03:21:34 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id n3sm1248827wrs.10.2019.02.22.03.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 03:21:34 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:21:28 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190222112128.GA7213@andrea>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What I do object to is a model that's weaker than any possible sane
> hardware.

Not the first time I hear you calling this out.  And inevitably, every
time, other slogans come to my mind:  "C is not an assembly language",
"No features (ordering) without users", ...

For the record, I won't try to push this patch further; I also have no
plans to touch herd7 internals in order to add the ad-hoc flag for the
(dep ; rfi) thing.  (Maybe others will/can step in here.)

In the meantime, the hope (admittedly, probably vain) is that this RFC
could serve as a further warning or as a reference to those developers
who are quivering to use (dep ; rfi): enjoy it, be careful.

  Andrea
