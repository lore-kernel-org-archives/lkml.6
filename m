Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA4F27A47
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhWLy7t6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA4F27A47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936436AbeF2BrJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 21:47:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40807 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934863AbeF2BrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 21:47:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so3640652plo.7;
        Thu, 28 Jun 2018 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/cvEQWDU2WRceqEFixjxn/m1I2LIbLzT7WMkguwJooY=;
        b=BhWLy7t6GZzOreb7m7rprv6egyxSmCA2MqYQ0fNPcrdDfeoSay9QN2Xcu/XNzlnToL
         ovVm1Ltsh8hmF9cI2jYFAx6pZZZBstTNOo0MvcSPDhKt/yC+AIZJ4pWXX31qzy8nXFHs
         5/xb1+hdSpMDWpQe7uMmqISwYs2S6/Fet6i64RamZCg1dzOVENScxkW1DtyEf/mNx5We
         TRFu14wZkq/+ZW3Lk9qbllujqbVVulvNnLF2cmtxoEZeu61bSrSJbtXUC9mni7OPhEHn
         nC3SBhVY3EBCb1QtgNR1546IJzXmpy4f1c8mRlSDotExDTwphSHkld7J3wH+5kVFFxHW
         J7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cvEQWDU2WRceqEFixjxn/m1I2LIbLzT7WMkguwJooY=;
        b=BB1OgXgnW/AHPGaApb8jXm4SXEDfxtOQ/USVa+Z7D88aEqf5csRQDWDcKowrGlPLhv
         25Adwk/kUZnQh0SDjKI3PFYZuw0Y/mdfPjmtglQYknAJNLtamV2phCgMP6NTgIxdAq/Y
         ElmFdz3sNnFozyoYiLpOS6/FGAgeh/G9d5IJMtrbYJuPBFhEejKGkDJuQ6Cl4d4Af2Gy
         1BKxLFhrjLBP9C6ho2/jUxnQDDTSrMa8qVHibH9Mq5q+g9mpaCa8HpEa+gpRBLjO0hrg
         SDM3Ub4pudfKyA8SVlqtLxy/Xey/0TDDYahFHvmGoWZCbdo3nYjvuVhITrJRmanY98aj
         BOMw==
X-Gm-Message-State: APt69E1FJQszBBxGdoT28junBtGkD+70F2qQBAe8esWn8NLY4TGZ2g01
        660c66b4I1XEHxW8dM56gCM=
X-Google-Smtp-Source: ADUXVKINu4ertEKSFV5HaE2bCtKwTyv3QDqOJbUwlap5Sc0wOBWyJQ8wQ/Jtenum9ckwlnPlNnFW4g==
X-Received: by 2002:a17:902:904c:: with SMTP id w12-v6mr12699365plz.34.1530236827575;
        Thu, 28 Jun 2018 18:47:07 -0700 (PDT)
Received: from localhost ([110.70.26.165])
        by smtp.gmail.com with ESMTPSA id p2-v6sm10740563pgq.14.2018.06.28.18.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 18:47:06 -0700 (PDT)
Date:   Fri, 29 Jun 2018 10:47:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk/nmi: Prevent deadlock when accessing the
 main log buffer in NMI
Message-ID: <20180629014703.GA614@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627142028.11259-1-pmladek@suse.com>
 <20180628022507.GD481@jagdpanzerIV>
 <20180628094125.cq5qunckjyxhbovb@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628094125.cq5qunckjyxhbovb@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/28/18 11:41), Petr Mladek wrote:
> > 
> > A side note: This nesting also handles recursive printk-s for us.
> > 
> > NMI:
> > 	printk_nmi_enter
> > 	ftrace_dump
> > 	 printk_nmi_direct_enter
> > 	  vprintk_func
> > 	   spin_lock(logbuf_lock)
> > 	    vprintk_store
> > 	     vsprintf
> > 	      WARN_ON
> > 	       vprintk_func
> > 	        vprintk_nmi
> 
> Uff, it seems that the current design is "good" at lest from some
> points of view.

yep yep

> > > +		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> > > +		raw_spin_unlock(&logbuf_lock);
> > > +		defer_console();
> > > +		return len;
> > > +	}
> > 
> > So, maybe, something a bit better than defer_console().
> 
> I am not super happy with the name either. But wakeup_console(),
> schedule_console(), or queue_console() looked confusing.

Hmm. defer_console() makes me think that we are dealing with that
fbcon=nodefer and deferred console takeover thing here.


So I summon Mr. Rostedt!

Does schedule_console_output() look bad?
What about defer_console_output()?
Any other ideas?

	-ss
