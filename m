Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D2C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298B02147D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298B02147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHSOpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 10:45:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 10:45:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4D1C92F;
        Sun, 19 Aug 2018 11:34:05 +0000 (UTC)
Date:   Sun, 19 Aug 2018 13:34:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v3] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <20180819113401.GB18715@kroah.com>
References: <20180819100458.GA13296@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819100458.GA13296@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 03:35:02PM +0530, Nishad Kamdar wrote:
> Fixed four debug macros and their usages. Replaced printk with
> dev_<level> without __func__ or __LINE__ or current->comm and
> current->pid. Further removed the do {} while(0) loop for single
> statement macros.
> Out of the four, replaced all usages of ERR_MSG and IRQ_MSG with
> dev_err() in the code itself and dropped them from dbg.h.
> Removed all INIT_MSG usages and dropped it from dgb.h.
> Issues found by checkpatch.

This needs to be multiple patches.  One for each type of macro you are
deleting/changing, not all lumped together into one big patch.

Plaese fix that up and resend.

thanks,

greg k-h
