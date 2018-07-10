Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3FCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E39208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E39208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGJOLb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:11:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeGJOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:11:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7CCD7D29;
        Tue, 10 Jul 2018 14:11:29 +0000 (UTC)
Date:   Tue, 10 Jul 2018 16:11:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 229/268] media: cx23885: Set subdev host data to
 clk_freq pointer
Message-ID: <20180710141127.GM1123@kroah.com>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100229.115203250@linuxfoundation.org>
 <1529273537.2289.239.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529273537.2289.239.camel@codethink.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 11:12:17PM +0100, Ben Hutchings wrote:
> On Mon, 2018-05-28 at 12:03 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Brad Love <brad@nextdimension.cc>
> > 
> > [ Upstream commit 5ceade1d97fc6687e050c44c257382c192f56276 ]
> > 
> > Currently clk_freq is ignored entirely, because the cx235840 driver
> > configures the xtal at the chip defaults. This is an issue if a
> > board is produced with a non-default frequency crystal. If clk_freq
> > is not zero the cx25840 will attempt to use the setting provided,
> > or fall back to defaults otherwise.
> 
> This depends on (at least):
> 
> commit 3ee9bc12342cf546313d300808ff47d7dbb8e7db
> Author: Brad Love <brad@nextdimension.cc>
> Date:   Tue Mar 6 14:15:34 2018 -0500
> 
>     media: cx25840: Use subdev host data for PLL override
> 
> Ben.

Good catch, now queued up.

greg k-h
