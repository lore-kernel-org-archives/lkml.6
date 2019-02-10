Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC923C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F49214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfBJJHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:07:51 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45190 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbfBJJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:07:50 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Feb 2019 11:07:43 +0200
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.137.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x1A97hNF029742;
        Sun, 10 Feb 2019 11:07:43 +0200
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x1A8K0YV022085;
        Sun, 10 Feb 2019 10:20:00 +0200
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x1A8Jv01020571;
        Sun, 10 Feb 2019 10:19:57 +0200
X-Authentication-Warning: nps-server-21.mtl.labs.mlnx: eli set sender to eli@mellanox.com using -f
Date:   Sun, 10 Feb 2019 10:19:57 +0200
From:   Eli Cohen <eli@mellanox.com>
To:     David Miller <davem@davemloft.net>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        simon.horman@netronome.com, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com
Subject: Re: [PATCH net-next 2/2] net: Change TCA_ACT_* to TCA_ID_* to match
 that of TCA_ID_POLICE
Message-ID: <20190210081956.GA18213@nps-server-21.mtl.labs.mlnx>
References: <20190207074549.29861-1-eli@mellanox.com>
 <20190207074549.29861-3-eli@mellanox.com>
 <20190207.100110.1557913033627638063.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207.100110.1557913033627638063.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:01:10AM -0800, David Miller wrote:
> From: Eli Cohen <eli@mellanox.com>
> Date: Thu,  7 Feb 2019 09:45:49 +0200
> 
> > diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> > index 902957beceb3..d54cb608dbaf 100644
> > --- a/net/sched/act_simple.c
> > +++ b/net/sched/act_simple.c
> > @@ -19,8 +19,6 @@
> >  #include <net/netlink.h>
> >  #include <net/pkt_sched.h>
> >  
> > -#define TCA_ACT_SIMP 22
> > -
> >  #include <linux/tc_act/tc_defact.h>
> >  #include <net/tc_act/tc_defact.h>
> >  
> 
> I would do this in patch #1.

Sure, that was the intention. It just slipped off my fingers.

Will fix and send a new series.

> Actually, because you didn't, after patch #1 there are two #defines
> evaluated for this macro.  One in pkt_cls.h and one here.
> 
> The only reason the compiler doesn't warn and complain is because the
> definitions are identical.
> 
> Thank you.
