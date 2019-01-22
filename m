Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EFEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9B520866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfAVWix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:38:53 -0500
Received: from mleia.com ([178.79.152.223]:58770 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfAVWiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:38:52 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 455A643C92B;
        Tue, 22 Jan 2019 22:38:51 +0000 (GMT)
Subject: Re: [PATCH] tty: serial: lpc32xx_hs: fix missing console boot
 messages
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Roland Stigge <stigge@antcom.de>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <e7fb8d2d-5daf-afdf-bd8e-472c76701650@mleia.com>
Date:   Wed, 23 Jan 2019 00:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190122_223851_305259_9132313F 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 01/15/2019 07:18 PM, Alexandre Belloni wrote:
> When probing the HSUART, it is put in loopback mode in order to prevent a
> potential issue that may happen on RX (Errata HSUART.1).
> 
> serial_lpc32xx_startup() moves it out of loopback mode but this is too late
> to get the kernel boot messages before userspace opens the device.
> 
> Also get out of loopback mode in lpc32xx_hsuart_console_setup().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

the change looks good, thank you.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
