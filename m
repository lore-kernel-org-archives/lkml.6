Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B8BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E78B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549980570;
	bh=cGTYY9AVRJd1RYKVec7ry5MpKh6+PUz5HcxogLU2pe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tHGOrsQYZeQnlP6OVKpezmtSCPwzO0UAEfkMzUs88EU7lSBlpf/asWQsZAqOuzPwx
	 NCXqSqFTx1LdXXjZ8bIfUNj0B0w1C1+cMB0g/+Gzzpgl6pVwrorImQOkqP98pju/At
	 Vm0b99IU59G9B1Iokww3hzNf42hZsV0DtB1XZFbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfBLOJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfBLOJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:09:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19DA20838;
        Tue, 12 Feb 2019 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549980568;
        bh=cGTYY9AVRJd1RYKVec7ry5MpKh6+PUz5HcxogLU2pe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPknNcoeZIrXlGYRb3QG2eFjlhmppxjN0atRk/w7V3HpNw8tl4Lgjnidyjo/yGE5t
         90EEDv389IqISDcZKGPn8xtM5WwwoKh/jZv9jlU96xownJlHoM3Vfx8qCDePF8P7eO
         bVXkrf9QRJlHegQFbN0U71IYUl5L33tGIbcjjlEY=
Date:   Tue, 12 Feb 2019 15:09:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
Message-ID: <20190212140924.GA14444@kroah.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5510642.nRbR3bcduN@aspire.rjw.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:01:13PM +0100, Rafael J. Wysocki wrote:
> Hi Greg at al,
> 
> These fix two issues on top of the recent device links material in
> driver-core/driver-core-next.  
> 
> The first one fixes a race condition that may trigger when
> __pm_runtime_set_status() is used incorrectly (that is, when it is
> called with PM-runtime enabled for the target device and working).
> 
> The second one fixes a supplier PM-runtime usage counter imbalance
> resulting from adding and removing (e.g. in the error code path) a
> stateless device link to it from within the consumer driver's probe
> callback.
> 
> Please refer to the patch changelogs for details.

Looks good, all now queued up, thanks.

greg k-h
