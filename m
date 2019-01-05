Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C98521871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfAEFwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:52:54 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.38]:42267 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfAEFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:52:52 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B052D5A4C6F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 23:52:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fet9gVcrXYTGMfet9gHlX9; Fri, 04 Jan 2019 23:52:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46910 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfet8-004M4L-5N; Fri, 04 Jan 2019 23:52:50 -0600
Date:   Fri, 4 Jan 2019 23:52:46 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 0/2] Fix NULL pointer dereference and use struct_size
Message-ID: <cover.1546667177.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfet8-004M4L-5N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46910
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first patch in this series fixes a potential NULL pointer
dereference by adding a NULL check. A tag for stable has been
added for this patch.

The second patch promotes the use of struct_size() in devm_kzalloc().

Both issues were detected with the help of Coccinelle.

Thanks

Changes in v2:
 - Fix bug in patch 2/2 reported by kbuild test robot.

Gustavo A. R. Silva (2):
  ARM: integrator: impd1: fix NULL pointer dereference
  ARM: integrator: impd1: use struct_size() in devm_kzalloc()

 arch/arm/mach-integrator/impd1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.20.1

