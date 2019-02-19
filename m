Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79267C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4D12147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfBSNHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:07:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:51040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727246AbfBSNHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:07:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 074FEAE30;
        Tue, 19 Feb 2019 13:07:23 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5DB8DE00A5; Tue, 19 Feb 2019 14:07:23 +0100 (CET)
Date:   Tue, 19 Feb 2019 14:07:23 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 04/21] ethtool: helper functions for
 netlink interface
Message-ID: <20190219130723.GF23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <266b4ea3596de134329f8bbd5d13e282d1d27442.1550513384.git.mkubecek@suse.cz>
 <20190218121517.4d299f6e@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218121517.4d299f6e@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:15:17PM -0800, Jakub Kicinski wrote:
> On Mon, 18 Feb 2019 19:21:44 +0100 (CET), Michal Kubecek wrote:
> > +/* create skb for a reply and fill device identification
> > + * payload: payload length (without netlink and genetlink header)
> > + * dev:     device the reply is about (may be null)
> > + * cmd:     ETHNL_CMD_* command for reply
> > + * info:    info for the received packet we respond to
> > + * ehdrp:   place to store payload pointer returned by genlmsg_new()
> > + * returns: skb or null on error
> > + */
> 
> nit: why not correct kdoc?

Good point. I'll fix that, together with the other things.

Michal

> 
> > +struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
> > +				 u16 dev_attrtype, struct genl_info *info,
> > +				 void **ehdrp)
> > +{
> > +	void *ehdr;
> > +	struct sk_buff *rskb;
> 
> nit: reverse xmas tree
