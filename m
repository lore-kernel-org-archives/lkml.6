Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807201-2-2708577770781962111
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
    t=1521807200; b=rhnFEau93PN1b0UclaanoQPEepnGniGRYOOF8CXgzEqyU4q
    9o21JfyI6UwE02LKs2PGD718dvvBYNuGwsy+bata5LcYRYbgP+M5hs5sW+9iObai
    0SZVyC+dGqTvigftLHkOLPHf4hGLwVdhfNfVqa7f5g8NCznpcUMWQUSZThnDgXS3
    yYmBtY/TAW2ZknOx+ZIuZI8QdcJY1LjXv+RV5dV0r+pzmLKwwisKBBt5ivTNnan3
    2Kp8R/mORFVEB1IvaC7Zx7huf7lMblwQ7QJwRUN6LAjYrsIpmfR44tUwhJnchYoT
    zjaEXnpi6dWXKYxM2jlMwaF3aqMQCZhRSKmKKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807200; bh=mDxTpRRRejj1xtisVDwaqMi1Z5
    p+MaOEM1cQ8J5LO7I=; b=ajqPdzlWdOJerk/Tpia4rFauQfghCBr6AGqg/SO0VS
    lVetcrl2PGlURGnjv65hsNQl9lk+V/Mj2FKkNVyGL31aBnZSqULz44Hn/SAOgc0H
    /FNgdC3BCaTcFKMRTYD2HYTzzC0BNyDXLP3sj3O5ZoR8W4lQhGVlBCVkaIYXTCD8
    CTslkKvvrGHh76/6b+yWBXYGHiSB06p5hFi8j+pLCCrKKM9OIOb9Fu5I01WJDknW
    xaaRZyGzLjNIrpd4VCTUF4lBSxKkLtJN1nLdItMCYO3xHZGFmOXsTwQOWrV6jseI
    LPfGQMfeVESvL19vo2ApnRzh/YE33uONtpqYYs+ZxhnA==
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
        id S1752830AbeCWJ5T (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeCWJ5Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Balaji Pothunoori <bpothuno@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 20/84] ath10k: handling qos at STA side based on AP WMM enable/disable
Date: Fri, 23 Mar 2018 10:53:34 +0100
Message-Id: <20180323095415.000628052@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
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

From: Balaji Pothunoori <bpothuno@qti.qualcomm.com>


[ Upstream commit 07ffb4497360ae8789f05555fec8171ee952304d ]

Data packets are not sent by STA in case of STA joined to
non QOS AP (WMM disabled AP). This is happening because of STA
is sending data packets to firmware from host with qos enabled
along with non qos queue value(TID = 16).
Due to qos enabled, firmware is discarding the packet.

This patch fixes this issue by updating the qos based on station
WME capability field if WMM is disabled in AP.

This patch is required by 10.4 family chipsets like
QCA4019/QCA9888/QCA9884/QCA99X0.
Firmware Versoin : 10.4-3.5.1-00018.

For 10.2.4 family chipsets QCA988X/QCA9887 and QCA6174 this patch
has no effect.

Signed-off-by: Balaji Pothunoori <bpothuno@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2563,7 +2563,7 @@ static void ath10k_peer_assoc_h_qos(stru
 		}
 		break;
 	case WMI_VDEV_TYPE_STA:
-		if (vif->bss_conf.qos)
+		if (sta->wme)
 			arg->peer_flags |= arvif->ar->wmi.peer_flags->qos;
 		break;
 	case WMI_VDEV_TYPE_IBSS:
