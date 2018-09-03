Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B90C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBF82054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBF82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeICLw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICLw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:52:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E38BACFA;
        Mon,  3 Sep 2018 07:34:04 +0000 (UTC)
Date:   Mon, 3 Sep 2018 09:34:02 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] firmware: google: make structure gsmi_dev static
Message-ID: <20180903093402.4c753833@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>
Subject: firmware: google: make structure gsmi_dev static

The structure gsmi_dev is local to the source and does not need to be
in global scope, so make it static.

Cleans up sparse warning:
symbol 'gsmi_dev' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Colin submitted this trivial patch twice already (2017-10-03,
2018-06-01) but nobody picked it. Greg, can you take this in one of
your trees? Or should it go through Andrew? Thanks.

 drivers/firmware/google/gsmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index c8f169bf2e27..734146eec1b9 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -84,7 +84,7 @@ struct gsmi_buf {
 	u32 address;			/* physical address of buffer */
 };
 
-struct gsmi_device {
+static struct gsmi_device {
 	struct platform_device *pdev;	/* platform device */
 	struct gsmi_buf *name_buf;	/* variable name buffer */
 	struct gsmi_buf *data_buf;	/* generic data buffer */
-- 
2.14.1



-- 
Jean Delvare
SUSE L3 Support
