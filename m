Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374A521104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvbcbrwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374A521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbeK1FpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbeK1FpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:45:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749D72081B;
        Tue, 27 Nov 2018 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543344383;
        bh=mRiHoIDuqed0pbhM7dEXVOB5UuJhE0HxiV9ntxeT52U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvbcbrwWZRvu9uSnQpKVJQsAL0s2T68u4Pl24i6Gwj7Xo0MasTTn8g0Y8TUXtoiZg
         HrnsIGOi+PcurdiKPsLvG0L5ynlin0UKFmw8IwZL9boPM1wXZHYxaGhcc9jO/sw6Jm
         myx0+yiy3DID+QSZUEx1d0u8+GxqkYl+PxavSHPE=
Date:   Tue, 27 Nov 2018 19:46:21 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Message-ID: <20181127184621.GA18012@kroah.com>
References: <1542283916-13101-1-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542283916-13101-1-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:12:12PM +0000, Ioana Ciornei wrote:
> Both the header and the command parameters of the fsl_mc_command are
> 64-bit little-endian words. Use the appropriate type to explicitly
> specify their endianness.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  include/linux/fsl/mc.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

What tree is this made against?  I can't seem to apply it to any of mine
:(

Any hints?

thanks,

greg k-h
