Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D24920835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng0kciy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D24920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJCTPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:15:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34451 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:15:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so1638186pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/q8lL31KgUmHSmJXnwCNOS+n3K2TwKbf+wWx/P/p1s=;
        b=ng0kciy6NtznFjv5D22mK8BvFcbJO2D0SIbD6+mxWHdi+AaUuFXqSyczVbd8A0lmXW
         qNptJdjowByb2hw7r6nTet5hLQ5YaoLNYM9lBUIt1wT+NMIoCepnT+3W9rY2ntTzbDg9
         STFbO2Zp5MCv7HutuVP7cYDKDOmkB3cPwSMDzM0IT5ceY4p5lB7xLWZPHsTpuX8hOEhz
         85KoM8fDqwxZ3g7e518NgwfsvMPUZEHyDzKabaTY82rYb3v5G08yqSrtprB1Iygp7t7x
         gQM5sCnJ/N+b1TIapww6xnKzoQfeRRmIFcbo3WDw6Qkm1x5X5h+C0x80p20Y2t1vwZS2
         Jr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/q8lL31KgUmHSmJXnwCNOS+n3K2TwKbf+wWx/P/p1s=;
        b=D9K59NJ8VEAxHDD5Ys2t8dvPjyaYuBksyyJdwrTfglG8PSH7mIf8kYcpx0i3EM5u1N
         zWU4QDEIAzjlcXBrReCgsGkAAi4ApC1sec0zXTSoSPlibEeCQAU8PMAwqyGJMx39N7R1
         u7J809T9qbwufsZioVVCerQsScun6fqZavjF1CjY8W/1+2pOvwsR5MtamD0fwiXVH+Nz
         6xSztZb6EkH3nxyJKwSEvyjhB5/5IYn+mqqKwru8AvsWDDbNiWjJBq9OYQtUhjbuQaHr
         fjO2O0a8t07QCYOZrIDJz4pc1IqgPjW/WPLU/H05AvKcNSmWVTqfWcJbWbsfrxQzJbeK
         pY3A==
X-Gm-Message-State: ABuFfogbEvqk8P7vq5sJuDvNgauePp1pF+n3E0VQ646Y/Uiziv3KD+8+
        EYWYrYLB79pQFiRLmY38rEw=
X-Google-Smtp-Source: ACcGV63ILV4NvmdtRF2G4t5bnCIDlTSPkrdymkVsR2MLKmcObk5G7F33oOfrCXLadU5QSiZ1CjJM1g==
X-Received: by 2002:a63:d0e:: with SMTP id c14-v6mr1148177pgl.281.1538569655064;
        Wed, 03 Oct 2018 05:27:35 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id h7-v6sm5714792pfd.35.2018.10.03.05.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 05:27:34 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 3 Oct 2018 21:27:26 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20181003122726.GB30267@tigerII.localdomain>
References: <20180928095304.9972-1-sergey.senozhatsky@gmail.com>
 <20181003092349.a6h5tprezkfo2xcu@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003092349.a6h5tprezkfo2xcu@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/03/18 11:23), Petr Mladek wrote:
> On Fri 2018-09-28 18:53:04, Sergey Senozhatsky wrote:
> > CON_PRINTBUFFER console registration requires us to do several
> > preparation steps:
> > - Rollback console_seq to replay logbuf messages which were already
> >   seen on other consoles;
> > - Set exclusive_console flag so console_unlock() will ->write() logbuf
> >   messages only to the exclusive_console driver.
> > 
> > The way we do it, however, is a bit racy
> > 
> > 	logbuf_lock_irqsave(flags);
> > 	console_seq = syslog_seq;
> > 	console_idx = syslog_idx;
> > 	logbuf_unlock_irqrestore(flags);
> > 						<< preemption enabled
> > 						<< irqs enabled
> > 	exclusive_console = newcon;
> > 	console_unlock();
> > 
> > We rollback console_seq under logbuf_lock with IRQs disabled, but
> > we set exclusive_console with local IRQs enabled and logbuf unlocked.
> > If the system oops-es or panic-s before we set exclusive_console - and
> > given that we have IRQs and preemption enabled there is such a
> > possibility - we will re-play all logbuf messages to every registered
> > console, which may be a bit annoying and time consuming.
> > 
> > Move exclusive_console assignment to the same IRQs-disabled and
> > logbuf_lock-protected section where we rollback console_seq.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> JFYI, I have just pushed this into printk.git, for-4.20 branch.

Thanks.

	-ss
