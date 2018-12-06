Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C76C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666D2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="WIeYS/3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B666D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLFPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:35:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39513 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:35:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so952710qtl.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EPvFlGwtf3ouZonNylTbHvWnQtnzTmxZeJhlUIPwVS4=;
        b=WIeYS/3LXFUDotVm0xxNlpL/u1lC/M8q9NDIMYm3BeTTRh0RajpSTtRF5bxeafgs6N
         veISQm/FWpIn5pXiJM1ZT9KXUbhFGrIEjFpEOV/csq9pptoVF7KL6QUMtvrchLcqUpga
         UeXGDRxoMFcDT3C2qUAjS90FngSC/FE+4EFjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EPvFlGwtf3ouZonNylTbHvWnQtnzTmxZeJhlUIPwVS4=;
        b=quSXYG4EC9XIzdM7OkHovOKJIQwpK4mDtAYpVqX1+RB5Ece7+HXw7JX6ik00JP74H4
         A1SxvQ0wW1cZJ1upLji/K/EEA7BdaQ1bFdCiLIw/PElw4AasS2kvwPXVxLv9Zf2PFNpm
         i7KimzUccnZtP+zmIXQRefUgs629Bg17q0lg7NdUlK0Ik4n6dqQiM32DTO5rlKOD4t+L
         IiRPvdwrqHm5POYn4oABRe0lgCikCzU32BQ46e3Oezj1n2vAJJpbVw99smUV565TR6ZG
         EjNyMiBuzIDIKsgGIh6N8WFxkh4Jwn4ozk/VVtqX9EoRdg1wT+lvX2TAYC2o9ZTftQ4K
         Hbfw==
X-Gm-Message-State: AA+aEWbOrKAXbBxM/qrGckpYswS+w2xpQ6e1KE5OqavPwimTWIw9TKgC
        89CpO5M5wHI1H7k7UqDCorPpIA==
X-Google-Smtp-Source: AFSGD/Vs/e6gMcWTgll5C7dslZkZTUY4KEmPt5ysaqlApfNelA0usslpkS7Hmxjnwx+b2pEyJN+NSQ==
X-Received: by 2002:a0c:f9c3:: with SMTP id j3mr28216976qvo.107.1544110532721;
        Thu, 06 Dec 2018 07:35:32 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 3sm274960qkd.84.2018.12.06.07.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:35:31 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 6 Dec 2018 10:35:28 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Jiri Olsa <jolsa@redhat.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
In-Reply-To: <20181205183326.GE3836@krava>
Message-ID: <alpine.DEB.2.21.1812061033180.2368@macbook-air>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air> <20181205124538.GA19343@krava> <20181205163838.GA3836@krava> <alpine.DEB.2.21.1812051208580.29892@macbook-air> <20181205183326.GE3836@krava>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Jiri Olsa wrote:

> On Wed, Dec 05, 2018 at 12:11:19PM -0500, Vince Weaver wrote:
> > On Wed, 5 Dec 2018, Jiri Olsa wrote:
> > 
> > > On Wed, Dec 05, 2018 at 01:45:38PM +0100, Jiri Olsa wrote:
> > > > On Tue, Dec 04, 2018 at 10:54:55AM -0500, Vince Weaver wrote:
> > > > > Hello,
> > > > > 
> > > > > I was able to trigger another oops with the perf_fuzzer with current git.
> > > > > 
> > > > > This is 4.20-rc5 after the fix for the very similar oops I previously 
> > > > > reported got committed.
> > > > > 
> > > > > It seems to be pointing to the same location in the source as 
> > > > > before, I guess maybe triggered a different way?
> > > > 
> > > > nice.. yep, looks the same
> > > > 
> > > > > 
> > > > > Unfortunately this crash is not easily reproducible like the last one was.
> > > > 
> > > > will check
> > > 
> > > what model are hitting this on?
> > 
> > Haswell.  6/60/3.
> > 
> > While I can't deterministically trigger this, the fuzzer usually hits it
> > within an hour or two.  Is there any debug or printk messages I can
> > add that would help figure out what's going on?
> 
> I can't see how we could end up with that config other than
> some corruption.. the only way I see could be that we touch
> cpu->events array without checking its active_mask bit
> 
> but that does not explain why the crash happened in the same
> place as before

Maybe it is a corruption issue.  I had applied my own debug patch that 
would dump some info if data->callchain was NULL.

But my debug code didn't trigger this time because it looks like 
data->callchain was "1" rather than "0".

[27764.840179] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
[27764.840179] PGD 0 P4D 0 
[27764.840180] Oops: 0000 [#1] SMP PTI
[27764.840180] CPU: 1 PID: 18687 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5+ #125
[27764.840180] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014

Vince
