Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400207-2-3096167158283894308
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
    1523400207; b=SmRDsoZhnrxSq2Oma0o0m8neZwbjFE95j31gYDaoiCCRgBZw1E
    WMSU+03gYg+J0VTaFSpaF/avH9DY1lhFti4LLk+qBz5MOwY098hrVO1fiT1n0K4K
    be63/zDa3WMDjpFBpZFIxyV+B8IrjRUMzvRPXCTqt30BTtwHE2YWCM8nlFYghS4i
    ZL0mICnWk+1TsroYyNfkmrZxrQmrOROBy9nTG1ANvuU7j1iEkssv2tdNWgtiKPCQ
    0Hu8a3SpVt8LlHEy9TEzNTtnA9wJYGOenCwG2DjCFZ1D2w2/pnTWhmtHbvSkVpAr
    FpppyMN1mXfdeiWz7UCg1YCDL7gijxVTvlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400207; bh=vIb7YUG7W/es6A0NU2bX8wWLU6tH5i
    Am4HU7B4AcLsQ=; b=qLkY8N+ZYR0B9Rx8O9dYSpQpvEWsD/MhtarWUEVXMs5MnT
    fIS1jmBfVWe1O3ruGl8sbmVjOfyfgXbHgsMKAXrSQOme3D1aUCSxEa6alDuIwNdF
    uaiJHr12/PQhmGQ0j7xv+WTOa2OUEBcQ1IY+0eaoJDm9CtMA+zLBMHE3xhavJc2R
    59+FH9yQ0fwIojs/eUtlwDBfDxAgabEMfzRfpLO5CVRA86c2t3MA0xOrQV3Tdjeg
    ETqhUeNon1OY/le+3v8uM81Ac0/E7B+fjxjYc36DiiMbaKgr0jwcbjvMzOlXffwx
    5uwHOWHwWRodzXu8Qp3tH8H3KKUOlUZAW9Abucuw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNMhS6N7DGtrHoi55s/omZHsMw3/aIchVy65QzAxK9Kf2ULnQXzhfNyS9gLbZRNIEqNK9JdMGV+/i8sL81XAzKqOkkFjcw7WCrg4RTI18P1kGvAdgBJM
    t33KeV2NbbiQh9ltyWXEp8yk3ysbn4uiS5pS6lvh6VzCe/yUSCJTRwmdUisGV0fmXdb6Tqoi/QLPyBrisGC6YZmpQq3imoqAjAIL8/TMszEi3VOSIjv7ucdw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=-COPsrLyAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=S2R-ogY8bjE9VJC8-YIA:9 a=QEXdDO2ut3YA:10 a=ksTjKdeKf_QrTKGjYr5L:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeDJWjo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756072AbeDJWjm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miguel Fadon Perlines <mfadon@teldat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 113/138] vrf: Fix use after free and double free in vrf_finish_output
Date: Wed, 11 Apr 2018 00:25:03 +0200
Message-Id: <20180410212915.311413155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>


[ Upstream commit 82dd0d2a9a76fc8fa2b18d80b987d455728bf83a ]

Miguel reported an skb use after free / double free in vrf_finish_output
when neigh_output returns an error. The vrf driver should return after
the call to neigh_output as it takes over the skb on error path as well.

Patch is a simplified version of Miguel's patch which was written for 4.9,
and updated to top of tree.

Fixes: 8f58336d3f78a ("net: Add ethernet header for pass through VRF device")
Signed-off-by: Miguel Fadon Perlines <mfadon@teldat.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -579,12 +579,13 @@ static int vrf_finish_output(struct net
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb);
+		rcu_read_unlock_bh();
+		return ret;
 	}
 
 	rcu_read_unlock_bh();
 err:
-	if (unlikely(ret < 0))
-		vrf_tx_error(skb->dev, skb);
+	vrf_tx_error(skb->dev, skb);
 	return ret;
 }
 
