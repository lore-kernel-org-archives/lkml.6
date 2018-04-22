Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406799-2-11224819631205780858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406798; b=Qdyafyescvh7w96JnIlNVU02i3TZ/+haBXyXbsM6LsSoHqLTcF
    aR35YiAQaIh57uRdmH+sfg3zIaPb7xtmirE0YQzOfCQ0QtGb71jgBu7DoMUHxBAB
    8UD0l0+PWs5H7HC09qvbnQxQ1bHNuOm2LCIrX4Owboi043BubX95OUDboXGKslAq
    k/8xFo9e8gPbZK8Ch+riiJQRat/ea7KIa1PryqrM6B4y9C76f7D13ftgmO+2X1vX
    qkCtFMrItoIrL8jpKq0BrMZFttATFuOdPzHMbrAj13kd4oELfb4GqBiNAlQOfh32
    jwu65nXhtSa7oPPrFMOdoGWVA0Ckb5PP9CFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406798; bh=F/Erq0hct8VRpN1N7AEoTk4JhyJRfa
    v8dB58jvdX924=; b=Y2g4IYhTFKk7UuK0IotFt0H7AF3MLnpU0zjcgPE4ifMt9x
    66986v5hgXSrPzkyExyMnsBniHnGaCfau1aCuZjVlerOEa2q37K999LJUBnGaF3p
    HQbpawJwJ+UGsUx4ydpTN7xk2g0FUE2J+W9LwOMC0vMWSeRm8rfKYztI0OiqioV2
    btUJRk/2cI0taB2vdAaptgBwdswD09Z8TzXHqxi4iRUKs/S6sPKNTWZZ2N8LZ451
    DrNCX6t95VbjBUP8UnE+BynDO6uHwGiObmcgLWC7RGzoRUbiNmcoI453xh78oizk
    fgNNNvGThNO3p2HEBglm5UmGVsGSB2v1BTh4kIrg==
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
X-CM-Envelope: MS4wfJaRYsUmrNxF9FN7jYZ1l+kN5LnDrEJdlcSLM46uadzPqiQrroO0+iYs/Q35JGw0wqOLOInquBCmjYv0+TTW4uCBkDGxy3Fu+3S97rQAToTGLA1DMTRc
    pL+KptuLezIKK2Dq3eXz7s/4u4lDibD/yhiLqoAXyrNecf48ytJ5BZ9Y3itlxt4+KLnCxWbEtubwAAnIwZUyn0QACswYa0assnlpRgrNTbbwAkAhSRHpMeYX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=0-rN4lzjX4iqAgTStjQA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757314AbeDVOTz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:19:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757264AbeDVOTv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:19:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f7a0348affc3b67bc617@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 79/97] ALSA: rawmidi: Fix missing input substream checks in compat ioctls
Date: Sun, 22 Apr 2018 15:53:57 +0200
Message-Id: <20180422135309.538959543@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

commit 8a56ef4f3ffba9ebf4967b61ef600b0a7ba10f11 upstream.

Some rawmidi compat ioctls lack of the input substream checks
(although they do check only for rfile->output).  This many eventually
lead to an Oops as NULL substream is passed to the rawmidi core
functions.

Fix it by adding the proper checks before each function call.

The bug was spotted by syzkaller.

Reported-by: syzbot+f7a0348affc3b67bc617@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/rawmidi_compat.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -36,8 +36,6 @@ static int snd_rawmidi_ioctl_params_comp
 	struct snd_rawmidi_params params;
 	unsigned int val;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(params.stream, &src->stream) ||
 	    get_user(params.buffer_size, &src->buffer_size) ||
 	    get_user(params.avail_min, &src->avail_min) ||
@@ -46,8 +44,12 @@ static int snd_rawmidi_ioctl_params_comp
 	params.no_active_sensing = val;
 	switch (params.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		return snd_rawmidi_output_params(rfile->output, &params);
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		return snd_rawmidi_input_params(rfile->input, &params);
 	}
 	return -EINVAL;
@@ -67,16 +69,18 @@ static int snd_rawmidi_ioctl_status_comp
 	int err;
 	struct snd_rawmidi_status status;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
 
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err = snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err = snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
@@ -113,16 +117,18 @@ static int snd_rawmidi_ioctl_status_x32(
 	int err;
 	struct snd_rawmidi_status status;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
 
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err = snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err = snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
