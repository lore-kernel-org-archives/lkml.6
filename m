Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415360-2-12762285977081614459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415360; b=WBPMUK9H+tnkxExPcAIS/m9Cz7fcCTUzxqGFOT3NJ0hItg/
    48d2PdajIBAEMWDoN6GIXVz9jgY6vIqCIKcYAA/uWWSrs+zq74Sq2p266L/D1XtB
    SFnAjKjtMatE3FBaj2XMPbw4MqZaaPwvsXhc17KZOUsTjyH436yvbVCalb6stOA2
    qiI5kOzwpe8y+TDDrpiPnglDiHy7QZZOA4oAYBfN73vOs45Al1IU3PgHUmesvy5s
    nBrYiSdMFbb3B47Uw+Sdh2IfLaG19VTZR8PRAN1af8nG6UCTKghrjWg/Wo9v6tQP
    nn8t3Zoyj8Y0VKK+l/eSEpWmYohK6l//QmQMhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415360; bh=uCRi4JqyCVp+WEdc/JEQSK6eAk
    YR8mVmkJKkku2BdGg=; b=GJ3NmMnXXn+wkFLlWF3AhGGwDNBtfErw8Wd8k6T8M8
    bATtwQOa7h8k5E6GW1BYNopAyySfv1SQOYJrOlarJhQrqX+lJtGWasttARU8LIWq
    zpmd0K8aHDDWCweeQd0A5ucaT5aQH13doANo0ZbjFDElXG9Mx4jCL6pdaGPcwbDm
    MzyqOuJIW0SOvfnhkzCqCAdUNJODVg7odcGaFYcZLB2Wlzl0Mbqguf7HUqUnHpWJ
    2zFo0AIWk8jH/83cMhhAjs7tubR+qVpMUHr3fnf7xgmZ8xD2hRJpPoUy5SrQw5aS
    q+nOTUhJj4i5CHsGKu+ls1XRsjNXF3sY3KUHKWtZOCIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754828AbeBWTtD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:49:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934061AbeBWSqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 103/145] scsi: advansys: fix build warning for PCI=n
Date: Fri, 23 Feb 2018 19:26:49 +0100
Message-Id: <20180223170738.147112312@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit f46e7cd36b5f2ce2bfb567e278a10ca717f85b84 upstream.

The advansys probe function tries to handle both ISA and PCI cases, each
hidden in an #ifdef when unused. This leads to a warning indicating that
when PCI is disabled we could be using uninitialized data:

drivers/scsi/advansys.c: In function  advansys_board_found :
drivers/scsi/advansys.c:11036:5: error:  ret  may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:10928:28: note:  ret  was declared here
drivers/scsi/advansys.c:11309:8: error:  share_irq  may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:10928:6: note:  share_irq  was declared here

This cannot happen in practice because the hardware in question only
exists for PCI, but changing the code to just error out here is better
for consistency and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/advansys.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -11030,6 +11030,9 @@ static int advansys_board_found(struct S
 		ASC_DBG(2, "AdvInitGetConfig()\n");
 
 		ret = AdvInitGetConfig(pdev, shost) ? -ENODEV : 0;
+#else
+		share_irq = 0;
+		ret = -ENODEV;
 #endif /* CONFIG_PCI */
 	}
 
