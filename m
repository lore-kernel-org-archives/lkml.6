Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE20421852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gaJO7aNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLRPDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbeLRPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:22 -0500
Received: from zn.tnic (p200300EC2BD17800C11009BD73D4094D.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:c110:9bd:73d4:94d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9AFE1EC0629;
        Tue, 18 Dec 2018 16:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545145401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AfPjf7ob1qdBDhGWYEjGXpUU+3vxeqXTTES6fdUZ0QM=;
        b=gaJO7aNIx1ZTaZ4YEa15E4rjWF+yrfW/OCAzWTGC7l4KjE7blrQIks2Y8Gfoz76okmTwGf
        CZEkBI+50UWlwNemnvst2cQ8oH60VJcHVZa2kQh8q1vh4Cpv6c/50GWzoI5Ag63Gbowhx8
        A5RmNo+NSIKDuN/uabqHnVudvIMz5Kc=
Date:   Tue, 18 Dec 2018 16:03:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218150313.GI7485@zn.tnic>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218145558.GD665@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:55:58PM +0900, Sergey Senozhatsky wrote:
> Good question. Theoretically, there can be some interesting stuff.
> Examples: https://bugzilla.redhat.com/show_bug.cgi?id=1515373#c6
> or        https://github.com/systemd/systemd/issues/5433

Just like that last page says, people should use the printk.devkmsg=
option when they wanna see all messages. Normally, we do add cmdline
options to the kernel cmdline when debugging, like

debug ignore_loglevel log_buf_len=16M ...

etc and this is no different AFAICT.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
