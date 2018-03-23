Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804350-2-18062652166093138691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804349; b=clzGxM0V1F2PSlE265+bz3R1qFCY1fk7uV7LGrJdx5AGYFM
    iXkHXIwQ8l8PuPhyv4SqiZtWKKIdrj+3+k3ASj5XpI7epqBLcSCDiOSrPcofuElA
    wloJH0/so0SyUddtOSCg8TogMOo8dfGiyF5uqkVWFD+CdVzbeCGH22vyhL6XxVEM
    2auJKsgH129X4wttvhXvhF/IjUMDsnMCG3VSzt30hdFzX2xdxrlRnTB23bT6PpT0
    d4Fo9YO4/l4COXMa1ntOohrQJuJPONvxT5F2s5paqT/OgOQ6/yiYAMibggq6NKuM
    pmDqWYlEys1U61VA9ovBKkuahppvZPFmEzxw/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804349; bh=HdjcbmdPBkzGgsvP1X5qTxqU3V
    SGG54cenSuugeNHhE=; b=Wv49CKHjUshVnokXjQp5ruzEk/vXXJn5Gw9vxxVfF/
    Cm1lyyHhuoNKGVQxdo89Y2RMCYjqOE5vndIs+S6oEJiL91hzaoii7X+W0KX9qn9H
    cEuBQ3D5diLrDX0LC/P+2Jj6Pkl2iyqZfkidtarJVOZabCaornVcj4wwpZ8Wf0Ke
    sZZLXtqCQvNFUqDW71k1D3zcElMNiS8nGv9AeIFzKhEIeDjzjEXFo7RVJ3RzpAT/
    H7n+/xj1J1jvkWmlMhRRcbSE9ZhZc7jaLHLyI1s6mcxm0GkpUZdHLLq9EH4G5PFS
    yfre5ZoyZGimw8BN/S9BDFFI+M8+0GGPV+sZA1yOZXrg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeCWLZc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:25:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755303AbeCWKH0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 061/177] mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
Date: Fri, 23 Mar 2018 10:53:09 +0100
Message-Id: <20180323094208.028293435@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit ec5ab8933772c87f24ad62a4a602fe8949f423c2 ]

devm_pinctrl_get() returns error pointers, it never returns NULL.

Fixes: 455e5cd6f736 ("mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1762,8 +1762,8 @@ static int omap_hsmmc_configure_wake_irq
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 		struct pinctrl *p = devm_pinctrl_get(host->dev);
-		if (!p) {
-			ret = -ENODEV;
+		if (IS_ERR(p)) {
+			ret = PTR_ERR(p);
 			goto err_free_irq;
 		}
 		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
