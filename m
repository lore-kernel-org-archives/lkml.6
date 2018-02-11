Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325825-2-8885851348846228382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES sk.us-asciiroen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325824; b=Fks6k+7I5AwxH6zCEUnFdWGzvcvtu/Z7O+Xz2rgKyVcG2CI
    t9ascEY1JscaFESbGp2gG9uPpQujKLWIQZi0P3Fa4v4C3yBLJDSnRSbdcjrUrwX5
    ca5QPLuMEInBlN5Ej/L2FFsawNXwiTPbSTYBAZPgrczwZr7ymZ5C52sgRpxJPFzQ
    uw6/IhBrDAMYxBlGabYBiERj/gFyCnLn8xnQV8VafkwBRNgg+5M8cWdt6FGlKiNo
    jiZidwq/IEdURlmHUm7Y2AN+HPP8OI6q+hpRxQuy9YrUPVacheLSUIkh/Mn7CTrM
    TjwuqCth9qT+f54PLIKouIE+avuW0SOkwLZBGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325824; bh=xCmlAwqICe8PJKIonMH
    MyieXO5Wy3HdwF/Zuo6bvaMA=; b=dTsnUqN7MQNXDMyL4+OZN/16W06gy4uzQGe
    FHHFD0tLVL8t+sjVr7hys1Rn35Hqe9FAsOEMMwOQ2rEgnMzniddkexeJxHfPm0YO
    6oi4/LM5THF33JjKuZQtLPSL3KA31LiXeu3ZwTk/0NqVTVq52i7MJpuQTqb/md2N
    4IImMSOqav576HDyI0NiuxuAYukacLTa/+nv42/9n/q8lINmtv2S1IAsxRLxntBl
    /x1iqXxTj7Qaog4hAM4hQPSbqJ8gEZPusdbHhSn/IPgTEDrbtk74pckYKj16P9iX
    CRTo179KFMZkFgPYMkcN0p0o3HY3bFAp74I+GS0D4mSkMCOMLCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeBKFJ1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:09:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41449 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752650AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.962749726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 59/79] ALSA: hda: Add Raven PCI ID
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -3045,6 +3045,9 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids)
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Raven */
+	{ PCI_DEVICE(0x1022, 0x15e3),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x793b),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
