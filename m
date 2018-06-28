Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45EF27141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzDEzYZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45EF27141
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935016AbeF1JIR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:08:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36284 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbeF1JIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:08:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so2458410plp.3;
        Thu, 28 Jun 2018 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8NxqkHFXA/3HkoBn0mLd3Wyr6DbthcrMCDl2Wy0bOsM=;
        b=YzDEzYZHj7/a/AXMqsrrjuggke6gWUjc9zb/EawlVZo58BsKcFo3FozGlE2GP3JVvL
         HDENGCKFpKvcJa9uZjjpl8f8rZB2JS6anzoL4E8x4Rl9BhFtqAaxNeT6ILbo38b98ueo
         WcZr5D/xlwKb+k1mQzK5u/VYk7Df+phlLiDK9Ptbdr6ipx+0yB4g8XT4S3N61kHDzIqn
         QhiC0Fmls4eZMgftc3Fz3j1n/1lZVCWfJpaW7AXjV1w/A2uf0tiViy1UnrbafzQP71w4
         suPJHTadyeTVOjqJSTeKlxPEUgBD9xGw5OoNrRIgUvg+hF48w1WIp0kvtgNvTdmGpmEj
         XlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8NxqkHFXA/3HkoBn0mLd3Wyr6DbthcrMCDl2Wy0bOsM=;
        b=BmVVlKpCwiTzwya7gZZ5YeCIq+KG7pvDioIjWOvCVcIsQwHAIqNO0tFljIciSXr3WK
         8IL4cC5NMEldnhzWU6nNxzzDe2dbEuztJHBaSuKN3pgGuWTM/D8aGiTq5u6AirKxsx4J
         bAft0ETv1zWunfE9VM4Zk+OG8Xo+yl0ogT660+RtO8iN+V4vKKHYag8oezpzCyCGXZib
         w6Pp45qRQlc0Cpn6LONOWIp0IwO7W+qAutB3+TABtNf+EaTNauxWwioZGokj4eNHYDHm
         fPOqyU2PGXQypoE0RAfb/E8ffWq9UUO1h9jo7a4XRN7JmA9XqyVwXkipFV934Pi4k+tH
         Xhpg==
X-Gm-Message-State: APt69E38WNqH9/npIBmUferSkeMO6mnQUuKVDqn0v2tqmW5Yh5dCcG2l
        OYgskW0Cj6zGxRa1na3BdDOikY12
X-Google-Smtp-Source: ADUXVKIKT3hpnl1nisBS2BfeYKpCid18/Zf7HWAHZTWYVrOdFVLlb3hXrrfKkDYHZdmZpq4Z17fKnQ==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr9549984plf.109.1530176894536;
        Thu, 28 Jun 2018 02:08:14 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id g83-v6sm25890881pfk.94.2018.06.28.02.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 02:08:13 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:08:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180628090810.GA2286@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627141612.GA477@tigerII.localdomain>
 <20180627143419.r75lat5cwzw3hns2@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627143419.r75lat5cwzw3hns2@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 16:34), Petr Mladek wrote:
[..]
> > > Changes against v1:
> > > 
> > >   + Move the check from vprintk_emit() to vprintk_func()
> > >   + More straightforward commit message
> > >   + Fix build with CONFIG_PRINTK_NMI disabled
> > 
> > Did I miss out V1?
> 
> It is the above fixed link. I am sorry for the confusion.

Ah, yep.

[..]
> Ah, the following line somehow confused git send-mail and the message
> had broken list of recipients:
> 
> Cc: stable@vger.kernel.org # 4.13+
> 
> I have sent it once again as you have already noticed.

Got it. Happened to me before as well. I asked because I sort of have
some suspicion that lkml email deliver has not been completely reliable
lately.

	-ss
