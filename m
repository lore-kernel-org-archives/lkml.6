Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807350-2-5568615885469195074
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807349; b=b9XQGTSnMLrQ+2hLY8ChAjZffmYlMUbd5g8DoyNnp3G9Vt2
    F8r4COrps4MFEmqmij8nDi7l/0x0OMQa+a72VWTQD0VTjjyhNAuCruScWS25Pq06
    pelcPRRaLjyqXy3t0gjKDvHN0xr3CjSJ9RX9RxgEar+vknXTxO50zBdUpPlPPopd
    BMtkNk9V4qBJvxaapKRVT2etYipFX0OCk6tszwE+zG0Sh2SIuV4Wkd4vGsPhazYT
    M1VlL9XLbEXZToPgiUdayN0fYC7ucwbLUYuIJYtXwzpnCxhYA0gB7HFWp9DqBOvk
    3QIeBxk77aJp+SY8Wo557SEZ24DTJob06pdJcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807349; bh=LEy3BKZWP+YI7cyttGxgPY5kW8
    9LUO46SmkL7t2Fm8A=; b=bvKKoD438ROnqfKc2A8lLDoCS89zix+4pa9tftiz6i
    f9cQh9ZXz9qtmh5OCfXHfZavkiTRQZmS7TqI/G2guMizYrLdS7IIpez6L/4AoA1P
    0rg42cPDvHKV1cVChzYmiF7xRBZORIt4APCe9nutTbzwjeE7PYGqytbHGL441IT0
    PuO25by7tWVEEYdXdpGQNoUvOQdSlDyrGi3Z7+hnw5gP2jEOm/GjbPKzUbJ063ZO
    7udl5+hvsGvqKdGG5CI8ThBFMZC4b8i+OH7fGBqLr/zqIX+wG9HeBgUsleVDmWZv
    qVNBaX/eabvDaFG6rgDInbdO6OzR9P44p+zkfHNWfI2Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1752696AbeCWJ4t (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:56:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeCWJ4r (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tsang-Shian Lin <thlin@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Birming Chiu <birming@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 17/84] rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
Date: Fri, 23 Mar 2018 10:53:31 +0100
Message-Id: <20180323095414.539950910@linuxfoundation.org>
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

From: Tsang-Shian Lin <thlin@realtek.com>


[ Upstream commit b7573a0a27bfa8270dea9b145448f6884b7cacc1 ]

Reset the driver current tx read/write index to zero when inactiveps
nic out of sync with HW state. Wrong driver tx read/write index will
cause Tx fail.

Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Birming Chiu <birming@realtek.com>
Cc: Shaofu <shaofu@realtek.com>
Cc: Steven Ting <steventing@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1555,7 +1555,14 @@ int rtl_pci_reset_trx_ring(struct ieee80
 				dev_kfree_skb_irq(skb);
 				ring->idx = (ring->idx + 1) % ring->entries;
 			}
+
+			if (rtlpriv->use_new_trx_flow) {
+				rtlpci->tx_ring[i].cur_tx_rp = 0;
+				rtlpci->tx_ring[i].cur_tx_wp = 0;
+			}
+
 			ring->idx = 0;
+			ring->entries = rtlpci->txringcount[i];
 		}
 	}
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
