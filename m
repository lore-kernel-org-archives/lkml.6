Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163165-2-3565348588419507573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163164; b=UkOgYGfmRYs4BTxMinVN5OrxcCYI+p/aPj9Zk6l9leWRKZWMhj
    6PmHyZa1fLirkdPJlT8PvNzqaiJWF+8ukXydQXTERGId925bKmnPBLMO6cGBjmWW
    cNXQVMuRfRGICyeliLzomhu/RVFJW7XR0/GjVb6QBfIlxy0JCBuXRwqXc6mLztzA
    BvcUqtB84cPAmGGLzakl7+kyQ78F6T6AyDYgmoooSrSVkGOEZy+6W0ypSkqL0pIA
    C8j6OW+QgcSdF4I6WULzsP5UWB4Y+CSiiFwsmeE4z95RihRuwF1OxvRkmls1ECMz
    zaiBTb0/2KxRjKdTOysqfmyUOzfYjshBVHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163164; bh=65ysozgfHi9HEUWy+lECQ3E+hEE4QN
    B1PV2ALSoDh4U=; b=hoQ5ftZZb3KAVXVBsLV3gRSs2n6VqBQmi1LLQDg84zBKfw
    r6svIvfYkw8zQRUPLyj5b4GnlrK+AZgya37bWkrAyAH4tiYcnpTCkQL/3gXt2DSn
    PD6UDHWZ5wnt3rhVlrSWTBlaWWQqvIdyQkfP0lA9RB3jnWmohAQfw6FqslHaAP22
    X5V3JrdhcJlF3aOGxX3mzC/hGWXTiVgX3YIx9HLrn8IaU1hpKGvnV8uj5h7VF7Tk
    dyXxo0i/fGuJQEhM37GDVyRjLpDeHe8QrtjsBIm/U4eJ15Pj7lLs8+ONJtL63dDP
    nMb8xoRRhkTjzUwdB59VMvuax4TBBkWTGvacmH1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=h6s4ZNs5 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=h6s4ZNs5 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKFG/dkhd8m3KgO5u50W37rFPRNqnxYjziPXtWG06G5NxoOfIUO9tuzre64IgsYtYG2wKsfiTZYqwNQsFsu3DP7lV7J3FWVdwG7oXx5l0Ra2GUnTZdoe
    mOrxnIfJxrcd5uinleZ2P2XbQ4EhE+dN2I4nf7nJ25sQlNBGlI29RjiwRFgOciznxszpXaxHpezBYDu18mHKxcfvI/Vr5OmVGQpKzMqgYBa8rGNiud0XYmsv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=0-W_TZN3pwaZvg6FliIA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966764AbeEXJpS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966756AbeEXJpN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 60/92] s390/qdio: dont release memory in qdio_setup_irq()
Date: Thu, 24 May 2018 11:38:37 +0200
Message-Id: <20180524093205.063361246@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.ibm.com>

commit 2e68adcd2fb21b7188ba449f0fab3bee2910e500 upstream.

Calling qdio_release_memory() on error is just plain wrong. It frees
the main qdio_irq struct, when following code still uses it.

Also, no other error path in qdio_establish() does this. So trust
callers to clean up via qdio_free() if some step of the QDIO
initialization fails.

Fixes: 779e6e1c724d ("[S390] qdio: new qdio driver.")
Cc: <stable@vger.kernel.org> #v2.6.27+
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_setup.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -456,7 +456,6 @@ int qdio_setup_irq(struct qdio_initializ
 {
 	struct ciw *ciw;
 	struct qdio_irq *irq_ptr = init_data->cdev->private->qdio_data;
-	int rc;
 
 	memset(&irq_ptr->qib, 0, sizeof(irq_ptr->qib));
 	memset(&irq_ptr->siga_flag, 0, sizeof(irq_ptr->siga_flag));
@@ -493,16 +492,14 @@ int qdio_setup_irq(struct qdio_initializ
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_EQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO EQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->equeue = *ciw;
 
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_AQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO AQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->aqueue = *ciw;
 
@@ -510,9 +507,6 @@ int qdio_setup_irq(struct qdio_initializ
 	irq_ptr->orig_handler = init_data->cdev->handler;
 	init_data->cdev->handler = qdio_int_handler;
 	return 0;
-out_err:
-	qdio_release_memory(irq_ptr);
-	return rc;
 }
 
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
