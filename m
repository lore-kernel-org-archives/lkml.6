Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802300-2-16791308499135836597
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802299; b=CtQThAz2rZp3Mb3ajLxIghGn7BQGchakV3ZWJrKt3XX3iPd
    rwZ6lG2IpV2LRiuHYAIcfj6RRbJiaLzJkcuoXHmt7MA9PthkMG7sOrmyzHOUFx5D
    eEMINU7Ax6FWSQ5r7FBd1MfKy2//xDoHYSQoLAlnt17hvZkffKofdPR0PuwsYwK3
    BqJOaj3L37MQAVdqs5IgvsYZKpezn3RBThMDjP2W8CiTQL0ONvoWQUNI8eODCNz4
    u+e7JWtwnOY7xstY12SEihsBkLZS4/pCEpRSW9bN7m0BQfD+xsMBl1Fg+H9aUFPb
    213XDZVN3vqRZjnV1+CkRF7yM+iAxNNuCdRiFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802299; bh=a31ntah99CRdwKQeIiT/+TbHZw
    ge4XtB5Ahgu2G0kMI=; b=i9+e8NtYKJ3aWSfUU/Atm9YLg7lac30cDruRrqFVT1
    EJVmjL4sIHYNgCBy39lMyPMoO/uEXJ5dumFNSqNBH0ZYiuk6T5vpMCZMOnSKO7bh
    1cfDNjoj1+pxszrl/xcPFvRLdWPHfRbmAYXKlqEGagxKHa/Oh5ERVqsNyqwcocA9
    xXFR9OlZPRd/+znmSPN7ziqdjDm0DTny7wTe1GVdHXw7wznfWT+LTz5sX5+K/jWL
    jPMKD8tINenonv/zjLRkfldmZ2zNuZXsV1B45HmlgByOGW36e6Zjal2lb7Wqb3lL
    4EzMkE5AsemAOZgb0oj9pfBNSlPdadoCvUE/91CVA6Cg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S933052AbeCWKOZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756023AbeCWKOU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 21/97] clk: ns2: Correct SDIO bits
Date: Fri, 23 Mar 2018 10:54:08 +0100
Message-Id: <20180323094158.652930498@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>


[ Upstream commit 8973aa4aecac223548366ca81818309a0f0efa6d ]

Corrected the bits for power and iso.

Signed-off-by: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: f7225a83 ("clk: ns2: add clock support for Broadcom Northstar 2 SoC")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/bcm/clk-ns2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/bcm/clk-ns2.c
+++ b/drivers/clk/bcm/clk-ns2.c
@@ -103,7 +103,7 @@ CLK_OF_DECLARE(ns2_genpll_src_clk, "brcm
 
 static const struct iproc_pll_ctrl genpll_sw = {
 	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
-	.aon = AON_VAL(0x0, 2, 9, 8),
+	.aon = AON_VAL(0x0, 1, 11, 10),
 	.reset = RESET_VAL(0x4, 2, 1),
 	.dig_filter = DF_VAL(0x0, 9, 3, 5, 4, 2, 3),
 	.ndiv_int = REG_VAL(0x8, 4, 10),
