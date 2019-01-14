Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC35C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA31208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfANOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:37:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfANOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:37:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8E2BAD2C;
        Mon, 14 Jan 2019 14:37:07 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:37:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq: Restore original console_loglevel when sysrq
 disabled
Message-ID: <20190114143707.amwh6ykixryxpesn@pathway.suse.cz>
References: <20190111124515.11017-1-pmladek@suse.com>
 <20190111130729.GA31790@tigerII.localdomain>
 <20190111153256.emsne4s37g2dgt4g@pathway.suse.cz>
 <20190114053642.GA7417@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114053642.GA7417@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-01-14 14:36:42, Sergey Senozhatsky wrote:
> On (01/11/19 16:32), Petr Mladek wrote:
> > The same problem is with the sysrq header line. It uses the trick
> > with console_loglevel by intention. We want to show it but
> > it is not really an error message
> 
> May be.
> 
> I usually see it as an "error".
> 
> 
> My case:
>     systemd sets sysrq on every boot to /lib/sysctl.d/50-default.conf
> kernel.sysrq value, which I usually set to 1. But after every systemd
> package update I have to edit 50-default.conf again, because somebody
> concluded that overwriting /lib/sysctl.d/50-default.conf during package
> update was the right thing to do. So, occasionally, when I need to do
> sysrq all I get is "This sysrq operation is disabled" error. So I swear
> a lot, reboot the box, change the sysrq mask and try to reproduce the
> problem. /* I became familiar with "sysrq_always_enabled=1" just
>             recently. */
> 
> "This sysrq operation is disabled" is always bad news and is always not
> what I want to see.

It is a matter of taste and I do not have strong opinion about it.
Anyway, changing the string should be a separate patch.

Best Regards,
Petr
