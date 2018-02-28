Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836581-2-6804176223862848274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836579; b=JEr9K964tZzfP/jOU+2YGntP2+C2zakgjQ7MNRGtIdAC5P/
    xqqbHqUDZpGklHp28ZnJqeLnvN9tj2j/ByRtz7FrZ7dyDDZFqgeEkSheTvCJ68no
    HIKgP9sQcC1mh2hxdoxn9RnRnwVvvGFlpTim/T+WJRpfma0Bs5pFvm7DM6h804yV
    e3R5iuk++fyWQFtclQtAavsHKZDhu+aP6QH9ko9b3a8340kvpTW/GlrEnZlzERig
    txrI5x/AAK/yywxPPzZ51AieMeSJ4cJQQBHu+LAkRe3i09+gfeyQM/kSm606HGcF
    I1xTYHMOAgX09DFxT4m+gdShc1MInJqSIL13Xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836579; bh=RommifVPZff5bHXTCAN
    UKA+F4H/oN1Zn7QveTZnCDjk=; b=GYDQEJKMwFfy9xQ4NTW6eUupZat09a7wxWx
    Uv1ANR/1Fj6h8PWy8ks6QehGgaarkSJLez2IjyWNuTdQZBI9+BPwN5kFoPdUsM16
    ocLJWi6k3s937twprYQd2irJ9JMX5h7th9t6MgXED26h30UfrVfHTt8IFo/NHiq2
    Rx6BOWTi2jiFGaUf0XRqNS/urkapfzZuE21+uOtDCnoBpBvpJNmBH2IWcmkNWA/m
    dZD0+3gzj9sUUG2BQYzJLk/qF2T/rKFCWlm/C5vyr38BUveW2g/X8MtcWNPwI0Sg
    aNycRD3+UU1CE7Mx3JbiSxsp3GpWagR8+opAlxvXVvXGReYwb3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbeB1P6p (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34574 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934277AbeB1P6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Wang Qize" <wang_qize@venustech.com.cn>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.494351907@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 253/254] ACPI: sbshc: remove raw pointer from
 printk() message
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 43cdd1b716b26f6af16da4e145b6578f98798bf6 upstream.

There's no need to be printing a raw kernel pointer to the kernel log at
every boot.  So just remove it, and change the whole message to use the
correct dev_info() call at the same time.

Reported-by: Wang Qize <wang_qize@venustech.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/sbshc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -287,8 +287,8 @@ static int acpi_smbus_hc_add(struct acpi
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
