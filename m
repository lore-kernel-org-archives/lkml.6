Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38B9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879CA2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8iE1W1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879CA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeJSAMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:12:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37296 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeJSAME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:12:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so889572wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TLdFKQdJScMjrSvDQSmPVZ+rdRsNi8sWryyHKi+FXPg=;
        b=g8iE1W1BY97ABe1Z54TeflMXNB2HpDjslZ7oTThl6nZAyQLldOeG3kWlImBPrALSnV
         IyKJApOtz7xBi0W2E1E9VNYwKRZmTOzFjL4ZPnneIKy6/7+OkbmD4onRFAIHiZWXo0Td
         Xr3vuX1jE3WvPWrd3oQDKYG4H1tMG4JK1f6+CMTjrsyE/TML5/ukQzN/Ojj1tkpOKYRf
         gYsE6onxY0rTAHKknlCSejZ6Caec/0kCbdt08x8RLeQJby1JMSz9QnCh2zAA/bK2pP6c
         afO+lY0mgoFu3FWzrjW42uko8NC0TuvNf1H12K1qamdG/WJ3XPGDCm+mVm0J1kS8CuG2
         NUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLdFKQdJScMjrSvDQSmPVZ+rdRsNi8sWryyHKi+FXPg=;
        b=g4UFOLTeDVk5lzwiD9kjU9VW3XgmgpScNOyu1oISVabWHFFMAj+sxaKB14wgV7c9qc
         CAfv8vNwq3I5n1JLTPvs+jpUGoZg2QtPQle1/pbl9ZyLbVPTEqjLThzsy6mVewP3uy8C
         xd+a0t5XqhDmnI55yZ3/LSyd8LMdO9swGcgkKMnw5Eh3Vzf2ruPp8fdMkcxlZxJkSbiO
         sCqUZorOWlpKT2t7kCagU0JgsTtXTFaDCfzzycvBvP9iNingHXoiCZCGuFQ0W/N2OIS3
         +Tzpyc0hwZuyXH/VL/Ka17e/gK3ybOEdxgU3aHZWikBl+oyMTG5p84ue0rLbZzdIsAT9
         YuHg==
X-Gm-Message-State: ABuFfogASLSV6EcGsOf4q/9PwVEHuqhtjWc2Gg0qHmr4wCOArGN1ZIZ4
        iuUbSJOdIcuCjwmI2R7Vd3U=
X-Google-Smtp-Source: ACcGV61QjIjVF86Xb6J61FphI6pDZJjjcRQKLKup/k1HNBFspSjvN3sDbqk/XceJ/XE+wDMkTwajcQ==
X-Received: by 2002:a1c:924d:: with SMTP id u74-v6mr1022370wmd.105.1539879022878;
        Thu, 18 Oct 2018 09:10:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j2-v6sm15741605wrw.29.2018.10.18.09.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:10:22 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:10:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     joel@joelfernandes.org, tglx@linutronix.de, rostedt@goodmis.org,
        frederic@kernel.org, paulmck@linux.vnet.ibm.com,
        alexander.levin@verizon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] softirq: modify comments about PF_MEMALLOC in
 __do_softirq
Message-ID: <20181018161019.GA7573@gmail.com>
References: <20181018142133.12341-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018142133.12341-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yangtao Li <tiny.windzz@gmail.com> wrote:

> ---
>  kernel/softirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 6f584861d329..6193e1d1b30d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	int softirq_bit;
>  
>  	/*
> -	 * Mask out PF_MEMALLOC s current task context is borrowed for the
> +	 * Mask out PF_MEMALLOC as current task context is borrowed for the
>  	 * softirq. A softirq handled such as network RX might set PF_MEMALLOC
>  	 * again if the socket is related to swap
>  	 */

Can I add your Signed-off-by?

Thanks,

	Ingo
