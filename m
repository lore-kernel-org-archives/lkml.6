Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B107C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40145208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1N4YRz4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40145208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeH0UaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeH0UaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:30:25 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46243208E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535388184;
        bh=CeCSVXp1HAq/9DGplbVmiI2vP+liWHZDR7PggkI/Qho=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1N4YRz4ZMRH598wNS/veTU1KwEE56r1XkbHIjCc9CO8flawqjRKGy1v++qRrUY/Xo
         tPFUxnglMi6uuhFfhoMVo1Ijp4ys9zO+nbd9CLIrqwRE9vdls6drmJNAsN4eymSs/o
         X7h1mXx+hSgp0DE+FlhSE2pbRSbpxJiKvZ4DWnHw=
Received: by mail-wr1-f44.google.com with SMTP id m27-v6so14256246wrf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:43:04 -0700 (PDT)
X-Gm-Message-State: APzg51Ai0InD7AFskyEOd6KxptoN8K5ywc2R7nbjbUQilbuJrgA7tPWc
        XPVXStt3GIU8Kje++M8lawHQzOooEav0gv1gDENCXg==
X-Google-Smtp-Source: ANB0VdZHvP483VX8LqzrMZ6E18xyIGm/i/1oDaaFkI+O4cRZCkBkGBmiCp3aox1TNSx11cVkJQCa9Hn51nBeEhsPWus=
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr9471077wrm.21.1535388182749;
 Mon, 27 Aug 2018 09:43:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 09:42:42 -0700 (PDT)
In-Reply-To: <CALCETrWqg82HxGEa6Locag=M6ytgOamvRyG96dT+Hqm2QwZ3pg@mail.gmail.com>
References: <CALCETrWqg82HxGEa6Locag=M6ytgOamvRyG96dT+Hqm2QwZ3pg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 09:42:42 -0700
X-Gmail-Original-Message-ID: <CALCETrVNUd3YahKEjF3mwNMz-zfp9AdvK+OV8uEvSyrX9TPymA@mail.gmail.com>
Message-ID: <CALCETrVNUd3YahKEjF3mwNMz-zfp9AdvK+OV8uEvSyrX9TPymA@mail.gmail.com>
Subject: Re: Removing entry trampoline and associated reversions
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[gah -- accidentally hit send]

On Mon, Aug 27, 2018 at 9:42 AM, Andy Lutomirski <luto@kernel.org> wrote:
> Hi all-
>
> We had an unfortunate conflict.  Adrian did all the plumbing to get
> entry_trampoline to play nicelyh with kcore and perf.  Meanwhile, I
> was working on getting rid of the entry trampoline.  Adrian's code is
> merged and mine is finally in good shape, and there's an obvious
> conflict.
>
> So I did a bunch of reverts, all but one of which were clean.  The
> series is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/pti
>
> and the messy revert is here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=50ef6380e448650b48db979d7d1f20a325b0a273

Is this the right approach?
