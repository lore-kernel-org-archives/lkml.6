Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476259-2-45752141185373598
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
    1523476258; b=ZA6kETLNZsPURgvs+d9osbAxNLGXd3ZFlTBeFtN67RXhbvZMEi
    wvsDoNFOKyv2K4t6gH8xRF3TbR6yhtWrZmL7nhVdcVculRXvQloCmcKl+5Jxm6qP
    sKz2HD5UPXoWU+Emt8hFJnvRMbSZ8f7VorlQQXw3nBR8DKCZEo19Gd97Moxb/+NL
    9pn9QBq2oIRaU/rFa2jOeSLmFKZOJ287dHxzu1R48O41Wn73gWqbIfCGlTJXA5V4
    42PTeSaKcOs75SITMMmGFBJDDDQtdQC2W1jKET8oOf1A9S0rh4ZmrI3G1HhaLwIJ
    QiK68/t2GViP6Pyej5dDZXsInoszcbhNbBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476258; bh=tEa7nnDh3i5wQyylkesNxFlhEiFpBU
    PT5IrcAJTcF7s=; b=JuVvJ7QaZUwUgF8eJp3KImsMAJsVbRx4zvUqkIfQiNIuxN
    Qtjlt+OWXfH4wxAc4Dypzy5rWDAIxQ6UDzVaH4h0gd+QVWGWh+PhLYGnapHyQ5jS
    xhkJKSSBsQI+jqmT9eTlhfjN2A8NtdSoQ6xywpaoB0xW/bQrF8qWbujxH+n7XUb4
    ljQO1hvvGx1VZqzXe/U/zjIbkqr9b0Ebqmz3kvkOX9N/QBjOBpL6AvNyqUncRyVk
    L0kJzSBHAfkAOkAkpy61TjuZLoJLU0Gz8YIFVlLfplYwNu+F1CZOa9gvgBVYaaaC
    dK2wRHDXuqoTtMvsUggb65HiAYgW/mOEYNMTRwWQ==
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
X-CM-Envelope: MS4wfEyZvx29xECcJxoqXiPegF5VGzK3y9E2bdXDmPMPy6+CiwLWsS7CeqJr32/RGvGg1iXatsI5AFfZdp4HlWRK54hPh1DcwNJIDCTUxihe2YWiUxLLzE4/
    bEOtxel9R4TNoutcIubA1mMOj954GYCm/P2ALZNBmo17JmALK4ueFd+8Sj8vmXbcdXiCXGnlV9nst3n0NalyEm/4fd5Pebo7FI3MBDZhT4iOFcBfx66q3xsh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=YlIGuZlHL28rWg6DWV4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbeDKTuq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:50:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754389AbeDKS6b (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 132/310] ASoC: Intel: Skylake: Disable clock gating during firmware and library download
Date: Wed, 11 Apr 2018 20:34:31 +0200
Message-Id: <20180411183628.150695378@linuxfoundation.org>
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

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>


[ Upstream commit d5cc0a1fcbb5ddbef9fdd4c4a978da3254ddbf37 ]

During firmware and library download, sometimes it is observed that
firmware and library download is timed-out resulting into probe failure.

This patch disables dynamic clock gating while firmware and library
download.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/skl-messages.c |    4 ++++
 sound/soc/intel/skylake/skl-pcm.c      |    4 ++++
 2 files changed, 8 insertions(+)

--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -331,7 +331,11 @@ int skl_resume_dsp(struct skl *skl)
 	if (skl->skl_sst->is_first_boot == true)
 		return 0;
 
+	/* disable dynamic clock gating during fw and lib download */
+	ctx->enable_miscbdcge(ctx->dev, false);
+
 	ret = skl_dsp_wake(ctx->dsp);
+	ctx->enable_miscbdcge(ctx->dev, true);
 	if (ret < 0)
 		return ret;
 
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1191,7 +1191,11 @@ static int skl_platform_soc_probe(struct
 			return -EIO;
 		}
 
+		/* disable dynamic clock gating during fw and lib download */
+		skl->skl_sst->enable_miscbdcge(platform->dev, false);
+
 		ret = ops->init_fw(platform->dev, skl->skl_sst);
+		skl->skl_sst->enable_miscbdcge(platform->dev, true);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
 			return ret;
