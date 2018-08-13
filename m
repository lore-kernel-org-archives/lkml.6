Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F3621774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F3621774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeHMSgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:36:54 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32827 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729191AbeHMSgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:36:54 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w7DFrwh7014771;
        Mon, 13 Aug 2018 17:53:58 +0200
Date:   Mon, 13 Aug 2018 17:53:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
Message-ID: <20180813155358.GK14633@1wt.eu>
References: <20180731191102.2434-1-Jason@zx2c4.com>
 <1534174811.7872.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534174811.7872.3.camel@HansenPartnership.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 08:40:11AM -0700, James Bottomley wrote:
> Could we please build planning for this crypto failure day into
> wireguard now rather than have to do it later?  It doesn't need to be
> full cipher agility, it just needs to be the ability to handle multiple
> protocol versions ... two should do it because that gives a template to
> follow (and test version to try to find bugs in the implementation). 

It's also what provides a *real* upgrade path to future versions :
before deploying you need something which works, and the only way to
get something working at a large scale is to have early adopters. Those
willing to deploy a beta version will not do it if it requires to lose
all their users and possibly to make rollbacks impossible. At least for
this it's important to support an optionnal new version on top of the
existing one (i.e. prod + beta together).

Cheers,
Willy
