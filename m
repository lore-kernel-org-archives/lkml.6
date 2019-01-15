Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C07C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C89720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfAOKPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:15:22 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:43432 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbfAOKPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:15:21 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gjLkd-0003XZ-1h; Tue, 15 Jan 2019 11:15:19 +0100
Date:   Tue, 15 Jan 2019 11:15:19 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [REGRESSION] 5.0-rc2: iptables -nvL consumes 100% of CPU and
 hogs memory with kernel 5.0-rc2
Message-ID: <20190115101519.pf7ogpvdz22wku7g@breakpoint.cc>
References: <1608957.xtEoauR4Ya@merkaba>
 <20190115101006.GE26670@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115101006.GE26670@unicorn.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Kubecek <mkubecek@suse.cz> wrote:
> > I upgraded to self-compiled 5.0-rc2 today and found the machine to be slow
> > after startup. I saw iptables consuming 100% CPU, it only responded to
> > SIGKILL. It got restarted several times, probably by some systemd service.
> > 
> > Then I started 'iptables -nvL' manually. And I got this:
> > 
> > % strace -p 5748
> > [… tons more, in what appeared an endless loop …]

This is fixed by:

http://patchwork.ozlabs.org/patch/1024772/
("netfilter: nf_tables: Fix for endless loop when dumping ruleset"). 
