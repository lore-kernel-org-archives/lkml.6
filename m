Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F5217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kASdR6TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeLRNH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:07:56 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:35252 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRNHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:07:55 -0500
Received: by mail-pf1-f177.google.com with SMTP id z9so8127093pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARdyqf3OP5vPqm91e7LtugYRBheuLowDurYopyIusKs=;
        b=kASdR6TX2R4PtND4CeCcctja1yccAMOW44R2kgMIH1QBJHyLKFWKwyxfDLSs7htkpV
         0c/XDhAtjKPOaPikUv6kV4IrDz4lYpnnduPFsPjKU13hpHs+XTYYwWabtRr0Yn8RhYlB
         e/SHlNj85SaMWRFYNXByVIwpIpOdDkUY/K3Bb5PjRrp1x4i0WhIDUMZj7Mfc0YfI/aDt
         YwHwIFcSKAMjgdaVoCeSslO47SuHYwzBOowHaNX4LpXTpVl6JF1TzSmDCxuiJa0yXqSi
         Lei4tkkGpeZFmap7nEmsEZGqIHzAFNlTNc8GkL5uahhmrSXP4ciZrj/3SeFVmWAt4gbP
         Pk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARdyqf3OP5vPqm91e7LtugYRBheuLowDurYopyIusKs=;
        b=swBe8p99ztOtH7iW3x2FxA+7wSbzu0Eq+tuipBGOyEWUlPv9TY91IhdGHp7AovlGWf
         0QcKrdd9IZe2dnQixwmUxwQQqAaU1XP0JDTIPuoh1LyP5Kz+z80LQ0MiLod6Y/4C4S+F
         rShw5YE8E+JJ63dDvCjTujA3fckGkBVvrSiD3//UWriheRRQBUVsFBIUt7fZfahz7NJU
         egmy61SlQ8MxklGgR77HSBfIwLH1f+MU48connFn45+PTj3G+IFGV4WqpCqhSCXm9qan
         yVJ0XjD1e5UQ69YuTVp7EUI5tG22bEFTb5hmYamOXtpb4vIJKCNGe2tCfWJJ4u2A8Mjr
         dNDg==
X-Gm-Message-State: AA+aEWbL1hAonc+Vt+vWTK79COypbDyOGg6A2BzxyFt2eEsiaf3xzJOp
        h9l048YK9cekp/5EJXVAeOE=
X-Google-Smtp-Source: AFSGD/VAnZ+NI+hg8B/GFdOkZVsOttgLpCypsXun+VWiK9BB4msj3974d7oY+4Em5hdj2HBmA9rCYg==
X-Received: by 2002:a62:1b50:: with SMTP id b77mr16702395pfb.36.1545138474654;
        Tue, 18 Dec 2018 05:07:54 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id e188sm19101411pfg.130.2018.12.18.05.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:07:53 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 18 Dec 2018 22:07:50 +0900
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218130750.GA665@tigerII.localdomain>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218114709.GF7485@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 12:47), Borislav Petkov wrote:
[..]
> >  systemd[1]: Unmounting /home...
> >  systemd[1]: Unmounting Temporary Directory (/tmp)...
> >  systemd[1]: Unmounted Temporary Directory (/tmp).
> >  systemd[1]: Stopped target Swap.
> >  systemd[1]: Unmounted /boot.
> >  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/a0737dff-e797-44f0-aea7-d0df1107ff63.
> >  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/5d773b72-e200-4d11-a219-176d62a16d8d.
> >  systemd[1]: Unmounted /home.
> >  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/35319ddc-9b92-4ab0-aaa4-9922db636a5e.
> >  systemd[1]: Unmounted /media/edev.
> >  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/da00daaf-5601-4531-912e-bd69103b379d.
> >  systemd[1]: Unmounted /media/dump.
> >  systemd[1]: Reached target Unmount All Filesystems.
> >  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/b52da2df-161b-4c33-b700-277d95b9672f.
> >  systemd[1]: Removed slice system-systemd\x2dfsck.slice.
> >  systemd[1]: Stopped target Local File Systems (Pre).
> >  systemd[1]: Stopped Create Static Device Nodes in /dev.
> >  systemd[1]: Stopped Create System Users.
> >  systemd[1]: Stopped Remount Root and Kernel File Systems.
> >  systemd[1]: Reached target Shutdown.
> >  systemd[1]: Reached target Final Step.
> >  systemd[1]: Starting Reboot...
> 
> And we wanna see all those "very useful" messages in dmesg because...?

This is right before shutdown. dmesg is not really available anymore.
I can only guess why do they write it to devkmsg - to make it appear
on the serial/net console, perhaps. Dunno.

	-ss
