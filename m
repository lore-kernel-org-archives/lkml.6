Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF77C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9F2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STdXHEMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D9F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJIT6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:58:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40145 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJIT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:58:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1-v6so781571plv.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TB0ULy2TPsLJIq4OtkbNDMz1b0VniZgu/A0ViX4av14=;
        b=STdXHEMZz/HbSyu053J7F0GRVg4wTi0dXQom2CZyFHMhtjY0ccrLSKCyLqSphb3pu2
         zk/6BGf3XPyKj31MS6NO8EpoFAOLj4y4oYxx5Rtm3z1lGlfn4BAxtbqUUPIQwRRmblJX
         Bp8XDsWCKtElJ9ZMk6UdqOThkQTAxoFXtq1Jnks2J1UXMa5Hz8WA3NgJ3T7EetsQrAjk
         TyowmDg7FBV6KWtQNlzKx5xzOFq+PIyN4MkJzSndIgoSPgpbAF+s2zJprkWDAj1lEvxU
         X6EK4rWOGJm8K55+mTrZWbnOAaHKstJPBHzuwVpRcwMKz1rb3IqpZ1+PfhMvVcXHT2s0
         gXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TB0ULy2TPsLJIq4OtkbNDMz1b0VniZgu/A0ViX4av14=;
        b=jx6ypWtEfZxAVdULkPQusaH9A+LDyV+G6PtlvOe8SKlrPj08GV5wLAXf5DLSZh4tN6
         DozR1N8AnKuwnRMb3tuI0Azg/ITNt5vAQIUZdVCZBBgjJDPWTbybnPV1wK1VgjqczQ+X
         wIqpeF0u9BbNUyxrXP4ynnJJPQMKCf3iWnARGSQcwY3N4v3HsGIx8x3NCRYIObKoqZuD
         8fpH6tBqFyEjJsJdVQSfAMJ/R4/kDur6iAWv4ZbMvSpjDHY4n2fRB+wicqYQXXMyGgI7
         sxVghpStn38GC3kLSZ2rQpHePpYtlAMqOCjpzk62bEuPnKApUXGeTeo7EK+zPN6GG/12
         UwGQ==
X-Gm-Message-State: ABuFfog/aIAej/Zry5vhih65UWxh7JDUwAKQMOAATpB78jwRoBO836F2
        EjBoeg/gIfe8M5M99YKCfoc=
X-Google-Smtp-Source: ACcGV63w6/OANrykLyJcZBiOgKRXnciwhKBvLmyiaP+Zf37UVuseGnSX5DEHSrjjg7RQJmBlMtOmWg==
X-Received: by 2002:a17:902:16a4:: with SMTP id h33-v6mr20913228plh.3.1539088920580;
        Tue, 09 Oct 2018 05:42:00 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id a15-v6sm18483804pff.8.2018.10.09.05.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 05:41:59 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 9 Oct 2018 21:41:42 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/3] printk: keep kernel cont support always enabled
Message-ID: <20181009124142.GC471@tigerII.localdomain>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
 <20181002023836.4487-2-sergey.senozhatsky@gmail.com>
 <20181009081410.cunmqz4zc7sdhwkx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009081410.cunmqz4zc7sdhwkx@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/09/18 10:14), Petr Mladek wrote:
> Just to be sure. The original purpose was to get full information
> including the metadata and dictionary via extended console drivers,
> see commit 6fe29354befe4c46e ("printk: implement support for extended
> console drivers").

Right.

> IMHO, only the dictionary was really important but it was actually
> lost:
> 
>   static void cont_flush(void)
>   {
>   [...]
> 	log_store(cont.facility, cont.level, cont.flags, cont.ts_nsec,
> 		  NULL, 0, cont.buf, cont.len);
> 
> Nobody noticed because the only dictionary user is dev_printk()
> and dev_cont() is _not_ defined.

Right.

> As a result, I think that this change will rather improve things.
> Well, I wonder if we should write something of the above into
> the commit message. Either way:

The commit message probably can be improved, agreed.

> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.

	-ss
