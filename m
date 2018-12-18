Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC244C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A8C2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrY94FFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLRIz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:55:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37533 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:55:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so6005263pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PHw2ka3sVg6gr59qEe0pGw+4P8YqLuZzAS8Y9B4Wr58=;
        b=MrY94FFmv3ZQibAjt5QH6Eupqg1gJ5u44ouuj6XIST6oyNruDLr2KR0rXl6ssOjtMh
         8scfd2ElZeqTMuDw35EWbEzpP1p+iCIwTzgcglmrlWhDhzoqpbO3GALq/tHFZjUh8WT+
         6VFUVn0M6UGglUjOxFLYEjysisqlN0lM45XlD0MdlSpnmneJReFfuRJqIFP19kEwBnJG
         jkUEwFgoFX37/JiiTP4RVhDlBqpnXAAsjXBHIrjOw2XPKbzfhNu0munu1ZxsmUrlJAVv
         957kf/ctsPVU8rxRp7f3Jut40Tf2I09Pg3kBN974y5nKeT3PgmQvSmYNwtZjk/1HdfvR
         Gypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PHw2ka3sVg6gr59qEe0pGw+4P8YqLuZzAS8Y9B4Wr58=;
        b=aF4tNC/QEmsvdUdGoMu4uEsj7ni/g0YcyTItdeYXxq9vqTbqB3RqxHazi6ee6ZPDCF
         pO+yO0s1A5pF7Kheu80FSH8cELFe2JvIq8jwSIFCThzUDgonahHDKOmd8mQgrUGKsGOK
         5OScOSQVKHP916e0ygCxviJBUxGJdNLHvbz/uDH6XD1h03SLtt1xuj1amk6RLf2c6gob
         D6GAx1Kstamn7S4pSKa8dbR2ik4IIppEfqPtaM7m4+VT4pI0mFSODwJSreDJhm5zeOWY
         syMhJm/WSdrfYQCA7RNs1Fep06B2xeWHWHsiDR6NOJLC+U3B0oNtS7wls5j9hBk4gXpZ
         W6VA==
X-Gm-Message-State: AA+aEWaoqwgypjTUdlUVxP7z0bEkq6zwQFP5/guwP09+c7XylRSZSoxe
        /9O3DoJemtNb9Om0CVSHXWA=
X-Google-Smtp-Source: AFSGD/WX3wlSSOCCCFLfNWKN35yeALqUf4ENLeiUEu6QFHSyxFMFpTQuzTCSXhSCyffmrGfQASeNAw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr16057100pfv.216.1545123328319;
        Tue, 18 Dec 2018 00:55:28 -0800 (PST)
Received: from localhost ([175.223.2.245])
        by smtp.gmail.com with ESMTPSA id b4sm15540359pgq.65.2018.12.18.00.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 00:55:27 -0800 (PST)
Date:   Tue, 18 Dec 2018 17:55:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181218085524.GA1047@jagdpanzerIV>
References: <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 06:05), Tetsuo Handa wrote:
> +#ifdef CONFIG_PRINTK_CALLER
> +static size_t print_caller(u32 id, char *buf)
> +{
> +	char from[12];
> +
> +	snprintf(from, sizeof(from), "%c%u",
> +		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
> +	return sprintf(buf, "[%6s]", from);
> +}

A nitpick:

s/from/caller/g   :)


> +	  Selecting this option causes "thread id" (if in task context) or
> +	  "processor id" (if not in task context) of the printk() messages
> +	  to be added.

Would the following wording be a bit simpler?

  "Selecting this option causes printk() to add a caller "thread id" (if
   in task context) or a caller "processor id" (if not in task context)
   to every message."

	-ss

