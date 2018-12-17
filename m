Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5FA2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545035849;
	bh=n1rrIP/rF4R7qd1aZ8RusL11DmC2gLjeJzQxJ2RazTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enlByseEW6FzsIZMfgWHT/4USSE7N/ZXX9CCYTvE2vB7XaFZbY5B46zJoidgusQbd
	 q8VA8WW1CYpiJHo2libugAlRgFG1E+mR45aRcNsRObDv8rCvE+VPefT/1BcVIL4nKp
	 gpgpKrueP3KGjPwBlpLUISL3Po2LVWPiGN8KwQBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbeLQIh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731841AbeLQIh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:37:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B502520675;
        Mon, 17 Dec 2018 08:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545035847;
        bh=n1rrIP/rF4R7qd1aZ8RusL11DmC2gLjeJzQxJ2RazTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uysv2h5ISGRCLpl7Qzph9v1JwSGk/ZaGL2PDqqlOQgWSrbGRg6otoWJO0ZEgyzKsz
         FyXBUypx+wmXdtMpBuahQVmrfgf49ZIbz4TpVrmBBwwhAMxDo1V1n3H9E3FrD+Jslu
         zGbpghI8EpjtuDr6AuLiBQFbN7db5SSVcszECGAg=
Date:   Mon, 17 Dec 2018 09:37:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jwiesner <jwiesner@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Peter Oskolkov <posk@google.com>,
        Per Sundstrom <per.sundstrom@redqube.se>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 01/51] ipv4: ipv6: netfilter: Adjust the frag mem
 limit when truesize changes
Message-ID: <20181217083724.GA6070@kroah.com>
References: <20181214115713.244259772@linuxfoundation.org>
 <20181214115713.491383576@linuxfoundation.org>
 <391da4b5b20f2d5632102ac03f337c5d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391da4b5b20f2d5632102ac03f337c5d@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:56:43AM +0100, jwiesner wrote:
> On 2018-12-14 13:00, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me
> > know.
> > 
> > ------------------
> > 
> > From: Jiri Wiesner <jwiesner@suse.com>
> > 
> > [ Upstream commit ebaf39e6032faf77218220707fc3fa22487784e0 ]
> > 
> 
> Commit v4.10-rc4-868-g158f323b9868, which the patch under review fixes, is
> not in 4.9-stable, so the patch is not necessary.

Thanks for letting me know, I've dropped this from the 3.18.y, 4.4.y,
and 4.9.y queues.

greg k-h
