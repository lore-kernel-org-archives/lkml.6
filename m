Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D56BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E0214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEFBBI4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06E0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeLDK7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40379 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLDK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so8026388pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kLMyn07eWuFNccovBcYb76ynW+lFnhZe6SryOKDeUuo=;
        b=ZEFBBI4j2LiOoCdRDZ3MtDrPPN8swirJomj4QzNXxtDFUMMcFj3LWu+FC8ocF5McmV
         h7J4xo85Ctnr0TW2jQ1pbaAkjdIYKzx25XeTUiD6Q260/P/42z9aBke/G2oOQ9d50cMX
         UMCdDCh6n5BJ0JCVq0ti8GEqOfMuI1OEnoo9ElqFwVieptp79FpgZSZHDHUjhv9olyAV
         Q9vCc9dR3lC+fv01e7Hugq8NMFQvJvees+IWw+gUHoqwSoDl09LeJatxBSHAwYi7Qqxu
         ht/raGDApQYasH+4RZYFWdaUeOK/1RZxaVlNvnVL7GCwdYAEFElrflXydaNasQYut5Ur
         5k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kLMyn07eWuFNccovBcYb76ynW+lFnhZe6SryOKDeUuo=;
        b=K4KN8dMVzW25a2P5G6c1HfZk9JeZmm4IIWLw/U932eKWYdC4nMPW85t6VvrV1J3lPd
         PIZb++8cdmz/3d1hlEBBOHIeZ9ijTG7fIwIRqggMY3aJpsUON7O0rUHQmdwefj259sxp
         r9vxG2yJ2OdwE/YigqMY5xhckVc9vim8Eb6ZFHWRIdDcF4wo+zX86IuNmCKRCeqB2gT5
         kvJ2GIftrA61pIydycC1snCwT+Cx9KJDK5071bOJjojR5Xm+BcoSdMyvr6BWHuhNPq3Z
         3LCbNnRYDB6efkXqUB8D1JFNcsbJIfYU4MxGRVVBrHOCipvfDfnLq33mcluj4XPgbgs3
         tO8g==
X-Gm-Message-State: AA+aEWZJcNRtY9hHe0R9ygCdnIcTz/TC7Mcapj9+MLhMRLVJyCoXTYtc
        KWJdGe7epybQ7JGK4TezjsbCSJwk
X-Google-Smtp-Source: AFSGD/WfPjzArBVPMN3aCS/OqQ6e21TwX27sAga91V/SnymO87M+/oxXP/el+dFrBb2FUOlAHjgGYQ==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr19451478pfn.220.1543921153165;
        Tue, 04 Dec 2018 02:59:13 -0800 (PST)
Received: from localhost ([175.223.44.178])
        by smtp.gmail.com with ESMTPSA id 79sm17491555pge.66.2018.12.04.02.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 02:59:11 -0800 (PST)
Date:   Tue, 4 Dec 2018 19:59:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181204105908.GC530@jagdpanzerIV>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
 <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
 <8634f952-7a14-055d-943c-d219ab5d8c1b@i-love.sakura.ne.jp>
 <1c1de4f8-f08e-37e5-2438-47ab985d476e@i-love.sakura.ne.jp>
 <20181204025614.GC7580@jagdpanzerIV>
 <555af37c-b9e0-f940-cb73-a78eba2d4944@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555af37c-b9e0-f940-cb73-a78eba2d4944@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/04/18 19:06), Tetsuo Handa wrote:
> On 2018/12/04 11:56, Sergey Senozhatsky wrote:
> > Can we please have something better than 'f'?
>
> OK. To pass 80 column limit, one line increased. ;-)

Ah, so that was the reason :)

[..]

> To close this race, get a snapshot value of printk_time and pass it to
> SYSLOG_ACTION_READ, SYSLOG_ACTION_READ_ALL, SYSLOG_ACTION_SIZE_UNREAD and
> kmsg_dump_get_buffer().
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
