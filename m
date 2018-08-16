Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F162148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F162148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbeHPLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:31:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51091 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeHPLby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:31:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0189F207F3; Thu, 16 Aug 2018 10:34:57 +0200 (CEST)
Received: from localhost (unknown [78.250.249.73])
        by mail.bootlin.com (Postfix) with ESMTPSA id A5149204AE;
        Thu, 16 Aug 2018 10:34:39 +0200 (CEST)
Date:   Thu, 16 Aug 2018 10:34:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uio: ensure class is registered before devices
Message-ID: <20180816083438.GE21707@piout.net>
References: <20180816073941.13618-1-alexandre.belloni@bootlin.com>
 <20180816080112.GA3496@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816080112.GA3496@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2018 10:01:12+0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 16, 2018 at 09:39:41AM +0200, Alexandre Belloni wrote:
> > When both uio and the uio drivers are built in the kernel, it is possible
> > for a driver to register devices before the uio class is registered.
> 
> How does this happen?  The link order should solve this issue, right?
> 

Sure, if we can ensure uio_init() is called before any driver calls
uio_register_device() then this would not happen. However, I'm not sure
how you would want to achieve that.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
