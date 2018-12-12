Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A019BC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642D320839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN4deFy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642D320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLLCUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:20:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36953 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLLCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:20:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so7837942plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQG6kChGCIpwY/2Sq16MRwnTsYQmGFaaHeZ7M37JPCE=;
        b=VN4deFy3Z2scyETh8SNN9v6m47pbMJAKgjbfGP4pXCDEuD1JIqu6XOvMIUZVjzzZVv
         IAC8CnnAnTH/Q81yc+dT6IJ42lGEx63kuHMwg9eXqdP+0X77kBIqxl26vrYIPYsJ8LzX
         udnMhkHsijzyxbwmIclXKkeEzp+sxjzObzZwbfQxopr5Y9yRTToMZLED4Kvsy2pnyjGR
         O/HxJpOgP+yrtoOaBBixAaqsTCuMgFkJFh0J3EHp0u273JsoMwmvkDl5BbVv5Drzb/RO
         RXbA3UEFP0E36PotovgsRMEaoCg+gxOO8Qtl3rjzWhhQImSTrUOTcJ44XO87QlPynwpu
         xhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQG6kChGCIpwY/2Sq16MRwnTsYQmGFaaHeZ7M37JPCE=;
        b=iBprGhJnASRiERNXkuQRTg0ULdTtC5MVYI7nsqQIH+h2nV1T/Abk757jBfnv7CQtm5
         3Z98fXj0ZHsIGjHbdVZqW1ouVi250GGE2cj5kCix8iQo+4phhYHG+ZidqiKA1LnTFbRU
         6GIVhgPYz4OgEs6L1kdxRnM+0oTEGKFWtSFHK/C7Aw/7SotR5bTEHSHLOz+OUIo4XxJd
         mxqXIEhKU4Nva3Xm4SFKHESrq3jiZBE1AEy/gY2ityTHrBe5HhoAWrrwapYxp2wn8AG9
         O1yocZ8719rmxz8mNHg9Xh+mxHHZMCUYmWEnjq51qw6ldg3k1hSLjR1LOEBy2bQb6QhM
         S16Q==
X-Gm-Message-State: AA+aEWZqdnwnxT+BjcsDKzn1lUX8sEDCndL6NbsoYj+pxedXxl5c6vT1
        gKzWQNxOq5cwcXCkMjQTP9Q=
X-Google-Smtp-Source: AFSGD/X3/GmYSRXDIJvXkqrgOgF0fq6OhKZ1/4mBPWWiVV7YeTz7YGJ0+hXeJFjU8q+RXBRAcMwFOQ==
X-Received: by 2002:a17:902:2887:: with SMTP id f7mr17702417plb.176.1544581235121;
        Tue, 11 Dec 2018 18:20:35 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id c7sm26200707pfh.18.2018.12.11.18.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:20:33 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:20:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove print_prefix() calls with NULL buffer.
Message-ID: <20181212022029.GA431@jagdpanzerIV>
References: <1544521745-11925-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544521745-11925-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 18:49), Tetsuo Handa wrote:
> 
> We can save lines/size by removing print_prefix() with buf == NULL.
> This patch makes no functional change.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Looks good to me,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


Shouldn't this also have "Suggested-by: Petr Mladek" ?

	-ss
