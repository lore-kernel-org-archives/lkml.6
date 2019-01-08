Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED09C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBFC214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546962327;
	bh=r2o5YRj3+lUtS6oIlpJFahaCwAp78Z1aOXCvtawvtuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eHWkcnkZbfmw0rX4aOjKMwp8z21KB1xm/KHZZnc0UN3r3NAYBpyTUcbN0bFFzsXGF
	 AFtjBvP6aXUpg2dRMRCjeBgUSuf1Jd7jYOgD3znuK7mHgOv4TUVHvWWeyeIu4lhj6C
	 9RGMEjvPrsaCDJ3mI7V2OR3dyoHTz5jRfxcdIREg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfAHPp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfAHPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:45:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B40420827;
        Tue,  8 Jan 2019 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546962325;
        bh=r2o5YRj3+lUtS6oIlpJFahaCwAp78Z1aOXCvtawvtuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlAIiQk1+CSt6O8V5GGDKG7+YcAmgIW8oPm7R2FSb9fZ0kACiqqzPMVMUa0JWw/wG
         HP0s54RpnhUxuPaRHDzKi+v+/lLp6P54rkIJZi9s7JlrxozwGSbB/XNo5d0l2/4+6a
         n9fOC5Nr5x8v0w/1PFfFdL9Kt+X8RPWj50niKrIk=
Date:   Tue, 8 Jan 2019 16:45:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Message-ID: <20190108154523.GB20989@kroah.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
 <20190108060426.11581-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108060426.11581-2-ran.wang_1@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:04:26AM +0000, Ran Wang wrote:
> arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(), which
> causing compile failure on some Layerscape Platforms (such as LS1021A and
> LS2012A which also integrates FSL EHCI controller). So use
> ioread32be()/iowrite32be() instead to make it workable on both
> powerpc and arm.

Shouldn't you have this patch before the Kconfig change, so that you do
not break the build on ARM systems on that one and then fix it up on
this one?

thanks,

greg k-h
