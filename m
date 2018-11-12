Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5586AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0222504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+y2LVa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED0222504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeKMD5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeKMD5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:57:21 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50DE20817;
        Mon, 12 Nov 2018 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542045781;
        bh=XinHxmC+riPbXbpt0nW9pFDCl+wztNnruSbPNMb3WsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+y2LVa7KMZAPpMFeVznoPrMpLjkJZHpyHx7hvLoT1jb6BrdSc/6zbZYLBXW1vaiL
         QO96/Kz/nV57HASA5DMlW+VAfRHMG1dU5tb7/5xARXmoE/GzA0i9acic/XhgQUZHYe
         hgM2PCs0NOTAF2BnkW+UYC4ZmRkU/6U5a/FYMw40=
Date:   Mon, 12 Nov 2018 10:03:01 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] serial: Add Tegra Combined UART driver
Message-ID: <20181112180301.GB28739@kroah.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-8-thierry.reding@gmail.com>
 <20181109170526.GB14151@kroah.com>
 <20181112153014.GA29481@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112153014.GA29481@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:30:14PM +0100, Thierry Reding wrote:
> On Fri, Nov 09, 2018 at 09:05:26AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Oct 26, 2018 at 01:16:36PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > > multiplexing multiple "virtual UARTs" into a single hardware serial
> > > port. The TCU is the primary serial port on Tegra194 devices.
> > > 
> > > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > > are part of Tegra HSP blocks that are already controlled by the Tegra
> > > HSP mailbox driver.
> > > 
> > > Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks. I just sent out v2 addressing Pekka's comments on the series.
> But I'm slightly confused now. Are you expecting anyone else to pick
> this up? There are technically no build time dependencies between any
> of these patches, so it should be fine to pick them all into the
> corresponding subsystem trees.

Ah, I thought there was a built-time dependancy, that's why I gave my
ack.

> Perhaps the only thing to note is that there is a runtime dependency
> from this patch on patches 1 and 2 in the series. Patch 1 is required to
> make blocking a mailbox possible in interrupt context, which we need in
> the TCU driver because the TTY and console paths do end up calling the
> mbox_send_message() from interrupt context. Patch 2 is only required at
> runtime if the two mailboxes are provided by different instances of the
> HSP block (which they are for TCU on Tegra194).
> 
> Would you prefer for Jassi to pick up the TCU patch along with the
> mailbox core and driver changes so that we deal with the runtime
> dependencies that way?
> 
> Alternatively, if Jassi is okay with the mailbox changes, I can pick up
> all of the v2 series of the patches into stable branches for v4.21, deal
> with the dependencies there and send out pull requests for everyone to
> merge into their subsystem trees.

I don't really care either way, whatever is easiest for you all is fine
with me.

thanks,

greg k-h
