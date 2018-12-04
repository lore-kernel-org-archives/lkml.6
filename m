Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE45C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E0C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGsEB9wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E0C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLDOzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:55:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38444 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:55:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so7483007pgc.5;
        Tue, 04 Dec 2018 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0JvXHj/6syjJhaX3qT3dIOpn7CBPUnGzSeT8hAkMTC4=;
        b=WGsEB9wuJ3/ByM4EiZqFe5DdC+8nE/Zuo+KCD67ectjNox3OtFD+sTFaxIROJRH1iZ
         ylhFX5tjkHh3KUxrM/o2LHiRDsL0Y016iAtxaWUJ9L2v42Ln8h6siGqGykh9T0MBHSq5
         UenWvYuyoSs/73G8CnrHudv/nHLJfLyNpFpvaRdfIvP+hjIQMyL+UNo4Rl72BQOcgh2r
         RX0n9rc4EcmtDaMainSCRMEbjfA7Q/83wRDstBY9Tdqt3P+5zguHOvpsSad97BkTJLwZ
         C2KtMBPsxhG2MeCmdHkr5YWLnbRS6g1porTQbFkpGe45upUdahNl8A3B9Q4Otz2ZxU3+
         vwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0JvXHj/6syjJhaX3qT3dIOpn7CBPUnGzSeT8hAkMTC4=;
        b=ASopyzl6JVFKpDzYtJC3Byw4RJqY3nh0PD7Ts5UxtKK09xTtXOVaFaIoZNDg9Vp11f
         ZxU5qKm1EP8WgPsqrrRfhLzvAJu6iHUitLM/24tgnh5bxiy8Heox87/3CGt6Q6+sL+LF
         Eqk2OMpHq4PrwKarmCpyG5+/l28aJkFSg1QXuOKbv7uRY0wfb4ptc7BfSL0Gjf9dT6tu
         VbYO25quS2d8vAQ+a234p84CoP14ssMrpH0GKogtoy3+1DDBHt3XSzi+4OFXxDkHiZuz
         Om/FZNt7t9X4a6c5LpouT2MyXJZeRUoR0HSkVJT4ea7J4bMHprhw1MbYfMCKAijPRdMF
         RwPg==
X-Gm-Message-State: AA+aEWbSXpa9GPi5aLf0NvXjD8Vkmx6JwkkujdOwR7QteAtGqhaoaFzk
        EpgF7V7T5pZ6u+GYm+OCUxw=
X-Google-Smtp-Source: AFSGD/VwWOWAC8Wz9t2U8NXj0NOklBhplorKOigZxkr4pdyqDPBCmBKCdzXoAxVUoel7wBcCI1ISuw==
X-Received: by 2002:a63:2507:: with SMTP id l7mr16348366pgl.22.1543935342033;
        Tue, 04 Dec 2018 06:55:42 -0800 (PST)
Received: from localhost (c-24-4-239-105.hsd1.ca.comcast.net. [24.4.239.105])
        by smtp.gmail.com with ESMTPSA id a15sm17522001pgb.1.2018.12.04.06.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 06:55:41 -0800 (PST)
Date:   Tue, 4 Dec 2018 06:55:38 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181204145538.dnyqlfspnpqmojop@localhost>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
 <20181204044257.grk3na2wyrx6nssg@localhost>
 <20181204070033.GG3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204070033.GG3073@unbuntlaptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:00:33AM +0300, Dan Carpenter wrote:
> 
> Why did you commit 3b1ad360acad ("pps: using ERR_PTR instead of NULL
> while pps_register_source fails")?  You're not listed as a maintainer so
> I wouldn't have known to CC you.

I'm confused.  Where is that commit?

   $ git show 3b1ad360acad
   fatal: ambiguous argument '3b1ad360acad': unknown revision or path not in the working tree.

I'm pulling from:

   torvalds git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
   stable   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git (fetch)

(and also from net and net-next)

Thanks,
Richard

