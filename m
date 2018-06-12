Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 76B2EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D323208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V12H7mRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D323208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeFLQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935104AbeFLQw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:52:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93ADF208BA;
        Tue, 12 Jun 2018 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822376;
        bh=Zc6KZhSbOpHFzmpBNUkl2mtsDbU+mL0LCEYN1poyb20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V12H7mRRRqWFntD6J+8Ccn14U2UNiKB/VEolSRlhgOE0ZfCbQmSrsvXP/vaLojlsq
         E7hSAUQs2dYCio3fS+I1Q+FAbCmZBcZM5ZSVxPKbLEaS6qEw9zEkK086OR3xhqfBnl
         x5OwFstxsAmjQDIt7rWhl/pGpInFf2vKFGcd6ZV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 15/24] netdev-FAQ: clarify DaveMs position for stable backports
Date:   Tue, 12 Jun 2018 18:51:59 +0200
Message-Id: <20180612164817.340545602@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -168,6 +168,15 @@ A: No.  See above answer.  In short, if
    dash marker line as described in Documentation/SubmittingPatches to
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
 


