Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4479C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948592089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948592089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeJBVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:40:09 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:37512 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbeJBVkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:40:09 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g7M5w-0003EV-4q; Tue, 02 Oct 2018 16:56:16 +0200
Date:   Tue, 2 Oct 2018 16:56:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Wolfgang Walter <linux@stwm.de>
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20181002145616.pwdhbmafgsihbxvm@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <20180914050651.GD23674@gauss3.secunet.de>
 <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
 <4708967.r5gU1pxIcW@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4708967.r5gU1pxIcW@stwm.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Walter <linux@stwm.de> wrote:
> Since my last reply to this message I didn't get a reply: is there any 
> progress how to fix this performance regression I missed?

Did you test/experiment with hthresh config option?

> Or are we stuck here with longterm kernel 4.9 for a long time?

I'm experimenting with per-dst inexact lists in an rbtree but
this will take time.
