Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806001-2-5087811178412928765
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
    t=1521806001; b=gm80SxzvGOsMTtwQwIy0WMcqVNJIKJsixiMera8FnHEmmHZ
    23pfHfoXLkdAJHhFfCjvvnfsVHzLPCC+K3WcHLbu5YKK40phbhOGSRnZzdRt1eQr
    U9LrtlxHeUYV0a20eydFmXZXnwbz/32O0PErL/9ESqdic2Tjj4pstuKsHgD/bbAq
    L3ubPzCMb3i7tY9hw+KEgHX6xsT9cwvJteV8N+f9I84Yj9MlQWjn0ekuzay1rZ5m
    yjWIaiXf1u3GJZqZEBFR/rhzcvw0F7+g4kYwFGsKAC+9GgqNileNCIpwaBkSL072
    +Lp7Ex+B2I2S3cgbgIbkPHUkZJ+PQRdjqFdGXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806001; bh=/PNrrlgUaKc47CmUhg6ir/GZzZ
    pJ4QK7lUMRxfpDWe4=; b=KE0hbx8MbbvHBDRYLPbD/znwHeuZTstX6ej/ym3Fup
    kcshqQ/t4K706ECuzvmbUcX7eMDdUelIcGNNfBFFU4FWRufaShZjvovMN32by13U
    Vv5bOZJ2PjU8md8XnSPyPG/TtXpk9rBNMY3XVdLCufHcUMGUcSvntdyd2RiTuFfY
    mGujnn0oe3xbke5qiB4rm42NQVRxhO1hYyDNXsdxPppkVWvVI2ofSi4TeLDyetD/
    noI3TbydoE1OB6+2cAtW0RJtqvsOAKS4PcUZjS6HmE4+5QLsuhRsdlGIjWtnMT/x
    gXvPqFATmtvaEghQXVbUPBYvG/4Y6EJehzmjoT8sv//g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1753988AbeCWKBt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCWKBq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 14/77] rtlwifi: always initialize variables given to RT_TRACE()
Date: Fri, 23 Mar 2018 10:53:48 +0100
Message-Id: <20180323094143.177548489@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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
@@ -1664,7 +1664,7 @@ int rtl_tx_agg_oper(struct ieee80211_hw
 void rtl_rx_ampdu_apply(struct rtl_priv *rtlpriv)
 {
 	struct rtl_btc_ops *btc_ops = rtlpriv->btcoexist.btc_ops;
-	u8 reject_agg, ctrl_agg_size = 0, agg_size;
+	u8 reject_agg = 0, ctrl_agg_size = 0, agg_size = 0;
 
 	if (rtlpriv->cfg->ops->get_btc_status())
 		btc_ops->btc_get_ampdu_cfg(rtlpriv, &reject_agg,
