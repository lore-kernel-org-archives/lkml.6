Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42223C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0484D213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHVeWN1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0484D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeJFDz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:55:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36445 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:55:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so15280087qth.3;
        Fri, 05 Oct 2018 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v+pb5d9zHeFESKORGf2Uf3DDrXJWJO+Z9Eh3VLscf7A=;
        b=rHVeWN1UoXlHDDdiWfnioepptpbbyfD/CRS52JKJOocZ3s1sZqRsSEAoWPwU6E91r0
         hEmXePwI6e6eWHwytq8wX4dCtBla0mW7pO/kAXZusQ/gvWAmWW3QmRnL5wlphtDMCAtK
         fizHo3RiFwovdUIVzq5bj+Nol0KNCttlCAWAoiW/ed4ViHYBi/hEvsCy6iiAY7HpqyXf
         HENqU/mECnHzI9BIWOHeMVwpKyO+65z+CKYjYHMq0KaHG9MbS+VSovjocPaIyGxvUw+x
         SlGifA6b9h0CX3W87jKhxTDw8NyLVj5uMZ26ajG+XVue+LoLJ/BRHF1WCPaTKcc+2LYS
         Lrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+pb5d9zHeFESKORGf2Uf3DDrXJWJO+Z9Eh3VLscf7A=;
        b=qVJ+Dp4Tg/d3OjG6SlLfjrRdHiMOLk9xCQQTKS3rEEuHbPkEiUnUo5vsFNXSYVtHMJ
         ttHssqQsrvfVAXUCohcDEgB9q+uMug/Rdtq8oA+rwqNJRssV7TrncvxZqtD6p40wMpKk
         B3b2EU8WQUMQ2ZczDZFb9l/obVc+uiu7Vs3SYE4j77hkIYF5Juxwutx6Y1fi2fXCvUp9
         KIZ4toUekvdjhtnhpco1Dwm78vfIjrlmSpt/3xHfoyKCc1bInMQYdEfC00cGvrcrcsJO
         jbeQ4uRK7KTtJp7e7IvPLrWz2pjl482VbVoS53GRdphLqm/snBUOJsbJcg2XCaN88VS2
         hB9g==
X-Gm-Message-State: ABuFfoiT6JGqsf2dxz3U8FFGQDjZ+HEwIIqC2ss29/HpBK8FygaAog+2
        aO9YvFbJDXUwcf5kgGX1LvE=
X-Google-Smtp-Source: ACcGV60oenxTY4Parc9elUzGRVl5/Y0F+UGMvD2XQWuC3e4fYSeEq+QGFiLuCQJSThse3EjanP7Yzw==
X-Received: by 2002:ac8:3775:: with SMTP id p50-v6mr10588278qtb.220.1538772932516;
        Fri, 05 Oct 2018 13:55:32 -0700 (PDT)
Received: from gandalf.middle.earth.net (pool-173-48-133-32.bstnma.fios.verizon.net. [173.48.133.32])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4503088qtu.90.2018.10.05.13.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:55:31 -0700 (PDT)
From:   "George G. Davis" <ggdavisiv@gmail.com>
X-Google-Original-From: "George G. Davis" <george_davis@mentor.com>
Date:   Fri, 5 Oct 2018 16:55:29 -0400
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "George G. Davis" <george_davis@mentor.com>
Subject: Re: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Message-ID: <20181005205529.GA3332@gandalf.middle.earth.net>
References: <20181005161826.2455-1-george_davis@mentor.com>
 <20181005162841.wy4uyespwcvffkpc@ninjato>
 <20181005164520.GA2617@gandalf.middle.earth.net>
 <20181005174301.GA964@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005174301.GA964@kunai>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 07:43:01PM +0200, Wolfram Sang wrote:
> 
> > Feel free to ignore if this is a topic already discussed in other
> > threads. To be honest, I did not search the mailing list to determine if
> > this particular issue was already discussed.  
> 
> Not this particular issue, but in general we usually don't change
> working code to silence false positives in code checkers.

Ok.

> But thanks for letting me know this is a false positive!

No worries. Thanks for having a look.

> BTW next time CC Dan Carpenter, he might be interested to fix the issue
> in smatch.

I'll try to remember this in the future.

Thanks again!

--
Regards,
George
