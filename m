Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96FFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BA42077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0Rh6jfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BA42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeICGsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:48:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o12ejVzLcad811NI6U7Q/j4k63dC2fW6MDgu31Xpv0E=; b=E0Rh6jfXb96b8eJZMxKrP4Rer6
        1WH5WKzYsqBsSvPWtQTt4vLtupDwjBVE72BseY+muef6LcHFxUQmGQyelYv1P6kmQqq9DrlhW+JEx
        AwdWxtISIiyIvB8mO8YCv2ZHr4G9VF+js+IqlDZs/5B1nmLIRNNgA/7KBIxLdyyXIE6POVeZw3/R+
        sNFttKpjiujHSs8h3Aycm3dd+ME2kB5SuD7DuMyF0hCqtsgpvb+gcm3mDS70m8dVz10hFBIbBXMqc
        kvjF5h4jgMksYOEMxabnfAAWlBW6Mb8wj+5rUQWRm8cfT+Vp2fBE/9iaqqcOZ1oPSztug01Zqx835
        fREM+DvA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwede-0005Tk-4J; Mon, 03 Sep 2018 02:30:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb: typec: fix kernel-doc parameter warning
Message-ID: <0b58da39-55af-b00c-95d2-14fb26fb70b8@infradead.org>
Date:   Sun, 2 Sep 2018 19:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning (13 times):

../drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c |    1 -
 1 file changed, 1 deletion(-)

--- lnx-419-rc2.orig/drivers/usb/typec/class.c
+++ lnx-419-rc2/drivers/usb/typec/class.c
@@ -1484,7 +1484,6 @@ EXPORT_SYMBOL_GPL(typec_set_mode);
  * typec_port_register_altmode - Register USB Type-C Port Alternate Mode
  * @port: USB Type-C Port that supports the alternate mode
  * @desc: Description of the alternate mode
- * @drvdata: Private pointer to driver specific info
  *
  * This routine is used to register an alternate mode that @port is capable of
  * supporting.


