Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155542-2-10280301408827474944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155542; b=W5BHGVI6CeTQPOWtfPZZ691nk2o3th1Q6WXosJCKzFDyCJLSHT
    vJOFKasHdw1ZrS7MVtrca219ZJ6DAF28yuJAdFYZUskHxFWaeoRAkOfFPMOSTLxw
    7Yg/iulrdCH8n/IHy18umll5TUTUhhu8nIcvNejLz8WtgJWO7v6uP8tR5YboP/oZ
    XUh8d/JI850CbPynI2YJREGv+HaAPQSbqgbnbWh3kdWJvjTy5KQKjcSywoG22JOM
    2abtdQUgmR23r+op2FmIxxS2cqdGtpZ7AEReoen0EvxgkAUrFbIEfqEmizXTY1EZ
    LgQRoYnAzkIZ7OHIVM4ZJvmP0SvlLuL6lOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155542; bh=uk22E7jryFi2WrqfhW2WkhJVZB1TY+
    v/e7+Uwwkcg0M=; b=G1ISj94/Rlht70w27gfnyYsX9UFZY6uUxJXD9rRmgUwJkl
    0TjfU72NrRakoSkCn6UD+Z3rO4/rYDzMbe748g3Nr6bJ7dCnEm30vkfzwxrkXPBu
    kOQWWW9xCQ3hi5TsxkX4lXClajVm9oP3lQkV6BxHac8dvZZCCasFISZpwKp4X/RT
    i/4mNi5GJ+TrfgTVXawp9L4Q6uucW0hPcfwEcWVaJXZcpAf7N8ghsAU6fagpLoeO
    PCROIxVAaveVek6EX6dw5u9/WsrwpsdJ/6lTmGMmMdxZi0aeFSckXRDwc2s3mYwn
    GQ6nSfWwi+kESKGZvPGz2Nk6+0/tTTx9HOhA4vBQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=plDn0ROO x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=plDn0ROO x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKX2F3lHLFK/iQEPkz0ALSjduAwIhb7T1wm4mWs/DFuJsZkq4AcuMNN8UyuMG54OBmtAsbLJTZ2MwGMs8w2E1Pdn8XT8JMmwWAPAPf7/cInc882U8omu
    E0+6lfKZ7eczKwjg9wfDmKCV1FlM6yCNT8I0RFmfp0IUiGUqKz4YgbE+3L2ByzdD/y0l07aUcYzFCtxuVhlrDa0+WaZI6v5NBFryOTCNleRJKQ47IDgimKIM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Mh4r-_ZpIgjaAtl8Q-MA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967838AbeEXJwT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967571AbeEXJwQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 024/165] hv_netvsc: cancel subchannel setup before halting device
Date: Thu, 24 May 2018 11:37:10 +0200
Message-Id: <20180524093622.958178798@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit a7483ec0267c69b34e818738da60b392623da94b upstream. ]

Block setup of multiple channels earlier in the teardown
process. This avoids possible races between halt and subchannel
initialization.

Suggested-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1340,6 +1340,9 @@ void rndis_filter_device_remove(struct h
 {
 	struct rndis_device *rndis_dev = net_dev->extension;
 
+	/* Don't try and setup sub channels if about to halt */
+	cancel_work_sync(&net_dev->subchan_work);
+
 	/* Halt and release the rndis device */
 	rndis_filter_halt_device(rndis_dev);
 
