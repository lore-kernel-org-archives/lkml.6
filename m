Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D992C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579C12147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfBUJ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:57:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:56674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfBUJ5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:57:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20B33AFED;
        Thu, 21 Feb 2019 09:57:11 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id C0401E00A5; Thu, 21 Feb 2019 10:57:10 +0100 (CET)
Date:   Thu, 21 Feb 2019 10:57:10 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 14/21] ethtool: provide link mode names
 as a string set
Message-ID: <20190221095710.GN23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <e969567a4630812230efa4fd4c7f0233564822d6.1550513384.git.mkubecek@suse.cz>
 <9a26eed3-f69a-b5fd-66e1-b926c6e92c2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a26eed3-f69a-b5fd-66e1-b926c6e92c2f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:21:58PM -0800, Florian Fainelli wrote:
> > +const char *const link_mode_names[] = {
> 
> Maybe you can define a macro (totally untested) to build the table an
> avoid some of the repetition, something like:
> 
> #define ETHTOOL_LINK_NAME(speed, duplex) \
> 	[ETHTOOL_LINK_MODE_##speed_##duplex_BIT]	= stringify(speed ## "/" ##
> duplex)

Thanks for the tip, that should work for most of the modes.

Michal
