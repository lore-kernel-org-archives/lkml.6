Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0512086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDrGmWwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfANFvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:51:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39818 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:51:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so9622094pld.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 21:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KD8ZozXl1dqsvEjB7fqHjvgetGRRO0Zg/CpmekgSHl8=;
        b=ZDrGmWwkwhVaUgDxXfLSguKm162dohJJsL38RjDnLKhE4vmCzsmLnPGGGndC2gDDQC
         qVJ8f8gz/d6uutHVbkexBoFpOkVurrfxmGoIveAbMmEIJ+0B+Jt1xAkaTxO3JWmXCZD9
         ezIw6vMNlel5SeJ+q8ci9KiA9a9qtXxtTdWBGfZPgIpfYTG3L3bk78kK9HJYTpbA6Gqv
         DioNlPoly9Qy4HBvwY2EWID13HaTGhDtzHl9JNrQnek71lKqrT26gWbvnO22XRxouD6A
         dUxR3JcKs0Yx3AXXsZe0Es05hENVfi32AnVEIz8JEo9OEQ6J6Kb231JHRuGUd+XVvUh5
         Sgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KD8ZozXl1dqsvEjB7fqHjvgetGRRO0Zg/CpmekgSHl8=;
        b=ffG5A0s6HivsogKxgzLxKaOh0r+/G6F+Ps0DvTou6cPtOqW85UaZ0C1MyXNZb+aQfm
         2fHJ39k5zY+vyPRkLDjuKAivZMWTjR32uTL9bBD9B8dV96XTsmAEg/eQhrMfJBVyD8pN
         vNhndr67iNF8Ma5c6X7/BUfA3BHeeyi0OE1fONUfFvQNH7LHrBVHuN2YHicTQ4Hi+ORA
         UTJ4duDRMHJ92oo/Ogp1p07fwpGiV8gnchnHpnh6kQRXqv1wrSxXReNJU9fzl7+0ijih
         Up0q9ipTbqB3v/orYE701oZt4jnTGC87KQ+lvLXp8RGlzXrmaNJAm6Zw4oxYDubYtn6w
         5UIA==
X-Gm-Message-State: AJcUukfxLWb/XYCDp2o5jXay3xKSNjRFvdhiApBSx0PmpCsuDwaKj2Bx
        0VNj5ynWjGee8fR77mCBNykH1WjV
X-Google-Smtp-Source: ALg8bN4wR3zCaHDjGLQLWSZnDvD+ucdPXzQnFS9np9y//sxQ2QglNnAkpnNHpgUmKPharDHro2MSLA==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr24101709plt.304.1547445091653;
        Sun, 13 Jan 2019 21:51:31 -0800 (PST)
Received: from localhost ([175.223.2.252])
        by smtp.gmail.com with ESMTPSA id b202sm159500509pfb.88.2019.01.13.21.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 21:51:30 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:51:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sysrq: Remove duplicated sysrq message
Message-ID: <20190114055127.GB7417@jagdpanzerIV>
References: <20190111162038.19771-1-pmladek@suse.com>
 <20190111162038.19771-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111162038.19771-3-pmladek@suse.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/11/19 17:20), Petr Mladek wrote:
> The commit 97f5f0cd8cd0a0544 ("Input: implement SysRq as a separate input
> handler") added pr_fmt() definition. It caused a duplicated message
> prefix in the sysrq header messages, for example:
> 
> [  177.053931] sysrq: SysRq : Show backtrace of all active CPUs
> [  742.864776] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c)
> 
> Fixes: 97f5f0cd8cd0a05 ("Input: implement SysRq as a separate input handler")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>



A side note:

> -			pr_cont("This sysrq operation is disabled.\n");
> +			pr_info("This sysrq operation is disabled.\n");

I wouldn't mind this messages to become more informative.

+	pr_info("sysrq 0x%x operation is disabled.\n", key);

?

A bunch of "This sysrq operation is disabled" in serial0 log file
(post mortem) is not very helpful.

	-ss
