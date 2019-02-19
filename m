Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2A3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfBSL5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:57:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:40194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfBSL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:57:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F57DAE65;
        Tue, 19 Feb 2019 11:57:28 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D2561E0122; Tue, 19 Feb 2019 12:57:27 +0100 (CET)
Date:   Tue, 19 Feb 2019 12:57:27 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 00/21] ethtool netlink interface, part 1
Message-ID: <20190219115727.GE23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <20190219103508.GD3080@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103508.GD3080@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:35:08AM +0100, Jiri Pirko wrote:
> >- some features provided by ethtool would rather belong to devlink (and
> >  some are already superseded by devlink); however, only few drivers
> >  provide devlink interface at the moment and as recent discussion on
> >  flashing revealed, we cannot rely on devlink's presence
> 
> Could you explain why please?

What I mean is the problem discussed under Jakub's devlink flash
patchset: that he couldn't implement only the devlink callback in nfp
and rely on the generic fallback to devlink because it wouldn't work if
devlink is built as a module.

But I think this should be addressed. If we agree that flashing (and
other features provided by ethtool at the moment) rather belongs to
devlink (which nobody seems to oppose), we should rather try to make it
possible for drivers to provide only the devlink callback and gradually
move all in-tree drivers to doing so. (And one day, remove it from
ethtool_ops.) It doesn't seem to make much sense to have devlink as
a module in such scenario.

Michal
