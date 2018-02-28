Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836618-3-16838069373185206414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FUZZY_XPILL 2.799, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836617; b=eM2SkwXCixvMYtt8OqiaT0x5fgFUCFpbjuqkHzajhy6BfR6
    oheGbJ0LrFB5h0dIVqwH/gn0xyj3onJNRnyiefjMA98st8+Sqlb4nJzGLX5qPitp
    WNrlLRasUEIT/MzgtwiTI9ois+zjgXJg+MvEdc4gtx8YzZs0++3loThVszDHBzWf
    hbRThYOOv/vv36NqQcjZA7zVjXvRtdWa4OLfM76CWTO3dp0seHheHo3Lc3McenDr
    KWKCOhkPU065FvOXi2p2HsCf/i7BkGHAe6/x9npAVF+Ts+cKhDEe6r3Tp5hscc/f
    0/y7jFdmVnZKROF8bLlvAly3CwlJUwMBoLYDHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836617; bh=4nTI1KynU6X2FwWp3fj
    1u/X2sUkiBm7YtyQPYplAHFs=; b=glwzL5/vqlRr6fjZkuBDD4rDf+7MKm23x6Y
    gGDheFMLR5GtyFXd6DcqRGGcgUJjm7kSsGnJSDZt8huAI4vgsGW58r1SM1kQg42q
    L1igb8UxduNripH9ckAAVsTf/n99ENLoBuRFxAfQxc6VucBBtmYyXMpNIguNBxyx
    7WKK/h37sjQjUcXA10ZBd5MnpiMBc4z3Uha+kcbY/k2txR6x3mL8NwrjuFRAnuur
    VMEt8gh+j9giG6VrcE6vqf/lHaex0jfD3WrxnwMfhDdykDU7nh62WiyRHXwDt2Sl
    M+Ey2U0yDnJ32Q3Z9N5o28BHxyeTakqrtMDut8AHUwkj2bBy0aw==
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
        id S933976AbeB1P6k (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34569 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934099AbeB1P6h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:37 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Freaky" <freaky2000@gmail.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.485773071@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 198/254] ALSA: hda - Apply the existing quirk to iMac
 14,1
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

From: Takashi Iwai <tiwai@suse.de>

commit 031f335cda879450095873003abb03ae8ed3b74a upstream.

iMac 14,1 requires the same quirk as iMac 12,2, using GPIO 2 and 3 for
headphone and speaker output amps.  Add the codec SSID quirk entry
(106b:0600) accordingly.

BugLink: http://lkml.kernel.org/r/CAEw6Zyteav09VGHRfD5QwsfuWv5a43r0tFBNbfcHXoNrxVz7ew@mail.gmail.com
Reported-by: Freaky <freaky2000@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/patch_cirrus.c | 1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -396,6 +396,7 @@ static const struct snd_pci_quirk cs420x
 	/*SND_PCI_QUIRK(0x8086, 0x7270, "IMac 27 Inch", CS420X_IMAC27),*/
 
 	/* codec SSID */
+	SND_PCI_QUIRK(0x106b, 0x0600, "iMac 14,1", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x1c00, "MacBookPro 8,1", CS420X_MBP81),
 	SND_PCI_QUIRK(0x106b, 0x2000, "iMac 12,2", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x2800, "MacBookPro 10,1", CS420X_MBP101),
