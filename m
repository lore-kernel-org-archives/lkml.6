Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7384C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582A220863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTiI5Ubb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582A220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeK3Pc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:32:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38729 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Pc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:32:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2149321plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 20:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MfZXo4P0/Qv7y5VDmnZC08uHLDhr+piSz/B3uFnUEE=;
        b=cTiI5UbbvrdqlWcwzOqevnQh3X4SxqLsfgEVNesynRy2/aWn2yWvD/cbvQYOECL9cX
         RQV5r034dKrci3Wgfv8+kSaxPbNsqAdgGTM3Z6J3ioXIit6nqWtS2K3SUt1DEB7JJIeu
         hfLIakLBxKaTOzIykMWjIBIe8jQIU0q6WImPIKTWfxII/6uv/p/YZGqxbiZIbq9B5OJt
         Xs4Ber2bw2y2DQm2lptamJ8FW8nXxe+nkgxqPhPYYYVPnChlMJLS5rptgBZbEhp7yZ6f
         6txfcWYMJLX3MrGg11A4Wtut0g/3uwyKsXvrEd1gKgC/OgsYcNGHbmOjZvZGUklk0Nfc
         tXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MfZXo4P0/Qv7y5VDmnZC08uHLDhr+piSz/B3uFnUEE=;
        b=QESoQoNT3L0tBc8Qyu6cWk3dY2nFUCIR2eMIhe7zXbXxj4GdtwNVASl7G4Pl7XEh6Y
         cnxQL2p990XZIvSWGcMbP3pb3N0is5BTQsuMyabta50pVAxjHFzZJlSanW/7NVmRiTp1
         vb/6RK2VZqLXsTe8DVqnQdvWA4OlsKtLIrngcT6YxoqcJTre5D6gYBKSqUPNtCNm35Zh
         Su8cUXN9IW5tv+qBByKfdYyDBgpLwws7sNJW6N4j0PUm1vB7dWZeLS04LPiJ3s9Htwj1
         IJi3Zl90fFmVyxvyBGwtiCMVEEsonTiMDF4j+ahYW0bGarJ8cHJNWwfqyLhP06IPGqhV
         +RDw==
X-Gm-Message-State: AA+aEWaG6XHbPgbRJyZCJTYGzMXXAqS+l+CWXZVAGjEIZqW1W0eJ0DeW
        GcrviCGW5I9uDVlGim6hwe0=
X-Google-Smtp-Source: AFSGD/WmljNx1fu4rwcdMJ7yE1SsJ2P/P5R9S8q8gdIFjlGQy+/AuD1JsP0WV5lAolcTRMGqz1zCoA==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr3931952pla.1.1543551900965;
        Thu, 29 Nov 2018 20:25:00 -0800 (PST)
Received: from localhost ([175.223.39.43])
        by smtp.gmail.com with ESMTPSA id 4sm5274089pfq.10.2018.11.29.20.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 20:25:00 -0800 (PST)
Date:   Fri, 30 Nov 2018 13:24:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181130042330.GB605@jagdpanzerIV>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/29/18 15:19), Petr Mladek wrote:
> This fixes a real problem. It might even avoid a crash.
> 
> See syslog_print_all() and kmsg_dump_get_buffer(). They
> start with calling msg_print_text() many times to calculate
> how many messages fit into the given buffer. Then they
> blindly copy the messages into the buffer.

Hmm. Interesting find.

So can we just use a pessimistic approach then?

If IS_ENABLED(CONFIG_PRINTK_TIME) then always calculate
buffer size as if printk_time was true; but use the actual
printk_time when we copy out messages. Yes, the buffer can
be larger than needed, but at least we don't care about any
races anymore. And we also don't need to pass printk_time
snapshot while we copy out messages.

I really don't know who and why would enable CONFIG_PRINTK_TIME
but then disable printk_time via param. So most of the time that
pessimistic approach should calculate the right buffer size.
Probably.

[..]
> It seems worth supporting the disabled printk_time() properly.
> I am not sure who is disabling the timestamps.

Yeah, I'm curious as well. Can't see why would anyone switch
it back and forth. Kconfig and boot param work just fine.

	-ss
