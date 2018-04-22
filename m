Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408223-2-12935608238764263505
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
    1524408223; b=JS5fk4lnyvApCdV8FHpvQ9mLJt0kMD5Lnd72NqZVTftuzuVhHt
    Rebm3kT+8X+F7iNRNuWvsffBZzC0IgmfGxKWqV8fuOhD+utuOTlHdEaxI9Af7plu
    HsPms23cEx0L0MOui7U6sM3rtuwK5cU82hTEIvjabmxiaTOL7NZQsvsi2p/N7d3a
    clp7phu1ZUJC7mdDRkd/y99o/YZaRJdy6ivmkjM3xVf5XkTu880lu3fKgpQlmgf8
    HRR+wfa7ZDFRkOcUKjqC44gnUbRBH1eBlSAwlG4PXLDAkyFsAfyrSFvMjexwu2iI
    wMFWHE2eXoJBopC9eTjsb23P1KpqtckI44zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408223; bh=Gr52KhL0B6/h2oUOTRfj7MKQnetlIg
    1itW08YmlxQ0M=; b=hn39MVE6TtQNv1AphzrbK1XSgPWCXjG58GapNUimxZE79/
    JH51dmzD6uP69juiXVAP/wAETevF8J2UsTXosAhTxE/AuOd7qQkjnr/vQIbiZIBw
    0GOHMSblGTaCkdoNZsCkIvJQt2abEMoY/2yRYCzXuIFTWngWOEPEu2BD0nFfXaZc
    RpxuPaIDavjDv6hV/R5zC3s3e2j6cvsXUPKvayncpRnusx4SfsPhgMJfInZgI/IU
    BmLHTyd2EwBBzbQ5IKQvErPTr+B+Ujt6sL6lV1LQDtPfw4RH7wU9cmOPOlg8lgMy
    VstK4o+x/J6t1Da1msSicaz51lmhzo2uKMJJ5h7w==
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
X-CM-Envelope: MS4wfBXL7RfBWWAK8X1JnoI1zlnC8d4OlzHquEH7VYJKh1i4ZTJb7SAp3y7dy9E8kYeuirMMZYY0MCAYgNYlXQNXD3If3KNqAnBLzzKJ/8Ahk/eyBNdlJb6L
    /GAu/NmHkGUMaLQMeCjU2lP8Kd8oIrow2T+wj5vnoE60DJ7IROk9RZvkecBeZ6xhiDyPbeuEMdYK10GYpSoGKMG6RHboHahgHYjSmGNUjgepECkWQYBBGCrL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=b-S21-GUswmE4nkRrQ8A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeDVORP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeDVORJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.4 46/97] thunderbolt: Resume control channel after hibernation image is created
Date: Sun, 22 Apr 2018 15:53:24 +0200
Message-Id: <20180422135307.880943911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit f2a659f7d8d5da803836583aa16df06bdf324252 upstream.

The driver misses implementation of PM hook that undoes what
->freeze_noirq() does after the hibernation image is created. This means
the control channel is not resumed properly and the Thunderbolt bus
becomes useless in later stages of hibernation (when the image is stored
or if the operation fails).

Fix this by pointing ->thaw_noirq to driver nhi_resume_noirq(). This
makes sure the control channel is resumed properly.

Fixes: 23dd5bb49d98 ("thunderbolt: Add suspend/hibernate support")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/nhi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -627,6 +627,7 @@ static const struct dev_pm_ops nhi_pm_op
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 };
 
