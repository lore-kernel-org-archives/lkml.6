Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473256-2-11464773589265487629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473254; b=e2p5Z7mUt28pVsngBHAf8X/qwGXad4QGvyq0UYNsRw00aq0fRG
    oVzmt1zTssZ7MIgoULRndI8VzxRrFdWgkW7F6CaQOQnAWfQM/gIBJNh529/u2ZtR
    wBqh795ofwONQ8qkhY1oc2hT9OVd8weJPqa/zrCOSatiD+AsGJzPDYQ4Q5cRYtH+
    rRYqB1klDOEDrWNuZa97s5EvJ+ooPtpp9PKFkJEr+bnNennY2gzYlxLlTIaXwaS6
    LMG0lqs4eFExHD/RQuTa6t964a4CGQOfyWqgIv3Qz+pPWzQx+3dH0JfVm9TMitB3
    c98vCACf2alMWvg+cB9YbMvFb5P7cltPcAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473254; bh=GBOgHfSgXDXZ9czKe+uNFNndSygq9Z
    N3oEYKcKkp0JM=; b=Hx5TM8oB93gkegPCHriLasLUORBWjPzCn3nB6FcM8BChL8
    mBAxvu/YlageNCJOicM/eFBrtFXmrabp5BSi8/nnuleMclRBjp9L7Y4+BEMg8BpI
    ohfLu2zO6dEc9jGD4KmN/diSeNyjzD180g7o/NPWiFAIDaChLIdzN/V8MZ0CuKCM
    v9yk4ManxOhguuqVz5xsypfaSRCz1zdUGXneEf6Waax5+I1ulkKOhoaN3gu6GNLa
    Lq8eQEpix91hkIsUYtRmOEloTtUAcKAriDP7UxzolSUsSvh9P9Cxd7wt8iB/FLaR
    HQPk0vl+7WQV/wRyD37cOGGlYuvRyoqzBSVHL2AQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL729e7jUcQasjQzbS34Y3fx91rzGGtn+xPP+Uozyfqxx5sl5oDdCV5Ae2VVGJ7bxrAcbhmageFUuk/XxKdawx3cx/K4Fc+QMFo/Xzhr2lceg2MZGSq5
    zYu0UZm1TDlVCOdhj+AS03gjI4u9IpIfmpTHkLxwvO2H5lcugHJcQrjgsQPULYu2XmBoDCY7t8iXqkYHCJ/pNRnF9R+1cwm2/fVg163e/D1SMU4GkYNcgt0Z
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=nn8tuMKtRf8A:10
    a=Kd1tUaAdevIA:10 a=DfNHnWVPAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=u-OqrgWLNW3bRWNzbpcA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756795AbeDKTAt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:00:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756746AbeDKTAr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:00:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 147/310] wl1251: check return from call to wl1251_acx_arp_ip_filter
Date: Wed, 11 Apr 2018 20:34:46 +0200
Message-Id: <20180411183628.761240766@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit ac1181c60822292176ab96912208ec9f9819faf8 ]

Currently the less than zero error check on ret is incorrect
as it is checking a far earlier ret assignment rather than the
return from the call to wl1251_acx_arp_ip_filter. Fix this by
adding in the missing assginment.

Detected by CoverityScan, CID#1164835 ("Logically dead code")

Fixes: 204cc5c44fb6 ("wl1251: implement hardware ARP filtering")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wl1251/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1200,8 +1200,7 @@ static void wl1251_op_bss_info_changed(s
 		WARN_ON(wl->bss_type != BSS_TYPE_STA_BSS);
 
 		enable = bss_conf->arp_addr_cnt == 1 && bss_conf->assoc;
-		wl1251_acx_arp_ip_filter(wl, enable, addr);
-
+		ret = wl1251_acx_arp_ip_filter(wl, enable, addr);
 		if (ret < 0)
 			goto out_sleep;
 	}
