Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804763-2-13352072265401155225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804762; b=qd9iMzR12jljLXwkEJ8+UatDZ4mkDCHji+LmIWHr/kljnau
    34L+9de2oJfG7CLeJ458yFO6dgNjwLadX0Rl6JMKI4ubsLUa4b86OQpBGOunnNQ4
    56YpZJWLLYwEimbQwP2x6b/O4m7iZFkv44zR96Ge6O/r97Rl70e8DTRyEwcWogO0
    Cilm9o5rs6ia3NWU9gTQ8+EQdPSAoxT8bJ6X0oOUUQyUecv3PAz0eW6Sj4Pj6Wui
    j4QEDN4F4dJXtH6tSxCQav9a3DIcAqGLh8WJJpxPusql5ttxojXiX0/qFwK5Z3Hm
    XJLIlvaKyZGV0JC989fhlarMpt/TCCj5gjbvaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804762; bh=ujH0HfpOkYjtEZC4O+cIP0NPZf
    mtjqMNLMXnd7Y8ZoI=; b=KQ+OyysZGl2C6zQePytLuiMbiRzdQO3pBf46W+iePT
    V0ZPQ0pZKpcb+EZUhgSekSjoF/L6MGKUyAqT3MAZXmFube03bmzNHkTcNd/jdrUv
    ee/lc4ILtfjSwF2WdwJTK3AHDehd7fOsbs264fGslND/yKgmn4GMf0Kz9GKuVtMD
    KJcyMUPSd2YYapftyVeq7m5q6THkfeJLWb13iwpPH9MjHktLsCNPZ/5rBWLqJTKU
    yUoRal6GkYn/zZdLtqBqiu0R/fdj2hoQGIPhW0AZAjMRSf5c7vzuhqBZUR+VbcyA
    Lh0RFHqLoCJRtoC1fc4UER3lv022nXwctzvbsQzBRC9g==
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
        id S1755103AbeCWKFw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755101AbeCWKFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liad Kaufman <liad.kaufman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 031/177] iwlwifi: a000: fix memory offsets and lengths
Date: Fri, 23 Mar 2018 10:52:39 +0100
Message-Id: <20180323094206.550726900@linuxfoundation.org>
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

From: Liad Kaufman <liad.kaufman@intel.com>


[ Upstream commit f4d1047914ea05e0f8393944da18f6ee5dad24c4 ]

Memory offsets and lengths for A000 HW is different
than currently specified.

Fixes: e34d975e40ff ("iwlwifi: Add a000 HW family support")
Signed-off-by: Liad Kaufman <liad.kaufman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-a000.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-a000.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-a000.c
@@ -65,12 +65,12 @@
 #define IWL_A000_TX_POWER_VERSION	0xffff /* meaningless */
 
 /* Memory offsets and lengths */
-#define IWL_A000_DCCM_OFFSET		0x800000
-#define IWL_A000_DCCM_LEN		0x18000
+#define IWL_A000_DCCM_OFFSET		0x800000 /* LMAC1 */
+#define IWL_A000_DCCM_LEN		0x10000 /* LMAC1 */
 #define IWL_A000_DCCM2_OFFSET		0x880000
 #define IWL_A000_DCCM2_LEN		0x8000
 #define IWL_A000_SMEM_OFFSET		0x400000
-#define IWL_A000_SMEM_LEN		0x68000
+#define IWL_A000_SMEM_LEN		0xD0000
 
 #define IWL_A000_FW_PRE "iwlwifi-Qu-a0-jf-b0-"
 #define IWL_A000_MODULE_FIRMWARE(api) \
