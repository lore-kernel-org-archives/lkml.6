Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2483311-1525767131-2-7180816456634205973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525767130; b=fd3SV6+tDSJ4gRB5xoaL45PIADpBre4Ln3GxWqr/2FoYmKJY8A
    p0f+JJiYhaADnPeScTSzGSo+pC5BOD7e7MsU/IQ5KH6p1PkVYgkzLqXXkAIsJXwv
    eJVFyW2mxMdWw+lhBD1yynUjxysE5SSC5Gt+EhgopJ+3n37qFwQGGVu7O0yn2y05
    2w24hJ1S4tatPtZInnIVyOysYhIx264CivqGNCpFrLis4UNwKzkevzN0rVIBXsr1
    vtWVIDtx0lbqsJs1tnqGdjikKjODaSX2YSC1cQxMCgWyhyT15/QQOJmlX1WkK5i1
    38eC7M+XDUolz/iqkMJhGh7/QKNjT3CXMh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525767130; bh=nwnRXKJ/PIxAqPBvyBFU9y1KldZc3W
    fChLWmExP6bU0=; b=S8pOBZEc20ZHHqixhaWLJmsMRMJB0UiZWOsZFHcaw/l03X
    n9WQhByjuayH0P/HSIZsbrN+wP0+cIu7Tud3AnMfE8GpYrToD1PiMZ5G8ursp75Y
    dUZTns2/NFNr+NVALDCmaMwh9igJ77mJU21T2wCt1TCPWNCXOr7yNpBQ8Pw7LNfk
    Kpv99Wn5nbtGhL/4XGmrXP8frrMTXlsDlfUuB9iWFKZLiC6h1FdxOdE5wHfC9y43
    GuippmIS9+gAYc1OfzPdTCehOfAC5ekJ4GCZixctQpRbLFo1tb3jOXsThAu5ChTJ
    hfXpkbn9O1XOD7Wu4dllyNOXNKYl1VbglJxiu47A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pmeUNRvr x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=pmeUNRvr x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJYxkTzc5hk21ZmOlRHzabfoGpzTWv7mb4tP3ebyzUO/OvW1t1w1pGFVn22/t/J52nqJ6zxQoFK6FXMyNnfC72nsKK3WVPud09ryoe1nJAr7ROqVD6Zg
    sfzVdzPZBAuUqUmypz9uZHKoXPd4IMAuE7j0BXPLuD+AxDClucJs7+nLFMPOmcPc5jyKmD15i3GlfTCIbN/FnAV9H3EcpR4Gs+rF+hWl/UsstS+Ci2GJGDFJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=a8odm4thDjT3yH3-VcoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeEHIMG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754343AbeEHIME (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 04:12:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, DaeRyong Jeong <threeearcat@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 05/52] ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
Date: Tue,  8 May 2018 10:10:03 +0200
Message-Id: <20180508073928.749948928@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8f22e52528cc372b218b5f100457469615c733ce upstream.

The sequencer virmidi code has an open race at its output trigger
callback: namely, virmidi keeps only one event packet for processing
while it doesn't protect for concurrent output trigger calls.

snd_virmidi_output_trigger() tries to process the previously
unfinished event before starting encoding the given MIDI stream, but
this is done without any lock.  Meanwhile, if another rawmidi stream
starts the output trigger, this proceeds further, and overwrites the
event package that is being processed in another thread.  This
eventually corrupts and may lead to the invalid memory access if the
event type is like SYSEX.

The fix is just to move the spinlock to cover both the pending event
and the new stream.

The bug was spotted by a new fuzzer, RaceFuzzer.

BugLink: http://lkml.kernel.org/r/20180426045223.GA15307@dragonet.kaist.ac.kr
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_virmidi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -174,12 +174,12 @@ static void snd_virmidi_output_trigger(s
 			}
 			return;
 		}
+		spin_lock_irqsave(&substream->runtime->lock, flags);
 		if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
 			if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
-				return;
+				goto out;
 			vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
 		}
-		spin_lock_irqsave(&substream->runtime->lock, flags);
 		while (1) {
 			count = __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
 			if (count <= 0)
