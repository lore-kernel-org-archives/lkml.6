Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172516-2-5540823258068163793
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
    t=1522172515; b=s9H+jXAGoo3XeomnJ4Q5ndrXtNSR3d0xQzExct+jMMIcfWA
    gVlB6qsTiBEfIPYAN+Hgf4ewE3WtCrLUqzFdMLIxqXPO3phIIL+cw/gCHfb35pj4
    jFq8VatL8M9uGM0ZskfmQ7r8HMrJttc9rVYZ6EF3KCjkQuN6T2rPmNM3TvProIvb
    Ue/ZCI75W4zUqJeqh3lVkDUnAkfbntLTdWo3qV57Oop12OlgWcdVX3UTYIXTC7bm
    epVCoIVGyA0FN3rdMBKZyx8mYFPBm96YjpiJV6OK7bLnu5GBlDMyqd1AVERChIcG
    0YDWU6hFvZU+63cUQxdkF0vMyRdJr1EftWYkj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172515; bh=tiSASD9YwCKeGyAvcqIQjHQktu
    U89nhfC7EvnjpGIic=; b=SFK58okgm4tD6a0hoEgbS96fkQdrCai+0d2mgQk9dp
    IeczkDj7fNNf9+aocEnhi4dIGFcMYlS1IO98knUpNsXLOWrvvR/NIbnJ6CGOpbYA
    FwhUi+77m17MFVha6jpSMO4o78YFa4xIZPBgAXck9OdxThCmAAnDLCsMHxGgDkK0
    QrdL7a6lHA4opirAGSjbsNIbiCVlHaUFij9zT96CvFUb8YTg+p+zM+YOZusLdQ9D
    3c34/lTs1X/olEyKfiDemvlYJu3EFYgLijQf45oYzUsJGa3YvnTKy3YWROmhKGb3
    ghtHT5nS/Y/u9B7GvUNhvUDJCO4ftpfzPIVriNUEg/KQ==
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
X-CM-Envelope: MS4wfE4D4Pp2q7DHzMWrUDTEPULpL/OnWuQ0bU1E5R5hZdJq1Ii0YwhP1GFhZsLc9N9oHaQn5wsmzEEMd7sR5UtWCOi214LWJ5xzQPmCknk2zmnbfZIgbl+w
    zeaINq5FqJCJrXmTDQFufTpUygzQoD5SRM8c+tKV0NAZogQRM/rPxNJjuHBWPNeWhrBjZAmtMWAdZY7NKP8Gf+Kscdx/vezts9EZmjkX7CWUfmOVms9C8h2E
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=n4yHPK1a9YeVPVKjqp4A:9
    a=FmBzSsjMmyFZxvAZ:21 a=9-BFIvEqx44UeleB:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeC0Rlh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:41:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754086AbeC0Qdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:33:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 011/101] ALSA: aloop: Fix access to not-yet-ready substream via cable
Date: Tue, 27 Mar 2018 18:26:43 +0200
Message-Id: <20180327162750.693836162@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8e6b1a72a75bb5067ccb6b56d8ca4aa3a300a64e upstream.

In loopback_open() and loopback_close(), we assign and release the
substream object to the corresponding cable in a racy way.  It's
neither locked nor done in the right position.  The open callback
assigns the substream before its preparation finishes, hence the other
side of the cable may pick it up, which may lead to the invalid memory
access.

This patch addresses these: move the assignment to the end of the open
callback, and wrap with cable->lock for avoiding concurrent accesses.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/aloop.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -666,7 +666,9 @@ static void free_cable(struct snd_pcm_su
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] = NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -706,7 +708,6 @@ static int loopback_open(struct snd_pcm_
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
-	cable->streams[substream->stream] = dpcm;
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -738,6 +739,11 @@ static int loopback_open(struct snd_pcm_
 		runtime->hw = loopback_pcm_hardware;
 	else
 		runtime->hw = cable->hw;
+
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] = dpcm;
+	spin_unlock_irq(&cable->lock);
+
  unlock:
 	if (err < 0) {
 		free_cable(substream);
