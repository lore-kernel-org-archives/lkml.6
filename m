Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A09C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481720872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYh+X3s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7481720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbeFTLYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:24:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45327 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:24:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22-v6so1449818pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRQ6ODCeq0XrUOO5Zsm7r44xI9VR/CObsjpZF0+3sG4=;
        b=eYh+X3s8xl01DxsrbpSAM0sMVJQDzgTpeRa6wIduFZcRUdtTq9SC3jgfgdCyN21azn
         vNnAOrK+PcOseal2ko9u4jlTG6JDF+B1jMCn0WXF27oHEJ6tfkKzVzmVQbDH2mcXyCUh
         tUC1S1xF3rDkdQUx2z99AbWVftTihlvWxOoWBgLmC7cd8wxIbDBUW81p9s8gcGx8rXzT
         0NAm5UuQd9xP0S9F4bHK7syFYY2AcjwF9DHutmD8PjH3/K60DOObAY2SX7wn/bPP5N0A
         Rh+CSYCDtpFxrjVoulsgouS5NgWWGcKwHtCVqjAGTQmS+rYNOhrkGW2EqKy5SwTUjjLt
         1ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRQ6ODCeq0XrUOO5Zsm7r44xI9VR/CObsjpZF0+3sG4=;
        b=SARonOeN9ziOj24YHdJjxhUwD4i5+lWbNNSR3HHr689yJWcdt+mhAv5vWlQGVPPV8I
         k2lCfZuuPSFnkXckLOfYAg4XDR29OaaDYD/u6aEw8UW9el1IdSYMFNYbnzOATelFUn3e
         0d5ADvsp2buqD/1Nz+M/x3dpHQS718ILen2kNRPeLvQkFBX43XXU+B9N71pg5x9IPFMn
         yfswaIOSmBaBOUfcMEL0xzyZwGCx5qgxQ/kGn7CXm7Wn2wjT4X00lwdr+ConP3TW9dZx
         bRsl7Hd+I58QO4OXg0kYXrw7ytWWChKogBx1wNpDzCvuALO1y7YLFXxq2uxxOWkv/wVd
         6rgg==
X-Gm-Message-State: APt69E2xYt/py1wZUeEbeVvsLCTwUCA5tUqkgEreXIAlYBLssf6VSz0V
        Vs9PhLrotWAb29E2JlfrrRs=
X-Google-Smtp-Source: ADUXVKL2aWTBViyAq/B1YUQHMhOPHNXEBZYI1e0EjjItLrdZZNRxF1a9CcxXjFJ3i95UyxZPy4y4ow==
X-Received: by 2002:a63:ab45:: with SMTP id k5-v6mr18623811pgp.23.1529493881040;
        Wed, 20 Jun 2018 04:24:41 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2695852pgs.59.2018.06.20.04.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 04:24:39 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:24:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180620112436.GF444@jagdpanzerIV>
References: <20180619115726.3098-1-hdegoede@redhat.com>
 <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 13:03), Petr Mladek wrote:
> > This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
> > 
> > This for example will allow distros which want quiet to really mean quiet
> > to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
> > then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
> > of whack-a-mole silencing harmless error messages.
> 
> I find it a bit confusing that "quiet" would mean something different
> on different systems.

Good that you brought this up. I had similar feelings but then the
patch looked rather simple and I kinda agreed with it. If we can come
up with alternative solution (you mentioned some) then it would be
great.

	-ss
