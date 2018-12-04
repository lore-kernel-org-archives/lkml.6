Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB5C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C953F2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZciiACp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C953F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLDC4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:56:21 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39850 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:56:20 -0500
Received: by mail-pl1-f181.google.com with SMTP id 101so7513607pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPrsEMS0/LxvD+8DdavYKhZj3xEcl4LkuFNF1kHagjs=;
        b=WZciiACpZvNewYkoCEF89CUkaTSn4KYpKf3FO4HkSXNh6rU7nvStE9NcZeyByHjQBT
         B8+rmvsikI/m1x4npkWftfYv+J9WSnvoJumJ18B/O6aSwzM5auEjnSzwDjzMTTHmNnV3
         FlXmoeXYwJUSnaOWUyPU+LK2qYvmTOe7ivWWOMPaA0ktT7wXeQOaX/ySZ4wk+wbBjmKB
         KIIkkWKH74WWV4ScMx673TEzgWBIwTA/MyfKFxmKPo+HnaW/UNMo4Vkp2SVrVWCyPSDD
         OVgmKRZbTotd19HuNhFlqoYFHwyqeGZZZ+wEIhUsuwats/LqqK5+Vy0W2d5G8DH/1J4x
         xHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPrsEMS0/LxvD+8DdavYKhZj3xEcl4LkuFNF1kHagjs=;
        b=Z3aLZuzPQsIcFRHNttyaFdbvgARm1LKuYImJL63U1jEucdI2KeQy/CAi8Vsw5PLdKz
         HIWkFO4tQxqAEqf7E20HXY711LkLJfHUytQcKm2tG0G4bLEcrXnYKqfI8+WKUh/8afKG
         KL/wd0h+W0H9XJl4LGYsAIEspWPLMW1pRBoh65SV2a81yeN0kDODpb5vzjCILHFnApPR
         UqxdqAbWkpfdYpAN8SCt+9Kage8VD7F0H0KBIt4RKPVt2ZKrnm9f45bnLyCZxs0wGeDd
         fGJ/BzwmSGJItvSP8J5bSVIluoFKNDIpK396DyrsmW3ulTnqfcIouaReZowYxZ7qTLgW
         0kuQ==
X-Gm-Message-State: AA+aEWZrBRHcYw6V+CtD+igvrzSFREMXupN/yrxvBfUNGHojSYDVz2Lg
        /GbTeSi5PXBUTi6VqVUtvEE=
X-Google-Smtp-Source: AFSGD/Xg+XPKGhjIapLkItOD4tIPqTGitzlka1XwMVdDCJfQjL58MAZGaxpOkqcSh5/MP9HE7/Y+nw==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr18119957pll.33.1543892179225;
        Mon, 03 Dec 2018 18:56:19 -0800 (PST)
Received: from localhost ([175.223.44.178])
        by smtp.gmail.com with ESMTPSA id y1-v6sm20108478pfb.81.2018.12.03.18.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 18:56:17 -0800 (PST)
Date:   Tue, 4 Dec 2018 11:56:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181204025614.GC7580@jagdpanzerIV>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
 <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
 <8634f952-7a14-055d-943c-d219ab5d8c1b@i-love.sakura.ne.jp>
 <1c1de4f8-f08e-37e5-2438-47ab985d476e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1de4f8-f08e-37e5-2438-47ab985d476e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/02/18 14:02), Tetsuo Handa wrote:
>  
> @@ -1541,11 +1545,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		} else {
>  			u64 seq = syslog_seq;
>  			u32 idx = syslog_idx;
> +			bool f = syslog_partial ? syslog_time : printk_time;
			^^^^^^

>  			while (seq < log_next_seq) {
>  				struct printk_log *msg = log_from_idx(idx);
>  
> -				error += msg_print_text(msg, true, NULL, 0);
> +				error += msg_print_text(msg, true, f, NULL, 0);
								^^^^

> +				f = printk_time;
				^^^

>  				idx = log_next(idx);
>  				seq++;

Can we please have something better than 'f'?

	-ss
