Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FD7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C867C208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544101054;
	bh=q0ujNMC9GwoEqWUKdbATPD/mp6/QDf4c5WMQhGPnMAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i2ZaXe4GIBzPrM17c3bENYNNDO+WhoQwBAnvbQWqsjHwp2gJqD0KR9xieKROgkpOk
	 CUDE02wbTFJJJTvMDLoNxHzLgyT3t1S2CzUq2r4lqjBWvnCfGKw2gJEfGi9+YpWKgL
	 ryXYIdaHJ+e/q4a1O3hhNNgVagfgXkHp7v3UhOFk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C867C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeLFM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbeLFM5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:57:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C8B20878;
        Thu,  6 Dec 2018 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544101052;
        bh=q0ujNMC9GwoEqWUKdbATPD/mp6/QDf4c5WMQhGPnMAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9HthlnMkfVwQHduNR1Tcj+YZTQ7b0YLHNIQb3PTM+e394sQGrljokqTZ75+ouHSn
         /dRQzZwPxPM8PqfhQ5fOltQFL59Hlmdy+ujvq4aT9ST4RjkhAahKguU/hjrQQmgSk3
         VpdiGSvJpDOkCh/XsGQzcNfgvBUYqZ7XVvvKB45A=
Date:   Thu, 6 Dec 2018 13:57:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] kref/kobject: Improve documentation
Message-ID: <20181206125730.GA30398@kroah.com>
References: <20181203164435.31530-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203164435.31530-1-ezequiel@collabora.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 01:44:35PM -0300, Ezequiel Garcia wrote:
> The current kref and kobject documentation may be
> insufficient to understand these common pitfalls regarding
> object lifetime and object releasing.
> 
> Add a bit more documentation and improve the warnings
> seen by the user, pointing to the right piece of documentation.
> 
> Also, it's important to understand that making fun of people
> publicly is not at all helpful, doesn't provide any value,
> and it's not a healthy way of encouraging developers to do better.
> 
> "Mocking mercilessly" will, if anything, make developers feel bad
> and go away. This kind of behavior should not be encouraged or justified.

Very true, thanks for fixing this up and providing a much better wording
for all of this, including the warning messages.

Now queued up, thanks.

greg k-h
