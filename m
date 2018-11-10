Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850F12089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XUIPiZNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850F12089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeKKHd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:33:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33148 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeKKHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:33:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so2507593pfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fJLqSDdUI5XZiDtgqi8bBUJo6cj3b2+RjL67ExJB/xk=;
        b=XUIPiZNXpQda6E1oRRs/6LTgk6Y7qfv+RjZIQ1gtExgl9eK/urmbObZI69KaR3Wvsg
         bjPYS/Nw1G+z+VT1RST8bzmuX/aG+bN/N0pF5krP1Rxt8Wij0991wkvFAFDx/Do99ctV
         bAeNkkLtazOh6j2JMz5CtCA09EfFY54JDv//Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fJLqSDdUI5XZiDtgqi8bBUJo6cj3b2+RjL67ExJB/xk=;
        b=CHIvv6e2wAAhvSZhKUSNxPgWJJux+2KaYRe8ONNgeww4uvibEFL6JyVRT3847jrjn0
         35UkUz4RRF50D2yTfbDt0OOxxDvEAxMHRtuhPqPHQ63kc58pwT8Hi00NnPf8j4+9UBbC
         dFzwFtBj80HCRa1dRRtM9bOLYm/Oqg3s00JtReRAa6NBa56MsmtbGLjvmD8iZ1vNzBO6
         sbJBVDBprvH4kjcoAL7YSq7X9Yt8wam1fdcZ5HELp1aY0ffktv95tEYrqtETMyqajGLR
         bfefl4XzSvcFRDJ7lnI0/8aYR9/SvyCXdOrEbDQlYlrHFx0FcIWZcgj0HXIZ933s7DGW
         50mQ==
X-Gm-Message-State: AGRZ1gJISRQDOrVeybRn14yY9gJ4sOyQNeuIMQ9WJBJvgcidZ0upXoAG
        yHwMNSvaLFXCx3CCRdZXQJGejl87R9Q=
X-Google-Smtp-Source: AJdET5fCmnkYYk+4ORtTCuPkVcIto9M0ZcVDnDyhCMuyICOCiYyx3lasktqUtCr3YMQq0Q+YdsVE/A==
X-Received: by 2002:a62:6d83:: with SMTP id i125-v6mr14543106pfc.184.1541886421244;
        Sat, 10 Nov 2018 13:47:01 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id f62sm10932310pgc.67.2018.11.10.13.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 13:47:00 -0800 (PST)
Date:   Sat, 10 Nov 2018 13:46:59 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: dyntick-idle CPU and node's qsmask
Message-ID: <20181110214659.GA96924@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and everyone,

I was tracing/studying the RCU code today in paul/dev branch and noticed that
for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
corresponding to the leaf node for the idle CPU, and reporting a QS on their
behalf.

rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0

That's all good but I was wondering if we can do better for the idle CPUs if
we can some how not set the qsmask of the node in the first place. Then no
reporting would be needed of quiescent state is needed for idle CPUs right?
And we would also not need to acquire the rnp lock I think.

At least for a single node tree RCU system, it seems that would avoid needing
to acquire the lock without complications. Anyway let me know your thoughts
and happy to discuss this at the hallways of the LPC as well for folks
attending :)

thanks,

- Joel
