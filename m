Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807292-2-1205487318581059308
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
    t=1521807292; b=ZJBnRO2PiIKxPrfMbwH33K7s/gmNv+BUkThy1kOPecibhWn
    dpMfdd60EKkxCFdfABddyjdZDByTyjWxYGGpoZMqtsG2Ub/steJz3PAtw6ipVQTN
    Cezgob/H9dEBbK9jXjz1ETpvjmDrfpdHZ+a6ePt0X8Zhi8cfZzfgrSc3mxpODvoq
    mGyAKEYquVNw15ZKW+Cwm55UWjtL75xMKEdLI3M8GF2QDRhqwKIxZ1ciOLkffINm
    uHOI1NOjsght+KTPlDhcvjRJRmDmHuU4UBQ/JQv3MK/+ZM4MkmarnIEYZAM5+Aoj
    xZPgBLMlnd/j8ggF2pTLqjT6EEXbaLtr4j6KSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807292; bh=QH4AqAmOMrTI08A1KPPB7HnPME
    Rynf47F43b5LlSW5E=; b=TPgQ/JYpQhk8u5aUZibWFwBYEp5b5A07Eby+yOX6sF
    XmQWZS1lFnKZKGNJkBuPVpHnM6oVHDUAc01VK0oRX5xig2clCClWc6c+DrGE2Ka2
    zo6AoTydWhsDwOWXvEjq5H7FCzdgmcjZsn6ZAiDVBS+bJaeJeobHcSAHGrr8IVFU
    sSJj5HPCW7LrKh6d2JjpEzSbH5VjljZvWjSS0U9c/8yDHNDOkteNwJKPh3xnTLf0
    nmyat2VDKqa7U6SCplQLvwj3weZNUVS/+30ptyhroTSm+RMiqo9FCRLM5L8CMu/r
    ZJKicqnFmhqQkyP6/Mn2Qwc5ZIdx4DCqRvrnIh803QgA==
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
        id S1752756AbeCWJ5H (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeCWJ5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 18/84] rtlwifi: always initialize variables given to RT_TRACE()
Date: Fri, 23 Mar 2018 10:53:32 +0100
Message-Id: <20180323095414.669971576@linuxfoundation.org>
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

From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>


[ Upstream commit e4779162f7377baa9fb9a044555ecaae22c3f125 ]

In rtl_rx_ampdu_apply(), when rtlpriv->cfg->ops->get_btc_status()
returns false, RT_TRACE() is called with the values of variables
reject_agg and agg_size, which have not been initialized.

Always initialize these variables in order to prevent using
uninitialized values.

This issue has been found with clang. The compiler reported:

    drivers/net/wireless/realtek/rtlwifi/base.c:1665:6: error: variable
    'agg_size' is used uninitialized whenever 'if' condition is false
    [-Werror,-Wsometimes-uninitialized]
            if (rtlpriv->cfg->ops->get_btc_status())
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/net/wireless/realtek/rtlwifi/base.c:1671:31: note:
    uninitialized use occurs here
                     reject_agg, ctrl_agg_size, agg_size);
                                                ^~~~~~~~

    drivers/net/wireless/realtek/rtlwifi/base.c:1665:6: error: variable
    'reject_agg' is used uninitialized whenever 'if' condition
          is false [-Werror,-Wsometimes-uninitialized]
            if (rtlpriv->cfg->ops->get_btc_status())
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/net/wireless/realtek/rtlwifi/base.c:1671:4: note:
    uninitialized use occurs here
                     reject_agg, ctrl_agg_size, agg_size);
                     ^~~~~~~~~~

Fixes: 2635664e6e4a ("rtlwifi: Add rx ampdu cfg for btcoexist.")
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1726,7 +1726,7 @@ int rtl_tx_agg_oper(struct ieee80211_hw
 void rtl_rx_ampdu_apply(struct rtl_priv *rtlpriv)
 {
 	struct rtl_btc_ops *btc_ops = rtlpriv->btcoexist.btc_ops;
-	u8 reject_agg, ctrl_agg_size = 0, agg_size;
+	u8 reject_agg = 0, ctrl_agg_size = 0, agg_size = 0;
 
 	if (rtlpriv->cfg->ops->get_btc_status())
 		btc_ops->btc_get_ampdu_cfg(rtlpriv, &reject_agg,
