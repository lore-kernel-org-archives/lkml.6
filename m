Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-572056-1520601937-2-17425448756238814799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520601937; b=WXpIpRsEZ1oxD4D+38ulXu32aFc7DO60Gs2MSH/5fQqLt3Z
    lPGwHRKd/KQhBAgaqZukfJCA/8I7yHpBMiOc3323uze+Q5dgWypRmNZK/xk04NlR
    daE4vN4vLR663APfDrHiMCP6f080a9k73RIWNhWZwShVMpCmr+KGfvKiyvZ/QGq5
    9eSQPvslcl+nJ3yfxosFrbawQFbnNhq2r2ATclsDCG6Rkyk7/qbrvA0NpuIQvLXp
    p+E5/bubHk63ZLnVugkJWSL8yhut3ICDubScHB4/GG1iO/31OYYqprS4ml+FJ+8+
    gIdYUGR+7hDfGVzz7GNt3a06pC0CR1iIezyJgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520601937; bh=Q
    6Qpc0ZqMpi7NCrgDzTiKPHzQZzvmwJ/RyRmbKHEALc=; b=jY95A9YZYF977m1Jy
    6wqP8/10aZ1OZEZly1hHgH53T6TK94rGYh781mjXAQK/0v7QH9TgKR+oBk6OoxIK
    GWKBU6ZHMPp3tkDQ7t5l3JpFXf4NUGVGUOM9Hmqk44bnAgvrA81i2Tx3jhn6zVJ+
    hB0yi5DqhJ3Nnd6Y8IRta8Ff0e2aneTiB6AyhpSgVmJickrIlNpji4LsBrTv5A/j
    aXEd7CMQgXKVz5MIiP3U8xLlsiKaTn1xMCnod+ACgSC5Hr9JqupSK8skcRyQ+CEj
    sSyMqWB6nVtg784+F7dZJ7KRFxEF3GPmYg3Naolqvn0/7AHUZNfrdSNLX2a/UCAl
    gPF0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Correct filter setting for
 multicast/broadcast
Date: Fri,  9 Mar 2018 14:25:23 +0100
Message-Id: <1520601923-26931-1-git-send-email-mgamal@redhat.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: otubo@redhat.com, sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 Mohammed Gamal <mgamal@redhat.com>, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 009f766 intended to filter multicast/broadcast, however
the NDIS filter wasn't set properly in non-promiscuous modes,
which resulted in issues like DHCP timeouts.
This patch sets the filter flags correctly.

Fixes: 009f766 ("hv_netvsc: filter multicast/broadcast")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/rndis_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 8927c48..411a3ae 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -861,9 +861,9 @@ static void rndis_set_multicast(struct work_struct *w)
 		filter = NDIS_PACKET_TYPE_PROMISCUOUS;
 	} else {
 		if (flags & IFF_ALLMULTI)
-			flags |= NDIS_PACKET_TYPE_ALL_MULTICAST;
+			filter |= NDIS_PACKET_TYPE_ALL_MULTICAST;
 		if (flags & IFF_BROADCAST)
-			flags |= NDIS_PACKET_TYPE_BROADCAST;
+			filter |= NDIS_PACKET_TYPE_BROADCAST;
 	}
 
 	rndis_filter_set_packet_filter(rdev, filter);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
