Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDC320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDC320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbeHAKme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:42:34 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:59036 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388607AbeHAKmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:42:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 8122B201BF;
        Wed,  1 Aug 2018 12:57:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tqPd4owt5z_c; Wed,  1 Aug 2018 12:57:35 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 3243F2006F;
        Wed,  1 Aug 2018 12:57:35 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 10:57:50 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id C01BF3182109;
 Wed,  1 Aug 2018 10:57:49 +0200 (CEST)
Date:   Wed, 1 Aug 2018 10:57:49 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot <syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com>,
        <ddstreet@ieee.org>, <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free
Message-ID: <20180801085749.3nf5hbxjxoafangb@gauss3.secunet.de>
References: <000000000000d71bf6056a34b628@google.com>
 <000000000000ed9844056a507832@google.com>
 <50d24879-7f38-f8c5-982f-b3fc5d3a9cc6@I-love.SAKURA.ne.jp>
 <11ddcad9-f3fa-dfbc-18a0-e5facc37a4a3@I-love.SAKURA.ne.jp>
 <20180731113152.4pes5xwhae2xydqg@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180731113152.4pes5xwhae2xydqg@gauss3.secunet.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 3B9A4770-5726-46D9-8C1E-A1E5669DC17D
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:31:52PM +0200, Steffen Klassert wrote:
> On Tue, Jul 31, 2018 at 08:16:22PM +0900, Tetsuo Handa wrote:
> > Steffen and Herbert,
> > 
> > Do you have any question? I think I provided enough information for debugging.
> 
> It seems that I was not on Cc at the beginning of the threat,
> so I had to search the web for some context.
> 
> I'm currently trying your reproducer (still with my .config) but I don't
> hit the problem.

Actually, I did not hit it because it is already fixed in my tree.

It is fixed by:

commit 8cc88773855f988d6a3bbf102bbd9dd9c828eb81
xfrm: fix missing dst_release() after policy blocking lbcast and multicast

This fix went to mainline on Monday.
