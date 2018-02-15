Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719474-2-11797735256240426250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719473; b=md8/dFgdGKo295W3K6n655YrdkqBmPVNZRR4cXeI1jFshuP
    MJPCV1niZL4UzDQ7IM4L6puXnHwJUhEqx/x++j8/zNtnRDq60lsVi7/PwVGX7eGq
    fGXLZS0VtYFWPTmIAtS54NRT4xM6DhmeddK8KJHYt4x8mtmXZYk/QdJgL2mkUEjG
    qNQXyKTj5vLx4dHxIYWwLBBgONj6sb+WcFowTCIyA24xv/Hgzs+e+V6eBW9DFTmj
    H9Kxzec8xxZnRGul5GJdnboeWkqmifBLWyOKguqlXOteJEa1hV9I9WueXDEEVZhY
    gvq7mSvlVKQWczUbTSmv3ZVjNRdlqfDX+1+uFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719473; bh=BhHvgbBpUzBEN6gJL5JMJ/ZJ2s
    kbvwrLEGIqlHPd+Pw=; b=VEDny8bOdfTuA+pGb/rohv9BxQTRNKv5FwzT90/Lb2
    /YaPHaDNQxgi7obKjYhYkXQw1Orwb8vsx4KRMHJm/rW5Clh0yLCL1Qx1a/vgXeGV
    pYUqBFxM7fYaejnP60c3TUiAVLzBl+MTlQIgrbfLEOLY6QrDf7HdEUD8y2XDJdCZ
    vjbGn5A+nSAp4CrCra+XVUvWOz9wcJaGAfJVYwNuwvKpu/rTbgjuMoDkxCFOWcqB
    P7AwAvwSNihEJTCTAm/zRwKfR485rKdZmR6RBGyolbiuHfxyTqQtMvaNzEWU+ZEf
    HHV+PnCFXfOnySpp5II5deLQwTJHcTxBz7Iks9mDO+BA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163175AbeBOSaz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:30:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162990AbeBOPZH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Qize <wang_qize@venustech.com.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 105/108] ACPI: sbshc: remove raw pointer from printk() message
Date: Thu, 15 Feb 2018 16:17:42 +0100
Message-Id: <20180215151236.910149177@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 43cdd1b716b26f6af16da4e145b6578f98798bf6 upstream.

There's no need to be printing a raw kernel pointer to the kernel log at
every boot.  So just remove it, and change the whole message to use the
correct dev_info() call at the same time.

Reported-by: Wang Qize <wang_qize@venustech.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sbshc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -275,8 +275,8 @@ static int acpi_smbus_hc_add(struct acpi
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
