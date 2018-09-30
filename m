Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBCC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8402D20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8402D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeJAANh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 20:13:37 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:55680 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbeJAANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 20:13:37 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g6fgo-0003bZ-Lv; Sun, 30 Sep 2018 19:39:30 +0200
Date:   Sun, 30 Sep 2018 19:39:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: __nf_register_net_hook jump label splat
Message-ID: <20180930173930.kyciz5vll23vpjw2@breakpoint.cc>
References: <20180929230409.GA27207@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929230409.GA27207@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> wrote:
> Hi people,
> 
> this is something new I'm triggering with rc5 + tip/master while rc4 +
> tip/master is fine. Any ideas?

No clue.  I don't see any netfilter changes between rc4 & rc5.
I just tried to set up a bridge on rc5 with call-iptables=1
and I see no such splat.

> If I had to guess, it looks like this thing:
> 
> #ifdef HAVE_JUMP_LABEL
>         static_key_slow_inc(&nf_hooks_needed[pf][reg->hooknum]);
> #endif

Strange, these static keys have been there for years.
Any chance you could send your .config or bisect this?

Thanks.
