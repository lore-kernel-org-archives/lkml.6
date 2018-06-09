Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Lw+dObfyG1v4XwAAmS7hNA
	; Sat, 09 Jun 2018 15:31:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F333E608C8; Sat,  9 Jun 2018 15:31:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx+ic8QU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 626E0608B8;
	Sat,  9 Jun 2018 15:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 626E0608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeFIPbR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753330AbeFIPbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:12 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEC9204EC;
        Sat,  9 Jun 2018 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558272;
        bh=UnndZdOZCDrdj3/VX8NRmtJqy4IpWqsz3dTv5daQK/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nx+ic8QUT8LZrlRZ4Ekn8yQE+HtxQeE/ZRIdV7H6nc7uhZ3j9fyskqKOBjTiblGVC
         381fzJBmGEsaboK0sxqBYvjXGQDkWoDlIu6qFXA0wV1DWqGpVmiUZfCOs5pJnmMXQ5
         UuCoAZUNEqtsW5tPF9mSlUKubr30O4Bd6+4HQhvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 06/15] netdev-FAQ: clarify DaveMs position for stable backports
Date: Sat,  9 Jun 2018 17:29:41 +0200
Message-Id: <20180609150001.065994217@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -179,6 +179,15 @@ A: No.  See above answer.  In short, if
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
 
