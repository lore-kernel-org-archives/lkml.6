Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161161-2-1437661403438468108
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
    1527161161; b=HBx1cLoBbnmNWlFCEEUUYw0/WrZfSDHE0BQs6Qc21j1NDrFVvF
    K0KZdLcKBxzt8wk6Io9rTx8tBh4QNoDZnj1L9KUPjNyvgCdEltu+hDIX71OaXvrE
    ffvIJvQq/0iXo6ZVNdPQ49g/dyvyAKmAeGtbfHwIdluiL4avJKo5ZRjjjqPnxI14
    rh+5q/fKYJIEhS0wn6mOiyDncnk6lLLUAHOtWKfY6pZY5BLpvqMhgFOg/5CrBtyj
    uzD2697usF3xTsYysRhajQ25Wur0+o86IDiI1fugXYzTpRHfK0Xc9j8p7u6Da72q
    NtW+cpTzzvvUXebeQ+DI+wV4v28jl4Y/VKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161161; bh=HUrpVwFU8hcQq8LVi2tFU2SmTE3qiO
    cpXuabwKznSMk=; b=ggW6qhAqkNEthHfnkujx0fcC5cu7q7P6y9rCFMAj3QOTV0
    jkhxeU87VZJwPel8jaRNTBJmBXrU1wO9DrDkQS6uraWXSqhpOYm/KTBNieQssXi2
    ldUUje6oy13ArTCMrAxqPvmB1iam7wroeud/RRG3JIjrDAMjZx92LHrH/2qHxeAu
    zpJ7fTy7ArO7KHztMKlXU+r12FpVNPjp/lAV8Rm+U/RIp7UyaFf5o4Mf1XN4e0Qa
    VeKxV3v1EINtIDet9eLwS0bZmAZzBKO8T+f/bL98bTwy+TC0qCEBni8WuosyLsrQ
    +7+IVHj6xbbpwd1WPBxyupRfvlRfPWvxGTWfQqpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Fm+T9/Zj x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Fm+T9/Zj x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFdnRH1a4sWkxNMrJzltC7TiQQfan3Ny3yS5I1bhgHXNLFLzahgUxERltjUThx2vz06sv0cjxv2TKgEC/1PLn7vlcuJbla7VcilIU0CHNyfVWWjcNX4i
    y/rcT1hJudlrAPeZh0aNw4Lpxsrq5KJa6rCCju1rbZrWwOyBSMLQIzMsZoS51WG6+ECpkJLU0o3OsuRT/uvTb9nblaG+i8b3hSwDcsi6OuAT6njHM4RQloql
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=9uM20D-oyJIafyQH7W4A:9
    a=5bmV_-dyjCp7pJ2j:21 a=zkhDmyxGluZocyVr:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967322AbeEXLZs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967749AbeEXJvl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 012/165] hv_netvsc: Fix the real number of queues of non-vRSS cases
Date: Thu, 24 May 2018 11:36:58 +0200
Message-Id: <20180524093622.471331648@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Commit 6450f8f269a9271985e4a8c13920b7e4cf21c0f3 upstream. ]

For older hosts without multi-channel (vRSS) support, and some error
cases, we still need to set the real number of queues to one.
This patch adds this missing setting.

Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1932,6 +1932,12 @@ static int netvsc_probe(struct hv_device
 	/* We always need headroom for rndis header */
 	net->needed_headroom = RNDIS_AND_PPI_SIZE;
 
+	/* Initialize the number of queues to be 1, we may change it if more
+	 * channels are offered later.
+	 */
+	netif_set_real_num_tx_queues(net, 1);
+	netif_set_real_num_rx_queues(net, 1);
+
 	/* Notify the netvsc driver of the new device */
 	memset(&device_info, 0, sizeof(device_info));
 	device_info.ring_size = ring_size;
