Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56407C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C48F2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRB2T3jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C48F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeLBPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeLBPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:33:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08EB20672;
        Sun,  2 Dec 2018 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543764802;
        bh=pFXe3MvI+bvcAqEb9Y0Qm3rcyT8cgIKKPcSXKeGn1dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRB2T3jY6SJYTonrjmv9DoG2HF66jIGCSbTlKA2kNC2Jqz0UBjeUb0PjIK7UCs9ud
         +g3A2BJhqgMppyiEZBg0xuRAoNfOjkPgBBZcKRwj7rQb8ERgWOy+Fk81tnFBlplXed
         1b08scFzfZk1enVyop7VlGnjNcXOFUU/2LS2Xol4=
Date:   Sun, 2 Dec 2018 16:33:20 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Message-ID: <20181202153320.GA24440@kroah.com>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
 <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <SN4PR2101MB0815A8C285162E3B48CD209AA0D30@SN4PR2101MB0815.namprd21.prod.outlook.com>
 <PU1P153MB016907FDC34F47CFE71B82EABFD30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181202073345.GC31761@kroah.com>
 <PU1P153MB0169244CF3902294F42D114DBFAD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169244CF3902294F42D114DBFAD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:47:03AM +0000, Dexuan Cui wrote:
> Hi Greg,
> Please use the attached patch: I rebased the patch to today's char-misc's
> char-misc-linus branch. It can also cleanly apply to Linus's master branch
> today.

I can't use an attached patch, you know better.  Please fix up and
resend properly.

greg k-h
