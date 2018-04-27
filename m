Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839684-2-898288395003627370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839683; b=Pngsx5rKm8WXbxXiRqU2iOmdiCRbW/4CUDK0HBOqxq5+CSKmrh
    Vt2uRSjq841c6ME3kPH1H58zvF3EO4SVPctcimlnJcPtThWO1iX/RA42hsCbAvbR
    MjSqS/9W5j9iGmsSqpAmLDHmfRjQLo8zscBiJ2nOqzWR85p8R/d7DrDeLfT4n8jX
    5L/EK50EoVbgRgRMLCpizdNOPUFVtwuqfnfLgjmbeooYKDm9QdmoGGKUFIlWHVvq
    MJvXSVLbnW3zGsdKZArjMWgdAE52uiKRhyOtRS3VWLhJMzR2H7IIR0TpnnIEHuYZ
    H/uoT+TLdoz2fTYI2wn6iLf5tOc3f1psQlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839683; bh=uEzyR9Lytg3OuDGQX4USzc0feSnNtt
    Zw4+6WR9Cg3zs=; b=B5F+Ro3wtpAG9qPHmIeEMlk3LQ2NWohFaccwcG85aX5TYb
    Qdn0w/fciRprspoyQ8Qr8b6ufLrnH3pRoSVVxrbuqhSyJcgVfG5YrCYw8VU0P0AH
    WZGu/ms60PSVHcREFtOUav0VBLs47hlt/zYvIkQPl6PF752r1oTK1IxAmIKP/CDz
    wLAyFeUkNFzm8uxGlS3R5y05V5vpg1PZbw0nxKwj3r8JYNziFVEUPMpyE9Y9lmy5
    wEL4aexGOKy1OzuofmfCO5ucIqKKu42S7bfqWd8epH3nlO8434zAvVXU/IwSkSTI
    xQQ5xefmpgdPRqrRFGJVQBn5mt4Q1iv5r1Ma/C5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIW/F4V4O3gEFTXzNAIviVTtlnjWQU4LaNZGL32zQk2XHzBRvlp9jYJcMUn6wVtDbJo2cuXDItk8TyNq8dDESiylx9/TirkNrI3d1BK/JJFr1tT8Qohx
    tVhMSCEdOXT6DUmFRxHbMEv45lqO/F9KcMZshAhLuJzAjO8fmJD42CBEzcC3uv+aIX+fExbhY6w3JqOf3a2gwJx/8I66dXYFjlkUDccBHbkja0vP/epe4YXu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=jZVsG21pAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=6cwDD5hSYp0a3WYX_mgA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbeD0OKF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934772AbeD0OKD (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BC321892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 19/81] net/smc: fix shutdown in state SMC_LISTEN
Date: Fri, 27 Apr 2018 15:58:21 +0200
Message-Id: <20180427135744.381601356@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.vnet.ibm.com>


[ Upstream commit 1255fcb2a655f05e02f3a74675a6d6525f187afd ]

Calling shutdown with SHUT_RD and SHUT_RDWR for a listening SMC socket
crashes, because
   commit 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
releases the internal clcsock in smc_close_active() and sets smc->clcsock
to NULL.
For SHUT_RD the smc_close_active() call is removed.
For SHUT_RDWR the kernel_sock_shutdown() call is omitted, since the
clcsock is already released.

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1254,14 +1254,12 @@ static int smc_shutdown(struct socket *s
 		rc = smc_close_shutdown_write(smc);
 		break;
 	case SHUT_RD:
-		if (sk->sk_state == SMC_LISTEN)
-			rc = smc_close_active(smc);
-		else
-			rc = 0;
-			/* nothing more to do because peer is not involved */
+		rc = 0;
+		/* nothing more to do because peer is not involved */
 		break;
 	}
-	rc1 = kernel_sock_shutdown(smc->clcsock, how);
+	if (smc->clcsock)
+		rc1 = kernel_sock_shutdown(smc->clcsock, how);
 	/* map sock_shutdown_cmd constants to sk_shutdown value range */
 	sk->sk_shutdown |= how + 1;
 
