Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4175208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4175208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeGPMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:01:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeGPMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:01:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84458C03;
        Mon, 16 Jul 2018 11:33:59 +0000 (UTC)
Date:   Mon, 16 Jul 2018 13:33:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arnd.de,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1 2/2] misc: npcm7xx: add NPCM7xx LPC BPC driver
Message-ID: <20180716113357.GA30937@kroah.com>
References: <20180704091427.409971-1-tmaimon77@gmail.com>
 <20180704091427.409971-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704091427.409971-3-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:14:27PM +0300, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM7xx BIOS post code (BPC) driver.
> 
> The NPCM7xx BPC monitoring two I/O address written by
> the host on the Low Pin Count (LPC) bus, the capure
> data stored in 128-word FIFO.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

It would be great to get someone else who knows that this hardware is
supposed to be doing to ack or sign-off on this patch, as I don't know
if this really is providing the correct api for it or not.

Right now it's just reading data from the hardware, what good is that?
Who uses this?  What userspace tools connect up to it?

thanks,

greg k-h
