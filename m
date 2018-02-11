Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324697-2-18433727069367047601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324696; b=stA7uRubj41KgSrENndpDt5NZKMkoEibPzNwfF0cLj6/ngR
    ptouXkGwHqL2nHbPTHCszU5ZzttyImGwb3k4DzZah+Cia26LUJRXFTfp4oNM7+u5
    4xG+JOPq+spInQsQgr/3uuFH/0whoG8KfME/I8B5LkugwaUn0v3HRXURN/nKTGlg
    viJu3KrRGDhWqRlJz+QHylzhDkxLy59YztylLmnJb8J5OwoVBNubXwC4aFP+v2C0
    zBDT44qaypwji5r5DFvwpBllq0Dtf/oXaCNHXbg8SgR3qspnyAe7sQ1Ao2A3o/gH
    Jp7AIDjUCXYPDh/4+BRoDMOl2xagDxQTT/IGjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324696; bh=2mzWnEMihqTLWXbRQNq
    s4EDD44Qi+gzyG/OvykVZO9k=; b=Gm6FrrHLwKyoU0YEvmjcRKdJ4p+mGqWM80m
    D3ruRr8/0Ni3GsydytSdYyw82jmqEFbv4vLo32SVDRNUDHfRTgQm1qgzJVsHsWOY
    2gRxpG78UD+V0+p5ue3w5Wgw2/lhWcD2tMp6uUtRhE7Ef4Wkn1NLHH1TJqB27Iit
    fEkQ+wqhBaPGvQpwCawZDgcox816oVClC/5R1DpNTggAX2qy8pArZ+474ZWizVtk
    Obp98GE6LNzPpobr/8SBcg+xtX8/azEAYyh8YXyYe91DPOGuFqNRcIeMISNvLb9S
    FeSS7nZRqoVTAbv4vqdztYhVMwOKoWKylhSuWLyBn17gSnrhhAw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeBKEux (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:50:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41791 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752830AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.708567131@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 106/136] ALSA: usb-audio: Fix potential zero-division
 at parsing FU
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

From: Takashi Iwai <tiwai@suse.de>

commit 8428a8ebde2db1e988e41a58497a28beb7ce1705 upstream.

parse_audio_feature_unit() contains a code dividing potentially with
zero when a malformed FU descriptor is passed.  Although there is
already a sanity check, it checks only the value zero, hence it can
still lead to a zero-division when a value 1 is passed there.

Fix it by correcting the sanity check (and the error message
thereof).

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1385,9 +1385,9 @@ static int parse_audio_feature_unit(stru
 			return -EINVAL;
 		}
 		csize = hdr->bControlSize;
-		if (!csize) {
+		if (csize <= 1) {
 			usb_audio_dbg(state->chip,
-				      "unit %u: invalid bControlSize == 0\n",
+				      "unit %u: invalid bControlSize <= 1\n",
 				      unitid);
 			return -EINVAL;
 		}
