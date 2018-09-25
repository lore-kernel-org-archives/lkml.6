Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED2820877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoG7MVC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED2820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeIYRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:45:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35988 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeIYRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:45:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id y13-v6so8493234wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aMzBIJKO//61yASkJLO1ntOw8ZefWJE2C1d7h9j2g9Q=;
        b=GoG7MVC6tyhuEW4+WfWR4hPgi3oEJTBOQ+tY4l/K7RbJoeoveFFNo70AWjHHtnqEwh
         A2x/WwONrq3xwf85hJ7WuHE/CLRY2XucVFP1sbt7+zSg2NkeOBdW6v27ZsfBMLmSkjxY
         qcQSQdoOBrlLSc89DF2HZxbn1N+C7hM4A0pKUgSxsI6mG2PLSwxOc8HePID9EJjeNzq7
         1yT3oRV/BoPzwIVmLFuhxK9McSVjpAG3H7kZzJFVxPck+yGMsdrgQZ9qpR6mE9G/tGqu
         Ntf25xV4BoFHZ5riiYS7/alOB2nWe73rlA+z7DZrtZYDnVpCSCRapB74QRH/4o7ndk7A
         858Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aMzBIJKO//61yASkJLO1ntOw8ZefWJE2C1d7h9j2g9Q=;
        b=j52jpu9jv0nEJqlt9DBcVCl/FyjbxMwPp4m9KJYn0VixzUHViBXJ5iM7itssVhndzE
         NQwHaNhsIOmy/SIJ2dK+nBcvFaUZ/4IuLwEagwnWa5US2OVjJr+Om0oVhyw/BFj678/V
         ZMMMYv8PPNo/FUsAwYP8LaKWlD4LG3RrpPs+mY3EoeBMcKZ1biA92M+a9XFkJPGL50Ol
         dXa+PRWx1uHSJv8uXER7tAxjHQCnYaboklpHf5Y4z2hShPi3ajcK2ROJXBAwX9i+U31G
         r3PDuwcUb9f4LBtNiYs1fL5YyaOnWiuJ0EM6EuNdTPCPcU9Zure/f2C7v0lrfEyoWDTd
         N5kA==
X-Gm-Message-State: ABuFfogYPkjYufGwmlqEbwXdHxPGFEy5MyqQfCN0Wgle3M/RK3c7BQzk
        hoZ55lX7O9InvL48Luq/wfo=
X-Google-Smtp-Source: ACcGV62GNDHFzGejKcbzGc2nx6JR3fyWHYNO9hIN6pgUQOS+Vf2/1AAyaWxB5j0+RMZqzMZa0d2jEA==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr375035wmd.44.1537875522072;
        Tue, 25 Sep 2018 04:38:42 -0700 (PDT)
Received: from localhost ([178.121.95.75])
        by smtp.gmail.com with ESMTPSA id x204-v6sm1850546wmg.27.2018.09.25.04.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 04:38:41 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Sep 2018 20:38:40 +0900
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925113840.GA523@tigerII.localdomain>
References: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/22/18 23:40), zhe.he@windriver.com wrote:
> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
>  /* save requested log_buf_len since it's too early to process it */
>  static int __init log_buf_len_setup(char *str)
>  {
> -	unsigned size = memparse(str, &str);
> +	unsigned int size;
> +
> +	if (!str) {
> +		pr_err("boot command line parameter value not provided\n");
> +		return -EINVAL;
> +	}

Hmm, I thought we agreed on dropping this error print out. It's not exactly
useful; we still have the default buffer size.

	-ss
