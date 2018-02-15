Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720721-5-13989740149206518807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720721; b=h/wmF93rZ3vlVkOCa15W0TrxTO5PgA5E1qkjMboD34LDqxb
    PfnUz9SzVEDA2Xrs+yhMTSl7kaKX4m95Bxd6yLmBDglCG4GyfqkiMzDCXzFnInRp
    q4KhpRVAmFlJwM92MxRvUNiX4Fq/lxErl8IfqG8oNfreUldU+gQkBXigY/Erk6B6
    7xatSsiMXDidmSYDwpqUsBav5ZQbkcAA1owpDFa09237DV66v3A/CE/n71gDrl8b
    KoaRBMXDdZ6Kk0gPffgWqLfHkb7YdOgf9Td4eJHpEE+hICqpdYqNb/Vf30sF6YeK
    xD5fJIdGpLhBVek4Dlqr7ryuSzkJ75MM78KueOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720721; bh=peg3wykYFGXU9t6TLhCl4AdfXR
    Gzqcw+jXxTE02hvEk=; b=HHY7x9SeN+6aEdb3kXg+/8Ep6BefZcXB+cQ+ZCZFBG
    yBl8RlIv7zein8tU9jkPZLWSOAOokbixQ25WS1dNWGeGUzvRPcDaS+jzwXCuRkoz
    bdL5Nve2PjAdTPMJS7VCHIDtsKg0V8wXhmt7CGPVwS64faD/AmHW4zTWPytnhYcs
    b3qyQ1cVPjWlCScCv4hmBn5bPfGjnKaD2hM6GfwNevVzRvzBq+UR2DdaojTlqys2
    clrxoMTHlqtPWxQTpUoklFI5C8UEmE78qFWZb9vcb1pm8ZxGTKgsBmw1IuUIY00h
    V1bmbYkDaehbXn/NyuFY3Wr3ree0FHDxmZ0R5NaH75ig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161999AbeBOPVW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162036AbeBOPVV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.4 022/108] ASoC: rsnd: dont call free_irq() on Parent SSI
Date: Thu, 15 Feb 2018 16:16:19 +0100
Message-Id: <20180215151225.677191137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
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

commit 1f8754d4daea5f257370a52a30fcb22798c54516 upstream.

If SSI uses shared pin, some SSI will be used as parent SSI.
Then, normal SSI's remove and Parent SSI's remove
(these are same SSI) will be called when unbind or remove timing.
In this case, free_irq() will be called twice.
This patch solve this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: thongsyho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/rsnd.h |    2 ++
 sound/soc/sh/rcar/ssi.c  |    5 +++++
 2 files changed, 7 insertions(+)

--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -235,6 +235,7 @@ enum rsnd_mod_type {
 	RSND_MOD_MIX,
 	RSND_MOD_CTU,
 	RSND_MOD_SRC,
+	RSND_MOD_SSIP, /* SSI parent */
 	RSND_MOD_SSI,
 	RSND_MOD_MAX,
 };
@@ -365,6 +366,7 @@ struct rsnd_dai_stream {
 };
 #define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
 #define rsnd_io_to_mod_ssi(io)	rsnd_io_to_mod((io), RSND_MOD_SSI)
+#define rsnd_io_to_mod_ssip(io) rsnd_io_to_mod((io), RSND_MOD_SSIP)
 #define rsnd_io_to_mod_src(io)	rsnd_io_to_mod((io), RSND_MOD_SRC)
 #define rsnd_io_to_mod_ctu(io)	rsnd_io_to_mod((io), RSND_MOD_CTU)
 #define rsnd_io_to_mod_mix(io)	rsnd_io_to_mod((io), RSND_MOD_MIX)
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -550,11 +550,16 @@ static int rsnd_ssi_dma_remove(struct rs
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int irq = ssi->info->irq;
 
 	rsnd_dma_quit(io, rsnd_mod_to_dma(mod));
 
+	/* Do nothing for SSI parent mod */
+	if (ssi_parent_mod == mod)
+		return 0;
+
 	/* PIO will request IRQ again */
 	devm_free_irq(dev, irq, mod);
 
