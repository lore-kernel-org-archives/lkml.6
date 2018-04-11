Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481421-2-2476354359232195024
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
    1523481420; b=wiINbwIEaBU7xSeRTU31EvzleEHofBBf7eszKHOUB5Sy6Nfkpt
    s42KPlKh+eCzb4/YfP8zZl1uQYR9zIh/cILm2Bs3lxx4emcwTz+ZhAnkSqNgTiqL
    MGIKxafkACwfrHg6PwDCtUmUFBuV4TIXf1b1N0nzSnd/fm8oVXG+FpvtJPlhg9xS
    i+orXaccYNHKXMxKL5OcJg1aUJuZAI16HBDOkvWesL9LUYd0m0TOgw4AoKi+qLUa
    kjFLr6LSS6T9V2BzlS1ksPC46jSS/YBjl4OIU4rv70dQJZhaQ4x9D1ztb8xKz5wx
    ZX2K+CGqGSSkuZ4lVa0msJafO6uf3vUVQmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481420; bh=pJ6nMW1thtDonpn+51OHq5mpFirivK
    UI1HJl2tJLR+Q=; b=QkCsJMQdvhg+22wqxWruWP8+kHMylzUfXmhlX9foKGVJS0
    yj+qoq5X9fz401e03lbKJ1IJadD/qi9Kng/Dwj6Et5YJd65PT74IoQsj6sd67AB8
    q4Xzt7opEXRxWMbe1mX4jF7CJc1ERuK44Ue7Ovcj0QOSyi1x+UkeH6DFtP55IKjz
    APNfLp44TNP+Qumi4WJlpObHjv3g5eoNTr0sneurZzlQDxFucooErtLtpvtpWXL9
    iMxSnkBzRUgqkkWFVpEXYePciCg6X9GUo3RxDRKVFOewyuO6gZQ6xHtv3xvfH+LU
    AvWRh/BeX3cENsEYLoI1MWM56ZlSVUwtBX9ds2Aw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOkVzclAkHCrESIUF3osg5BeYs/aBrTxRy1fHYhu59q9qPoPC/2uV94kanoOo/kO/iws+2zo4IHUjpqvec/6TRGUlfIwWfl5S47CbG481/S0XUCOM/6B
    B4GOpVUbf7Y6APBZthAA0IJyfTckG5/U+mkaBR6tkinORGdHCiii75/KoaskmzRSPGshoBIqFKFv2EGk/Qp0rhqyfrBseZg7Ahpvpt06GPzJJ9gpZ5Ac1T5K
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=isfTqjNbOI2PD3KCteAA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeDKVQs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:16:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbeDKSka (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 063/121] mISDN: Fix a sleep-in-atomic bug
Date: Wed, 11 Apr 2018 20:36:06 +0200
Message-Id: <20180411183500.072500032@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 93818da5eed63fbc17b64080406ea53b86b23309 ]

The driver may sleep under a read spin lock, and the function call path is:
send_socklist (acquire the lock by read_lock)
  skb_copy(GFP_KERNEL) --> may sleep

To fix it, the "GFP_KERNEL" is replaced with "GFP_ATOMIC".

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/mISDN/stack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/isdn/mISDN/stack.c
+++ b/drivers/isdn/mISDN/stack.c
@@ -72,7 +72,7 @@ send_socklist(struct mISDN_sock_list *sl
 		if (sk->sk_state != MISDN_BOUND)
 			continue;
 		if (!cskb)
-			cskb = skb_copy(skb, GFP_KERNEL);
+			cskb = skb_copy(skb, GFP_ATOMIC);
 		if (!cskb) {
 			printk(KERN_WARNING "%s no skb\n", __func__);
 			break;
