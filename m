Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172477-2-10252103592556972407
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
    t=1522172476; b=rLCINWAnB4dkcfuuAUTnOvqH/Q2mieR6AUReyixpnuU6BSI
    q5j1of/1c2jP5cURKgoQLeQ9uy4kQ0eOzPmdaG2pCnU9AC2X1xY2vkDh/G6cX6f9
    9L+jKZo/PScxhY/PrxuOKmnIf/X8f3mKtmadz2xef453k4HoThhtkSoXop3WXJd7
    oDEs0acoeq53IlSRYvz8aYn5lS0BVAtdq3t/jdVCaewN6V/zeyFzQr705Vp4iMyw
    rvw1H1HaiYw5g+Jnz/HQi883BbehekG4bGWhrZN8inqtU0nM7NO0tOQO1OggHM0i
    fPKy0gEkJio0PCjjBtPSXHZ4un0AAjjqxfkgclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172476; bh=wCTTHZor2osvjCegWZr5rf6GZa
    y9riyctHlM7JmNdwY=; b=gOhsKiT2EZG7/HeVM9hyLnS3QtsDJiMg9hhejTpQs3
    N6yHTUqgvIU5L2XRuHa8pej/V3kvtrU/ihyYYfrI6PnYSI40ouvZYQiOXesTJKad
    KsH3G5H17mA1an3iyQyp71S6yxaTqNXtebagUSj/sX2W34MY8gnjNDn+RQDwJMLe
    tcftavwmQqSHWzt5WP8ZsrG+Yvxd/nN/G3BOPAJjVugpf643NFsPwad6zhZJldCF
    0KBE6joCyG9fP/4Kx79GjEuG7DalaG3kSDKTswrNGCotSVgehPhZTJ9DwB/mXpBS
    Nk6MCsHfGj8ryqxgs6vtjOdBmerVq5PQPiiUWZQsodrw==
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
X-CM-Envelope: MS4wfHdF9HPlGbj6Y/tHfyEWsYKJ7gZofB7E/RPAqXLhRgm0wI3sfM94TKosW0yXDLcRz9GAJKL1mHutZHZZyvvSxOWwzxgTRegYWOBAk35rw7ff7ber64l9
    +k68KLT3aG0qDENNVL4WARx6ywAIW3Zl2Gh4DWMyH8KgULl+3jmYbGbbc3WshN6IKXYWP0bJ2OqNet44Z3yTqNEQGBcmnMBtmUoGLQP0CNM4QT1nJHr8DdrG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=n9Sqmae0AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=faaN5MpH8Yv26IJOdYYA:9
    a=QEXdDO2ut3YA:10 a=UmAUUZEt6-oIqEbegvw9:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeC0QeC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeC0QeA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 013/101] ALSA: hda/realtek - Fix speaker no sound after system resume
Date: Tue, 27 Mar 2018 18:26:45 +0200
Message-Id: <20180327162750.799407678@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit 88d42b2b45d7208cc872c2c9dec0b1ae6c6008d7 upstream.

It will have a chance speaker no sound after system resume.
To toggle NID 0x53 index 0x2 bit 15 will solve this issue.
This usage will also suitable with ALC256.

Fixes: 4a219ef8f370 ("ALSA: hda/realtek - Add ALC256 HP depop function")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3107,6 +3107,8 @@ static void alc256_init(struct hda_codec
 
 	alc_update_coef_idx(codec, 0x46, 3 << 12, 0);
 	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
+	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 1 << 15); /* Clear bit */
+	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 0 << 15);
 }
 
 static void alc256_shutup(struct hda_codec *codec)
@@ -7004,6 +7006,8 @@ static int patch_alc269(struct hda_codec
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
+		spec->shutup = alc256_shutup;
+		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0215:
