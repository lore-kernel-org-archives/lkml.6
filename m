Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96321C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63A2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ee+vdNz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIZA6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:58:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37434 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeIZA6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:58:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so22787463ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+CK6/JK9NoS9LCQtCqUtUy7XYEtjbTk8RCaxRN4oyE=;
        b=Ee+vdNz0oRrepr40QayxH2KChXVIFdcF6XiZl+e/TK7GjXt6OxWzAIyNrthXMbDaOc
         qLELqUzObikPoB2HebvldN8vGnU5R/tnlvHetYWkB1cNET3y9S7hVxmgLpzZTP1gQd8k
         uvhtyrp4PHXMiMbv6bp0mHCjyljA3nQ3X2mXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+CK6/JK9NoS9LCQtCqUtUy7XYEtjbTk8RCaxRN4oyE=;
        b=CEP55lF2DQKA1Roy7s1k/vrwX1zFmvd1RVAzJ48w3XH2Fd1xe7H82tiNdVhYCQ2uzy
         /t4xVgmEnIO1zSng/jkFpZBQt8FGHci2ovVBNRbPshKGpueOyMHlUeKSytP6dPS2ccOM
         pka+AiNYdA1pPzzWYMzAaU+9VuXZ6f14yoxGaJpGdEa45fwIxEQc39j4gnQMyboMosQN
         0LDfqeYOWATxoA+3uhQorNAWH/D/QiWCJv/rXRrZZmk6d/qk9/JraoiIjBNP9hdgK5Q+
         IKDwkjxVVrvd5u8Q22ru1yMCX0BAAjZtnUjBi2Fvm8uUWj1vJAyEqRbRApP6gSEjUpek
         EX6Q==
X-Gm-Message-State: ABuFfojvh9BqhqbvGYY8sZpfqJy1QWfRdEM6BItjhh30SPsOUmnnoUj7
        g9X668qIjC8l69+PGQ5Kkj78DTkVChNBXr2pgkP+6OcM4rQ=
X-Google-Smtp-Source: ACcGV63u/3+NqecsKqbo2XqsCwlLXzTvnL8lUC7oeiKehBIHnj7RWJWbh7/p5GpjbrgN2K1HafMo4A5xaxFtbpaXnjg=
X-Received: by 2002:a2e:900a:: with SMTP id h10-v6mr1775226ljg.121.1537901361707;
 Tue, 25 Sep 2018 11:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180925182601.37421-1-joel@joelfernandes.org>
In-Reply-To: <20180925182601.37421-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Sep 2018 11:49:10 -0700
Message-ID: <CAEXW_YTjjfZhH6rpOArSVub_XhC4mvbKn6Rf0DSiy=rAHQGzPw@mail.gmail.com>
Subject: Re: [0/5] rcu doc updates
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:26 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Hi Paul,
> These patches are documentation updates for the rcu_dynticks rolling into
> rcu_data and also the updates to the fact that there's a single rcu_state now.
> Its based on your rcu/dev branch.
>
> Next I'm thinking of tackling 'RCU Callback Handling' and further digging into
> the dyntick handling and then dig into other documents outside of
> Data-Structure that need updates. But let me know any suggestions.
> Thanks!

Apologies that my scripts missed the 'PATCH' prefix. Hopefully that's
Ok for this time, but let me know if you'd like me to resend them!
Thanks!

 - Joel
