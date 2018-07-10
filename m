Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6282C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJQM7uAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0F2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGJAI4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:08:56 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45406 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932812AbeGJAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:08:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id a17-v6so919898plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mmltr/Dd+R5CsYCrDwn8ebtQuh6MpbIATIGTBEhAUpM=;
        b=EJQM7uAg4WuG4KyohyVLZn13Nwc8xLzhYu4kuHLQwPdTm1ipTqNCmXyX/rRCPfbAXp
         lEZo/mjPXuVSmyRZx6Q5AgFNZ8O3BsURRBkawEGlJmwKFKbOwt2yHtRk6hYnD77TaJ7Q
         itikuFEilrrglVCzVqdFSZf5Va0VqiaqZjiY2wiApU9vQ/2JKAAjC00vS6ILZ1vgg2a/
         ca2A3bCjq4EG1CYFUZ3kKI0n8MhbD2p1ZTh2vdznCPpuqB+Np6+KeZh6xHe3tbIA2h0a
         P7xpUKxqHqdoPkb6CdAM1uz25vYKQR8SLWI/jYoRaT3G97WEDnbQ0IxMUyUj1/uaD4QM
         9JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mmltr/Dd+R5CsYCrDwn8ebtQuh6MpbIATIGTBEhAUpM=;
        b=HMpgfel3LR5VEqXJ+DeZ4h2l4iWNL0SPlSdgeWTgdbOFkiFPmwGg8kQzzwrbbN92uw
         1SQH8zKnIbviyU/s9YRN6+YyMiEjLSa+SMwGXoVETqPrKcnw9xKZFZbB4+y7S0+Wdcgq
         YozwiaEKMr7UAWYPWDTJS8hSYVgKA9lUVBidvIk2BpPGkyvFQGvnG3jGpXECQf0stv1R
         fm7cA4T12glGlTOEyZbyyPD3sjaTE3M22TzX+UFYI3MfNLOnV54Pgj1NvweUOmlCHwgu
         OGBItk6LhVK0nhW3oNe181jmNmamt7dei9aCm//RgJ7IFgAw/EtqpPtMGbyo8gGZf7zB
         laMw==
X-Gm-Message-State: APt69E0QnciOgSQ9oTig96oHGoU/vXEB2fyyjdLtuuWIkSxecf8NuHFU
        0i7SHXhBXvMjrsdd/vG5kHw=
X-Google-Smtp-Source: AAOMgpf1HxeyGkqSVuds1J/5bKEMOr+X7kFi/JkLOG1VsHhQiZNFitXhh/figotTRTtUUb4+p098ug==
X-Received: by 2002:a17:902:700a:: with SMTP id y10-v6mr22926504plk.249.1531181333482;
        Mon, 09 Jul 2018 17:08:53 -0700 (PDT)
Received: from localhost ([110.70.15.27])
        by smtp.gmail.com with ESMTPSA id r87-v6sm36791836pfb.1.2018.07.09.17.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:08:52 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:05:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180710000524.GA6759@jagdpanzerIV>
References: <20180706134724.563799-1-arnd@arndb.de>
 <20180706144213.GA411@tigerII.localdomain>
 <20180706114951.6e739180@gandalf.local.home>
 <20180709234203.GG4447@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709234203.GG4447@eros>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/10/18 09:42), Tobin C. Harding wrote:
> > I prefer not to do squashes unless absolutely necessary. Yes, it is in
> > next, but even branches pulled into next should try to resist rebasing
> > (I never rebase my next branch unless there is a real bug that will
> > break bisecting).
> 
> Steve if you do not rebase your next branch and the branch ends up
> containing fixes to patches like the above doesn't this mean that when
> you do a pull request to Linus the branch you are asking to be pulled
> will be too 'dirty' i.e. I thought that the pull request should be like
> a patch set and only contain the 'final product' not every change that
> was made during development?

+1

	-ss
