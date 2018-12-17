Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4A3206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbeLQLB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:01:28 -0500
Received: from nautica.notk.org ([91.121.71.147]:55881 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeLQLB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:01:28 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 30B6FC009; Mon, 17 Dec 2018 12:01:26 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:01:11 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/3] 9p/net: implement asynchronous rpc
Message-ID: <20181217110111.GB17466@nautica>
References: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
 <0da7d896-0d67-46f6-83f9-b346eba991a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0da7d896-0d67-46f6-83f9-b346eba991a9@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Dec 17, 2018:
> sorry for the delay, I've been quite busy these days.

No problem.

> The patches looks good to me and should indeed speed up the code a bit.
> I quickly tested them against Syzkaller tuned for the 9p subsystem and
> everything seems fine.

Thanks, can I add your Reviewed-by on all three?

> And by the way, which refcount races?

There's a problem with trans_fd read_work and cancelled callback; I'm
not so sure about refcount but we can definitely get double list_del
as we're not checking the status. I think when we incorrectly remove
from the list we also mismanage the refcount, but honestly need to
test..

-- 
Dominique
