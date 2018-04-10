Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399810-2-1006683944272206915
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
    1523399809; b=ug4uSxEws3JcHbODJCAautVe7cytJWqGaQIy43Zz6vmQsLMLZ5
    b5RdeZ9VPiAsM7SzeZNQMzGURrE8MZNAHwiQsQAMvHeLCQUfdS+9JwHByF3YHFom
    jqjQ5FgYYQ6/IJ0gIhYM194KXifGP6Lg/E9wIavVaqjcjZmtkdmQ6Ojh7Hrjatww
    mOgfXNz8LiXXBVj6ItFLC6jRd+fCT80c0aEkAvNSUzfROBOKtD5EZ3r7Nrog89xp
    AGK+RB10JmvoYBBpejOrH3n+MmE4I2E1i7d+Ro2zS5ea98STDvQ9wskx5ilbMUjT
    2JgxyQiYCnBO+c6zKZFtc0jbGAX2UWjNGyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399809; bh=BTX09JlBxOfbpnb1nIZn/CYpFeifqy
    x/60RRl4LOPGg=; b=CoOOBW+Cm82nX5t4d9DHXawdWeGZoI3JHSmvVEgaVgEbMm
    OS2kaWoyUlvUGK8ouE4dS6+0Kl3ZdQE6dUs0i9jPzeilneiYILgYEU0aqhVfejZr
    U86U7O718VBUe38kJTyA7Do0az6lKKpX9x44GFm7QEWn+mwLyXR2rlxI2MPkJq9a
    u1SOsBurlXmCICkV6Av1q2Z0WF/2AuheNqYWoozmrspehAJ5QxpH5yM201RJxRo7
    mbLmj9/aqXo38IZWI52Hcu6q5j0kWJaUZcUYuWg0tMj8PRCiAhFAToiR5gp7zFOw
    QMLFD0YU2+TAXjIuYH9nG3CWUVxJFiqiUhjJvDQQ==
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
X-CM-Envelope: MS4wfKgA9T8tVl5KZYEybfW5cU8ycLQ+KJM51TLiPGJev6adp5Kqu/nb7avBM4ZNZMRNE8GLRHHKPV//f9O4N67UmiquQENxoVwTRbJaKTRjNYzcE55nlx68
    umB9JXmtw2tdt7emw2WqQAWhxzgn/f1Mxg5IeZ1lVMQ7aovSyMcRwYorJpyCmS+3LSG0puiFFLMzCjwrLqOZqf51v9gyaOzTCOB7d+6l4B4BD+OPG5BsjPJC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7Mgd0HYs9-wA:10
    a=Kd1tUaAdevIA:10 a=DfNHnWVPAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=u-OqrgWLNW3bRWNzbpcA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755676AbeDJWgq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:36:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbeDJWgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:36:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 051/138] wl1251: check return from call to wl1251_acx_arp_ip_filter
Date: Wed, 11 Apr 2018 00:24:01 +0200
Message-Id: <20180410212908.028690354@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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
