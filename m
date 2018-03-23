Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804570-2-10412119175416631378
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
    t=1521804569; b=VCci7OvI8BZawMk3hJFeT/Gp5+QDi047g/tJiB7j0xRTWkM
    dmqXlPQDULUq31zZlUPw8VdsWQ0ikrrWFbVDChpdpejBDNH5Tn1sUGw/iXBMWtob
    5TFRYJTtPl8Y/nAhWH9eEHFWcSt/HhVhvOB0DBdM4KsEmsGBCTKOmJ0Ckpx5HizF
    QBJNjwsl2TRqWtwiwFrDhFSgkEeZ91WqQGRKYusup5EQsUa1F0azZGoe3PQMWh9f
    3TwRPiSu/EbcQXsbTw9i9pG/ORI9eQbJ/4+Mvzpq+YnMRQU1m/R4KOhyXwksRqxk
    ydRzi41XGoeKx+2wCc9OOy6pDMe91lvBkuOeOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804569; bh=PquaHfza/vkRR94BDgZbOtyBrr
    uQlp024VV7JwFTwJc=; b=YId11TUGR31FblpH4FRopbDEgNC5jVeKXKwKX4JH13
    v5BrwMVpTZf4mdgdNKAjzIY9kCw7QqZ1DjWnXcGSH36IJy9KHbYY738ay6jNx/AW
    I65Fg9dziqsuS8y0Iq9hrekEmUPYfgbxJS+R8W6pjVJHGmyI8/XvbGHYYKGniFw8
    Xv640CKGCb1BNst5kK+9zNMHAR7kPOk06xSq+GcZpOvAvPFVqwTyenvDN3YjwmI8
    ijoEgaF72b4W8wd32tX16XdGwILq0LACZ9Z1JJi37dHt/NcXQSqt3JdHRWdT/5PP
    vx4tNLCRpDHsts5CZ1h83vxHP3J/pNI0hyH4Cx9WhO0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1755264AbeCWKGj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755260AbeCWKGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 045/177] IB/ipoib: Update broadcast object if PKey value was changed in index 0
Date: Fri, 23 Mar 2018 10:52:53 +0100
Message-Id: <20180323094207.269972686@linuxfoundation.org>
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

From: Feras Daoud <ferasda@mellanox.com>


[ Upstream commit 9a9b8112699d78e7f317019b37f377e90023f3ed ]

Update the broadcast address in the priv->broadcast object when the
Pkey value changes in index 0, otherwise the multicast GID value will
keep the previous value of the PKey, and will not be updated.
This leads to interface state down because the interface will keep the
old PKey value.

For example, in SR-IOV environment, if the PF changes the value of PKey
index 0 for one of the VFs, then the VF receives PKey change event that
triggers heavy flush. This flush calls update_parent_pkey that update the
broadcast object and its relevant members. If in this case the multicast
GID will not be updated, the interface state will be down.

Fixes: c2904141696e ("IPoIB: Fix pkey change flow for virtualization environments")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -974,6 +974,19 @@ static inline int update_parent_pkey(str
 		 */
 		priv->dev->broadcast[8] = priv->pkey >> 8;
 		priv->dev->broadcast[9] = priv->pkey & 0xff;
+
+		/*
+		 * Update the broadcast address in the priv->broadcast object,
+		 * in case it already exists, otherwise no one will do that.
+		 */
+		if (priv->broadcast) {
+			spin_lock_irq(&priv->lock);
+			memcpy(priv->broadcast->mcmember.mgid.raw,
+			       priv->dev->broadcast + 4,
+			sizeof(union ib_gid));
+			spin_unlock_irq(&priv->lock);
+		}
+
 		return 0;
 	}
 
