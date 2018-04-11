Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476272-2-8237666682016069600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476272; b=n6Fni2MIijCwEFomoModKraZEAd5Pzct0BKfrKTW54dljOezuR
    183/DXn72fpDXYvu8qYv+/uoE38PHm8NTtxNTyDkBqXPu3/isvfinMnHW3M1oXOB
    WX+sXirDZ4iiECBGhlmbjSt/f5LNzkjFU1hRv+90J3yQ9InanqLZc0faa55euoOC
    IrAxNiDqWqGfZHz1Jfqu/V7umNO6620LjMvqNlSARn9AeFdiXTZqN+nPyOtrRIVY
    Kn7V4BbQuJdxOXR93h0o3o1bH07D60uBSKk6IChk5Guxm0NbnunhjPjV9J0bOkmQ
    WY9CbTBfdLcgW5fWbd+t/xGw0uXHM/KytiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476272; bh=49VzKqGJNXRt4Ota+DpIyJgBC+3JKw
    Zf2HBVnGzLRC8=; b=q77T/TuQ2RGvfr8v/JIC7xhpwfHDFPxQXXbYK9gv+60rAN
    SkBYiCoNQfw80M/7i47x7eWNazo7thjT1n1VQIGZjx/JGwW+fVrh82GaAv8n9W/0
    9jhl8odkZEXbshRqxfYs/yQLx6YpqYRTVW4hfdNCq6JszxAh6nqxOghljA5MDCHJ
    tu4Q9So/mULjpBwp+lz5eVn1vfX7IP2xeG+zpNKHKn8nQVh12V6jcihrFDp7zYmc
    ZgFsBnt5cHhEXKQcbnOVrZMfNxyP2ELJGlv6UGkqconCG+7PHrmwBipNmzWNd5qH
    ofiESUJkcjLNOL+cagkcyHMaeY1sr+UX4OmurLYQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfECBdLtxeeq5a8sF2QEtMU0R0pedyRU/qzjcSBLfTOa9fF/t1AmuaZQNqDT7fnKde6UH2JxNaC7dScAwfX+wNinASSf/aHwwwCJfxWuEX0W+VWZa8g2L
    VNkxs+vxu5u9jDqLRszy2drJYC+7/PB7n7JcjJ4BkG1x8AopfHDMbLD1vru8pN1G9eX+G6JGCOZQ4+GsUpeU+OzzZEIo5Vc3voPvKUblFfJHXDE75eHcK/hq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=3aRVpg73mdcFBhZDVc8A:9 a=QEXdDO2ut3YA:10 a=QsnFDINu91a9xkgZirup:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbeDKS61 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:58:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36686 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeDKS6Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 104/310] ASoC: rsnd: SSI PIO adjust to 24bit mode
Date: Wed, 11 Apr 2018 20:34:03 +0200
Message-Id: <20180411183626.692654972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


[ Upstream commit 7819a942de7b993771bd9377babc80485fe7606b ]

commit 90431eb49bff ("ASoC: rsnd: don't use PDTA bit for 24bit on SSI")
fixups 24bit mode data alignment, but PIO was not cared.
This patch fixes PIO mode 24bit data alignment

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/ssi.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -552,6 +552,13 @@ static void __rsnd_ssi_interrupt(struct
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 		u32 *buf = (u32 *)(runtime->dma_area +
 				   rsnd_dai_pointer_offset(io, 0));
+		int shift = 0;
+
+		switch (runtime->sample_bits) {
+		case 32:
+			shift = 8;
+			break;
+		}
 
 		/*
 		 * 8/16/32 data can be assesse to TDR/RDR register
@@ -559,9 +566,9 @@ static void __rsnd_ssi_interrupt(struct
 		 * see rsnd_ssi_init()
 		 */
 		if (rsnd_io_is_play(io))
-			rsnd_mod_write(mod, SSITDR, *buf);
+			rsnd_mod_write(mod, SSITDR, (*buf) << shift);
 		else
-			*buf = rsnd_mod_read(mod, SSIRDR);
+			*buf = (rsnd_mod_read(mod, SSIRDR) >> shift);
 
 		elapsed = rsnd_dai_pointer_update(io, sizeof(*buf));
 	}
