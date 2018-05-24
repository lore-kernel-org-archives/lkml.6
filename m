Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032613AbeEXSL0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:11:26 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:34796 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967377AbeEXSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:11:25 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 24 May 2018 20:11:24 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] ARM: pxa: add dma slave map
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
        <20180524070703.11901-3-robert.jarzmik@free.fr>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 24 May 2018 20:11:23 +0200
In-Reply-To: <20180524070703.11901-3-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Thu, 24 May 2018 09:06:52 +0200")
Message-ID: <871se0yldg.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> In order to remove the specific knowledge of the dma mapping from PXA
> drivers, add a default slave map for pxa architectures.
>
> This is the first step, and once all drivers are converted,
> pxad_filter_fn() will be made static, and the DMA resources removed from
> device.c.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> +	{ "smc911x.0", "rx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +	{ "smc911x.0", "tx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +	{ "smc91x.0", "data", PDMA_FILTER_PARAM(LOWEST, -1) },

Hi Arnd,

Actually after rereading this, I realised that I completely forgot your former
comment about having a NULL parameter for network devices (as there is no
requestor behind).

I will cook it up for v3 ... that will be a minor change in this patch (hence
I'll keep any Ack), but for patches 0006 and 0007, things will change, and
another patch for Vinod will appear.

Cheers.

--
Robert
