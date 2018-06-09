Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BQXHIkPzG1t1ZAAAmS7hNA
	; Sat, 09 Jun 2018 15:33:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C0FA608C1; Sat,  9 Jun 2018 15:33:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLQepCqA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0F40606FA;
	Sat,  9 Jun 2018 15:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0F40606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeFIPdZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbeFIPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8E5204EC;
        Sat,  9 Jun 2018 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558398;
        bh=eGiYm5ojXWMEQz30qJ8JkObCugEhCn5VqS1p+gKmwRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLQepCqAQQ0ZJXEEDiPUWPfzlyTPibhA7k2QPMQDD1LIb/8IVXk6J9L6hOfQOhX5A
         eT0mCCYm3xAoCa73y4EMfSkJByy30hZMq/P1zAyb5Eji2nG4n+hwK0VYqerhQuxQ3q
         wM7ey6VZRAvvjSgPsPtP0nHxYrEIEF/XzagKr8vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 21/48] net: ipv4: add missing RTA_TABLE to rtm_ipv4_policy
Date: Sat,  9 Jun 2018 17:29:33 +0200
Message-Id: <20180609145949.040517632@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -643,6 +643,7 @@ const struct nla_policy rtm_ipv4_policy[
 	[RTA_ENCAP]		= { .type = NLA_NESTED },
 	[RTA_UID]		= { .type = NLA_U32 },
 	[RTA_MARK]		= { .type = NLA_U32 },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
