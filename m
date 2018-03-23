Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802352-2-9215638499437708929
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
    t=1521802351; b=GVJsNl0Ke3ZdXZklcsLs9FizGyWAIySr8PXdLDP2Ovnd2Xx
    Vlvt+aWpObqjVvSmddX9c6sQHRLD1xxUGAPDvtyo/Md1h8FO+y3wnHQcW7ysW+QJ
    8Fpe/S7d9+8bICeHulcwCX5SJZJko5vaqdsZ3src5DuCGlbmCsB0BfTadgHs5k0w
    TQ2C/lvxXU+Sd89QgF/NDjykOqFORE0VVHKE84vVDWBr4FZI7XYe7DWejvEG0Qcx
    6xvF/Irmh7j+2DODtNLlG+8B5RXNxM2mXuDy4ob+wB2QGNgW52UPFXaLfpeKB+pm
    hFoamRyrMP6wHScoc5jdQ8KkJr/AajgVlKqiTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802351; bh=1fGt8G6xCr8JpU9PddLVcuRaTi
    IRSKqJESt3pyZFyGw=; b=k8FvhnafKYpztm6eygTT/WfsBYfeixmgwu+1ky0S37
    Gxp+WIDdBZRTQ75NcnBOmFtgcgZ/wmeV7Ayh7qBVHgHFAals7278I5+4rjraLpcV
    AmUvbe/J4RRqMRLchcqHhJX7tLdqCBtY7MMq0K7ziTtKJdWEU92jhAIIE2StwCdl
    SwChhhu+tUXNawUVfSeWJx+yCDlksbgZkss1B/ViXPE1uxHFsNkhOYolcmBtu5qE
    N2Eh+8/lL4smCCF4XVjDIKUN/Nq/8leYLSeq7MvXWmwcnThw/WXjqcRLHiekN1+6
    Fj5Q4uUViSmWhN+c1OPLK6jB/7qu6Pr3gSWMRu4Py3/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1755181AbeCWKwX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:52:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755968AbeCWKOE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Paulyshka <me@mixaill.tk>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 30/97] ALSA: hda - Fix headset microphone detection for ASUS N551 and N751
Date: Fri, 23 Mar 2018 10:54:17 +0100
Message-Id: <20180323094159.325224861@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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
@@ -6717,6 +6717,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
 };
 
@@ -6964,14 +6965,21 @@ static const struct hda_fixup alc662_fix
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
 };
 
