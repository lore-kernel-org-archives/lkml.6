Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC64EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9154D23FE5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZv1Ka9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9154D23FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030337AbeGBKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:39:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34305 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965277AbeGBKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:39:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id e10-v6so754935pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DJCcPLsn4nFXb59xiYAUyrQxqepA/cE4v8qhRW+10gg=;
        b=IZv1Ka9psp13HckE2cgqHVnfO4U9Y3ThtgWkjZWO//pwqPteNKy/SnBhuccysXhvSS
         y9yDWG5NH0P5Uh80BGQ81ei2tpGUZxNGi1A8RaGohbXqfww/WzRaf5J2IN8UBULpBb3M
         frueH/fOMIjqD0c7F2qnTM59W8Ob2TOq56nDoIh5Paqnd/7cXJAAn9JQayeDOd2dpHx1
         SxS+ETGNR+xu5ak+Ch8YKyGlgc2wgm5SSBRsp69Jm872Vo+7/YVZdLpv5sMD4or3DjaD
         I/6voE3+xp/AA3MvlxbGCv3whHARU6DhDKBCN9VzffmG2tv7+PWQuf60KmLbtzP4LzDr
         xF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJCcPLsn4nFXb59xiYAUyrQxqepA/cE4v8qhRW+10gg=;
        b=Fkky9dtc6Cw5Ku1A0CERkusVuYtRRkkh7/wgVD2bFMU2h4VDtLPGHoh1HlkEh7JXjM
         NREFo/+vXGI84eTK1UmtdspZXllhlzUyqlkYf0eztkXUcMFax5b6Q80XRUW8sycAYrWL
         6GZpCLf6R1ulPpWZaIcv5CkGcYRLUNoI75A779YtSIp/FAehuUJ+m+bfDsNxALsPlhB4
         MEv1M5n53YB5jo2Ab0i4miMOz5tHxR3WGYxUmAJqPJ5kSbi9teqZWAJXzTKJhVqFXt6n
         Leqc6yO8vI47Y/x4vaDkICHEi6rNaBchbf8p5nLolssKejPZJHP648VM7fBE0Uy/kZlf
         e5Sw==
X-Gm-Message-State: APt69E2mUQrW/CUEo4hjdGsN5Cy3Ms57HTHgubjHNOHYx3OKJOxyK02i
        b7p+4x+G2isVBg2L2jr87o8=
X-Google-Smtp-Source: AAOMgpd1nwJJeDKSKL+AH0lvp9il4QMWX2iJgIKRSGHHB/S962H5EKlbfVcDQzVuIIz97eZo+EskHw==
X-Received: by 2002:a63:2ac4:: with SMTP id q187-v6mr20228439pgq.333.1530527962336;
        Mon, 02 Jul 2018 03:39:22 -0700 (PDT)
Received: from localhost ([175.223.27.171])
        by smtp.gmail.com with ESMTPSA id s27-v6sm38420722pfk.184.2018.07.02.03.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 03:39:21 -0700 (PDT)
Date:   Mon, 2 Jul 2018 19:39:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180702103917.GA3673@jagdpanzerIV>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (07/02/18 19:26), Tetsuo Handa wrote:
> Hello.
> 
> Today I was testing conditions when/how stall watchdog fires. I noticed that
> printing NMI backtraces to consoles is delayed till IRQ is enabled or somebody
> else schedules printk(). This is not a welcomed behavior when the cause of
> lock up is doing nearly-infinite loop with IRQ disabled. Can we improve this?

Hmm. We can't call console drivers from NMI, this can deadlock on
uart/etc locks. So we always need [except for panic()] someone else to
print NMI message for us. Either it's IRQ on a local CPU (we need two
IRQs actually - one to flush printk_nmi buffer and the second one to do
console_trylock()->console_unlock()), or printk() from another CPU that
would print pending logbuf entries. We used to have a fast path for
print_nmi messages (direct_nmi), which soon will be used only for
NMI->ftrace_dump(). Even if we re-introduce that fast path for printk_nmi
[may be we can do printk_direct_nmi type of checks for printk_nmi as well]
we still can't print anything from the NMI CPU.

I need to look more at the data you have provided.

	-ss
