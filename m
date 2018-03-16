Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214942-2-14596123266478810071
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
    t=1521214926; b=NnV9l3XJ2ZvIko2LmLDos03Gd0VbjxYB6XRfhBIilo5YGSV
    AcTuxeUCTvwkqa8WH4+5ibwyNspZS82itGiU/JDVOunrn8AFpHnCsMdUTFOHeP4D
    +4n67Cnd7B0CN9z6LY7WPAso1rRboWbXC0s10zj2ZSjPF31eAsnZ7IXv6/NK4pZU
    lo1otFRVQyXAM+dI9BLsSQD3lEZXa1kzSgyQn4SqjRW7OWbhfkWIHXgWD0/oqa6t
    mVZeR4rky0awowc3DrTxOXG4u9pmarbb0X1pgUN+cJbP7W+FxP2s35jytEVxbzi/
    wcjn1zYJrxg37FGaVFbjnnqHLPQ0FI2eI4l/6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214926; bh=OrZswYOuOIKSfiQRkWnsURfO28
    0MNwwMjLC6NpGQ9sQ=; b=ejlbyqfjfcV+rDaFuL3KknrTEiOy7DDTtjT1IyiZi6
    HQQN5zBsBNWxt7wD0cEIK4cTSXH/Yj2pi5wn6NjZ/T3YEF0PVngTF6MY0Zk4cj/w
    ULuq909MITs7kqyZicpNB5GtNRa18i1sc+kT9t8Rnzb+j1MyJbWayBIj//QlrVdp
    4IMDdBGrQOwMB8hBlBHbLfWHhS1b2M4o7kFU2iYw8rABu5Orn/PUTg3UJRvXs5T6
    A6zurfqrJ2+QVYSAvvx6BuDefQw+Q6aG8j1lpHT2bUBcgY3dIk2OaR8Cfsyn15UE
    3nt6iq/740kEBtky6su0rhxd2lYYUkVEHcbqKgTzVxGg==
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
        id S1754784AbeCPPlv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:41:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbeCPPlt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:41:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sunil Goutham <sgoutham@cavium.com>,
        cjacob <cjacob@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 060/128] net: thunderx: Set max queue count taking XDP_TX into account
Date: Fri, 16 Mar 2018 16:23:21 +0100
Message-Id: <20180316152339.795876734@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunil Goutham <sgoutham@cavium.com>


[ Upstream commit 87de083857aa269fb171ef0b39696b2888361c58 ]

on T81 there are only 4 cores, hence setting max queue count to 4
would leave nothing for XDP_TX. This patch fixes this by doubling
max queue count in above scenarios.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: cjacob <cjacob@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1833,6 +1833,11 @@ static int nicvf_probe(struct pci_dev *p
 	nic->pdev = pdev;
 	nic->pnicvf = nic;
 	nic->max_queues = qcount;
+	/* If no of CPUs are too low, there won't be any queues left
+	 * for XDP_TX, hence double it.
+	 */
+	if (!nic->t88)
+		nic->max_queues *= 2;
 
 	/* MAP VF's configuration registers */
 	nic->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
