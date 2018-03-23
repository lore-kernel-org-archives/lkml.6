Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799792-2-18091809355925301383
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
    t=1521799792; b=U38rhE+EYrqMhBb6nO+vPMwS7ChL1y+W/BsA1BaxurF5TiY
    11JWR6oXjNX80dng3aHaLXb42wmchL1SeFh/mai9BYT7FvFNzQecwCBlLSyEzzfR
    o87vatQQmP/8saABzzorgpHp9/ijDvtqVmNkx1dWrqdNTMREiuZeh5Rmbx+OvRxn
    DSa2YJR3aZDzKJ2uMeJ12dDGAfPB7wKH3F0rY4vqkzVWjB0WpE9RhtV+UPzEaHES
    8+bjWkxzgkx4znKcX/DNYTirK36utyLdqvv4qKOSY9LVTBiWKEg+yRYV9BAPh1zB
    6MNYepflJBt+g/LZHbqmEDhDZIC3XsLjsA4NHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799792; bh=xT0jFPzQTTopHesJl7tZiGgEFw
    +0yvbOkpbSiTtvIhA=; b=gnPaYxGvnGExFpLNnjA2zNpBxOYsLr4yf8BrBTJthL
    vyZsBQaZ2GmIUWkaFtgHp6jHgr72TMKvrkQAx5d6plL1A7wPhCcIzeV7yrJUDjCb
    GfdROFvrtbR9nenpTu4KNHbpdkFWiIzSKgmDItYAOX8vlAcLG+OBOvTwsxAMa8XE
    dZAtIZUc4CL94G52nx84KJupvMRTkPv5UoAynBYV2z/QwGGfsF9WO48tV786zYCq
    3VuzlG87MmqpFdeqGeStLQ5IP1X03YTamCn50jVR7n9O375/vOMIheRyeEZVm4or
    eepiZb0nMny3dM2Dw9/jRfY7QxSJQeOTUwnej8R3icVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbeCWKJs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932539AbeCWKJn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 108/177] vxlan: correctly handle ipv6.disable module parameter
Date: Fri, 23 Mar 2018 10:53:56 +0100
Message-Id: <20180323094210.042037001@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Benc <jbenc@redhat.com>


[ Upstream commit d074bf9600443403aa24fbc12c1f18eadc90f5aa ]

When IPv6 is compiled but disabled at runtime, __vxlan_sock_add returns
-EAFNOSUPPORT. For metadata based tunnels, this causes failure of the whole
operation of bringing up the tunnel.

Ignore failure of IPv6 socket creation for metadata based tunnels caused by
IPv6 not being available.

Fixes: b1be00a6c39f ("vxlan: support both IPv4 and IPv6 sockets in a single vxlan device")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2816,17 +2816,21 @@ static int __vxlan_sock_add(struct vxlan
 
 static int vxlan_sock_add(struct vxlan_dev *vxlan)
 {
-	bool ipv6 = vxlan->flags & VXLAN_F_IPV6;
 	bool metadata = vxlan->flags & VXLAN_F_COLLECT_METADATA;
+	bool ipv6 = vxlan->flags & VXLAN_F_IPV6 || metadata;
+	bool ipv4 = !ipv6 || metadata;
 	int ret = 0;
 
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
-	if (ipv6 || metadata)
+	if (ipv6) {
 		ret = __vxlan_sock_add(vxlan, true);
+		if (ret < 0 && ret != -EAFNOSUPPORT)
+			ipv4 = false;
+	}
 #endif
-	if (!ret && (!ipv6 || metadata))
+	if (ipv4)
 		ret = __vxlan_sock_add(vxlan, false);
 	if (ret < 0)
 		vxlan_sock_release(vxlan);
