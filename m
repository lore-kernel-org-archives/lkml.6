Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652838-2-8319969633662646998
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652838; b=pYhRcfa4CSsCcm7zDuZbVulub1XTCj3WkQYcd6Sp5/2Znin+YT
    CC9YdbGgBxoepp0SucAD8kng/s6VmKbT/rJpGdGcNp9wgP7IaOXZnJQaF56cA6zO
    5juND4Yx30gCPyYzIBgtF5odiICxuImfStJmm4AdQtP6V41FfVPAnWZ0qqUsbpJD
    qC0etVFMMglHCVkYo403JFW2q4PAfATtyAg25ID1B0rCAINMX8q5QhvbU76AHmWl
    GDei+tck0QwDDuw69kXV1ZpW+JC/33VrSKYAGMnKeiFJQjZVYqHX8yBbXJ0KCKSz
    zAaSXI2hYTIBzx/AjW3x5DHM3I2ABrfOKHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652838; bh=x7sw42kPkshT/Eww6W/6MDf/4o2m4C
    oCTPqkxjzXHKs=; b=pHfdBVAa6SpyKG5H2f8WN2ib3Q4EhRqYjg0ISyV5Ls8jte
    LYEy9eMu6/taE7Y4O/ET5qoY/9xub95pgxRvmCQRQz1Kc0if6bXqofP4tEC6XoFM
    17V0gvaWLO95h9W8oOwIodfXIaalCDaUW83duYy5DGiuz4MEBR15yT4JJLUtTTeC
    VNJxGuXy8rz5R7GkxFDrMDeZXUQ3pGrfA1aE+YRBOjYSRBJGoeefVKu7s0fDscbj
    9cxqc4cOtul06wrsREYyunEyFhyRUA6M+2dGd4IgcfhiFBvxY9xUnTmZ8e3aQQQ2
    DE267tdQDMlaIabSROoXQRuE9QmiRPUjoRO3+oSA==
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
X-CM-Envelope: MS4wfCjwVCHZPDe+U0JiNbfz/EVuX1bTglbEzJ81pYqLPlNP8lg2fMW9oaxeZif+w5Qh67nc8B+nER7ILJoo6wHXBfotNW65Kqbh2WWoXmD+kNI9pdlqLvWN
    rI3x61nzGZABF/IAFZ9Lue9Z3rYmzr7TZWhYhTkr/tt+5Y509e4Y2EelXEw5F1jJ4SJKGTQ/51EtYABBqTo7DKZVzPKI0akvPvpBY+686dx7JR9GpOFj3Ily
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=s8YR1HE3AAAA:8 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=dOWJWV5Flkr-bMFZBqYA:9 a=QEXdDO2ut3YA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDYKkb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:40:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDYKkZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:40:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 083/183] ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink
Date: Wed, 25 Apr 2018 12:35:03 +0200
Message-Id: <20180425103245.836344112@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Jeffy Chen <jeffy.chen@rock-chips.com>


[ Upstream commit fde7f9dbc71365230eeb8c8ea97ce9b552c8e5bd ]

The rt5514 dsp captures pcm data through spi directly, so we should not
use rockchip-i2s as it's cpu dai like other codecs.

Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -387,7 +387,8 @@ static const struct snd_soc_dai_link roc
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_dai_name = "rt5514-dsp-cpu-dai",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
 	},
 };
 
@@ -432,7 +433,18 @@ static int rockchip_sound_of_parse_dais(
 		if (index < 0)
 			continue;
 
-		np_cpu = (index == DAILINK_CDNDP) ? np_cpu1 : np_cpu0;
+		switch (index) {
+		case DAILINK_CDNDP:
+			np_cpu = np_cpu1;
+			break;
+		case DAILINK_RT5514_DSP:
+			np_cpu = np_codec;
+			break;
+		default:
+			np_cpu = np_cpu0;
+			break;
+		}
+
 		if (!np_cpu) {
 			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
 				rockchip_dais[index].name);
@@ -442,7 +454,8 @@ static int rockchip_sound_of_parse_dais(
 		dai = &card->dai_link[card->num_links++];
 		*dai = rockchip_dais[index];
 
-		dai->codec_of_node = np_codec;
+		if (!dai->codec_name)
+			dai->codec_of_node = np_codec;
 		dai->platform_of_node = np_cpu;
 		dai->cpu_of_node = np_cpu;
 	}
