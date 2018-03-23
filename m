Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803436-2-5466608499838459679
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
    t=1521803435; b=h/5io8eIjbk0Rp+XVOZmLHtGbRuNQIDSz8xbV7QTOOQ4LWx
    b13kYwuY7f8Q7FCRsFGhkyvBUSNn4rfktLVpO9FiUEm7xRO+gIlboTPNHyG9r0hQ
    Lsiwb7cpFkPrqMc9h89TgEma2fDf1cV10OKb++U7PXiG+lmMqAot6KCHt5ncbXxK
    FBMn+mSbJxeSlsfhIXNSnMQRYIgU+Xe3PCF3nF1qTynykkthN4ya9yUtIRo7nq9V
    kSkW88r+mX9jR4lWAMhQc89XvqDlMNQyWwbdA7FQsAwIa1qp8fAeKg69gOrpbH+D
    OA822VrJHSgnW/V3rEHGOtjR69SJgrA83JByrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803435; bh=G0GDPU30C1ZBbxt8tF2wWnf8pM
    kV2cGh4uByrS14d+8=; b=E7L98tmmD3ige+hLtnhLOmwlibMMWlffiy275WOcGh
    nj8xjJRrsJfoC32h/ifYb/3A0zAqcY9YBhDeQczLXVcFnbGdivtWvT70BUDYuYUO
    Hr9tdHeDRAT4ihX0fx58bCqH8Xi24Lq23ablOPNtzpDdBsairbtQpsjAEVG7Qbja
    kc8qDCGxk7tsBriCTv9pBglJv09PPXq00Yqa5YZgtjWEf6IKkVKW6gjUUhl9OG/7
    9hn/j+RSOnsWKMlrYv7NyJ9izNucJ2yxuw5iua3amkClJb7lTS7YM5UBywKoqh3/
    6DKC5mFR0z5M6C1W3J1i+94pYx2tCyPkzq/YKKAi3UMw==
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
        id S932950AbeCWKLV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:11:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932472AbeCWKLQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:16 -0400
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
Subject: [PATCH 4.9 139/177] rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
Date: Fri, 23 Mar 2018 10:54:27 +0100
Message-Id: <20180323094211.346703573@linuxfoundation.org>
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
@@ -1572,7 +1572,14 @@ int rtl_pci_reset_trx_ring(struct ieee80
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
