Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3AEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F77120869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wbc+erKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F77120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeIDAUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:20:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42052 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbeIDAUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NKnHeddD+9LCLD2ISaRFhqbE0YV7DN9jcFexL8GpyXo=; b=Wbc+erKNAztt0Olv5q0HncSn2e
        N30Sms2oYYLq+rpI8OE6BZZEq60d/a3eVJR5VTiVBeUm7VcQwZVHvstVaP6/XpfxcEIoQiaLHzFc7
        3cD68LSHCLIYR9rdSkjfMauwvtz6Y5N2j5Fj276JX0Zb18mIWePVCw3jiIGYUupKa3s7/NOMX+b+4
        dxl5JbJx3xSX1D4G2EGblCicFM6NXbkdfYa+6mGiMTdcObsvcbPlzy3kEVBDy6+Stdxx7VgcWFFBa
        uVsOUwsw6ZcCUQStHE6xy4XBffvgbikoCp+wr15/9DDznzba++dVIyc+/eLREQPN46jK6qO4l3/aA
        ygzg1EVg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwuzd-00023a-1H; Mon, 03 Sep 2018 19:58:37 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb/typec: fix kernel-doc notation warning for
 typec_match_altmode
Message-ID: <ca3906a0-fbb0-1afb-d619-d8b013c1d0b1@infradead.org>
Date:   Mon, 3 Sep 2018 12:58:35 -0700
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

Fix kernel-doc warning for missing function parameter 'mode' description:

../drivers/usb/typec/bus.c:268: warning: Function parameter or member 'mode' not described in 'typec_match_altmode'

Also fix typos for same function documentation.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/bus.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- lnx-419-rc2.orig/drivers/usb/typec/bus.c
+++ lnx-419-rc2/drivers/usb/typec/bus.c
@@ -255,12 +255,13 @@ EXPORT_SYMBOL_GPL(typec_altmode_unregist
 /* API for the port drivers */
 
 /**
- * typec_match_altmode - Match SVID to an array of alternate modes
+ * typec_match_altmode - Match SVID and mode to an array of alternate modes
  * @altmodes: Array of alternate modes
- * @n: Number of elements in the array, or -1 for NULL termiated arrays
+ * @n: Number of elements in the array, or -1 for NULL terminated arrays
  * @svid: Standard or Vendor ID to match with
+ * @mode: Mode to match with
  *
- * Return pointer to an alternate mode with SVID mathing @svid, or NULL when no
+ * Return pointer to an alternate mode with SVID matching @svid, or NULL when no
  * match is found.
  */
 struct typec_altmode *typec_match_altmode(struct typec_altmode **altmodes,

