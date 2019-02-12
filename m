Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02668C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FF521773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549961542;
	bh=wFWMDgMCh30emx7+7b7orVY7IFxuTXGQObWzF5sJdds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u4nept9uFzRq77tzZQ23pbu2KJwPLclP1foENnlc9H+J2mgLPq+ytFgx5nU2jPOxo
	 8g+ZQlKzIqlm7hcs71oy3SA1YbRm8dKdGEvL2ylsDOfh7BDFqLsWtrlrfrIxJY5cfH
	 AyMS+6IJo1ve06fviCLk/Rk70Gz8Z1jLTB2mDT9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfBLIwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfBLIwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:52:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DBB20675;
        Tue, 12 Feb 2019 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549961540;
        bh=wFWMDgMCh30emx7+7b7orVY7IFxuTXGQObWzF5sJdds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNdpXYBU2iYpMUh82uGr9DJE3S03ZJx5uGfLGcointJlNlrUpsh+v0mUeeUiRJKzD
         vwfiN9ftnMuUo7b7ETgzSqWrdi0JkAWTM0Ljyv19Byqj0Sw9QN7h9Ir408N7vW/78b
         JMaHIsW259GOV0L0bd/reqPxMBldKFgEVQTms7LM=
Date:   Tue, 12 Feb 2019 09:52:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 081/352] f2fs: avoid build warn of fall_through
Message-ID: <20190212085218.GB31657@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141851.175526205@linuxfoundation.org>
 <20190212071858.1a6a43c4@canb.auug.org.au>
 <20190212072100.395ec633@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212072100.395ec633@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 07:21:00AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 12 Feb 2019 07:18:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Does the 4.20 stable tree use -Wimplicit-fallthrough?  I assume not
> > (since v4.20 doesn't), so this warning does not happen in that tree.
> 
> Ditto for 4.19, 4.14 and 4.9.

You are right, I thought this was needed for a later patch in the
series, but it wasn't, so I'll go drop it from all trees now, thanks.

greg k-h
