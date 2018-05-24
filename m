Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164277-2-13644600745522843989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164277; b=Y9wbBPVTysI2fMwozy+qFZDpDhFqqmeHwfd3SLZJUhj4YkFb+S
    C4PXwwWywZCw21BAZUfCjyw1jNHsp6tsQz+vA4Ci2ATyXg+QfG6P1982rt9Nqh3m
    th/jtIUouSE3yl5wzU1soPmNaC31lyO/fPWDT5PA9UdP9xIizKw6OSR9WwgQV2HM
    T65R87jvjITjA28trj0CG9bAEcAemvdE/SLCaoozoM5ZlyzjovfE3StNcy60u6jY
    RfgvAKqo1U7DYo4Vse4bHuFXjFXDWEmC3fmEzENCauDUC2QLq9tWSkVSr1YdUTkU
    4a1B19CLW35wUStA/Kv/HyPMyPuy3Ku7E/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164277; bh=SbvSf79iNYUHBn2HP9UBUdv5sX2Jh7
    KoJwAqSGZh+Pw=; b=OS71gI57WxZJV66WI0tO0DAKf9ZC/bBOBtZYCGhPxv/Pos
    RJwlD4hraCF2B4dgkWfXMuQy7IelL8cCRuOJdkJfREinXnu98JJ5B7yeiEWsvdNE
    xOyG4jiayj32OR7l0jQ8PD1ANvn9jZsyotS5Hfi3uEsWl43iz91Jcutd2MPFQnjW
    J98P1mkbRpoU+IJwv79kepOrBFh0yZAtLh/9/HwszNVakcRu1ijCfpKIwfMLQ4ee
    mxaLaNGmZiLaltfAyjksZnSeyGKkXy42Q2cbMP4rqQVWunQTUZ2asSEaVy9U97Ju
    HSvhxEsTz3fi2XzzOM1lrQv03gVKnLQ66Z9SAo/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HYGTvVpy x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HYGTvVpy x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKKua4oXeomV4eWw3D79/KCJx2ulDADsHLyXLgI3UrQdiM9XxHh4l5T769twpIthOMHwZpwwd7sx9GAKkt89DPZ/rHU8pTqXMAl6mtA+7AyhXBfP7ekr
    b6ZtqhxfB+0JIon49pdQt0Ur+0eWqTL6prMv/H5uxkceo6vMV+Tz2Wpw3+yAmydQVTBM8Lmff+xIlaRlmldaNKuhtM9N5YuP0cBP+XUAKH0QSEgsozMUlvHT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=J2zoVyZDAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ZwEik9AnzkoCkD7mK00A:9
    a=QEXdDO2ut3YA:10 a=DvW0qZC7_2Hvvf243_-1:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966235AbeEXJlp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966216AbeEXJlm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Federico Cuello <fedux@fedux.com.ar>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 29/45] ALSA: usb: mixer: volume quirk for CM102-A+/102S+
Date: Thu, 24 May 2018 11:38:37 +0200
Message-Id: <20180524093124.301878739@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Federico Cuello <fedux@fedux.com.ar>

commit 21493316a3c4598f308d5a9fa31cc74639c4caff upstream.

Currently it's not possible to set volume lower than 26% (it just mutes).

Also fixes this warning:

  Warning! Unlikely big volume range (=9472), cval->res is probably wrong.
  [13] FU [PCM Playback Volume] ch = 2, val = -9473/-1/1

, and volume works fine for full range.

Signed-off-by: Federico Cuello <fedux@fedux.com.ar>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -883,6 +883,14 @@ static void volume_control_quirks(struct
 		}
 		break;
 
+	case USB_ID(0x0d8c, 0x0103):
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				 "set volume quirk for CM102-A+/102S+\n");
+			cval->min = -256;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
