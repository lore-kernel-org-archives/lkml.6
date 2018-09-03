Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1844C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7308120862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kv8iCY/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7308120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeIDANv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:13:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41936 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbeIDANv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kkQDTDh2R9Jp2Dqhvu4mbr66XQM0WL6IxjBpzmZ4b4k=; b=kv8iCY/uliAJrd/oFK62Gh+/bR
        lOiD5gN9Lo9I7Ez0YWodbXxYN28DPxoml1ulxIgHN/haurbpks62vBUxZ4XwZM6+xSyXGJeG94CLJ
        qhDV0NICpHhilEPz/dUxBa3CHWRtBhO/eYrmdngL4zAPLe09ugdr49JkvhhkSsWPQoXs7cEWhF6P4
        y1DONp8mKrVMWqIC+LGgIO1WT8AW6hMzxcbn0tbt/mJ78d44Xmu0opx96YWgl7shOpGevXTGZvkQE
        6PEwv17+q2AMPTz7ZRiiCiAJg7hTHxXI8XOSfbja/UNexLg+2+Nn19j8IOMJ6CvukWgQYdrL0BTc2
        8y+N/82w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwutK-0001yT-9X; Mon, 03 Sep 2018 19:52:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] linux/mod_devicetable.h: fix kernel-doc missing notation for
 typec_device_id
Message-ID: <ab0e079b-0160-8d67-3aa9-0205372df3ca@infradead.org>
Date:   Mon, 3 Sep 2018 12:51:59 -0700
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

Fix kernel-doc warning for missing struct member description:

../include/linux/mod_devicetable.h:763: warning: Function parameter or member 'driver_data' not described in 'typec_device_id'

Fixes: 8a37d87d72f0c ("usb: typec: Bus type for alternate modes")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/mod_devicetable.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419-rc2.orig/include/linux/mod_devicetable.h
+++ lnx-419-rc2/include/linux/mod_devicetable.h
@@ -754,6 +754,7 @@ struct tb_service_id {
  * struct typec_device_id - USB Type-C alternate mode identifiers
  * @svid: Standard or Vendor ID
  * @mode: Mode index
+ * @driver_data: Driver specific data
  */
 struct typec_device_id {
 	__u16 svid;


