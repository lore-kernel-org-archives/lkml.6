Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA342070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfBTIQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:16:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:56284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfBTIQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:16:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D33A9AD72;
        Wed, 20 Feb 2019 08:16:30 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 00483E00A5; Wed, 20 Feb 2019 09:16:29 +0100 (CET)
Date:   Wed, 20 Feb 2019 09:16:29 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 05/21] ethtool: netlink bitset handling
Message-ID: <20190220081629.GG23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <5f70eb8055a26f60f2282d7c1d193619a96c40a1.1550513384.git.mkubecek@suse.cz>
 <20190219182759.0abf08ae@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219182759.0abf08ae@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 06:27:59PM -0800, Jakub Kicinski wrote:
> On Mon, 18 Feb 2019 19:21:49 +0100 (CET), Michal Kubecek wrote:
> > +		else if (is_u32)
> > +			bitmap_from_arr32(val, bitmap, nbits);
> > +		else
> > +			bitmap_copy(val, bitmap, nbits);
> > +		nla_for_each_nested(bit_attr, tb[ETHA_BITSET_BITS], rem) {
> > +			*err = ethnl_update_bit(val, mask, nbits, bit_attr,
> > +						is_list, names, legacy, info);
> > +			if (*err < 0)
> > +				goto out_free;
> > +		}
> > +		if (bitmask)
> > +			__bitmap_to_any(bitmask, mask, nbits, is_u32);
> > +	} else {
> > +		unsigned int change_words = DIV_ROUND_UP(change_bits, 32);
> > +
> > +		*err = 0;
> > +		if (change_bits == 0 && tb[ETHA_BITSET_MASK])
> > +			goto out_free;
> > +		*err = -EINVAL;
> > +		if (!tb[ETHA_BITSET_VALUE])
> > +			goto out_free;
> 
> !tb[ETHA_BITSET_BITS] && !tb[ETHA_BITSET_VALUE] is already rejected
> above.

Thank you. I'll drop this test.

Michal
