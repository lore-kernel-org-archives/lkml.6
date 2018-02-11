Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325231-2-10280509748916461971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325230; b=CmDSTQWMLyCQ2aUg08/du4IztUIiIaY+C3d8THCWegCJ6BC
    HSouL8PiaUMrhvm8I/J92urg0K+rbM+m+yhqTAj2ribTZosbYKfB36CG1VbqqyeF
    BYenqvSVm1u/qag+m/gFAQfoUW0UU8qD3EiIG9dvV8UjW0kGy+Qstr+78g+gLFyK
    WinO4WRCXA7NO6wtXfnfk0LJ/kH49uZAIX+VLb5D2rjmLG1SRsunZgv4iskDXJJa
    xzUDHTnB3slJguhqUNnYTeEWBp3cE/VB3XHb8VgizhbdfPdhz2VvkrFj8HZGvyo+
    g3zrJd+Fqt5BrT7MhGbp5YO+TDaHphe7zgFK4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325230; bh=bUkkSMNVy68vRVSG092
    5cycVuKH2KrSHsXOtMgTUZTo=; b=gEVrTZLgpLIBO7CzqGnVfIJCsNnEs7bj2cb
    +zu6RuIKhgLo/Mbq+B4t7/1fvMnqTEZImotySazPr9FjOoF9ei0Vl1Cnrgn+NckV
    myr+bpJiDjAxZ2bOCvd3jVrL/IgEiixU9LibOUVaggUJq1mvy5YTNYd+NkYeQIez
    iue602BSuOodpETKZSnxzZp2+DIF3BF1TntV5sKhDRI3Ve68qlaDE3gmmFlKHLBv
    e6x63J90Pc5UWx6RgukuuVGSKwKW/hkJ/s1Gq4cr3ga4mmHfMFnmFwfaEtwN61+l
    1PvDNz0x/mle6EnA5sZZqDrCQF/Qn+Pw//Y3vPrRAbJWGT9rp+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeBKE6y (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41659 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752774AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Weilong Chen" <chenweilong@huawei.com>,
        "Corey Minyard" <cminyard@mvista.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.183683521@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 004/136] ipmi: fix unsigned long underflow
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit 392a17b10ec4320d3c0e96e2a23ebaad1123b989 upstream.

When I set the timeout to a specific value such as 500ms, the timeout
event will not happen in time due to the overflow in function
check_msg_timeout:
...
	ent->timeout -= timeout_period;
	if (ent->timeout > 0)
		return;
...

The type of timeout_period is long, but ent->timeout is unsigned long.
This patch makes the type consistent.

Reported-by: Weilong Chen <chenweilong@huawei.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Weilong Chen <chenweilong@huawei.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/ipmi/ipmi_msghandler.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4007,7 +4007,8 @@ smi_from_recv_msg(ipmi_smi_t intf, struc
 }
 
 static void check_msg_timeout(ipmi_smi_t intf, struct seq_table *ent,
-			      struct list_head *timeouts, long timeout_period,
+			      struct list_head *timeouts,
+			      unsigned long timeout_period,
 			      int slot, unsigned long *flags,
 			      unsigned int *waiting_msgs)
 {
@@ -4020,8 +4021,8 @@ static void check_msg_timeout(ipmi_smi_t
 	if (!ent->inuse)
 		return;
 
-	ent->timeout -= timeout_period;
-	if (ent->timeout > 0) {
+	if (timeout_period < ent->timeout) {
+		ent->timeout -= timeout_period;
 		(*waiting_msgs)++;
 		return;
 	}
@@ -4088,7 +4089,8 @@ static void check_msg_timeout(ipmi_smi_t
 	}
 }
 
-static unsigned int ipmi_timeout_handler(ipmi_smi_t intf, long timeout_period)
+static unsigned int ipmi_timeout_handler(ipmi_smi_t intf,
+					 unsigned long timeout_period)
 {
 	struct list_head     timeouts;
 	struct ipmi_recv_msg *msg, *msg2;
