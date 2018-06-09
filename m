Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3x/5F270G1u0agAAmS7hNA
	; Sat, 09 Jun 2018 15:39:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 50D40608C1; Sat,  9 Jun 2018 15:39:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0raN0kd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BA726605A5;
	Sat,  9 Jun 2018 15:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA726605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933243AbeFIPjr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753725AbeFIPfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1266208A4;
        Sat,  9 Jun 2018 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558539;
        bh=0Lb91kqQwDT802IW4gsVTvG3/LVG/jZXiaTzAg0mzFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0raN0kddrtGg/XUcYmxH0Bc9jyMXZLPtBfGkwpOtHznpzjIJ+ktczqQXFGJ8mhxA
         SvnpvE1+sjWFdd2reQUhB2eW0rAX4b52ZB7jGQdZFO90SWbMh8IC5n/bI3xpzByT/7
         isLRA/nyivKdG3bnkVPZZLsyrhpWEL/nh7umK8I8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 18/41] netdev-FAQ: clarify DaveMs position for stable backports
Date: Sat,  9 Jun 2018 17:29:50 +0200
Message-Id: <20180609152927.414008842@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 75d4e704fa8d2cf33ff295e5b441317603d7f9fd ]

Per discussion with David at netconf 2018, let's clarify
DaveM's position of handling stable backports in netdev-FAQ.

This is important for people relying on upstream -stable
releases.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/netdev-FAQ.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/Documentation/networking/netdev-FAQ.txt
+++ b/Documentation/networking/netdev-FAQ.txt
@@ -176,6 +176,15 @@ A: No.  See above answer.  In short, if
    dash marker line as described in Documentation/process/submitting-patches.rst to
    temporarily embed that information into the patch that you send.
 
+Q: Are all networking bug fixes backported to all stable releases?
+
+A: Due to capacity, Dave could only take care of the backports for the last
+   2 stable releases. For earlier stable releases, each stable branch maintainer
+   is supposed to take care of them. If you find any patch is missing from an
+   earlier stable branch, please notify stable@vger.kernel.org with either a
+   commit ID or a formal patch backported, and CC Dave and other relevant
+   networking developers.
+
 Q: Someone said that the comment style and coding convention is different
    for the networking content.  Is this true?
 
