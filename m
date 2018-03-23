Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804624-2-1485758601659310675
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
    t=1521804624; b=AVtCSnHNmKtbT7vX8jsz5M0O+FCs0FWStphizb5IVB3nwEq
    pwtLJcMqFaM5Nft59n+6Z62XckKn2KiBgH9aMVLb1YX9H6Af2ALMyUzmGpAtIjME
    LWcaTFG/w/Uy3S8to1YRcXoIlXMA1cY5Mnbtg4rrB6LLn4ueMnuNBDvXsN7x2zeN
    /EExRYeWdZfdN28tCpMvEvyMT3gbnp4XjyH4JFsNC59tAn+crgE9FoRhXlqjeSLH
    kkPnMEK0CPuv/uOoAaFFITH1ezatPOkQj7UMIifOyNqL0kK7gxPVGgGvL3wnFsd5
    oImNispCGb7ofvS5L6EHndP2JqOfq3DgBOSeeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804624; bh=pNGBBbhLRIizPbBzdAZ+CHWG87
    qH7pSi/LwLypQEPXU=; b=XgiMJ4jHIWoN97TdYp82DXK7DJjtKVChEu8vJNbjuu
    H3KaMafcTaikRT+UviDVixQX/0xX1H4g/0v3uQR9vTtVlT7S9IqQcInZCVwz50r3
    HAVrI8HhaxRoJlS5VzW88ZG87WEcZ8G8OfDDMT+gUIJSJWFkNy/vtjYrJiYdq9FO
    457Rlxq3MNS3fdtGMJaVbeuro7gTPZ+iYObCzvMEENBSUitrkZqy4RY4TdF6ysGM
    zqHrdk7z7o3sfI3bgUDg01wmnNTz+g2b3hKwaD00IcBuhIE95VdBspDHhw3txQMF
    wKGkBwPZCUUGzgT8T5qW/zHLen9M4p/yIZAc1S3aOBKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1755225AbeCWKGY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755207AbeCWKGX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 054/177] netvsc: Deal with rescinded channels correctly
Date: Fri, 23 Mar 2018 10:53:02 +0100
Message-Id: <20180323094207.738694716@linuxfoundation.org>
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

From: "K. Y. Srinivasan" <kys@microsoft.com>


[ Upstream commit 73e64fa4f417b22d8d5521999a631ced8e2d442e ]

We will not be able to send packets over a channel that has been
rescinded. Make necessary adjustments so we can properly cleanup
even when the channel is rescinded. This issue can be trigerred
in the NIC hot-remove path.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -151,6 +151,13 @@ static void netvsc_destroy_buf(struct hv
 				       sizeof(struct nvsp_message),
 				       (unsigned long)revoke_packet,
 				       VM_PKT_DATA_INBAND, 0);
+		/* If the failure is because the channel is rescinded;
+		 * ignore the failure since we cannot send on a rescinded
+		 * channel. This would allow us to properly cleanup
+		 * even when the channel is rescinded.
+		 */
+		if (device->channel->rescind)
+			ret = 0;
 		/*
 		 * If we failed here, we might as well return and
 		 * have a leak rather than continue and a bugchk
@@ -211,6 +218,15 @@ static void netvsc_destroy_buf(struct hv
 				       sizeof(struct nvsp_message),
 				       (unsigned long)revoke_packet,
 				       VM_PKT_DATA_INBAND, 0);
+
+		/* If the failure is because the channel is rescinded;
+		 * ignore the failure since we cannot send on a rescinded
+		 * channel. This would allow us to properly cleanup
+		 * even when the channel is rescinded.
+		 */
+		if (device->channel->rescind)
+			ret = 0;
+
 		/* If we failed here, we might as well return and
 		 * have a leak rather than continue and a bugchk
 		 */
