Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93532C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C9A206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp64vb2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C9A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbeLEKKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbeLEJjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D99820851;
        Wed,  5 Dec 2018 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002744;
        bh=1Abw3GSk2XAbWyjCFPdGWOOQ7DtCUU9ue7pjwupRDH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fp64vb2edyaT4D4xS9n57pZqTNOncJpWJUut87MxxyVsOlCC37VHlCBXQvcBRr8qk
         4yRgebcWamxVP0mKyaQ6md2YvoP7tZvMWllbJ3Rd2ty7DNfL701o66b5+YhPRu9sSh
         3eHySg3zSwj7AxQ1QLts/RrQweW3ZViOWlIZMP4k=
Date:   Wed, 5 Dec 2018 10:39:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyle Williams <kdgwill@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Tim Anderson <tsa@biglakesoftware.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech
 Flare|Meetup|Brio|Rally
Message-ID: <20181205093902.GA18633@kroah.com>
References: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:38:25PM -0500, Kyle Williams wrote:
> Description: Some USB device / host controller combinations seem to have
> problems with Link Power management. In particular it is described that
> the combination of certain Logitech devices and other powered media
> devices such as the Atrus device causes 'not enough bandwidth for
> new device state'error.
> 
> This patch creates quirk entries for the tested Logitech device
> indicating LPM should remain disabled for the device.
> 
> Signed-off-by: Kyle Williams <kdgwill@chromium.org>
> ---
>  drivers/usb/core/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Along with what Alan said, this patch was sent in html mode, making it
impossible to apply, and it was rejected by the mailing lists.

Please fix up your email client before resending patches.  Or just use
'git send-email'.

thanks,

greg k-h
