Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C38C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB4820846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB4820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933253AbeFUNAg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:00:36 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:63762 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932881AbeFUNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:00:35 -0400
X-IronPort-AV: E=Sophos;i="5.51,251,1526342400"; 
   d="scan'208";a="58220289"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <netdev@vger.kernel.org>
CC:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] xen-netfront: Fix issues with commit f599c64fdf7d
Date:   Thu, 21 Jun 2018 14:00:19 +0100
Message-ID: <20180621130021.27029-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of issues with commit f599c64fdf7d ("xen-netfront: Fix race
between device setup and open").

Ross Lagerwall (2):
  xen-netfront: Fix mismatched rtnl_unlock
  xen-netfront: Update features after registering netdev

 drivers/net/xen-netfront.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.9.5

