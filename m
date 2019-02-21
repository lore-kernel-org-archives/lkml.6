Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27F92089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBIxkm/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfBUCXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:23:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:23:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so12924263pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 18:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pr+lh/6Oy70dxwSWZ+b+sOinxQFvJaGYzWj0cTfpPzc=;
        b=mBIxkm/lf0W9nHmx1LGF2tclSbpu0NB+OVz+gDCk+lcFDLFVaQayCR4HbZXdgzouLx
         1ld3COhc/3Og6TiJa35qbXCGTpdz5rp2oJMe7n0+v0bf3lLkHeM2vPa8frgsFF+cGbma
         EALGQiyXm3y3WCaQWzWnS2IPmzTHrA/S5X6OWJNwmwADpaVMOeq7LMtC1oThu1m97ahl
         6CKTM3Hq0IUzbK7fkO5h75SQSNZD9vtgWfWs9sxi1ll/HluO5rTzXGyLAwLnDVdGGl2e
         IZ7xsXjXMglTYwoxEl0BwiwQ/EUzgBITMRBiPzKx1ZlrT1muuE9xXdhGMUL4pazREw1s
         BXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pr+lh/6Oy70dxwSWZ+b+sOinxQFvJaGYzWj0cTfpPzc=;
        b=BlIA/UWMpVRjtAbF02KzK1oFV36mXsZ/ZTL/COZoY8wNwhMhyulEFOFPIfIJp3C5AM
         Nxq4PEpNjNWxTxtj/z8H+FcVXDjwhcVAhHvLAz4amZ5eD9Iy/MW0K0RMCE3elmjyNcys
         IU57KU+ZFwRxq/Q/F9g6jATzzqbKubBFD4Env4dX0Qsd+tRV25lKOM8H4/3w8n7BTLGb
         kE5Pu0r5mPdeqtB7p0DW7KZsPEQ+9OYV02hmJaQMmZyNR/RQBDQIxvtbKMCTlVptbxdR
         vtuZcArZ0wkSnK/Orw6m4BkP5UZ7wbgNr0BkrcG33XET/84LWjz+Pb1N/XLNkTmKKmaL
         q+Ig==
X-Gm-Message-State: AHQUAuadAE0KOlGNc020lSIZ2z9PpSopc8E9om9XK8wRm0J2/ssa0CLg
        1bREPkP6ZLOhb/gj7kJG35cwdz3M
X-Google-Smtp-Source: AHgI3IZJ+zsh+vRYKWU/+RahG0BdypsB72UpBJx34m0+FFIeYHdkb31X3RWK5Pl32ScrH99+uoGf0w==
X-Received: by 2002:a63:1845:: with SMTP id 5mr32646417pgy.108.1550715825179;
        Wed, 20 Feb 2019 18:23:45 -0800 (PST)
Received: from localhost ([110.70.55.83])
        by smtp.gmail.com with ESMTPSA id h13sm16244919pfn.114.2019.02.20.18.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 18:23:44 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:23:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Pass caller information to log_store().
Message-ID: <20190221022341.GB15012@jagdpanzerIV>
References: <1550314773-8607-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190220121825.kpqjhdl62x65a6se@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220121825.kpqjhdl62x65a6se@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/20/19 13:18), Petr Mladek wrote:
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> The patch looks fine to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
