Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75650C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2249320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl3FNJ04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2249320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeFTLIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:08:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38844 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeFTLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:08:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so1439010pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njb60ll3v9Zm/B6IkBAeRZ+68kPYfd5AxQyQd90QWLY=;
        b=Hl3FNJ04bBEGM01aOXfCnQPu76ShZSl3VfDmpsEpct5fmtUuvYlJV4RXy3f6prsbTN
         pwgdbzPOTNr8ocXkRK7a/CkkBMPDtasy3zqA2p9eFPSx05lcFmYUbapuVlnMtKtyCrnL
         xS5vNsYne7N0OI1xdmhmm6SgeB6oeOr/IDI2dLsKH7C4vNbVsQVN0Sa5oxjjeUaVKtYR
         9kgkcssV5+fNZHllM+s1kYWexjgDsdVBde5EqgP81ExD1wA+uPOPz5ZhHJUT6uqOgsNO
         Pid3IPaiIhLhEP+tUOqJIiZ8gZXhcI5pKM8sJwi75+WxP3RiZMeKtakwdcoo5pim76Gs
         EeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njb60ll3v9Zm/B6IkBAeRZ+68kPYfd5AxQyQd90QWLY=;
        b=O0cOpmDzhA+H+rfZhEwRpfADfMG93efa5QQgvxIid/13K02+HuTF4aSFWbsxggnVdF
         dfdO/WXZtzWU4fcq2e7ea5BCW9DxSpVXDPtOZBOD2WJlfg3cTYj2ojFenkaYJWF+SPPO
         6QCnySn21EsS4VtEpwEMkV99gegS9NXdRsNNW9VHG+ed24jZIn28MdAzrNKDFupwNAst
         oXIFDWpSTTgNBo+oy6ek3Kj2+ESIe8QG40jilC1sxRAQe9QOg0+I/SPHMSqOlwdJbyrQ
         e+g4Ev5mhSf0X1GKkAv6F8TKBn+ucnl3X6FCuB9BlmfpmyV88euVVvUxAyxNF7o1Oqqv
         70vQ==
X-Gm-Message-State: APt69E3QzPDhJ3rzaIcuQU31/rvb+FM5IeV6sIpUj2t8+Uy4BAok6Eh7
        zJnUVgtPieLMN7OIU+ieP/A=
X-Google-Smtp-Source: ADUXVKLVLbR5N2GWhrKirGU76KXbFB+ktrN/wtQXGKRQmBvO64FvjYNYZUF7mAIU+27DdBVXbgkUOQ==
X-Received: by 2002:a62:418b:: with SMTP id g11-v6mr22338879pfd.51.1529492884093;
        Wed, 20 Jun 2018 04:08:04 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id g10-v6sm5491358pgs.17.2018.06.20.04.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 04:08:02 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:07:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180620110759.GD444@jagdpanzerIV>
References: <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 11:31), Dmitry Vyukov wrote:
> > BTW, pr_cont() handling is not so simple when we are in printk_safe()
> > context. Unlike vprintk_emit() [normal printk], we don't use any
> > dedicated pr_cont() buffer in printk_safe. So, at a glance, I suspect
> > that injecting context info at every printk_safe_log_store() call for
> > `for (...) pr_cont()' loop is going to produce something like this:
> >         I<10> 23 I<10> 43 I<10> 47 ....
> >
> >         // Hmm, maybe the line will endup having two prefixes. Once
> >         // from printk_safe_log_store, the other from normal printk
> >         // log_store().
> >
> > While the same `for (...) pr_cont()' called from normal printk() context
> > will produce
> >         I<10> 32 43 47 ....
> >
> > It could be that I'm wrong.
> > Tetsuo, have you tested pr_cont() from printk_safe() context?
> 
> 
> So this is another reason to get rid of pr_cont entirely, right?

Getting rid of pr_cont() from important output would be totally cool.
Quoting Linus:

    Only acceptable use of continuations is basically boot-time testing,
    when you do things like

     printk("Testing feature XYZ..");
     this_may_blow_up_because_of_hw_bugs();
     printk(KERN_CONT " ... ok\n");


I can recall at least 4 attempts when people tried to introduce new pr_cont()
or some concept with similar functionality to pr_cont(), but SMP safe. We
brought the first one - per-CPU pr_cont() buffers - to KS several years ago
but Linus didn't like it. Then there was a buffered printk() mode patch from
Tetsuo, then a solution from Steven, then I had my second try with a
soft-of-pr_cont() replacement.

So, if we could get rid of pr_cont() from the most important parts
(instruction dumps, etc) then I would just vote to leave pr_cont()
alone and avoid any handling of it in printk context tracking. Simply
because we wouldn't care about pr_cont(). This also could simplify
Tetsuo's patch significantly.

	-ss
