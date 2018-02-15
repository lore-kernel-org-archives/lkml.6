Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518720162-2-18359034182874913456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720161; b=ajuo4MT7JOP8mFklTzWQbSTHbnkMM4ubg8lZm7dRg2eCppY
    2rj9dfO6atAH0YXRui2jQVOeGuIB1ke79ZoP/I2zBwitQdwqKtdrSGIj3a05viqC
    ZYYeOOZ4Zl2TnF4uji7I1wrths8NXo9BGK7FUDVt5QWgcFgH47Ul7LY4jOa3vJhX
    m7NEc9pCDLliQRtO5rKZK/jMhcl/rGgyQyR23FDjEaxAD8wM5DPYYtZuMQSU1fX+
    5RhCnQL8fCcTWToNw/onN0ebTX+8tmb/ifS/SREzcaAlmNbL023Y0EENLEr/KE2F
    MtMd2hDkyzTO95JhTZ2xaOB1xb/X1PNffz8gLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720161; bh=uQ476OrKTi9MVc83KG4IsvXV1u
    I307pYjTjnm5Zvh88=; b=hH0Ak48TJVXIofb8zZQlotDhcYMY9KSxg4GHVwdsVv
    AzMQZDof49SqS0LmyBs2UFTFeN1E14rUd3QP6DDDG/1Sp0MUTRNQZyUdtTR+7SQ9
    Ldu+qY3rcjcSSY13spZs4elXRhg5G8YaUobg/ije8Go9D9oM0rVW5hXxluv9dGgF
    8rHI1qQaDiLbqI8TLlCflo741XU8+39ED0Mys96ybMKWAaeVjuFUp8SXxCwCTHN0
    N8Z9aHB2TRWMcZtMmjgeWawCpU5kc8qf5PoOTJEtzTHXzK0dPdLY9tjTm5/lR94W
    dxERwN26ujPlgMm+vwGrQtRCS5tVlSQyC4MXIir+Guow==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162709AbeBOSmZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:42:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162092AbeBOPXj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 066/108] ahci: Add Intel Cannon Lake PCH-H PCI ID
Date: Thu, 15 Feb 2018 16:17:03 +0100
Message-Id: <20180215151231.612003587@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit f919dde0772a894c693a1eeabc77df69d6a9b937 upstream.

Add Intel Cannon Lake PCH-H PCI ID to the list of supported controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -382,6 +382,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
