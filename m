Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B6BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E35F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEecLmec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfBSQ1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:27:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfBSQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:27:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so3450306wmh.3;
        Tue, 19 Feb 2019 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tL6eR2L7UxyIUDY61oSvLQ6mml8epcJcG5zvxZPMXl0=;
        b=nEecLmecB13ogUur2zLydQOrcByBy0GH+tzjZ8SbZB0RTgp5rYx489R565zK19xvKj
         wac9GlsORscIAfcJ7dLMfEHHm8ZRTJbTZ5dOBTbrQeL3hJsXfaZfbc5WAIdFTAoAlnc4
         96k3WuceNqWShcSYKXEMUhp5CUy9Y9EFEoLtMxVHnOqvovcVibt2+d773y5pFIh2DdVP
         lLsqvAbPExpz+N7/bcfZTA0vYBxNBIUbyMAIK1134D+1iTlkbsxdWO8wuNAtZ1VmwRRj
         SXJIWMxqPaXpv+UL4mFqAwVT675Ns2f+02CNuPMsJoOVVL8brSZ0+inidDeBbYTwi9+V
         Liog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tL6eR2L7UxyIUDY61oSvLQ6mml8epcJcG5zvxZPMXl0=;
        b=q12CJy6fq2nk4srRNTunXnv50mZC0QJ9758VKRqVs9b7/1fxHuTblqDlvOX8cmwiyf
         mqsK6dXVeNqIIsuspwHgIT2ETeVWQWpRRC6EOlZ70WrQLeW46mQCFUBACPQJRrP6SLaV
         /rhMtBRm/3japRH1geF1O/5syXDTrpdg5odZ2gEtAUmDatveE8U4yvsSJACwwcVrsdo0
         cYlk1pV1y9Dcc+Mnd0ooMeMNgguA/dbladVI2Op2gekKhUGMkCJ2HSm0SVf9aFa4g3u+
         m/483jI4KXAw1FdkXwqyNkvywgUkQtpDRyynsP/EwLAVqjrI6YMiuLx+ve1fM2OIMdkZ
         L/jg==
X-Gm-Message-State: AHQUAub72FBV/Z6OJEMcX7b2rsnBhRguHnqSLgkX7CM9k/EG1z85LVPk
        dEObvrMGdPA0IJgZV2/sMkCVb8W0
X-Google-Smtp-Source: AHgI3Ib+S98WKw85zSUH96pmJdD5n4kucUv2Dr1bpmPOKF3EVCGJyT+8GMsPWinSo9iUkkNW8Ss+rw==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr2441373wmh.42.1550593663936;
        Tue, 19 Feb 2019 08:27:43 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.225])
        by smtp.gmail.com with ESMTPSA id h1sm3466314wmb.0.2019.02.19.08.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 08:27:43 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:27:41 +0100
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages
 if ksoftirqd is blocked
Message-ID: <20190219162741.GI21785@localhost.localdomain>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190219145826.GH21785@localhost.localdomain>
 <20190219160606.jwjrgf6nxarnd2wt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219160606.jwjrgf6nxarnd2wt@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/19 17:06, Sebastian Andrzej Siewior wrote:
> On 2019-02-19 15:58:26 [+0100], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > I've been seeing those messages while running some stress tests (hog
> > tasks pinned to CPUs).
> > 
> > Have yet to see them after I applied this patch earlier this morning (it
> > usually took not much time to reproduce).
> 
> So is it better or not. I kind of read this as "nothing changed".

It is better. Warning message doesn't appear anymore.
