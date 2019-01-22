Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF8921721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167303;
	bh=EW3QVpb27BziYAlcJhctPKWpNDqg0dDn2vmSu0nkLgk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SkbNr1N3jiFZBS0HOFjMEAJn49pNNGwBig05OeBoxfaqs1pnIXSXdB6l1alcY1D2f
	 bU6JrMIynPFprQ9rqZ/JfB7KOPYbdWNs6mNnyyXNsMBh9Tf3MceF3VyL3lO0GiHbAh
	 gDcbpsT0HJTPI5HK3KURTOgOoAd+s3HoHTS5CCfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfAVO2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbfAVO2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:28:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0489F20684;
        Tue, 22 Jan 2019 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167300;
        bh=EW3QVpb27BziYAlcJhctPKWpNDqg0dDn2vmSu0nkLgk=;
        h=Date:From:To:Cc:Subject:From;
        b=ekQ1GymO37ZO61x8k0R+QsQfYTXmHi1jmo4y8hbbyH6fAlIv0d0HhyE+CONWzIgTr
         FGQ/TeXdQ55VDq4SmKHKMXegfrtonL657DKQupei5lmo2vL4xspyZrIgjMca35o6rW
         i4FFuZFSep1HIPstRiPq4VwcqND3SiM8mvyWQgrg=
Date:   Tue, 22 Jan 2019 15:28:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] SCSI: fcoe: remove unneeded fcoe_ctlr_destroy_store export
Message-ID: <20190122142818.GC18225@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to export fcoe_ctlr_destroy_store as a symbol, so remove
the EXPORT_SYMBOL() line for it.

Cc: Johannes Thumshirn <jth@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fcoe/fcoe_transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index f4909cd206d3..6d3949b687ef 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -855,7 +855,6 @@ ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
 	mutex_unlock(&ft_mutex);
 	return rc;
 }
-EXPORT_SYMBOL(fcoe_ctlr_destroy_store);
 
 /**
  * fcoe_transport_create() - Create a fcoe interface
-- 
2.20.1

