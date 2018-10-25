Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A6320848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A6320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJZHUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:20:07 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:54666 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbeJZHUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:20:06 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gFoNc-0003Y2-Li; Fri, 26 Oct 2018 00:45:28 +0200
Date:   Fri, 26 Oct 2018 00:45:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Wolfgang Walter <linux@stwm.de>
Cc:     netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20181025224528.5k52dq4cmq3h7tyl@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <20181002213536.sgjansduqenps2md@breakpoint.cc>
 <1729915.dWWxddREcQ@stwm.de>
 <2766296.15tpkxTHJV@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2766296.15tpkxTHJV@stwm.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Walter <linux@stwm.de> wrote:
> there is now a new 4.19 which still has the big performance regression when 
> many ipsec tunnels are configured (throughput and latency get worse by 10 to 
> 50 times) which makes any kernel > 4.9 unusable for our routers.

https://git.breakpoint.cc/cgit/fw/net-next.git/log/?h=xfrm_pol_18

This is mostly untested, if you want to test this anyway and
find bugs please feel free to report them to me.

Improvements to test script in patch #1 welcome as well (its what
i've been using so far to test this).
