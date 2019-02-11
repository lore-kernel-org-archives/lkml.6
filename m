Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3A4222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899651;
	bh=WQdqKetsqSHnTdjrIs7RV+6dwHfUumvz0ojVvlyOMos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L5s0kEeCyVQ54kFXSim8juhHulrCfaTfzpU1+uXXqxvnIyctS4LWc33ireoCpRplG
	 FfbWrbgaRobo9coNvL2BXCDMiP9/ziz9XIOA3aAAJ138mf2A0yx/S9wyPM/Cc3RNaO
	 OeRUAMDXP5zN1SjAJ8EgsKA90br35Tgb+JE/2Gns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbfBKPkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387961AbfBKPkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:40:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A91222A7;
        Mon, 11 Feb 2019 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549899647;
        bh=WQdqKetsqSHnTdjrIs7RV+6dwHfUumvz0ojVvlyOMos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHjN5QjOLpHQ+mJEvOdgixYHdKqGySEX5tqMX0D2MnRbY4JisrkzjG27ZKBEBrDf+
         s98IVkUMpShvEUAHKGtqRIzg8LW9psQMM2qOEB8xVYIZl/+9qyyGxBpiH8xhpDQF/v
         AN3BjB0mzFs0aJQOsp3ASfG3nhV0JiKaPNuCKD34=
Date:   Mon, 11 Feb 2019 16:40:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: vsoc: Remove
 VSOC_WAIT_FOR_INCOMING_INTERRUPT
Message-ID: <20190211154044.GA16105@kroah.com>
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> ioctl. This functionality has been superseded by the futex and is
> there for legacy reasons.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
>  drivers/staging/android/vsoc.c          | 5 -----
>  2 files changed, 12 deletions(-)

So userspace is all fixed up now and this ioctl can be dropped?  Any
pointers to the userspace commit that did this?

thanks,

greg k-h
