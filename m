Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF44C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B4B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqnT3sfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392227AbfAPLnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:43:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44561 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbfAPLnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:43:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so2903199plt.11;
        Wed, 16 Jan 2019 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yP5q4xsWqcIkZqqwOPTDMFnIdAGxXGy16x81ltL/e7o=;
        b=bqnT3sfrJxL280Wm0YVFj6CxH/QAAmKD9hQh9RANEn/GX7xIy7+fZgrkhsXHVIiRfd
         q89nvC1cMpUhbfxWIyUycut7Kn8p/F3uHuvyk5NUxbzZQWF86sHwqQ5+GI+Og3HgfXt8
         DQztBPyZvEjywX5xGY2B/C9GHB1FNvVDT6GNoxdu+ADiELQbMeZlwuh3pa+bj+HfVZIt
         7ybJ+J7ErjoEjD6k0Mxqavn0gOP+RP2MdpwFgcNwiEciXpbQgav3HHbbHiYiJ0jk7Ej/
         lZxJxYP1mwwhFINmmp0nlrJGHGEFpzuQIOvawX8Xf6mNFnoXEPz0NQUVx55SQYx/GU1c
         tSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yP5q4xsWqcIkZqqwOPTDMFnIdAGxXGy16x81ltL/e7o=;
        b=B8jopa4dukPmyaZPrdsqc4JSJB+VEnpq13vTrUQT02Z6RnGWsqvbS1wFourr+O9lZs
         MbL4jLwSgV++U5p0K6U5eNKeVki4chkeRc7VZL+5tG76q3XjYc4fJIz5kQL2M6B9hO+9
         o+f8JvdaP+HqQHwB3ECv27BAr4H+did2c8pHnqNEJynOxuamEk5d2jYlqUo4+gqXi7WH
         4L0eibZplnY0/X82bkSyEin8JwrN3LyY/UiJT3Fml0Iztpi5ti24s903TDxY/L0Zm7yF
         YJ9tV38yypmPKiEia9NVaRdOkavu+Ve5ZxBPyLYXMZORgPrEzwT/kl0rflq3Ll5ZglMj
         8QFQ==
X-Gm-Message-State: AJcUukeJLCPYAsdK3AbIp+ucZMlDISszAL7Z01qEK9bOAwDCLUo33oAK
        6Ly+Pw3JEaqvHiMz8C58Z3SZU2NB
X-Google-Smtp-Source: ALg8bN6/GqrDk7oLVuCLdrB3W0a8hxe/jtmOwBjTUpe5ezj5N9x+IzrIwDEgZvVwDS+jm30Luofdig==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr9562501pla.66.1547639025409;
        Wed, 16 Jan 2019 03:43:45 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id t3sm5639788pgv.31.2019.01.16.03.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 03:43:43 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 16 Jan 2019 20:43:40 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on PREEMPT_RT
Message-ID: <20190116114340.GA6322@tigerII.localdomain>
References: <20190115123910.2b18df54@gandalf.local.home>
 <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
 <20190115145815.13713791@gandalf.local.home>
 <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/16/19 11:07), Petr Mladek wrote:
> The patch makes perfect sense. But it is not ready for upstream
> because CONFIG_PREEMPT_RT_FULL is not there yet. Do I get it
> correctly, please?

Yes. Hence Cc linux-rt-users.

	-ss
