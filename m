Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A32FC6184
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8F5216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8F5216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIMVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:49:10 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35156 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbeIMVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:49:10 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g0Udk-0000Uh-Jo; Thu, 13 Sep 2018 18:38:48 +0200
Date:   Thu, 13 Sep 2018 18:38:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Wolfgang Walter <linux@stwm.de>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
References: <5781211.jtEvgqSZyO@stwm.de>
 <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <3448099.9yk84El3Sa@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3448099.9yk84El3Sa@stwm.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Walter <linux@stwm.de> wrote:
> I'll try that but this isn't that easy as the router image does not contain 
> perf. I also have to do that on our production router. I try to do that 
> tomorrow evening.

No need if its too difficult.

> What I can say is that it depends mainly on number of policy rules and SA.

Thats already a good hint, I guess we're hitting long hash chains in
xfrm_policy_lookup_bytype().
