Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DCEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0800520882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761919;
	bh=rhpj1RDu5bw3C4t5V60VO5UGYyxRDVU9zVX4j+/ShdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvnZuys+TcBiDVk8R5+fzbTxLJBznfzmpS4Pr8XQqHLxQcZhnaD2jCK18EhQYwhCW
	 HVs9r6XTQWb8X5VfJVNOgT+bxUl3yeBzZJJ8rjt2TatSVNINF1gZbIJmO7DIdRPs0s
	 ZM+uirqnpfMrycOEOrf9wUROJ1Pl+hk5qi95MRwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfA2Lih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbfA2Lie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3515220844;
        Tue, 29 Jan 2019 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761913;
        bh=rhpj1RDu5bw3C4t5V60VO5UGYyxRDVU9zVX4j+/ShdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVM6fvDrfSb5RA1jZroB50BQIMfwTHKz1vIATIVCbyW9E9VfOhsbiKn6xeO4Hbn9G
         7hhairgqqnssyqFIYTm35qdgvMm5Pviook6yUGbBx9jXRkMaX0yqH7N9KAM4HHkEBT
         mWmYiJKR8uQ56Vf6qm/O9sSJCrKT2ts+a9U9OR70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4.20 027/117] USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE
Date:   Tue, 29 Jan 2019 12:34:38 +0100
Message-Id: <20190129113208.999014163@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit 70d0ba4cf79a0e73485b22d955991c6f27257376 upstream.

This fixes autoloading the module by the OF compatible string.

Fixes: 813e18b18a87 ("USB: EHCI: ehci-mv: add DT support")
Cc: stable@vger.kernel.org
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ehci-mv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -302,3 +302,4 @@ MODULE_AUTHOR("Chao Xie <chao.xie@marvel
 MODULE_AUTHOR("Neil Zhang <zhangwm@marvell.com>");
 MODULE_ALIAS("mv-ehci");
 MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, ehci_mv_dt_ids);


