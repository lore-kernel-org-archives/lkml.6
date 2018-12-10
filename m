Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC21C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD61120672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq2D9g6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD61120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLJGL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:11:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46770 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:11:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so4453532pgp.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLFdJwDbqeuwAQdpQ7SN1FApwpz0uzVGfQ2EjesI8Qw=;
        b=Bq2D9g6u+O4lUF3WYvIyXRuGXbjscRQUgz4REDtX+1y+rUZCmjJq73u+B+4kAPLl46
         vcy4Tdp4tiQ07Bfk9NYwMTl3hN6gPsuqur7UwFcScFEj15Dxb05N+8lHRO3OW9vC+1cE
         rciDAH0PkU5WUxTxWFud7H7vjgIOncgVrEY5gCmyIyeAM3fe32m/xbxfRohMv8cFY7KA
         KeTCSOay7VZtUAR2SiyqffyepWrz0NiUYat3ObFLhcNRPv4ijQcPpYiuC4h4A87yISQR
         YXQE73aPFfxsZkJDJaNcuiGUf0fiPIV4zQpVwDQMLJB0pctGhyLGGALkze9gDk6pY5wB
         setw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLFdJwDbqeuwAQdpQ7SN1FApwpz0uzVGfQ2EjesI8Qw=;
        b=Jt3yRY2O9POt7+KvCm76wjJrPElmjjgRonFM4sI8k1yF1B7iNvEgRsV+yZoa4aqqX4
         QkBNQJ9yptrdSVTgnpHhk/L+7G7vpos+vIN/MyTvC5r2dV5h89hCvNDAETz5ESztxHKi
         DfgilNqM0PbeO9xcIgMhf5afYaiM9XO7QXcCdorBm2bO6QYZ805bkyH+Q/24SZluS94f
         Sz3WMhXwO3fgzFfyLcPkGnCpAQok/VRCjaYR3vQY72JkClaT9xas8RXBHJgsmPnNNjiG
         UGPyx1GJgP1VeHl+TZTqY9eO6X7MV2pJ5pgvktK79XkqmRyKGYQt2/Kx4FQ8j2XXtAt9
         vnxg==
X-Gm-Message-State: AA+aEWYxxxYTE7yX0/4hBA5o0Mgo65ku7KOEwdHPBTAQd1fpCXSBEz/S
        chJs+EMOCQivw0WqUvWdtfxJn3vK
X-Google-Smtp-Source: AFSGD/XntxVmo8GPh4iAfySW7FQ7susmj0lO3b97Guyk4H4MqSqOodtcEIPwRLvpzoEydPdvuStyLg==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr9897736pgv.393.1544422315557;
        Sun, 09 Dec 2018 22:11:55 -0800 (PST)
Received: from localhost ([175.223.21.78])
        by smtp.gmail.com with ESMTPSA id o189sm14218786pfg.117.2018.12.09.22.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:11:54 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:11:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Message-ID: <20181210061151.GA28533@jagdpanzerIV>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/10/18 05:58), Liu, Chuansheng wrote:
> > On (12/10/18 05:40), Liu, Chuansheng wrote:
> > > @@ -130,6 +130,13 @@ static void check_hung_task(struct task_struct *t,
> > unsigned long timeout)
> > >                         init_utsname()->version);
> > >                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
> > >                         " disables this message.\n");
> > > +               /* When sysctl_hung_task_panic is set, we have to force
> > > +                * ignore_loglevel to get really useful hung task
> > > +                * information.
> > > +                */
> > > +               if (sysctl_hung_task_panic && !ignore_loglevel)
> > > +                       ignore_loglevel = true;
> > 
> > 		console_verbose()?
> 
> Thanks Sergey, it is really my need. I will prepare for a new version of patch:)

Let's wait for people to take a look at this patch first.

	-ss
