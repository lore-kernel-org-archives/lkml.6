Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585EBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E14120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E14120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeICVx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:27 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13E73D16;
        Mon,  3 Sep 2018 17:32:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Larabel <michael@phoronix.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.18 021/123] hwmon: (k10temp) 27C Offset needed for Threadripper2
Date:   Mon,  3 Sep 2018 18:56:05 +0200
Message-Id: <20180903165720.398791365@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Larabel <michael@phoronix.com>

commit 484a84f25ca7817c3662001316ba7d1e06b74ae2 upstream.

For at least the Threadripper 2950X and Threadripper 2990WX,
it's confirmed a 27 degree offset is needed.

Signed-off-by: Michael Larabel <michael@phoronix.com>
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -105,6 +105,8 @@ static const struct tctl_offset tctl_off
 	{ 0x17, "AMD Ryzen Threadripper 1950", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1920", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1910", 10000 },
+	{ 0x17, "AMD Ryzen Threadripper 2950X", 27000 },
+	{ 0x17, "AMD Ryzen Threadripper 2990WX", 27000 },
 };
 
 static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)


