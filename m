Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00521C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B024320C0C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B024320C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbeGGODt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:03:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbeGGODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:03:48 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0958DB7;
        Sat,  7 Jul 2018 14:03:46 +0000 (UTC)
Date:   Sat, 7 Jul 2018 16:03:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jann Horn <jannh@google.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180707140343.GA7052@kroah.com>
References: <20180707015344.146672-1-jannh@google.com>
 <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 10:29:26AM +0200, Samuel Thibault wrote:
> Re,
> 
> Could you review, test, and resubmit the patch below instead?
> 
> Samuel
> 
> 
> If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
> the loop to copy as much data as available to the provided buffer. If
> softsynthx_read() is invoked through sys_splice(), this causes an
> unbounded kernel write; but even when userspace just reads from it
> normally, a small size could cause userspace crashes.
> 
> Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

You forgot a "reported-by:" line :(

also, I already applied Jann's patch, so could you either just send the
fixup, or a revert/add of this patch once you all agree on the proper
solution here?

thanks,

greg k-h
