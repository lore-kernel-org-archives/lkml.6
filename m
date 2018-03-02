Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519987092-2-12413626858509089439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519987092; b=YhXs4umlRxbPFJe54ArZ5qkP8cOYjdaZmJZwnggzjDa6Co6
    VIk3V9WmjhKoRO1W//YapG/AfDZmGU0uDzs53bTu7G7xtTVhGKXn5uP5viKRDhgP
    HFtfwqs6ViG2ZZ+Mv0TbjkokTBUipktfpJ8rzg56kwHUuKC0QasQT7NqiZfFTOsK
    8ZtiITP89LGBpAaDN3nmEtcqjDoj4OLKENG+glwoJ4lzp/3vcjqrrF4a6z7znRKR
    ZIp3gRhKqlAxVXhuEVX84vQHPlvKn8FS/WM07q9xrzvawIY1GrfWCiL31VSIavRj
    ydPjZrOlyTdeYOzXYqklyWi3oRVOffPiwvcjGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519987092;
    bh=KvcY2vySQ6Mc9lGbA/z8WbGXRlX0s3H1lJaFHh/shTg=; b=kE6UCoLf0wL1
    C9tRhbUiQqG5IyVH/4cAmUF+cXMHARXAIzqP4ufy9VmY10q85prS0Ry5j7gQ1OXr
    6MKNIR8t5dvNhF2R3QUIbOjeAL6aNlKpOeKPLzDAZxCka4Tb6CRg1MIW9ZKOz8GI
    PyADC33q95e8p69UZOR9xVFSO7fVbJVjDll64gv95OYKCTT7HwketCumwfxOCGKH
    o0udBZ4SZnJ3iRFd64cy97YNCw12x7BBmZBVU+p9C4ZlUlAi8K6v6guFyWUvHrNU
    SNAafDLFtCzYpoOjyuqHDDVXapDQPRvJw0JWfMyIeiA1n0neJ0jfcqMW95tgMqgo
    b61QdssN5A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946273AbeCBKhU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 05:37:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946345AbeCBKgh (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 05:36:37 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] ahci: Add PCI-id for the Highpoint Rocketraid 644L card
Date: Fri,  2 Mar 2018 11:36:32 +0100
Message-Id: <20180302103633.10592-2-hdegoede@redhat.com>
In-Reply-To: <20180302103633.10592-1-hdegoede@redhat.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Like the Highpoint Rocketraid 642L and cards using a Marvel 88SE9235
controller in general, this RAID card also supports AHCI mode and short
of a custom driver, this is the only way to make it work under Linux.

Note that even though the card is called to 644L, it has a product-id
of 0x0645.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1534106
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 355a95a83a34..1ff17799769d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -550,7 +550,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
+	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
 	  .driver_data = board_ahci_yes_fbs },
 
 	/* Promise */
-- 
2.14.3
