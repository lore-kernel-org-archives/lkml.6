Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2276EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA8B2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA8B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388805AbeIXSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:43:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeIXSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:43:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3EDE109E;
        Mon, 24 Sep 2018 12:41:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 178/235] serial: 8250: of: Correct of_platform_serial_setup() error handling
Date:   Mon, 24 Sep 2018 13:52:44 +0200
Message-Id: <20180924113122.519851028@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

[ Upstream commit b29330d829042512fabb2bfa3bbfa32df1115594 ]

Don't dispose IRQ mapping before it has been created.

Fixes: aa9594740 ("serial: 8250_of: Add IO space support")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -124,7 +124,7 @@ static int of_platform_serial_setup(stru
 				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
 					 prop);
 				ret = -EINVAL;
-				goto err_dispose;
+				goto err_unprepare;
 			}
 		}
 		port->flags |= UPF_IOREMAP;


