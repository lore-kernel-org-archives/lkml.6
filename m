Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527163888-2-11335327610583361814
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
    1527163887; b=aQ6k1WVHv+hIUPXY015uSgPrCaRmIYgfdytYYnxrHvlY1ILVKA
    QXE18K81oZ4OCCTQjCHVBh0rZJ/Zwo2Dteg09qTNXSwP86FlnBPgxF7Oq41lZDMV
    kIyVzfCYsjsZN/VRWeoUamH4FQEYYanktR6qPIMfkctqHwMq2vvTGwLJYuKTdVmU
    DD/J408gGTrdt6bf1PdZTOQdIzs6xxtEJ+yIxttFaofCUatD5ggsN/LKhoRTJXze
    WCZI+g0VLqwfXsNrd9ekv7gwAxEdrzur21hkzTo7L91x3Abhs77+wSeekb1obtV4
    O/7oDxTUKU/9zxNXVcJc36eOQ0khpzP7WDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163887; bh=pwGCsBAORvoWDXbZvgcdmz7K31WVbX
    jhpbSmMEVOEws=; b=hoGilgmMPtVFhVL2P8qHbO0c4h1R1jo3xvmR5lgr5JI7ly
    Am8Ahus9S1C9tkzDI1ecazb8lwh+2D6x6T6i4riGy3XzzoS42bqJPYiK4DJnMynK
    V91LchJtrSr02823ol5u7WyDjP1JAJkuXChs0nmCpJAr1cUwQxf47gKsIMHsGx9u
    cV2e6JoLK27u55w3hAxcTjalfUDa6UjgWhg1EFzbYIZU2pi2tNjy2t4nDr/CYy3v
    mwkxx5VcZW4/BVApKPk81iUqUo0p3/XmsCKrKwcwvq52zGu+cPSvTje402jtqfLh
    ocig6iZ9XWm0qeJvTjawBxnR+gbfYoDQbVUwUkyA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=o3icjI9o x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=o3icjI9o x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfK7Rmxla8Y1c7klkKHyS6UcSe7YyGkVoMBbWG0XmWIUuwfrBK3NV0sXBn+fmUEEDgbsNJg7fLDsQ9u2q7R8i3K4xseTvvBCKLxt1eL8qcQLGnSU1Zi9Y
    NtMadqFLLzpikCtiXOomvAzobrkFGFERqFwyNx07LRZof8NKf/7DT1WgptRSx2qB5CYG7yr9WimN8Nuta1pILQv30piAkWuUYFDQW3YXY15fdBzG5PTpcKfz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=X7Ea-ya5AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=-QkFZ1CkDEvVFEUcWrEA:9
    a=QEXdDO2ut3YA:10 a=f3QdawHiMRSDlnPgGXNW:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965925AbeEXMLM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965956AbeEXJnM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Debabrata Banerjee <dbanerje@akamai.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 16/92] bonding: do not allow rlb updates to invalid mac
Date: Thu, 24 May 2018 11:37:53 +0200
Message-Id: <20180524093200.686610227@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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
