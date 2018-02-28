Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831567-2-6660446307258386883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519831566; b=eY5efHsEn1VvVvl70fuLVtfVJgVBpVtjEgIttIg2H0akzbs
    NJYy9v8bfAv3tAjQyppLgjeowZHjPksYZVqzI9y7uAJmWgUtaxeIFPT1tqDIqrRJ
    u6E3xIf3gT2L0mP1J7kzHmT00O0F2bxBHdHoNEPl0TdZCtiulXjFO1qh+9Zu82L0
    aoh8aLuoFJe/l0L/9YIz3+E1SMuJAsSJX+nW5DesfFdq7hIpPpVCaqtO2pUnVytX
    kxazYKaAW0M+bHxSD8PsGnJmwpyajtAIFS+GZHIsBQ5bXqvSUlvaccTb47wvez41
    hCa+4MGjbhbO8gN2rPad4kbOvdiPbtDdgzUYwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831566; bh=+UaOFvfv9kntBdADI73
    9mdKPSN+tYb8VXf+bZpwIOYQ=; b=uWijJKmlVN48AblrTn6kv3KVGtp7rX6uKSz
    Q70vu4Qa3cdLvULka3mzsNU7G6lEZbcFdh76m2pLgi2UtjvaqSaIpN5e3/LqowtG
    GS5OxqY4nDX+rcO/oG8YPyLfKwB104uVKgajKvuc2GEbH9uXkFDDx8B8aGDyo8wY
    +vOQePQg/dYwzNlu8ZIrOMB+MEzhWXph8PTtUw3dcLCSgB8W59inWhOI3KUOHA7V
    y1hwGcyPfitV9fxMjOEkHKvMrP5Tl6HiR7/SAo9QiMZ9BCaOnddNjbXRR5uAFTSj
    uO0PNp+IA6Fju3zI0cH+hShNwsnSuWyGtPbqOjKKRGIxd29ZUew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeB1PZW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:25:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33378 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752876AbeB1PWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.625133933@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 045/140] ALSA: rawmidi: Avoid racy info ioctl via ctl
 device
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

From: Takashi Iwai <tiwai@suse.de>

commit c1cfd9025cc394fd137a01159d74335c5ac978ce upstream.

The rawmidi also allows to obtaining the information via ioctl of ctl
API.  It means that user can issue an ioctl to the rawmidi device even
when it's being removed as long as the control device is present.
Although the code has some protection via the global register_mutex,
its range is limited to the search of the corresponding rawmidi
object, and the mutex is already unlocked at accessing the rawmidi
object.  This may lead to a use-after-free.

For avoiding it, this patch widens the application of register_mutex
to the whole snd_rawmidi_info_select() function.  We have another
mutex per rawmidi object, but this operation isn't very hot path, so
it shouldn't matter from the performance POV.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/rawmidi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -575,15 +575,14 @@ static int snd_rawmidi_info_user(struct
 	return 0;
 }
 
-int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info)
+static int __snd_rawmidi_info_select(struct snd_card *card,
+				     struct snd_rawmidi_info *info)
 {
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *pstr;
 	struct snd_rawmidi_substream *substream;
 
-	mutex_lock(&register_mutex);
 	rmidi = snd_rawmidi_search(card, info->device);
-	mutex_unlock(&register_mutex);
 	if (!rmidi)
 		return -ENXIO;
 	if (info->stream < 0 || info->stream > 1)
@@ -600,6 +599,16 @@ int snd_rawmidi_info_select(struct snd_c
 	return -ENXIO;
 }
 
+int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info)
+{
+	int ret;
+
+	mutex_lock(&register_mutex);
+	ret = __snd_rawmidi_info_select(card, info);
+	mutex_unlock(&register_mutex);
+	return ret;
+}
+
 static int snd_rawmidi_info_select_user(struct snd_card *card,
 					struct snd_rawmidi_info __user *_info)
 {
