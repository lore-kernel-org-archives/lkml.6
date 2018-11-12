Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF40C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9176E223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9176E223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeKLTmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:42:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:35494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbeKLTmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:42:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7538DAFE4;
        Mon, 12 Nov 2018 09:49:43 +0000 (UTC)
Date:   Mon, 12 Nov 2018 10:49:42 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Radu Pirea <radu.pirea@microchip.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: at91-usart: Add platform dependency
Message-ID: <20181112104942.765456f7@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to present option MFD_AT91_USART by default if
not building an AT91 kernel, as the drivers which depend on it are
not available.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
Cc: Radu Pirea <radu.pirea@microchip.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
As a side note, maybe it would make sense to have SPI_AT91_USART
select MFD_AT91_USART instead of depend on it, so that
MFD_AT91_USART could be hidden?

 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-4.20-rc2.orig/drivers/mfd/Kconfig	2018-11-12 09:34:20.096038788 +0100
+++ linux-4.20-rc2/drivers/mfd/Kconfig	2018-11-12 10:39:51.102170181 +0100
@@ -102,6 +102,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
+	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function


-- 
Jean Delvare
SUSE L3 Support
