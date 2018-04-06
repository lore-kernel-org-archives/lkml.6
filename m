Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523021184-2-3871964244561733558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021183; b=Sl/7Vdql0CEeo1PrM8yHrcBRQ7IsTQ0dZXcRN/NAiRaZMgECAp
    1JqFf9nUG5K3k9V5y9xeNBLn2ubqbl8mDnN9d3lRw+9tIUDxV/M9mNK9fPb0lMHw
    lGzFhu3KRE3iceRBLhmyAGIMhpNShxIV9J2rSn9KlH+Rx4Si3dLatWbC9FRCAwK9
    XI0WxKaQrEmQVK9RBYI8pcrKrQgaVIrpjxXPKY++JNtkV/6KNGJpPfj+wdLon2ra
    4q6zjQ0C9H4Q0NjKMYA6a/T9TdkYv7/KG5QOJLwUn8mU+fD23yhCDEPSCxI9lfeA
    SSN++3iEDWwvGnAJ6CNK6MIuVxYFss1vOGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021183; bh=riSbA1PADiVdpXEw622vIf5WcSBFJS
    VVd8KMjDNYoxs=; b=pHAhSYmfGzJwmWxNdqSV0uaIjKbww8rQWYjL2iLVJxfeQQ
    9zbFpT7oX5Ef+FU5mTO66/B+YpxqQ3rM7Cgrhg6B4foBFOrMV94N5xsaRB4S9BNX
    dp63X/YqxWdwf5PF82ie64qDqESvbSWNFrA60MRGRX/qzQ8w7/Q1W0n78gZ9Z9+9
    1EdTqyPqKOsx/mFFyBvfC8BVVgZehp/Sexvi+qNq1LqLW2LRzt3RJbc2tsxHMOCj
    SogE3TeUmOlqknRwwCDpwL53bAcZKH4/B35NzntJmM+WRn0ovztqcrwfLDKTf5B3
    0xwsnsENJCuKO4X6GyFQb3bpLNEUSSPzq//PQ9RQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDCMQFqTM3/2Eo7CCjL6BrFO89IHOyoclykP8rlL8ha1FOuSGr3/qtgN1GpVpD9e5Sk0Dmf98Stg97c883VIUqDB9Ney5c/iVYClK2kgBi8pQuK2TJmr
    SDtSOUwwoDjozi//SQbjhx3wIYEG8uYIpKs4Q/UAz6pVeN5UaVEXoe8fTKCei2nQ3rfC4m8DPXUMKdnqBIx8bUnR0bZ/cyY6xnm/mylULALiygSKxLLvJZfs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=uku85CEG5Zrwi_CjhSYA:9
    a=QEXdDO2ut3YA:10 a=F1TI1Km7xOsA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDFN0U (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:26:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeDFN0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:26:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 35/93] s390/qeth: on channel error, reject further cmd requests
Date: Fri,  6 Apr 2018 15:23:04 +0200
Message-Id: <20180406084226.481218662@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit a6c3d93963e4b333c764fde69802c3ea9eaa9d5c ]

When the IRQ handler determines that one of the cmd IO channels has
failed and schedules recovery, block any further cmd requests from
being submitted. The request would inevitably stall, and prevent the
recovery from making progress until the request times out.

This sort of error was observed after Live Guest Relocation, where
the pending IO on the READ channel intentionally gets terminated to
kick-start recovery. Simultaneously the guest executed SIOCETHTOOL,
triggering qeth to issue a QUERY CARD INFO command. The command
then stalled in the inoperabel WRITE channel.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1158,6 +1158,7 @@ static void qeth_irq(struct ccw_device *
 		}
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
+			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
