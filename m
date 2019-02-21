Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F250120842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550738122;
	bh=6Xewx6PwasFCCgSKdziiCQ+MoKI87cjw59OAWw7k4PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fRpvc6tzZc6VS/0WvYYtCgt5GLOSFm/5ka5JIuJFt+JepBsziK54t30bHUf8Ue5s2
	 HjuB8VCRfgnzzWmFtDnX+C0vbVTmV5hg0Tc4x49Waac0WJB8iYUmg/Q/NuExEgXeWF
	 sHFq4X1eV68E+VzeJiQVKE98+XVRNQZgVl7VAtNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfBUIfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBUIfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:35:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD27920842;
        Thu, 21 Feb 2019 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550738119;
        bh=6Xewx6PwasFCCgSKdziiCQ+MoKI87cjw59OAWw7k4PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uV7DnbzcMJcn2qYqAnWQeG4t9ZMnEeiMSAjACxA9n+QlQYxfQ5LWzFP66qxG2K/nU
         8epDFmQCfrdaFCeWClGbOKmYLhVtmc4fAz/NQBb9zaHtccPRUTjLVbf4qljdQi34Mr
         AlFGu8vGVl5WiECghTgQ6Kb19o27cq5vf819vAmc=
Date:   Thu, 21 Feb 2019 09:35:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Hsiao <matt.hsiao@hpe.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        david.altobelli@hpe.com, mark.rusk@hpe.com, jerry.hoemann@hpe.com
Subject: Re: [PATCH 3/4] misc: hpilo: Do not claim unsupported hardware
Message-ID: <20190221083515.GC6397@kroah.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-4-git-send-email-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550736282-25416-4-git-send-email-matt.hsiao@hpe.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:04:41PM +0800, Matt Hsiao wrote:
> Do not claim when SSID 0x0289 as the iLO features
> are not enabled/validated by the firmware.

Can you put more information here, like _what_ hardware is not being
supported anymore?  As it is, this has nothing to do with "validation by
the firmware", you are just deciding to not support a device that
previously was supported by this driver.  As such you should provide
more information why you are taking away functionality.

thnaks,

greg k-h
