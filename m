Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA84C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfAVSEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:04:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45765 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAVSEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:04:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8BC7120898; Tue, 22 Jan 2019 19:04:18 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2D053207B2;
        Tue, 22 Jan 2019 19:04:08 +0100 (CET)
Date:   Tue, 22 Jan 2019 19:04:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fix a missing check of block data read
Message-ID: <20190122180407.GF16702@piout.net>
References: <20181226030911.72845-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226030911.72845-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2018 21:09:11-0600, Kangjie Lu wrote:
> When i2c_smbus_read_i2c_block_data() fails, the read data in "buf" could
> be incorrect and should not be used. The fix checks if
> i2c_smbus_read_i2c_block_data fails, and if so, return its error code
> upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/rtc/rtc-hym8563.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
