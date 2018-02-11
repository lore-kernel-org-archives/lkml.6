Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324933-2-6753308630612052747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324932; b=qN+3vdC+90xb/zlOLto52mo4/w5KylOF/C/5x5K6+V6wTxj
    B4IiMaN24oFLt6T9NYrcZxipTCc3UEzC6YD+QaNO+KQzDVJj2N+df4ShMcefXeRM
    pxobesbyzar0ieocqihvprdeiBL5XfLW7/FMXGrbc3EFWjTB3IHLNkHSg9PUeIYF
    8JzAxqbV552ISYBUUkIfeDEjFBpKfoXB5N5Su/sJeLmd6/POZWDQPIrLNjjnO/Pp
    g9q//qE4EXRf8BOiXoDsiiAAYUgUJPONplBSRNJDeGh9adjwBkz+TZC1W0gYyu4m
    Tgdii7jtIBNPQfpbh/Mqm+Za370OVbpepA5DMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324932; bh=IEpcfdl97rXnFzQjYho
    dNyPnZAwLFacSqsn+2qZE5Rw=; b=ej7ucIFRPBrrUkfM7f+MHRRmnEVwrCQ7NeS
    KzlOX786/VILr1s7JKYvlubwZag4xoUFetyf5nakiyePZKT6D/8TfDyq0O4JDLAJ
    3wvu5kkBR9XrXBzlUzu8poilnmnxhcvNWhKZcOQaEjqWRZ1EeAqlwVZJyDHgGbz6
    YRudHNxCPx4RDDtF0KAw+J+JKBmyJKaDi/gSrWFc4l0J2nQeWiLm7w7hvDuV2FY2
    Bi+dJrXkYgxeoSotpnk2XUjog1SkY0T23Cqj6EinTFJzB3whVkqHgvI+dBNTY8ic
    Ddv/xZCs63kxyECZwXpLEo3AAWmSmuThEdqYQGrvf/0fk6ouViQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeBKEyQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:54:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41733 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752809AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.720339324@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 114/136] ALSA: hda: Add Raven PCI ID
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

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

commit 9ceace3c9c18c67676e75141032a65a8e01f9a7a upstream.

This commit adds PCI ID for Raven platform

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1914,6 +1914,9 @@ static const struct pci_device_id azx_id
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Raven */
+	{ PCI_DEVICE(0x1022, 0x15e3),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x793b),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
