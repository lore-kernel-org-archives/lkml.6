Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174247-2-1467636588803325595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174245; b=I07I1qOfM5dgnvlDV8XGFy2rOsGA1Q8Z3AhWxWhnYTfcC+V
    BuU4j5PHe0zkxI9aUoD9X6zWHwEY22xGutiOwp8adS9SEzIQHpMAnnyZ47J1MPwR
    pMQ8WPLiCKTzJ2Wj5FWkaXBtQObrfBebDJMleIflQN/Ne23GZpJYgelT4Zjy+fNH
    CsUUhQFHn97+W/IL9cIHpLVA0rGAmBStX1KUu5EPPydHrOOfsqV4tAxJhf2lZp7G
    ByJfkPOQz2QMeVB5yLSqKUjVZQzeyPxhgKl2JJ3Bf9JpXnDOMMmZ+zkxk2U+EWBe
    NOSuraD03shtWlY6hPAV/lCl+vMGFNGjFd8SWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174245; bh=ohxNuN9eWibl22URVdCOZUeTQX
    tG8kwobBINL46jlwc=; b=cOYmdEsrdts5AEVqO4/PIm+K/+X3YWfWJ/UMSZt5w/
    x564k05N6+NY6NvgXqHpxsny8LPWzCEE2Hm7Ra46IxwpoFpMoNJS8q9kjwqXI/6T
    DitXE4jQtiLKnB/MFdJTcYq1VQTvpqikqmUGQ4NWFVpQ/erJ1Xfnr3N0HiugBB72
    Z8InDtWyNuyv5iHq8+iMY08CNap2aZKqj1EaVIsncLJ8Tt+yh7bfupRzOZrHWktK
    S3CZv/wPkILcnryib61HCWYXn/7+fqfVO2ioWN63V1lizF1gTXjJb2FTp2cMwUPI
    k0a8pPedxUDsplfZrpm9ko1bZJ6GGGORBzYe5GQT3HOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJYYZ5TNIIhGx5nJOiBbj9Tp23ar6+nD4vqK2TMO24hDzqJJRj4nTxp3KYUS0sABwBsyEEr0LY660Uf+mrjE8okv7Qz7VT06+5q64FTrZjC8kXQkfPUc
    iut/yF8Ir+fPi5aivR3xflDlsF0AeVB/Ly/tjTziLnueCNKNhorgWBOj8CG0t4w1S7f34d3m6K5YKbcEYlil+EUreXmyNpZozZhmcUnsJaGzmPxc2pQIIoCl
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=mkCXhCCKOUKQdph7VtgA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC0Q2s (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:28:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeC0Q2r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:28:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 04/43] ALSA: aloop: Sync stale timer before release
Date: Tue, 27 Mar 2018 18:27:08 +0200
Message-Id: <20180327162716.638981112@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 67a01afaf3d34893cf7d2ea19b34555d6abb7cb0 upstream.

The aloop driver tries to stop the pending timer via timer_del() in
the trigger callback and in the close callback.  The former is
correct, as it's an atomic operation, while the latter expects that
the timer gets really removed and proceeds the resource releases after
that.  But timer_del() doesn't synchronize, hence the running timer
may still access the released resources.

A similar situation can be also seen in the prepare callback after
trigger(STOP) where the prepare tries to re-initialize the things
while a timer is still running.

The problems like the above are seen indirectly in some syzkaller
reports (although it's not 100% clear whether this is the only cause,
as the race condition is quite narrow and not always easy to
trigger).

For addressing these issues, this patch adds the explicit alls of
timer_del_sync() in some places, so that the pending timer is properly
killed / synced.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/aloop.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -192,6 +192,11 @@ static inline void loopback_timer_stop(s
 	dpcm->timer.expires = 0;
 }
 
+static inline void loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+{
+	del_timer_sync(&dpcm->timer);
+}
+
 #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
 #define CABLE_VALID_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
 #define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK|CABLE_VALID_CAPTURE)
@@ -326,6 +331,8 @@ static int loopback_prepare(struct snd_p
 	struct loopback_cable *cable = dpcm->cable;
 	int bps, salign;
 
+	loopback_timer_stop_sync(dpcm);
+
 	salign = (snd_pcm_format_width(runtime->format) *
 						runtime->channels) / 8;
 	bps = salign * runtime->rate;
@@ -745,7 +752,7 @@ static int loopback_close(struct snd_pcm
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-	loopback_timer_stop(dpcm);
+	loopback_timer_stop_sync(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
