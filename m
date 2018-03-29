Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346898-2-2549920225187258535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346898; b=Fiq1INFaNi/Alg0qMLAZbJShjH2LnA1k2ELcGWgVDFPPhmjQNh
    hdAM1vtCczMGY6+irKR1SlwFGS+XEkEhLOpcUd8dPjgDTgTdFA8YSY3nPCnYNRr7
    NM00k2Eiu83NJQRWVBxGAEeDu7w5oFUGrotuWEUdpjY9fy/fO0Lu2JUWt7t0SLKK
    +onwKIuKLwe/cW9z/d2CfTHUE13cMffb+MwDayK8s8HOvh3KzitI+R1hoDhdBfx+
    67/Hl9qGqzTo0SWWOhElWtJ00n9UyOk8GAc7Cn1zKrl0+3XGzh0OWhwc73V0+1o6
    wHpQqglJ4QyUyqfvSkfFu6wVxQMPourGkzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346898; bh=ujGUzzvICLboNLsLb1o/LaXe4ISYlm
    /vzBKjlYJlumg=; b=S6226eF8mV0xHq2zo5ctzYM7hhKfPQtFS1rii3kPNIY9t1
    /ZDfpKharSH7apE6T0UIAQjXGpyryL3I7Va2B6lvrpqBy9AFlINMghOOS7uMX1gB
    9Tnn6r7B2q8F3UWfQt+mVXgXHUoArQDO3hwOHpYMdesu1QUhwS8/DO5PiVFmij+f
    07e8ngQt30++nKKv1d7wONHKhbTmmYpn5vYhwxDrIDQlBiOorUsEJOMS3EQZFbDC
    DT6M2te3GD/ZuXwId6RMkqDFx1R9MbHIdZJPktnWxHMY+ZtXyDoXoZrSng6+CWl7
    Ius4xJvRP8fv6HLur510BN5ql8Ae/Y5NLyo7eNxQ==
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
X-CM-Envelope: MS4wfDTitxvicUMBfq9TjtdpvqBq0WH7uqUd7LzZcAhxlWk2ukcJL4QbNj9hxOeVB6wIJ7/mIZ26ajDE5+GUbCZHAZS5LysdyqOUFDQrolSe2xhvd7vaZHAF
    AVIvchd38MGiUURFJrf94/nG3gwiH997eQ8bX782yFwK1aLVU/0nL80pdNDCacwx6/5mUgAFGixJ6X4XEfpWGn6sP0xDrdq6PtvPCQO2yUhuH3y2GrQhWnp+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=5obkJBC4009fAKjw8KMA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeC2SIP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:08:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbeC2SIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:08:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 15/20] s390/qeth: when thread completes, wake up all waiters
Date: Thu, 29 Mar 2018 20:00:51 +0200
Message-Id: <20180329175742.647123546@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 1063e432bb45be209427ed3f1ca3908e4aa3c7d7 ]

qeth_wait_for_threads() is potentially called by multiple users, make
sure to notify all of them after qeth_clear_thread_running_bit()
adjusted the thread_running_mask. With no timeout, callers would
otherwise stall.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -952,7 +952,7 @@ void qeth_clear_thread_running_bit(struc
 	spin_lock_irqsave(&card->thread_mask_lock, flags);
 	card->thread_running_mask &= ~thread;
 	spin_unlock_irqrestore(&card->thread_mask_lock, flags);
-	wake_up(&card->wait_q);
+	wake_up_all(&card->wait_q);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_thread_running_bit);
 
