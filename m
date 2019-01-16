Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCFA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547653107;
	bh=EUKcnzzT2mgLCAbwSxtZtVeonQm0pveYdCHMEse5Bz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0CAUdHxaHCQ6+ZxMwh8gEnX6cLvFNX0BSbPQ6w/T3raAfYP6rqpTkMktzGMo7Cj0p
	 j2988faVB2q4xvBzIb4PwGP0zIetQJ3aE8YR45v4e8URH7hBbewLMoiA7Aq6vLq/K1
	 ddF9j+Tfq5Qy/gvVZD8Rc8lA8wS88MnBYiOJRFdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394127AbfAPPi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbfAPPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:38:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F65220675;
        Wed, 16 Jan 2019 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547653105;
        bh=EUKcnzzT2mgLCAbwSxtZtVeonQm0pveYdCHMEse5Bz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJN8S8B1AMwT80G3hMEbc570qZOq97ILi4G7ATDJ+vwcGTDnqeprySvu6YVjvUBeO
         rTJfQcyn7a0Wwg6RKggAZ5wGKKqAagdGxX/rp4gvDIyoS1+v8dEYIC0Eo4+txZJyPK
         /zbWV54EE5220QJB+0vr2fULFHpgPzWrlNAptprg=
Date:   Wed, 16 Jan 2019 16:38:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [patch 2/2] scripts/spdxcheck.py: Handle special quotation mark
 comments
Message-ID: <20190116153823.GB871@kroah.com>
References: <20190116102651.489113812@linutronix.de>
 <20190116104127.698565432@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116104127.698565432@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:26:53AM +0100, Thomas Gleixner wrote:
> The SuperH boot code files use a magic format for the SPDX identifier
> comment:
> 
>   LIST "SPDX-License-Identifier: .... "
> 
> The trailing quotation mark is not stripped before the token parser is
> invoked and causes the scan to fail. Handle it gracefully.
> 
> Fixes: 6a0abce4c4cc ("sh: include: convert to SPDX identifiers")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/spdxcheck.py |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/scripts/spdxcheck.py
> +++ b/scripts/spdxcheck.py
> @@ -175,7 +175,13 @@ import os
>                  self.lines_checked += 1
>                  if line.find("SPDX-License-Identifier:") < 0:
>                      continue
> -                expr = line.split(':')[1].replace('*/', '').strip()
> +                expr = line.split(':')[1].strip()
> +                # Remove trailing comment closure
> +                if line.startswith('/*'):
> +                    expr = expr.rstrip('*/').strip()
> +                # Special case for SH magic boot code files
> +                if line.startswith('LIST \"'):
> +                    expr = expr.rstrip('\"').strip()
>                  self.parse(expr)
>                  self.spdx_valid += 1
>                  #
> 
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
