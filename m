Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804592-2-11458770923121937986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804591; b=RWAay0/M5hWG5GJqL5ALOgq1WjGL90tMNSQkxZiuyYqiSW/
    cy2x+EzI+eZxdNNjwgquh+eGYmxHJncvCrZXNiGqmW9pIxibbAUX1bJsCK4V6Tz1
    usIEtgTaRRdwUDxQN5BfGJp4w5U8lWiwgPXyWVCkpHODR9jevL3n3WHNS/SpH8sa
    LjJFZt4d9KpsUf6MfOaycRn8nlfhDQoy5ssIlHG+GLninVffS6BOx317MBdviJ8I
    msPNrCfRB1/PMxPCvohcMrZRy6/shMg03Ab8HIE/QKsKtbjda1Sf3TS5FC+OFk+D
    TbjE84r+beEn87ycaX2GMHzrkNJejQhahx+grLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804591; bh=Qf+FQNawkpN8QN4qC86w1VpLbB
    WaON10HXq+BOGXKt8=; b=Hr7oBYIsrQAqgS66KXAXkGmji+kWw0O8/rDBdXvpg2
    e3E6sM4SlSPq8fFWPjrz0PMMMYITF+rxK6dZ7KbYOjKjjWDq7hna3gJ1t+L9yU14
    I5z/8v4r5ri7odn5JQjR34ItCzi+hxpdxW7oVYU9V/smVIm7yzBTjQmbqTVx242l
    Z2e0kWMCjNpfyQW8a7QEJxYoTzS1iJIL5FCXvzlT60f1SZYHuufEir9SXas1dSSw
    T5KwqGvONM3v6kO1zapb7mWgO9kooefWBBAn2xIGv9Bxx51hKOOaxjUqpc4BXAu+
    THSTY2US/yFdgodeOnU4W1UETlfV7J9LQt+vQHFJspLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeCWL3h (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:29:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932083AbeCWKG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Paulyshka <me@mixaill.tk>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 043/177] ALSA: hda - Fix headset microphone detection for ASUS N551 and N751
Date: Fri, 23 Mar 2018 10:52:51 +0100
Message-Id: <20180323094207.152201801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Mikhail Paulyshka <me@mixaill.tk>


[ Upstream commit fc7438b1eb12b6c93d7b7a62423779eb5dfc673c ]

Headset microphone does not work out of the box on ASUS Nx51
laptops. This patch fixes it.

Patch tested on Asus N551 laptop. Asus N751 part is not tested, but
according to [1] this laptop uses the same audiosystem.

1. https://bugzilla.kernel.org/show_bug.cgi?id=117781

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195437
Signed-off-by: Mikhail Paulyshka <me@mixaill.tk>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6780,6 +6780,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
 	ALC891_FIXUP_HEADSET_MODE,
 	ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
@@ -7031,14 +7032,21 @@ static const struct hda_fixup alc662_fix
 		.chained = true,
 		.chain_id = ALC662_FIXUP_BASS_1A
 	},
+	[ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_mode_alc668,
+		.chain_id = ALC662_FIXUP_BASS_CHMAP
+	},
 	[ALC668_FIXUP_ASUS_Nx51] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{0x1a, 0x90170151}, /* bass speaker */
+			{ 0x19, 0x03a1913d }, /* use as headphone mic, without its own jack detect */
+			{ 0x1a, 0x90170151 }, /* bass speaker */
+			{ 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack detect */
 			{}
 		},
 		.chained = true,
-		.chain_id = ALC662_FIXUP_BASS_CHMAP,
+		.chain_id = ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	},
 	[ALC891_FIXUP_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
