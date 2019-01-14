Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD993C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D7620660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfInERFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfANFgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:36:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34531 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:36:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so8985092pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 21:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tF5F5KzDvwkVsVC56m2tjnITTY3YwTaHXb3Dw7UoUHk=;
        b=IfInERFYFJWtmr6LPTXir6ieNSTnibHTbWbIDOcmvELWRe964mnnQ2lQ2UKvYtlRGe
         lIvC6lHVE25LyGGmglZP6LvwsI9hPdMOlyUR33kulniNfABqniW7nxUoOWbO1oMJ5+8O
         VPkEUrmZyovcJ+Sim53O5oqzXXg6oThazsV94hEqTUn9RTdFyE4+Yve886YmGt70BXhC
         vslWP69xzpWeRGZ8YirxaFLIG8h48YepbOeCmHBcV5a9vPZmiRswV8w3bDctxpxdLbT1
         jKf289NvwPYEAqORShBmmnB4ExwLkg8DVin4RvDEg/VDI7R7Z97woZelB/tYdAQVQ0TT
         0NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tF5F5KzDvwkVsVC56m2tjnITTY3YwTaHXb3Dw7UoUHk=;
        b=g75p5V5fjXAgfChvQaAWA2C9HkgO2LhipVS7E1ZL/86gYXhGfeZ9atC3en+jVffm7L
         EMvyy/v7FzYnBBc9K3FNzL6ekerS1ayKD6ZwqcxvDLrGX1fKQlPx5hZ5nVZyWSusJpmD
         Qllcg5875Z4hGt3cItN1lDL55+SGYrrc5eHGIW91BcV4XWrvEE0v8OGxh9xHbw+uR/Ou
         QM374bDttq9JEDTeINzKkcWLOyijU5ZKu8FNHR4vaw8UIR+DiQ0tXK9Jmrv6TaOc1tXE
         sAdsvhyTTMKxEEVJBG0syMY7lvcXqfFmWfsG9LI6pAERhasgJiGFiMMwzezXTlsOqqRt
         I+CA==
X-Gm-Message-State: AJcUukcuCaLkCiIBPBc0X8UNag5RRE2lw0cu0y0sVueXgDGlZrNK7YQq
        10CFH6PKSfeJocgMhzph824=
X-Google-Smtp-Source: ALg8bN75PPvTeWvb6HLvsmvEOdVNdBfoHt5eddgXS5bj9XsZTpsFqOI8NNxOVkgs+VtSGpl3h/4DaA==
X-Received: by 2002:aa7:8758:: with SMTP id g24mr23473288pfo.250.1547444207064;
        Sun, 13 Jan 2019 21:36:47 -0800 (PST)
Received: from localhost ([175.223.2.252])
        by smtp.gmail.com with ESMTPSA id e24sm120842832pfi.153.2019.01.13.21.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 21:36:45 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:36:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq: Restore original console_loglevel when sysrq
 disabled
Message-ID: <20190114053642.GA7417@jagdpanzerIV>
References: <20190111124515.11017-1-pmladek@suse.com>
 <20190111130729.GA31790@tigerII.localdomain>
 <20190111153256.emsne4s37g2dgt4g@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111153256.emsne4s37g2dgt4g@pathway.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/11/19 16:32), Petr Mladek wrote:
> The same problem is with the sysrq header line. It uses the trick
> with console_loglevel by intention. We want to show it but
> it is not really an error message

May be.

I usually see it as an "error".


My case:
    systemd sets sysrq on every boot to /lib/sysctl.d/50-default.conf
kernel.sysrq value, which I usually set to 1. But after every systemd
package update I have to edit 50-default.conf again, because somebody
concluded that overwriting /lib/sysctl.d/50-default.conf during package
update was the right thing to do. So, occasionally, when I need to do
sysrq all I get is "This sysrq operation is disabled" error. So I swear
a lot, reboot the box, change the sysrq mask and try to reproduce the
problem. /* I became familiar with "sysrq_always_enabled=1" just
            recently. */

"This sysrq operation is disabled" is always bad news and is always not
what I want to see.

	-ss
