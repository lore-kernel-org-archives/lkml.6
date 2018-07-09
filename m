Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32F1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7902086E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU7HpM/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7902086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933091AbeGIUux (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932928AbeGIUuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:50:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C56832086E;
        Mon,  9 Jul 2018 20:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531169451;
        bh=PR5paq9mhPAXg/xTlTKqKA8wDIdqg0o8kHgcU4olj+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DU7HpM/vQx1YYLp2j75IxpRbFaih7n1DTWgGS8xzUBYVHjYlyWUA/ltZZVo3pYHLN
         eG6FVWQR90nBkTwtwULrtGINaTALG65iQCg8bDnIyJkEFgXyCTdhH0j2rjxFfW/cgu
         laixOhoJ+SOUczbNWtXV8uG4QfcfRX1y2EBzYnT4=
Date:   Mon, 9 Jul 2018 22:50:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 1/7] mhi_bus: core: initial checkin for modem host
 interface bus driver
Message-ID: <20180709205047.GA1202@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:08PM -0700, Sujeev Dias wrote:
> This is the initial skeleton driver for mhi bus stack. MHI Host
> Interface is a communication protocol to be used by the host to
> control and communcate with modem over a high speed peripheral bus.
> This module will allow host to communicate with external devices that
> support MHI protocol.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/00-INDEX                        |   2 +
>  Documentation/devicetree/bindings/bus/mhi.txt | 258 ++++++++++++
>  Documentation/mhi.txt                         | 235 +++++++++++
>  drivers/bus/Kconfig                           |   8 +
>  drivers/bus/Makefile                          |   1 +
>  drivers/bus/mhi/Makefile                      |   6 +
>  drivers/bus/mhi/core/Makefile                 |   1 +
>  drivers/bus/mhi/core/mhi_init.c               | 538 ++++++++++++++++++++++++++
>  drivers/bus/mhi/core/mhi_internal.h           | 238 ++++++++++++
>  drivers/bus/mhi/core/mhi_main.c               | 122 ++++++
>  include/linux/mhi.h                           | 341 ++++++++++++++++
>  include/linux/mod_devicetable.h               |  12 +
>  12 files changed, 1762 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/mhi.txt
>  create mode 100644 Documentation/mhi.txt
>  create mode 100644 drivers/bus/mhi/Makefile
>  create mode 100644 drivers/bus/mhi/core/Makefile
>  create mode 100644 drivers/bus/mhi/core/mhi_init.c
>  create mode 100644 drivers/bus/mhi/core/mhi_internal.h
>  create mode 100644 drivers/bus/mhi/core/mhi_main.c
>  create mode 100644 include/linux/mhi.h

You don't say what changed from v1 here :(

Please do so...

