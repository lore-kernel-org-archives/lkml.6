Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838061-2-6877996185290851135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838060; b=Rr7782JoapSDxuEn2z2LmBbAZErLPeEpfXGeGHNxgtkQHMH+dk
    RqJaitgxXVw6fKKVcLBAlNMiBCdMvhleaN0VK5JvfNasJl0ZNeMc3kZyslK9e1lX
    yKJws+gOrh4S0rb/s3aa4f3tTL24wdAed4l2AfAw/CJ9zy+j3OZ7iIZfsjgfSbat
    hcioicfUy7lV4oOjFJO1g6Lrx4LkeOEPyKgsmwUvJxyHzqcxVusd4TiaH8SzCHVE
    ofy1EK1O7L8btMF9O1vkYbnHg4dnMgJxwIlxXjsIaGtqbvux8iCFWd2cSiOUO6JL
    lKZ03+Ln0hPHhKZ9mI2LFauMKbJVWpPRdfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838060; bh=dHk0sLviJKJ0961ZpxQeGwsGquCY31
    AN+z4ACt3y+js=; b=G4RAFWXHINRMuqb4mF3sPACdyMwF29odnEJuLF1cDhmEy6
    r7cB7YDwa5Zbwx++/vxriaXbzqXN0o68RA5UQxLhuAs9cGKy1grPmeJm2ZHWwjjP
    YoHLqcGvIh9/bbHX1MAqeGDQp2fF4zlR1i24Q/xn3tGlxyN6q+iYZA/qvVUwRtjm
    TLgsMFK3Uk5yZGcgDLCxV1Gd8U2j061eKSjrrv23qIjW1DLoeHclx6kZYQmxt8EF
    T7WDbOSYFvmkkqukot/+gqbfuHlbhcUF7bFTdB6+5hhqqUDWM7ZVStHIQRVYZL3P
    8bxr+lqAsktbxwmMkn5tsnowHCBvTzls2BG98LkA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOJg2Em+T+FimX/HYlJEWt0aAW7S/XDeADgYnvw2e+0JefIIkaVFNkuG9HAGuHBHX1VZi4k3gc3pzk2qJ6iRRITaAyEPYh2TJtpG7XW+RQnn+uzCmuBX
    aQz/DwHcHFZtWm77dxQSR1M0AbaW8jIrZPkD9/Z65tl8Q8pWgNkKNR2JMr+ARsQDv10BYHze/55nTHBwB2AW824l+V0w+LeVvb+itQY/WVLk/H4c/PKU7RWd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=A7XncKjpAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=NXPcQGchGuLSuwl_YqQA:9 a=QEXdDO2ut3YA:10 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934313AbeD0OHe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934306AbeD0OHb (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA18218C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>,
        Yotam Gigi <yotam.gi@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 35/80] net: sched: ife: check on metadata length
Date: Fri, 27 Apr 2018 15:58:28 +0200
Message-Id: <20180427135734.747464797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit d57493d6d1be26c8ac8516a4463bfe24956978eb ]

This patch checks if sk buffer is available to dererence ife header. If
not then NULL will returned to signal an malformed ife packet. This
avoids to crashing the kernel from outside.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ife/ife.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -69,6 +69,9 @@ void *ife_decode(struct sk_buff *skb, u1
 	int total_pull;
 	u16 ifehdrln;
 
+	if (!pskb_may_pull(skb, skb->dev->hard_header_len + IFE_METAHDRLEN))
+		return NULL;
+
 	ifehdr = (struct ifeheadr *) (skb->data + skb->dev->hard_header_len);
 	ifehdrln = ntohs(ifehdr->metalen);
 	total_pull = skb->dev->hard_header_len + ifehdrln;
