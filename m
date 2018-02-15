Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708885-2-5882645297053124178
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
    t=1518708884; b=PlKhKC++yjdK8MGVMfE4kteQLb46IvjDypquOa25OIQJF2D
    wn+ZcCUnhkd5kTGDyjxwNrx+NVFp4298dWWYdDAMO8Uf6u5D0Fd2x9FuQw/d56L4
    A2xuuyH5pixjdVevdxUBh9KjQCryY52BnJ7QQL2JCPujcKwK05KT0Sovj8m1XW7a
    WoSsOVQzkfSogCZ00S7h5ji3CBkoVCh/b2ff33SimjqMiJ06+58CCzi6EVv6rLXp
    f1OpronbmWHgejv5YDmncD0g3OzBPjzzoSgzXVIbJevUsU4J+IpHhgJgaaFjdJor
    ZTrDLEIW9a5Zn81sKPUEQVf2XRwRHC/0/JBmDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708884; bh=jm+Gq5DPlmZ5SBvZ0rZ2pQfxHy
    OJNYkQ9jmYd3FL4WU=; b=HJPZnfSU92Rj2grpB4+CeKczzZxbnvIpXxeuE59Ti+
    6LSExmuOHV356KJ7V7ExMmzNrCN2ZzmAWgWo3K6nIQaG98tdQg6EhmetdctLw8nD
    TiXjPEyC4KCcJmHeYL0VfjRivcKix3NXe+rvA6teFkzMY9KO2kkUYiBLCE43hdEJ
    6XUAja3IogGA2DqkYK/dooK7igLVfkURk/1l/cI4UAncus/ukRL27eCkmht1Tgnw
    4LptYrhKoEHY6DLUGnbAeABdAoMHcyhSc1lnC5Wte+eYoTLlm5GmpLVOWWaL5CCb
    ZIrZ/RJf8ORd4pYs9yAVlOfwtZWummwm8/UnYcM97ELg==
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
        id S1164553AbeBOPej (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:34:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165004AbeBOPei (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:34:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 113/195] ahci: Add Intel Cannon Lake PCH-H PCI ID
Date: Thu, 15 Feb 2018 16:16:44 +0100
Message-Id: <20180215151711.342987622@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -385,6 +385,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
