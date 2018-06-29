Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7916327A8D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti4muhuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7916327A8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965429AbeF2BwR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 21:52:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43069 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934863AbeF2BwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 21:52:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so3640084plj.10;
        Thu, 28 Jun 2018 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FAsu1PZ9fz9X+XriHpbV1Got68+Iv/S2lWAkv5A9hfc=;
        b=ti4muhuwFRDEJRDp7HnUsTgWZksU9+u6trNOCdBZAH0gTfM2VqB1YbYZOx4PS369GR
         y4R351IBeBECnfHjHwbZTAbpt9AyQw8VMgpd+nyASDsbDeg6Retb1pTMh/4aoL+ohzHP
         Pg28fGDqdY3HAtNCokHKS7sRT3PVCFFLbY+7WEb3Wjp4Xfy2EQOw8gh2dfPjA58cOlRF
         8PXls6bAyYTHZjeyjcN15FxMThfbcVFE+ivndTqBTwjArzrxH2neQoBlIDwp6sebLB/Z
         iH30mEZVUtfO10ErHRy/6VnBSB7vCNJgFbHeNy/TSe2RnGBFbtsHbqMH9KQBrJFzUat7
         fPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FAsu1PZ9fz9X+XriHpbV1Got68+Iv/S2lWAkv5A9hfc=;
        b=gAf6uRsgm0FoDOwAC+5dvygImh2jAmpDwRLNMMpeYS7faMY/IxD6b6D2m87lzGFdxN
         BCnAquw0pVmJgM/jxd32oKxLtX9/cjws1bbqxLSAItzAfZetq+Mi6n9R7C1N9k2naHKc
         /GiOBgufT0mlb0XH6ThJASa+itLmvNbC+F6k6+28Fx8QxyDoauvH9aMI5x94FLfaJzyE
         x1kp5znOK977nfq9VCvz67lXp5aKZI9WHgguu/8CkLDXKRRZ1hgmh6puPtu5pzTewD9S
         2e/M1Jmn68evShLf93A74zj4wD1kgl7LS41atRF0vhqU14+kqmriM/8kZz7KHr9d64uB
         lP2g==
X-Gm-Message-State: APt69E1l7r7yS7yqmf7faYZATDqBpt7mmiOatoqNIswbKqoR8HXNIDsN
        O2gEtQhrkoC3mpos91vRqCg=
X-Google-Smtp-Source: ADUXVKIjVzGSjgTTxDJXP9zsH73fcGZZGuLy/uuZVQjDrD+XHzzwbFiiiHnObTsSdjo8MdMCMbL7Pg==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr12871634plb.14.1530237134997;
        Thu, 28 Jun 2018 18:52:14 -0700 (PDT)
Received: from localhost ([110.70.26.165])
        by smtp.gmail.com with ESMTPSA id p76-v6sm16217846pfk.147.2018.06.28.18.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 18:52:13 -0700 (PDT)
Date:   Fri, 29 Jun 2018 10:52:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180629015211.GB614@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180628023902.GE481@jagdpanzerIV>
 <20180628105404.stnlihwzfgpsrl4f@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628105404.stnlihwzfgpsrl4f@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/28/18 12:54), Petr Mladek wrote:
> 
> On Thu 2018-06-28 11:39:02, Sergey Senozhatsky wrote:
> > On (06/27/18 16:08), Petr Mladek wrote:
> > >
> > >  kernel/printk/printk.c      | 57 +++++++++++++++++++++++++++-----------------
> > >  kernel/printk/printk_safe.c | 58 +++++++++++++++++++++++++++++----------------
> >
> > Shall we just merge these two?
>
> Do you mean to merge files or the patches, please?

Yeah... dunno. We now lock logbuf spinlock outside of printk.c, and
we now have printk.c functions that have that "printk guts, must be
called under logbuf lock" requirement and so on. I like when static
things are static :)

	-ss
