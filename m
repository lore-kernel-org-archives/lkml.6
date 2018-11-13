Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE691C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00712086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqnQqw7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00712086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbeKNBsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:48:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38946 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeKNBsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:48:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so2663885qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gOAV0k2gvKfeb91puidkIzomn4EPqc9D+iWtYqWh1wg=;
        b=FqnQqw7lHxSVGOLBYEYli8jfN2D+DsX8vo9z5EvNDuRAqNGOkrpqOqTOcyj8cj7nIW
         CrgnbJ8RgADP3E8cvIBT2VIdJHB/LS3av0I/qt3skBSUVm3C8d0wGlL1Zl40FSJ8G6ED
         sMkuCJPS+aSSfp7Cza43n0jveKEwt1cZxao2dXAj58i8kQhMF+FZPvZY6JnztSwjl7S9
         YYS+y1YKtvVS2Y322yyN84uqpFPvNkZromtRuw9gIEOz6J6r4C8RPl+oT/6hOKvkmrg6
         vpn6toCca1n2xXM7be1wplXBDXoe0s2bbN2pKh/g5ng3mrLprYLSJ9jGNUujTfX1/Q+5
         yT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gOAV0k2gvKfeb91puidkIzomn4EPqc9D+iWtYqWh1wg=;
        b=Vh0tHz+nghLANrP4Wj1HMz9syMXS+DbVFPABXXZ9Ahva1ax5+tNbi4pjZFGGbQ5GZb
         WbtNOmXAoX3ElY5HaXx5YPybXS5AWU60OOrTiXJt6mefOwjsB5WXdrFYNldJC5vf9Gy7
         DUznHmnHO0x4gpvleErhDL4niZbA0r6E+8zvZHZA8DA7ruHfcfoWWLcS78YuUwL4oux6
         pPgH1QheIHLr/5IXBP248IDMARCP2/9qklFREZnJ+vZgO3HR4B4u9qXAGIxG1XMRfxDX
         E7LzRdaSrB/Pc6oK11ryPpL0k+Yx+1xJAFvyobI21Z6FiY+522XT6tKzE7qKtZNUAHXO
         81Sw==
X-Gm-Message-State: AGRZ1gLMBltNW1jklV/4AbWewCmFgP9/2WK8uhLIthipBavSru+InwuT
        eLHeb4tXiSDOTEOO1I90q30=
X-Google-Smtp-Source: AJdET5cPG2oMhWpQKz9isdIFacx/bo+jgWphvG/dRqW6jC9wzNXnr70BHEjvPETQkvAoXcHcP5j4tg==
X-Received: by 2002:a0c:9359:: with SMTP id e25mr5753964qve.203.1542124171783;
        Tue, 13 Nov 2018 07:49:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id g5sm687810qkd.55.2018.11.13.07.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:49:31 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:49:28 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH tip/core/rcu 34/41] percpu-rwsem: Replace
 synchronize_sched() with synchronize_rcu()
Message-ID: <20181113154928.GI2509588@devbig004.ftw2.facebook.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-34-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111194410.6368-34-paulmck@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:44:03AM -0800, Paul E. McKenney wrote:
> Now that synchronize_rcu() waits for preempt-disable regions of code
> as well as RCU read-side critical sections, synchronize_sched() can be
> replaced by synchronize_rcu().  This commit therefore makes this change,
> even though it is but a comment.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
