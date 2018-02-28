Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833351-2-6776352843606238468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833350; b=h8c22AxPaUYRYaGBsRIAE3f4uKi7AxCZw7XSYLLrlY4CFuc
    QNdIq/Xze2nIuL8xb1KhQ9IUuVbpyG+4uzvgL3B7puRY5XaZ7QH9slz0FBRK3EHH
    Q75qouc5PbvLvAL00WRHqiahXY5+dJzTbcRLfE284072bUs7pMi1DBahr2LF2Sx0
    tX2a5KC913mQbfdMg+vy7aLkRKa8UaXW/K65PzOyStz5X0EWq7Bo/+yIUsEZmWd6
    CZDh6Z6zZBV/L6CXBWearIXebXKLOSYpNoWqLRazG+F+83qTBgxcq/a2VwEBUCYV
    gLKVFJyES9iqWcMfY/msDJ54hnK/SdoltuvI2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833350; bh=/NT23Q1K/pBy/Rhb76Y
    MhbBNPFuG7sFDDAyDgIjAx3s=; b=IOdIbJ3ocl0TqeTLL7yC50Iij/nudO8sMOZ
    Eg+LyygEALAsOTgJ+K7xXmVX5ptRc2v3atN+aFPWJxNYA3vtVqAOyzSeKneTHpGl
    Z0Ttqlt+oxVCJMDhSv8n+ye1qhcy3Wx6uDNNAtwUK8uamDTkyOjGsASZ82Bzxpny
    L/S0zdzqlGRpXR0iLlTMufs4utkV4AAYb9BubjHNK/LNh5RO/gKAV4MI2h2F+C10
    arIfy3jBODZnX1IMlKXSXYn35thQAm5naGA3DhdhkVPAjIf/B8/jvoqRbGzVz34K
    LfBGhU1Du9FkESU3DsPrWhd18ZlDPH7ff5XJjqbPRgcsPf7fJvQ==
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
        id S934029AbeB1Pzs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:55:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34487 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932974AbeB1Pzr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:55:47 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jaejoong Kim" <climbbb.kim@gmail.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.848172585@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 026/140] ALSA: usb-audio: Add check return value for
 usb_string()
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jaejoong Kim <climbbb.kim@gmail.com>

commit 89b89d121ffcf8d9546633b98ded9d18b8f75891 upstream.

snd_usb_copy_string_desc() returns zero if usb_string() fails.
In case of failure, we need to check the snd_usb_copy_string_desc()'s
return value and add an exception case

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1928,12 +1928,14 @@ static int parse_audio_selector_unit(str
 	if (len)
 		;
 	else if (nameid)
-		snd_usb_copy_string_desc(state, nameid, kctl->id.name, sizeof(kctl->id.name));
-	else {
+		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
+					 sizeof(kctl->id.name));
+	else
 		len = get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
-		if (! len)
-			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+
+	if (!len) {
+		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
