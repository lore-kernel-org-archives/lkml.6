Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76462C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2457C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhIhTtrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2457C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeICG6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:58:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33238 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeICG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o9YXrMm/ho7rmuQGSrj9XrAqG4L6d3vyuY80qNPyzHA=; b=DhIhTtrD+VOqob0Pt1cYqun8lU
        6upHKyclFZmiQjGK7tGVSsJ4e7BqSFqUhpaDvuuMnWOehBsvIDdSA7qVSxDj7eJ5EniqPS4FDcM8X
        HLucM+VCaTDNKZH1EDq9FioikttOrcArd1Ph4BuLK4HVN803XxiCXv3z18Pcywt6NZfD9GUdhqD6Z
        TH5kNo8jQLT3TS/mN8QGTTDn9w5YBhuhaQo9amGZESIOKcFlfzolgnlZkwWudKZxGNLzU/1h5kg7Q
        LNPoIPyculimtjcwx56MuwP6wa4xjM7//0BQVRORdf3bHf6gQb5leTrwzVdWYmpzYddga4/xxrDNy
        fv1kFLDw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwemS-0005Vb-G6; Mon, 03 Sep 2018 02:39:56 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb/dwc3/gadget: fix kernel-doc parameter warning
Message-ID: <50ab44e8-b365-a3a6-8aff-8621374e3f94@infradead.org>
Date:   Sun, 2 Sep 2018 19:39:55 -0700
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

Fix kernel-doc warning:

../drivers/usb/dwc3/gadget.c:510: warning: Excess function parameter 'dwc' description in 'dwc3_gadget_start_config'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Felipe Balbi <balbi@kernel.org>
---
 drivers/usb/dwc3/gadget.c |    1 -
 1 file changed, 1 deletion(-)

--- lnx-419-rc2.orig/drivers/usb/dwc3/gadget.c
+++ lnx-419-rc2/drivers/usb/dwc3/gadget.c
@@ -473,7 +473,6 @@ static int dwc3_gadget_set_xfer_resource
 
 /**
  * dwc3_gadget_start_config - configure ep resources
- * @dwc: pointer to our controller context structure
  * @dep: endpoint that is being enabled
  *
  * Issue a %DWC3_DEPCMD_DEPSTARTCFG command to @dep. After the command's


