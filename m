Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116392-5-10688252277882860248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116392; b=DcLCXzwBuGlyJlj6kbzJWTB1zfuTw6dCmV6fOK0Lu8UmV1nUXZ
    LbMUG9YeEqL6t5L73EYQTGMb9P3lMJV56EAdGhlOlaNHcRnV74ZmVbCeJDpGHgE0
    TyZ+YYIxZNP4UnZ1QkeDImOp38VYcyPKzyBNQiQCbtgA9QKuUCyLC+w3hG3Ay/3e
    Z2iRJWgbnOou3/I+H5cIWLb4DJtFxTmvZkAdQGw198FnZa0zxCW/fUYsm0TebZ0B
    5b/R8yQ3A/vkryTBuuL1Fp8xUldsE72blWEebfO33RjBckEW/dEbeCmKDOrMBA+7
    Sjlohcwxj2JweEdH98cRZDDkD/Rx30siC3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116392; bh=8KwZPFSe28Xd8wlxfx2M5ZqXMVJUiQ
    r4zqjXWUi/Gdg=; b=X8ryPFFKVSpv/rI1XoJxx82FxI13wbtNiRZJbbct5shv5x
    5syUUksaFuEbvl0u4RqgSqAKxT222Sl+F5Y0k9ctpiTxP1zdxb/EtKUkErOzLjcn
    oGbbnTbAohURwDHQZklE646ls+ioxDCLanvv6wn8YqUty0XSnDhDITsWRazZOJlA
    /1UuUce/kGT1JGOdOFFralS1Jh5HRr0IfgMGeXyiTSrUFY+KmpvpUtYAcdn53zoc
    krccs/Ep9wMhPDglfOhaFkwNYH1/Rygf61hVZse5WXwklewRG1dYbnwwXP7Mva34
    jFtiy0d3TNrC0M949AVtaiZ83QzNzJjEaOlVY1sQ==
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
X-CM-Envelope: MS4wfPe7Q9PKCCgarSqIutMBwZ4dG8vvgN8IFvL+l8GLrFUjE+VAbYF4vW7U3xfeBnTwEx596U2iSUEs2+wJn6/ek6HAjyzU1mb32lyErzRlJrWZfhd8vlbS
    i3z4KLb3kOB12SxIJ21ygkA/hjS1RoASljZsa1B4k8VQqXOy8x+P4U76aCsscQowGKKh9MNcAM4bVZLZS/OADwxdMNQ5HkdiM59axHjQYsdBjwVM3OG/w+vE
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=dtPC2VOzn14TCzhVhWMA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbeD3T02 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754120AbeD3T01 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E07422E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 26/61] ALSA: opl3: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:29 -0700
Message-Id: <20180430183953.663995864@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 7f054a5bee0987f1e2d4e59daea462421c76f2cb upstream.

As recently Smatch suggested, one place in OPL3 driver may expand the
array directly from the user-space value with speculation:
  sound/drivers/opl3/opl3_synth.c:476 snd_opl3_set_voice() warn: potential spectre issue 'snd_opl3_regmap'

This patch puts array_index_nospec() for hardening against it.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/opl3/opl3_synth.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -21,6 +21,7 @@
 
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <sound/opl3.h>
 #include <sound/asound_fm.h>
 
@@ -448,7 +449,7 @@ static int snd_opl3_set_voice(struct snd
 {
 	unsigned short reg_side;
 	unsigned char op_offset;
-	unsigned char voice_offset;
+	unsigned char voice_offset, voice_op;
 
 	unsigned short opl3_reg;
 	unsigned char reg_val;
@@ -473,7 +474,9 @@ static int snd_opl3_set_voice(struct snd
 		voice_offset = voice->voice - MAX_OPL2_VOICES;
 	}
 	/* Get register offset of operator */
-	op_offset = snd_opl3_regmap[voice_offset][voice->op];
+	voice_offset = array_index_nospec(voice_offset, MAX_OPL2_VOICES);
+	voice_op = array_index_nospec(voice->op, 4);
+	op_offset = snd_opl3_regmap[voice_offset][voice_op];
 
 	reg_val = 0x00;
 	/* Set amplitude modulation (tremolo) effect */
