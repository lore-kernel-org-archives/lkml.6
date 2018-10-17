Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C95C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE052098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH+dcVjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE052098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJQN7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJQN7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:59:41 -0400
Received: from localhost (unknown [106.201.39.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E54B20658;
        Wed, 17 Oct 2018 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539756340;
        bh=VZk4Vuo7lLNkS42NIqo23xHXLXqu6NctijCYXEOKiQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lH+dcVjTJxd4DdJwDIVcjbZvFlvI1nCCeL5wy47Zqt6T18rQ6zqwApTgjL/usGTIW
         W0fX5ebKTDeoeJ7YsULeriS4Z5SN0HJRcvjPdfVPaR+DatDeeoAsVmVOCe2WprNave
         asTZoqJJB4mravsXgWclf3DgH4wnw9U+nBO6Xuv8=
Date:   Wed, 17 Oct 2018 11:35:31 +0530
From:   Vinod <vkoul@kernel.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: Re: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
Message-ID: <20181017060531.GU2400@vkoul-mobl>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-18, 09:41, sudheer.v wrote:

Please add the change log describing the driver and its features

> Signed-off-by: sudheer.v <open.sudheer@gmail.com>


> ---
>  drivers/tty/serial/8250/8250_aspeed_uart_dma.c | 1594 ++++++++++++++++++++++++
>  1 file changed, 1594 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_uart_dma.c b/drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> new file mode 100644
> index 0000000..e1019a8
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_aspeed_uart_dma.c

why is this in serial. It is dmaengine driver so belongs to drivers/dma/
like other controllers. Please move it out and resubmit.

While doing resubmission please take some time to understand subsystem
tags to use. (hint git log <subsystem> will tell you)

Also series has [[PATCH] 8/9] whereas it should be [PATCH 8/9] please
let git generate that for you (hint git format-patch start..end does a
good job)

> @@ -0,0 +1,1594 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *   drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> + *    1. 2018/07/01 Shivah Shankar created
> + *    2. 2018/08/25 sudheer.veliseti<open.sudheer@gmail.com> modified

we dont use this log in kernel. I do not see s-o-b by Shivah, that
should be added. I think he should be author and you need to list
changes you did..

-- 
~Vinod
