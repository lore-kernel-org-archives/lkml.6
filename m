Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDBC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791F62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635932;
	bh=4ULccZHnBtvqKObOJ8nbpWBfjS+DcNKY1ryB2SzmVoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N50+K9G/fP/L/miizkA0uKRcQnB6pFnV9+oQoscuKwAD7kAXbRbnpMVaw2oCu4s1k
	 y7DW/gISe/a4hZNiY0FR310+s7rjt5HQRuLtMnzNW2OrUY9SF0H+SZc42eHQlGe1Yv
	 50TklUWaGp3u8+r2wcJZ1HYysHhxgzLY0iuFw4X0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791F62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeLLRcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeLLRcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:32:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D1D20839;
        Wed, 12 Dec 2018 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635930;
        bh=4ULccZHnBtvqKObOJ8nbpWBfjS+DcNKY1ryB2SzmVoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5fLaSZFNEBBy8Q25l4BX61crLQD06VCeYV6c+t5PQL8Me1WFrL+7AXNZTyeBVaUo
         dsu0/NrhZ8ari43ha6uS6KmEYW6zjseZWhMIMdZcy/BopSfe3ovQtOqUc/cDlTtpUk
         AnDi08PS9FYs9cmti69kDQoQC3YZxJvAXeIrYZNA=
Date:   Wed, 12 Dec 2018 18:29:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
Message-ID: <20181212172931.GB8269@kroah.com>
References: <20181211151606.026852373@linuxfoundation.org>
 <533608e5-526b-0e65-643a-4ca539882e89@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533608e5-526b-0e65-643a-4ca539882e89@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:24:28AM -0800, Guenter Roeck wrote:
> On 12/11/18 7:40 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.167 release.
> > There are 91 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> [ preliminary ]
> 
> arm:allmodconfig, arm:omap2plus_defconfig:
> 
> drivers/dma/cppi41.c: In function 'cppi41_stop_chan':
> include/linux/kernel.h:815:27: error: 'struct cppi41_channel' has no member named 'node'
> 
> [and various other similar errors]
> 
> The same problem also affects v3.18.y.

Patch now dropped and a -rc2 pushed out for 3.18.y and 4.4.y with that
removed.

thanks,

greg k-h
