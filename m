Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527164575-2-5784431841691209719
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
    1527164575; b=BZ744W4qcpJ3dx2z/ELhdWt5GkIWehW5OR/1thuEnvtUdkdSgs
    uhhZ+KQiKV3qSu8647gGtOIlNb03KaA0drrA4z06K4sdEDEfDNkiblIsw+tENYgj
    uBu+k32jt87Dhi2TkTwZbvDs9Z4AckcA7XiXiLM1p3/4V5JPJz5x9h2iJqP9aHxM
    W7gTw1JPbzo9YWoZPMr3RwHhWfOslJUeEy2rh2LE02CazwWmqmClyltR++KYuiI8
    6m3rgm7S+MDvpoQNhrw1BxlXM906yWUoupPRKVlqZzIAMScyQcVu6dlBkbYkSN2M
    E4mTP4Qr8n1Yxbymr+IIWIrPx6oySpKQaUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164575; bh=s9dhPjoaxlBstaxlaWlYFue00QdU/I
    5W5oUS2i6vTs4=; b=OMI3q0xDJrKGfxGX4gpYAWb4QFnAj3Kz9LePC8qUPrGLMS
    KhZXO6ThF+wT9k3p15lUHQI//8byKesDr7wH3TRFYoyLix1CciLXHrr4Z3ug8SBG
    yair4TahGWJpWyk6S6GcA5tVTmm4KbFEJyV89VUC55ooL8l9ctwoKp3Jmu5Ps1YC
    E8YSXxHJnAv3pywLl8LYyuuHqgCuFsrnJq8ntwABbLH2Musx1aQY5ygtaJfwdFIT
    U+/iKIRH7HlHAD2zUo0RkB0bxegKYNytztBfKyanAl2nMQfmN7rHlQPlFANqc/8Q
    srJXjnBZopUw6gEg9pcqkW3Il0jWzO8yWD4iwU5A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=UG+/ZxzN x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=UG+/ZxzN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOXVZzpYWpT3lptN7UveiJyZKrOLFjQ2MkHUWS8WpLyb6g490PWv3WLK4GWh/8fb1tpc0UoYLunquYm5skWcpiuPjog3Tgc3K4k5AKzBOPT8EoihXUVR
    dBjrPZpzFxSpjq4z3AvFiD28qDLotmg4zKt2MC0CcBqg5lITC26y23dFP25wgDySL0mFkqjIAZ9seu0A44woKi/KvrJbET9E+8Fvs41AxM7Ja5/dHLrN36Z4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=X7Ea-ya5AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=-QkFZ1CkDEvVFEUcWrEA:9
    a=QEXdDO2ut3YA:10 a=f3QdawHiMRSDlnPgGXNW:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966202AbeEXMWw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966097AbeEXJk6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:40:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Debabrata Banerjee <dbanerje@akamai.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 13/45] bonding: do not allow rlb updates to invalid mac
Date: Thu, 24 May 2018 11:38:21 +0200
Message-Id: <20180524093122.144254083@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Debabrata Banerjee <dbanerje@akamai.com>

[ Upstream commit 4fa8667ca3989ce14cf66301fa251544fbddbdd0 ]

Make sure multicast, broadcast, and zero mac's cannot be the output of rlb
updates, which should all be directed arps. Receive load balancing will be
collapsed if any of these happen, as the switch will broadcast.

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_alb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -453,7 +453,7 @@ static void rlb_update_client(struct rlb
 {
 	int i;
 
-	if (!client_info->slave)
+	if (!client_info->slave || !is_valid_ether_addr(client_info->mac_dst))
 		return;
 
 	for (i = 0; i < RLB_ARP_BURST_SIZE; i++) {
