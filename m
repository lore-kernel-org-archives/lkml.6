Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BBB2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBTNAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:00:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfBTNAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:00:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B11AB00E;
        Wed, 20 Feb 2019 13:00:11 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id BB430E00A5; Wed, 20 Feb 2019 14:00:07 +0100 (CET)
Date:   Wed, 20 Feb 2019 14:00:07 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 13/21] ethtool: provide timestamping
 information in GET_INFO request
Message-ID: <20190220130007.GI23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <790ee93d90931278b6e4fc51da712aadfcb8ec90.1550513384.git.mkubecek@suse.cz>
 <20190219190048.1c8a4482@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219190048.1c8a4482@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:00:48PM -0800, Jakub Kicinski wrote:
> On Mon, 18 Feb 2019 19:22:29 +0100 (CET), Michal Kubecek wrote:
> > Add timestamping information as provided by ETHTOOL_GET_TS_INFO ioctl
> > command in GET_INFO reply if ETH_INFO_IM_TSINFO flag is set in the request.
> > 
> > Add constants for counts of HWTSTAMP_TX_* and HWTSTAM_FILTER_* constants
> > and provide symbolic names for timestamping related values so that they can
> > be retrieved in GET_STRSET and GET_INFO requests.
> 
> What's the reason for providing the symbolic names?

One of the the goals I had was to reduce the need to keep the lists of
possible values in sync between kernel and userspace ethtool and other
users of the interface so that when a new value is added, we don't have
to update all userspace tools to be able to use or present it.

This already works in ethtool for some newer commands (e.g. features)
and obviously for those where the list of available options depends on
the device (e.g. private flags or statistics). I would like to extend
the principle also to older commands and new ones which do not work like
this (e.g. device reset).

Michal
