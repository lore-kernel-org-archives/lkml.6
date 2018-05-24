Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156256-2-4959017918844201643
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
    1527156256; b=W8/ouMaP5Ek/C0VNV4yrKBXonvfZDNprXtYYpDwEvZumDwZetC
    uHyDloIjm3/OsonDOsalOuU2qpGpqDvrzCUKGFj1lw6tGTRZ4RsxtBngXyXZ6lwq
    Ar8ao5AvfKd1LpdUD5RRz1/DNpynBAdTOmMJoeAFISwZADtEr0Gji9X7NxBcme3X
    Bp3djW27pEo2Jf3SNxyH18k6OlKo34qz6sUPT+QkKzghAy7yI0XJn7fSGzhoV6Ue
    HO+X0dCukdpkabEY8wXJimNOwo7Y0zooZOliReG03Fw0Lkd4SmgYOswb9fz8hEni
    Pd5jlWE5J3wv6/xnHuWWSniKwPjln1EDsLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156256; bh=GmhWlfkLT5EvrrstvHSWGC6qFLV+zJ
    0h98MPL0ImMuQ=; b=WTS1TfH2HRHTb/6WHejm5VYnNL/8xOvf93JwbkwszuUrXG
    1nx4eBe2r8/6uvGbaQan/qZJtb5XCn3biFqJ8RaldqwtKXgtJHovroK+Ts3q3CCo
    PFNoQ78/APPXTPTKqIFbx3DcE89uN93/A5vneEEh1AHvYuLsW5x0qv5gdrUDr/6Z
    BoZgWcB+t+dbl3ghlX+0pDx2J0+Fzc+88pHpoRtXSr1CXf5TPtFHmU65fH5tNhMd
    Gk8D9Kx/DHBrCIG2fus7lD5/OxRN+SKfldbjpTK1gyEAPAM0k6ONE1Rxf05GPKtW
    D/qDMn57wGxmrN9W93pNN2BtuNJtFrF527LBfH4w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IZB9pgiz x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IZB9pgiz x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCHvz4pGw9GZ206Uork7JgQE+V70TzgJAh7o+64BNjjXJdPOwv3zbg85p3rjqGFIDnDeY4Y4woeE/gZ+Y6mMjX+0pz0/nd6cuwMRnRmyO/ZbA2qhS2Ld
    X59+RL22WrF5QQmZKMWZlzO1NCjM7Qw/OZJJS/ay/4fgv9nnCdoMR/kfPhf13GHDkOr3a6vSSiimnreoc2ZtaLH0Zh9vZUUblTZHUCMfdTFioua+u2nDqOo9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-1aYBIiNm3zyKIbkVQIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031384AbeEXKEM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031344AbeEXKEK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:04:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 118/161] ASoC: samsung: odroid: Fix 32000 sample rate handling
Date: Thu, 24 May 2018 11:39:03 +0200
Message-Id: <20180524093032.442149893@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 1d22c337dc8f3a25638f7262e7bcb5729a34d140 ]

In case of sample rates lower than 44100 currently there is too low MCLK
frequency set for the CODEC. Playback fails with following errors:

$ speaker-test -c2 -t sine -f 1500 -l2 -r 32000

Sine wave rate is 1500.0000Hz
Rate set to 32000Hz (requested 32000Hz)
Buffer size range from 128 to 131072
Period size range from 64 to 65536
Using max buffer size 131072
Periods = 4
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument

[  497.883700] max98090 1-0010: Invalid master clock frequency

To fix this the I2S root clock's frequency is increased, depending
on sampling rate.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/samsung/odroid.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -36,23 +36,26 @@ static int odroid_card_hw_params(struct
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	unsigned int pll_freq, rclk_freq;
+	unsigned int pll_freq, rclk_freq, rfs;
 	int ret;
 
 	switch (params_rate(params)) {
-	case 32000:
 	case 64000:
-		pll_freq = 131072006U;
+		pll_freq = 196608001U;
+		rfs = 384;
 		break;
 	case 44100:
 	case 88200:
 	case 176400:
 		pll_freq = 180633609U;
+		rfs = 512;
 		break;
+	case 32000:
 	case 48000:
 	case 96000:
 	case 192000:
 		pll_freq = 196608001U;
+		rfs = 512;
 		break;
 	default:
 		return -EINVAL;
@@ -67,7 +70,7 @@ static int odroid_card_hw_params(struct
 	 *  frequency values due to the EPLL output frequency not being exact
 	 *  multiple of the audio sampling rate.
 	 */
-	rclk_freq = params_rate(params) * 256 + 1;
+	rclk_freq = params_rate(params) * rfs + 1;
 
 	ret = clk_set_rate(priv->sclk_i2s, rclk_freq);
 	if (ret < 0)
