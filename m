Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1368DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7412087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546698944;
	bh=uoBB13R0SCbsoP4GZH+Zbs4CuqBNVabu3jUdeKyEBV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwqkawkcKpt8T9P7iXO0cfN9+NWYumAIk59sRQBnWCQJqsbzDtT6/hNqrskkDydX+
	 mmX9Xu26NmybgjKqOsnZefILvOrjlb7AIoTUbOuWxCNBZ5s+MULA2Qbvb5ll98nmA/
	 Bqg/+YMRtnZNfxuNuq5Rh2G04Ke1e6toX1hzfaz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfAEOfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 09:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfAEOfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 09:35:43 -0500
Received: from localhost (unknown [188.89.135.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7042070C;
        Sat,  5 Jan 2019 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546698942;
        bh=uoBB13R0SCbsoP4GZH+Zbs4CuqBNVabu3jUdeKyEBV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqc+Johznnr9QjQYJZDy7QwM3Fh03CDzixgBnm7T4AT7ofJ6fV6nFAOiSFKTbAtSz
         ubmBAA6yBfO6s2UCKu2gHxQUTgqNM8gK4fuxFLoQYwtxJomZe7ieKg+0izi1NncCAb
         qy4ejvP8Eucyq+8iJzTm1Mv7uwrjAXXU024DY7Mg=
Date:   Sat, 5 Jan 2019 15:35:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     saranya.gopal@intel.com
Cc:     kernel@kolivas.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiwai@suse.de,
        felipe.balbi@linux.intel.com
Subject: Re: [PATCH] usbcore: Select only first configuration for non-UAC3
 compliant devices
Message-ID: <20190105143539.GC22044@kroah.com>
References: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <1546696957-28294-1-git-send-email-saranya.gopal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546696957-28294-1-git-send-email-saranya.gopal@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 07:32:37PM +0530, saranya.gopal@intel.com wrote:
> From: Saranya Gopal <saranya.gopal@intel.com>
> 
> In most of the UAC1 and UAC2 audio devices, the first
> configuration is most often the best configuration.
> However, with recent patch to support UAC3 configuration,
> second configuration was unintentionally chosen for
> some of the UAC1/2 devices that had more than one
> configuration. This was because of the existing check
> after the audio config check which selected any config
> which had a non-vendor class. This patch fixes this issue.
> 
> Fixes: f13912d (Select UAC3 configuration for audio if present)

That should read:
	Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")

Please use the full commit name and more sha1 numbers :)

thanks,

greg k-h
