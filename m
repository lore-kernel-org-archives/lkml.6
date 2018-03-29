Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346719-2-3732287930132362441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346718; b=YacbKORIAZ8rr2DoeesGcoFe64fwRQ8vQgpfN+dv6bnJMa6WMW
    lSCbBxFOuG/9wkD4r0bpTIqoFBdbjTiiEyBKo5bHVnQIEVOOGnZZgOFr78pow6Zp
    sdpt7ckTD97CU1UJiRvGYw7OgnmHadm4fPY5rdWSSbPfeMWvM25i2eDYMcYYOLTq
    VXD2ceYIX2L8p7eTiUmcWfqE4v7niJbkrr5RDer4RYMO45cP4o9eVqgHRKfVm92v
    7EQMKBvB8uMNTY3YBfoCAvLJOzyU6cwYdPtMHw36CuIJTm6UN33MRjkVqv03QiER
    9ODbabiI0+nTlB3GW3y/1yQ/bHNxalfy0BQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346718; bh=OfU8KT9wnIT3QGcyGaGKiE9DzS0dZS
    0T6HfKM+CrcSM=; b=Xzpi++Al6sqxQZs+CdfzG6unq3rAKe/E0E4B55q3ScE4oS
    Xp0hsOPT0mebncHNY6bOrJcz4fwrZi1l3k+wClAVPmWzOkFfEwnBVZkes92osfCa
    2WWzhe4F6r/Y2Gqww6HkkhE/mhLC9YwD18svv8AWGRMqQNTFMk7dmZ4WxNUNYYoZ
    48ve+T9fqnxewUmp5jjJ28YuYcmqK7EpXUZ/C6VfheUCI5rMP1pwIddEa+xFTLIA
    MEJSFusgvFqUifBCVzXcCYuhkEjkhoIhaDGWzQsKxn9BsmF+sWCfppAH7/6CBzas
    ykjwlPUOxuPYd/qKXg8DFeqzKKaDCkl/QNqMuo/w==
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
X-CM-Envelope: MS4wfBPVAcDOs/vR/vQi9Ee1MprPziikQVQUGTY9RGZ/YLuiD3zCsWQ04f9oBvT3Ra1CQwdgOZKSd5XchWN/cUe/jWM3WBVsy27ZwWhATy3STXX9hzgUYYF1
    t7N2pJ+u9etD0xq7+ByDUm5UkYbOJujriFpjcDSgUVD+PNVM3hEjr/Zw8ShKoJYnvk9jJ1QX+Cb8bpdQx1k+mAL2eIUz5rpHDMT+RDRAwtXqovDfp7igkP8B
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=wMhl-A6El2MiV7JXehAA:9
    a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeC2SFO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:05:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeC2SFM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:05:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <michal.kalderon@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 32/43] qede: Fix qedr link update
Date: Thu, 29 Mar 2018 20:00:27 +0200
Message-Id: <20180329175733.480826122@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
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

From: Michal Kalderon <Michal.Kalderon@cavium.com>


[ Upstream commit 4609adc27175839408359822523de7247d56c87f ]

Link updates were not reported to qedr correctly.
Leading to cases where a link could be down, but qedr
would see it as up.
In addition, once qede was loaded, link state would be up,
regardless of the actual link state.

Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2066,8 +2066,6 @@ static int qede_load(struct qede_dev *ed
 	link_params.link_up = true;
 	edev->ops->common->set_link(edev->cdev, &link_params);
 
-	qede_rdma_dev_event_open(edev);
-
 	edev->state = QEDE_STATE_OPEN;
 
 	DP_INFO(edev, "Ending successfully qede load\n");
@@ -2168,12 +2166,14 @@ static void qede_link_update(void *dev,
 			DP_NOTICE(edev, "Link is up\n");
 			netif_tx_start_all_queues(edev->ndev);
 			netif_carrier_on(edev->ndev);
+			qede_rdma_dev_event_open(edev);
 		}
 	} else {
 		if (netif_carrier_ok(edev->ndev)) {
 			DP_NOTICE(edev, "Link is down\n");
 			netif_tx_disable(edev->ndev);
 			netif_carrier_off(edev->ndev);
+			qede_rdma_dev_event_close(edev);
 		}
 	}
 }
