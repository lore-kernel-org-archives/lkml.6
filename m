Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB710C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E8F20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPKslM1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E8F20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeHaSpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:45:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46818 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeHaSpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:45:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so11405601wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsUWn1tdpegM0IUsMBl6l5qr5WlKXJe7TqKmA3ZUpEQ=;
        b=WPKslM1av1BrKv1PaB4J1pE3JVa9Wee4MrA/1sagBHb5AlBKIff4AehasmmXUx7z/o
         VY1ZGXvuF2nB232oJdHCcOmRSF65r4Fbop0q6iEEtWL3sRnO1t4jItA7bbZbne80UbkL
         XxdFOnxZnBpk0XXAMhXxICnU1e5wSQJyJ7+taQwKbCiNvuUgeeR+PkqsJ/PxvLUaXmGl
         JnZptNw0IVrZheNVprEjwSF+IRuVi33WRy88i4kycTgXLeqXs7Am+c/AdLBZ1XBhtAwD
         VgQ47vnyQnsMC/EW651ilFqwbuE2rRLxH605i9U1BreDw1gp3DkNHQPLJqU9qw+Swd9S
         iBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsUWn1tdpegM0IUsMBl6l5qr5WlKXJe7TqKmA3ZUpEQ=;
        b=l1Z7oOomtYU791wgdrrAipKsHlVAMixD4/4rBKJX3Gcl4fCI7j5w4WA/nzU1huZ5yP
         EF0OnPCU8M5UiPQH8YuZkv+o2hssX/njzQyk30TgJRsPbqh9msQm2zMgbuS8tIvbzldw
         UK3RcknLXzydBO+RwyahWcNQlcFENBIIv1vdviX1p6UwrwLS0UcPklCe04fkFctdWf9C
         GEzt5E/v9KpQ7IxEUrbHFvyp18HfUzdo2nw2ov4EihFdqHBkIhy1RvbpJRUkSt4MC9Fo
         MDwb1dxaJHnKb3hJuy9/3jrNjYKbOGbPkDORI8cgpB/BLm4Tcu6kTY5ygZgiGn4xqzzD
         JcYw==
X-Gm-Message-State: APzg51AvHbsMduJwpMmXVB7zyoxNumpbIvgbIiD1NT9UcJNYms7egrm4
        peC5RGtWiGKoSN7NZUHuFtA=
X-Google-Smtp-Source: ANB0VdbQr4N7VynO2FpePxaaMWfdx87CjH1MtIE59SZddiYr+6oFJTuP3BrWTtnOagoZ42DezuoGoA==
X-Received: by 2002:a5d:6451:: with SMTP id d17-v6mr10307712wrw.64.1535726284051;
        Fri, 31 Aug 2018 07:38:04 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:6d3b:d608:c6b2:3704])
        by smtp.gmail.com with ESMTPSA id j6-v6sm9221232wrq.25.2018.08.31.07.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:38:03 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:38:02 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, bp@suse.de
Subject: Re: [PATCH] x86/dumpstack: fix address space casting in
 show_opcodes()
Message-ID: <20180831143801.dn5dgpob7xb2kqaq@ltop.local>
References: <20180830194736.210039-1-jannh@google.com>
 <20180831082712.cbfvv655amizvkfq@ltop.local>
 <CAG48ez1aw=fSfDEp14=d+GxSu=3hLYP70Sd_s1Xux4MPiNM2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1aw=fSfDEp14=d+GxSu=3hLYP70Sd_s1Xux4MPiNM2VA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:26:24PM +0200, Jann Horn wrote:
> 
> By the way, here are all 60 probe_kernel_read() callers:

... 

> 41 of these (or something like that, I counted by hand) have some sort
> of cast in the call expression.
> probe_kernel_read() is kinda special in that expected types for the
> second argument are both kernel pointers and unsigned longs. It might
> make sense to have a wrapper macro around probe_kernel_read() that
> accepts anything as long as it's as wide as a pointer...

Well, if __user pointers should not be accepted, then it's much
better, typewisely, to leave it as const void * (and cast the
ulong args to some plain generic pointer, like void* or u8*).

-- Luc Van Oostenryck
