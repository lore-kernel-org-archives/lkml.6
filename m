Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56082C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235FA20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORMLU9iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfAaRrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:47:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36739 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfAaRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:47:12 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so3391878ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yd3EYB9CxmABaQHZJKF+uIWLsaH4ep2DIxCWor39Niw=;
        b=ORMLU9iXDVuB3AQl44W88pRun2lzoa2EQW2QcSyqBmtUov69GZ2MYlWyfnzUGAn91c
         Xlh1asD6ldIjfimrOpUOjZQ2JbfHq7sws3cZpQtLu7U4Ta3t6Tw9dbK1B7KxCIPqvBA/
         HAnKLF3n0rRsfSH09FB5EapW8mTYiCZ4wMplQJJhORMSplTzwyeSh2x5Q9Pff00TR4MK
         +YqJ2sQbyDJZPOpuBnyCi1t51UuB/1cTSeiqPzY40NWKjixsGF/fPgsMvD70kHzSR5gP
         l/HZgrOY0O5ur1iRcXqJVFoefMbChs5wC2UbnPGun7Qll8gRJ/2PxzPeMxwjicau3CbP
         9wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yd3EYB9CxmABaQHZJKF+uIWLsaH4ep2DIxCWor39Niw=;
        b=mCzzZxTkLMyfpKMvqDasTHcaj3/gqrds/TAHeNkrqwvnohIcTrWcLKr7RKTgxEsVa8
         V0hqRTTxVSsTekYgCWrCjo+Zqwz9NIfebs88+n5ZDYTCUap9GFbgdOR4lt/of0gdGya4
         D9rxtVPWszuOMWRvfqdOJXnOEjOZ1ZjmsU14ln7YzjnFnkQze3P1yGxxIIY6LTeC11KS
         Q5D+IJee80X7uKYRoBtMISHLoeVcEnpWWBtkOr0znxjywU2jjny/lZjepWumXY+3k8XD
         qqoUCwssW9Q66GNSCP9NWuVV1RjDd/1mamemmNWgKgfqz30Na/j9GA9iXAZD+tEoARj+
         +keQ==
X-Gm-Message-State: AHQUAubkqlIazWgQKKl/BnlDzpID4TzjiwSE0v3WfHB9vQ0s2HJdwQmB
        fKEd0elTrzYKNpZOGORoRP0YlOp3XDI=
X-Google-Smtp-Source: ALg8bN6WGB2aXij5ugHSHNjAxKMvv5fL1qKcwqrBDH5LkXhrKgRR6kbrDLGezdlKR8coMlzP3bZ1Bw==
X-Received: by 2002:a5e:da49:: with SMTP id o9mr20754694iop.246.1548956831211;
        Thu, 31 Jan 2019 09:47:11 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id 85sm2341262iou.8.2019.01.31.09.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 09:47:10 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:47:07 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190131174707.GA2055@ubu-Virtual-Machine>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
 <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 04:45:35PM +0000, Michael Kelley wrote:
> From: Sasha Levin <sashal@kernel.org> Sent: Thursday, January 31, 2019 7:20 AM
> > 
> > I've queued this one for hyper-fixes, thanks all!
> > 
> 
> Actually, please hold off on queuing this one.  In a conversation I had yesterday with Kim, they had identified a deadlock.  Kim was going to be looking at some revisions to avoid the deadlock.
> 
> Kim -- please confirm.
> 
> Michael

This is correct. I need to send a v2 of this patch which addresses two
issues:

1) Check channel->state inside the mutex acquire/release in
vmbus_chan_attr_show().

2) Prevent a deadlock that can occur between the proposed mutex_lock()
call in the vmbus_chan_attr_show() function and the sysfs/kernfs functions.


I've identified two possible solutions to the deadlock:

1) Add a new mutex to the vmbus_channel struct which protects changes to
"channel->state". Use this new mutex in vmbus_chan_attr_show() instead of
"vmbus_connection.channel_mutex".

2) Use "vmbus_connection.channel_mutex" in vmbus_chan_attr_show() as
originally proposed, and acquire it with mutex_trylock(). If the mutex
cannot be acquired, return -EINVAL.


I'm leaning towards (2), using mutex_trylock(). "vmbus_connection.channel_mutex"
appears to be used only when a channel is being opened or closed, so
vmbus_chan_attr_show() should be able to acquire the mutex when the
channel is in use.

If anyone has suggestions, please let me know.

Thanks,
Kim
