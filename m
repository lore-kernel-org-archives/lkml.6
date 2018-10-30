Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B3220664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OdbZCJGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B3220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeJaHWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:22:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35767 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJaHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:22:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so5674948plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ODUHw4UpJEs657WSrEknsU0kC3MCLVZKf+dGAdOHRew=;
        b=OdbZCJGpOkizf9H6t8umcdfivPvqBSxuC6T0SV0SNrwAGhjxzOPuX5CtjgU8sUCM+b
         /ntrl0y+HNiir/q17RDWQvmzf95zQGtXogHd1oqVUaz6zJf8jMReb6yc8L8UeXu0WZ3i
         3eUbKPHm/XvUL9f2zk9BkSikpscTu+D/7iOXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ODUHw4UpJEs657WSrEknsU0kC3MCLVZKf+dGAdOHRew=;
        b=r2hDYh2F2XoNkLyiquuJWEhHdIL/unLsqJ8ly2BMI7giOYOOj3bdBofi5bxJQDw4nA
         duiHp2GLkF7D/G3rVq+A1RMA+BKtV5cywSCdCCX3642RRK8wikQ2IFnh8TkjY2JXr5ta
         3B9aT1OWxmaP7GutLLVkcXBqJBZlWFcW54mBCLT6oaxWZw+cl7EcCMu5oAljRcmmE77u
         BO9sWF6eS4CGg6jIjKKn0dc4N5OEBEsWghbbaFA5d/2Zi3iDL8YRl5G2hEmyLvwv68kT
         KxezfFm5woJloC5Q2WaAzla2nr2of75+NPWpwX6sQfcVdmgeWJHNXPcvoqXcTpbtNjgc
         2hNw==
X-Gm-Message-State: AGRZ1gL7smngqTrraLFMqFIE/jUtOb4ID0jgPxFTOfEMaB6PKIG9fme6
        oVZVGzQi/WRWZ+L87e6owd7aSA==
X-Google-Smtp-Source: AJdET5cuUN0CWOsrtq8MBcy3JATU/S6jH6zq+Y/1/4193zUhu5ZYKURyGRSx4Ibhj06MbdFePFYL3A==
X-Received: by 2002:a17:902:744a:: with SMTP id e10-v6mr559443plt.61.1540938411854;
        Tue, 30 Oct 2018 15:26:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q11-v6sm2518580pgp.62.2018.10.30.15.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:26:50 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:26:49 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181030222649.GA105735@joelaf.mtv.corp.google.com>
References: <20181028043046.198403-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028043046.198403-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> As per this thread [1], it seems this smp_mb isn't needed anymore:
> "So the smp_mb() that I was trying to add doesn't need to be there."
> 
> So let us remove this part from the memory ordering documentation.
> 
> [1] https://lkml.org/lkml/2017/10/6/707
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I was just checking about this patch. Do you feel it is correct to remove
this part from the docs? Are you satisified that a barrier isn't needed there
now? Or did I miss something?

thanks,

- Joel


> ---
>  .../Tree-RCU-Memory-Ordering.html             | 32 +------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> index a346ce0116eb..0fb1511763d4 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> @@ -77,7 +77,7 @@ The key point is that the lock-acquisition functions, including
>  <tt>smp_mb__after_unlock_lock()</tt> immediately after successful
>  acquisition of the lock.
>  
> -<p>Therefore, for any given <tt>rcu_node</tt> struction, any access
> +<p>Therefore, for any given <tt>rcu_node</tt> structure, any access
>  happening before one of the above lock-release functions will be seen
>  by all CPUs as happening before any access happening after a later
>  one of the above lock-acquisition functions.
> @@ -162,36 +162,6 @@ an <tt>atomic_add_return()</tt> of zero) to detect idle CPUs.
>  <tr><td>&nbsp;</td></tr>
>  </table>
>  
> -<p>The approach must be extended to handle one final case, that
> -of waking a task blocked in <tt>synchronize_rcu()</tt>.
> -This task might be affinitied to a CPU that is not yet aware that
> -the grace period has ended, and thus might not yet be subject to
> -the grace period's memory ordering.
> -Therefore, there is an <tt>smp_mb()</tt> after the return from
> -<tt>wait_for_completion()</tt> in the <tt>synchronize_rcu()</tt>
> -code path.
> -
> -<table>
> -<tr><th>&nbsp;</th></tr>
> -<tr><th align="left">Quick Quiz:</th></tr>
> -<tr><td>
> -	What?  Where???
> -	I don't see any <tt>smp_mb()</tt> after the return from
> -	<tt>wait_for_completion()</tt>!!!
> -</td></tr>
> -<tr><th align="left">Answer:</th></tr>
> -<tr><td bgcolor="#ffffff"><font color="ffffff">
> -	That would be because I spotted the need for that
> -	<tt>smp_mb()</tt> during the creation of this documentation,
> -	and it is therefore unlikely to hit mainline before v4.14.
> -	Kudos to Lance Roy, Will Deacon, Peter Zijlstra, and
> -	Jonathan Cameron for asking questions that sensitized me
> -	to the rather elaborate sequence of events that demonstrate
> -	the need for this memory barrier.
> -</font></td></tr>
> -<tr><td>&nbsp;</td></tr>
> -</table>
> -
>  <p>Tree RCU's grace--period memory-ordering guarantees rely most
>  heavily on the <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>
>  field, so much so that it is necessary to abbreviate this pattern
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
