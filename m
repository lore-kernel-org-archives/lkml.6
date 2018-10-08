Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48785C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B42089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsx9lf9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118B42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeJIBvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E541C2064A;
        Mon,  8 Oct 2018 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023891;
        bh=tKjQYyNA5BJvlWd112YzW3IeUeQlLV2b2DeLisQ4Tpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsx9lf9/07bK1EQv9oZmQZBhLVa8F+povSSff/3dIkmHG11mEfwcEomHLfz7KvmKl
         opVY3Afa0mwc30rMqZlv/HEjpPdnbrNztapxTj4L32KwYzWdHboYEb2PO6OxlS7zMS
         sz5ueMYn6KHyT1N9WgSoA2pS/PkU9at1KluTnWYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joshua Abraham <j.abraham1776@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 108/113] xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage
Date:   Mon,  8 Oct 2018 20:31:49 +0200
Message-Id: <20181008175537.256378915@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Abraham <j.abraham1776@gmail.com>

[ Upstream commit 4dca864b59dd150a221730775e2f21f49779c135 ]

This patch removes duplicate macro useage in events_base.c.

It also fixes gcc warning:
variable ‘col’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/events/events_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -139,7 +139,7 @@ static int set_evtchn_to_irq(unsigned ev
 		clear_evtchn_to_irq_row(row);
 	}
 
-	evtchn_to_irq[EVTCHN_ROW(evtchn)][EVTCHN_COL(evtchn)] = irq;
+	evtchn_to_irq[row][col] = irq;
 	return 0;
 }
 


