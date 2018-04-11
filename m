Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479642-2-6059152600926429579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479642; b=dus8D8uNEOZeJ9CNwZ4jGNGBvY3QGdMGxRhc5YOdoxJ2xrH4/p
    QzyxJ4qKgJb0BmxlkCm1tlEYp3hlowVlGEkmA1sjOjhtwRBJKYvs1BIM0Wp+F1iK
    TjRSlAxlDw0CeVa/CkInIDqWLib/a6Bj3B6Z/1ixuQcvC1jey3JsN/GXqFxENIJr
    23RF0r3fAayQQtcL04YBbZ9UCEdELO9LG1YoDBcPSLW5lF2z0rVxX3uCDzOF6QGS
    6cEdDFZ6U0tRoXu4YFv6/0X3gqWkCTzjc0xFRhmHSz1MUC73uZVRTvNnSBahlgnS
    2vUGs0vy/qGMTAubKNWfaqoyv/JwZm7/B8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479642; bh=WFBhxlCenEYOPtDpHrWrR1Bf7E4n8V
    wofuwtmetZYL4=; b=khVPuTzmb92f5OHH1YgpIDdOofK3pwDIOwC/8uWMoqZC4U
    wFt3kkdGtNlag0Z4xtDPfWJLvwmURWo9ZB5EOEfcdV6TTRDzOG1TLpLXYnNoCeK2
    vQ7rzxoA/G7mdb7LS/N4QcGmTnr7bDNuAMDYTOfm6CCaUdr85vPoGeaLalcbgO8h
    dV6PXjOYam4oJ7QfLxw+ElSjWyMSMhmGkWhFQwXNqstXji0+cURN7EA1GINaWvoD
    P1yBXmMF3b5H49HR/W/BRmAGAILTsECARzVOcfYz7g8lCVmN3HkEYyyFrEeBsgIZ
    l0E3+eonoS8FWmWt3/GUVeHKw+YpIEVUS2uyHihA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfHHvmbvSU1ilSECEqEu8vZIXoU1c5aM6NaAJBcUxj7vqWpe1Vo9PR34qEh+1+kOtV3+7SQtsqashenLCMCsybFq1TuNeh6x1Lopb1HMOvyRi1rtH0rnX
    zMIW4BD9hvU9jkPek+vWHtrggrQmztCktVTuEfj55pRibs13oUkKbmTo09wDtTk+eUPGv3pUd5cyLoczz/YwEQPiC5WoU/LUQyEe/ZVvAzI2ktZ+qY7S0tDm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=3aRVpg73mdcFBhZDVc8A:9 a=QEXdDO2ut3YA:10 a=QsnFDINu91a9xkgZirup:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbeDKSqd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932361AbeDKSqb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 071/190] ASoC: rsnd: SSI PIO adjust to 24bit mode
Date: Wed, 11 Apr 2018 20:35:17 +0200
Message-Id: <20180411183554.456946126@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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
@@ -453,6 +453,13 @@ static void __rsnd_ssi_interrupt(struct
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
@@ -460,9 +467,9 @@ static void __rsnd_ssi_interrupt(struct
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
