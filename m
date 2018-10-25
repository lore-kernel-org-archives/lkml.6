Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60C207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJZD62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:58:28 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:54088 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbeJZD62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:58:28 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gFlEy-0002cr-JD; Thu, 25 Oct 2018 21:24:20 +0200
Date:   Thu, 25 Oct 2018 21:24:20 +0200
From:   Florian Westphal <fw@strlen.de>
To:     David Miller <davem@davemloft.net>
Cc:     linux@stwm.de, netdev@vger.kernel.org, fw@strlen.de,
        steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, christophe.gouault@6wind.com,
        gregkh@linuxfoundation.org
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20181025192420.2dwxiniutqrqrc7h@breakpoint.cc>
References: <20181002213536.sgjansduqenps2md@breakpoint.cc>
 <1729915.dWWxddREcQ@stwm.de>
 <2766296.15tpkxTHJV@stwm.de>
 <20181025.103450.1966639999117342457.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025.103450.1966639999117342457.davem@davemloft.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
> Please work diligently with Florian and others to try and find ways to
> soften the performance hit.

I will send a patch series that pre-sorts inexact policies into rbtrees
at insert time as soon as next-next opens up again.
