Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837304-2-3997298304331562015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837303; b=lR5Z9/zq6xP0D4NGVvCUPRqtrAlyi6tekcTQQHcvING2NUh
    elha65Q7381m/24h4ZOBCFkcC5/6Zl+zvnPIhsP+JP5cAnPg2Q4iGaIO1VLn4aXW
    MvAbAVDHjzJdN+/ZfvKd876liimodggVACIPvg4sLJX8oiIVdR8rdMpcQMImraDZ
    GzBfUYA1Jn6ANAXNowrxjG8H+Xo1XLLlV9XILIjZzK10TbLWB5s/qqwbtKH9hSO4
    Q27zvFwem0+v0xWdAQGA/5YrRK0Vu6TF7bdVuefpt08LszNgJu8e5CmrsGTeqZ28
    l4X0MuJJ1IDGOXo6ZWRiMMb2vN05S+Yw2DurR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837303; bh=2oubEHAXHkr+XS/P7ML
    pG3V/lQPwwiZiwW9kV7aPNow=; b=t3l78Bw7R4rfeS6XNgJsINAFyrWaRqo4hMx
    Us4s0YLDqZIuHLjCTE2V/TPatleA2RA+EpdiWAGsatlQj5gaGLpxBR919w6/UlN6
    PAdKAwGYmO37ud8buoCO6omTizOirW3CUXRmr5hA5zm2YBsxijMoGQd8qlxJge1K
    RWjLR6vbOvZV3GCcRi1P1ahXHV/WuYbQkrHEzfTBx2p0827zJT6j0pd6VbjlQSHp
    TB2nlGHYdFFrBM/0653PJrBvpbtZBxKgWhod/ZYcOczULNxO32bJGQctLRSG/wTF
    TX03NJDC0FU0auHdpdz58oECqQvUY3yCDEghLBTxfTK44a8OdIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeB1RA7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:00:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34372 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933211AbeB1PwG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jaejoong Kim" <climbbb.kim@gmail.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.593591252@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 050/254] ALSA: usb-audio: Add check return value for
 usb_string()
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

From: Jaejoong Kim <climbbb.kim@gmail.com>

commit 89b89d121ffcf8d9546633b98ded9d18b8f75891 upstream.

snd_usb_copy_string_desc() returns zero if usb_string() fails.
In case of failure, we need to check the snd_usb_copy_string_desc()'s
return value and add an exception case

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2100,13 +2100,14 @@ static int parse_audio_selector_unit(str
 	if (len)
 		;
 	else if (nameid)
-		snd_usb_copy_string_desc(state, nameid, kctl->id.name,
+		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
 					 sizeof(kctl->id.name));
-	else {
+	else
 		len = get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
-		if (!len)
-			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+
+	if (!len) {
+		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
