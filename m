Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UwSdB7PzG1sTZwAAmS7hNA
	; Sat, 09 Jun 2018 15:35:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 768D8608C1; Sat,  9 Jun 2018 15:35:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/l9lV5h"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D68FC608B8;
	Sat,  9 Jun 2018 15:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D68FC608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeFIPfr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933082AbeFIPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:42 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C74208A3;
        Sat,  9 Jun 2018 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558542;
        bh=QFCVBYzJqtMKY5fMpkJFt1FDhhaSQNoTCxsYyEKUw0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/l9lV5hdQRVa9iIz8yxsyOByceMM9G7c83xzAK2PLXPmApaJa4hMQ8SAVnSAY1jw
         SuEcqFYD/2xjOZx/nnBcGT5R+ZI229hjhUdeA7xSYSJhbojee35BAsV/A6PlakKuAY
         yhlnrynvUNHnwGI/wxx0eAQk8vOnvMJzbWUiqJn8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 19/41] net: ipv4: add missing RTA_TABLE to rtm_ipv4_policy
Date: Sat,  9 Jun 2018 17:29:51 +0200
Message-Id: <20180609152927.463250140@linuxfoundation.org>
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

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit 2eabd764cb5512f1338d06ffc054c8bc9fbe9104 ]

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_frontend.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -625,6 +625,7 @@ const struct nla_policy rtm_ipv4_policy[
 	[RTA_ENCAP]		= { .type = NLA_NESTED },
 	[RTA_UID]		= { .type = NLA_U32 },
 	[RTA_MARK]		= { .type = NLA_U32 },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
