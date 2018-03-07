Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520452694-2-14089652352124493118
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
    t=1520452693; b=Z6uS6oFIfTMQUw4k+9C+SDOJpMLp7lmrtUGAofCRUxwQVCA
    zWFBi1F2kYC7WFKltcoe43tVuCrt+x1MzJ7BNfIjYYkrbOKhK5SijCzYwJ5rhqy6
    HjP/NTWUYKHSSwtob0FdBlwBSl4kOuIvvnphMW73FCV8sOPf1kLz7q6BRpmMO5qg
    7avQmMF+pHEpGTC/N9LLsrBbPitHxRL8jNgOjo65khWIVY9F2awPNsWtatdbRvO2
    B+hJe6BiOL/bTFwtL59jEnA8MERoQgDiujkhkgvO1ESc2GFHhdEPgtnH/UtbxBnY
    kl/pQDv/FqRtTfsYRDOl65RhMyKo4QKKxVZpvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452693; bh=a5TKtVBDcec/cfspB+lGsF7mUc
    2OyLXxMFIN+46j3+g=; b=YRoZUtzsNs57eEU15hAHO/MrynQH+13C2dr09mlQJK
    CHNP8ENWHUlsXP7fNCC2V3hU7QO3WcaNsEbdl6gcusaq26M3J1pbyF4CGX+GUja5
    Nv525pv7ahKv1PTcMx+Y1HLL9XDmvC0XdTezrsZMx6mPhXTxWeaq22L+wvjvoeBM
    fMN5KeG/HY+oVOaR+LeQEtV11r7dyJHzWrKJFUKE+0O0nKxIliDrE/Th3HenDv8B
    ruCfaPUa7KM2l0icVVwwlCNFZKPWvuLba/6k1hCAIFK+5c7yDhWRbavH0fjUsDE1
    HkBvDBBrj8wR/gwx6/iPJJGRnkWF+i73Z6nnK794nDpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934938AbeCGT5v (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:57:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754921AbeCGTrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 080/110] Revert "s390/qeth: fix using of ref counter for rxip addresses"
Date: Wed,  7 Mar 2018 11:39:03 -0800
Message-Id: <20180307191050.049079635@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 4964c66fd49b2e2342da35358f2ff74614bcbaee ]

This reverts commit cb816192d986f7596009dedcf2201fe2e5bc2aa7.

The issue this attempted to fix never actually occurs.
l3_add_rxip() checks (via l3_ip_from_hash()) if the requested address
was previously added to the card. If so, it returns -EEXIST and doesn't
call l3_add_ip().
As a result, the "address exists" path in l3_add_ip() is never taken
for rxip addresses, and this patch had no effect.

Fixes: cb816192d986 ("s390/qeth: fix using of ref counter for rxip addresses")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -249,8 +249,7 @@ int qeth_l3_delete_ip(struct qeth_card *
 		return -ENOENT;
 
 	addr->ref_counter--;
-	if (addr->ref_counter > 0 && (addr->type == QETH_IP_TYPE_NORMAL ||
-				      addr->type == QETH_IP_TYPE_RXIP))
+	if (addr->type == QETH_IP_TYPE_NORMAL && addr->ref_counter > 0)
 		return rc;
 	if (addr->in_progress)
 		return -EINPROGRESS;
@@ -328,9 +327,8 @@ int qeth_l3_add_ip(struct qeth_card *car
 			kfree(addr);
 		}
 	} else {
-		if (addr->type == QETH_IP_TYPE_NORMAL ||
-		    addr->type == QETH_IP_TYPE_RXIP)
-			addr->ref_counter++;
+			if (addr->type == QETH_IP_TYPE_NORMAL)
+				addr->ref_counter++;
 	}
 
 	return rc;
