Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD59C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B86120873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzf6cWMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLROCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:02:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41322 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLROCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:02:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so6230471pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtIAwiyVyPrAiLTiS34Zwc9UngKAIw5vQ62s9hPfmDI=;
        b=bzf6cWMSpqEOchVKg9bgM5K55aM5y6wIvBsQEmIbGq0sFdAZJCQ5rY8RKfkXknsFD4
         PF+fsj7ETVjYkjomWo0rVRo83mIqMAYqJwJ9sCd3cWIro7vhvx0KJKPUE8lidwj8eNhx
         ClbwpmnWUx3y5vwqS9t33pt8xtaczsoAAVC5v2+HMjCsTsSiKlJ3Ti/rx01LsbIqb6S6
         jh5qoPdmzBO4SR67Hm67/aWeCs2GteBkNXott3lPZYPxzfs8wMTB9E89HEYKTrAlItKC
         NtNryLpV5py3aO647P2KLa46fmk/7z50ueax3n0sVsIsBuJ0JJWh3HkF6MqzZ1vDdnDR
         K5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtIAwiyVyPrAiLTiS34Zwc9UngKAIw5vQ62s9hPfmDI=;
        b=dZzJDEqPuW6b7Rr4CoMyxG+Fp22KmWwzcAU3e6iUurtph1SbFcMdd45vN6jApjEMCO
         /hPAEu+bq/kpCrM5DMUdDYt0oOBuRrdQWpvJhYPgXhMwofbOvzSFyQ0ym9YxzlVK+LoA
         MBlMCKFN12UiBIkf1sFjdlR8Lj5D3ugPNCghaTxFCGJBQKIZ+4ZqK3r2wx1jJRGBVald
         ghtDQCgTVDI4dXvac/3ZekDtg7aOQW2qEcHzJtdsrGFzqjsnq0WsZHp8s/hSP0pQ9Bd3
         aCK89JsuehlST0MEDg4dJ8w+xES8S0v12a6GnH3nxI5BkgOABDM106MHBrUFScYHRLLU
         +aaA==
X-Gm-Message-State: AA+aEWblxi991sRf/dqPiifeHv7xOzprdAjDFQIQDSmhQceb7xCD2gmu
        cTG0AdKA8lU5njq5QHhnBOE=
X-Google-Smtp-Source: AFSGD/V0H4Cq5vj/6uM3mElLNuwyHqF2hlM/PqgLBCXSC8mHT4eHsAeCzOY8OBpVp/bnHZBbGQ9quA==
X-Received: by 2002:a62:33c1:: with SMTP id z184mr16632054pfz.104.1545141731808;
        Tue, 18 Dec 2018 06:02:11 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id j70sm21117770pfc.43.2018.12.18.06.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:02:10 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 18 Dec 2018 23:02:07 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218140207.GC665@tigerII.localdomain>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 18:18), Sergey Senozhatsky wrote:
> 
> I know that there is a "kernel.printk_devkmsg" interface; do we
> expect every systemd-enabled distro to find that out and to tweak
> kernel.printk_devkmsg

My bad, this should be corrected. I thought that user space can
adjust ratelimit, via file->private_data->rs. This does not
appear to be the case.

So the question is - is it time to change the default devkmsg
ratelimit?

	-ss
