Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524655940-2-11165248834183606611
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
    1524655939; b=XgcauwyWgjt236x8latG5pISPeNmTbLdGnkvnpRBndkl9cYeaF
    UEU7sWkjVmjjHk1a6JvqYuP4lPsOpNofGi0bwWHXgEYNd9AThTlXzyfeOBiv9SC8
    PbHHuF2rxh9VXxAbKgigjeB9fDIM6vEUV/jZZFCfa5fxQ+a4mmKcFuaDD4rmUkjF
    HYqmiMAIw1D3MyzkMlui1a5UIBYVBAauDZfanD9mGHP9lTFciDrFCQT1HkjUr4vP
    mQCWPeX0cmn8bWBjb3Q3HuTUCxjFcgPdihBV+Y20IkKltTHcaoFxM1JHxwEmnrFE
    /pLpowDKwmpL00DxeAnrLgKdhIWMRZiegPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524655939; bh=d4ckc3w1BxxEohKKQttekb/bvOOAhT
    t0ZDbmE1Eidwk=; b=JaicTcXLk0MFBYmDspmdSbZbvwXlCTDSqTPkA8AFX4fOHz
    VX0ZXT3al5sO7VJoKsFqTCIeAKXth4wECYExEVFbWDHL7k1UrECo0qrWvNwBYe7C
    74K5TCPheJu/UWzK445dmbExdYMRvzH7zYF2MGRMY+zupap5SMNFpOBnfQTL5s8r
    +XRFwzHTqTRdzwVnw2xUJLNvd54SlN0wMhgAgQo7alVAITmgm0PQGcjactzZxKwd
    cTr2VnRNRh2Do/D4Mr+SKeN+wA+RNvuK8imIP//om+TUlVHdiJuuHTe5xy1+Ln6o
    fGI/RYRufQ0RVsactTmAGlngUoKN+UIzGYNMfbhA==
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
X-CM-Envelope: MS4wfJkQRN0dfUOBdwLGLr3O1EIby1Ce8hlP78DtEnU28rLh1PAX5eSpy6AqdDqwC7wFYGrv+JEfSqywiqtCJ5u1XDERchfbDCzzS8kq/bv9aB+t7nnjG5ju
    vgAccHgnd+XS/+gAZNqinKhiLTl16uiLPFbm9PwhIZjoPl4Zk4QlmBF5xTyTtuJK9ej96XLusdu/7c9HD+bVSw9WHigN+SZiwz12eiBCthQT3aQK2HHVF7Kg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=XsaRKbsCnGI0xWDK90sA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeDYKhh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:37:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbeDYKhf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 020/183] ALSA: hda - Use IS_REACHABLE() for dependency on input
Date: Wed, 25 Apr 2018 12:34:00 +0200
Message-Id: <20180425103243.418370294@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>


[ Upstream commit c469652bb5e8fb715db7d152f46d33b3740c9b87 ]

The commit ffcd28d88e4f ("ALSA: hda - Select INPUT for Realtek
HD-audio codec") introduced the reverse-selection of CONFIG_INPUT for
Realtek codec in order to avoid the mess with dependency between
built-in and modules.  Later on, we obtained IS_REACHABLE() macro
exactly for this kind of problems, and now we can remove th INPUT
selection in Kconfig and put IS_REACHABLE(INPUT) to the appropriate
places in the code, so that the driver doesn't need to select other
subsystem forcibly.

Fixes: ffcd28d88e4f ("ALSA: hda - Select INPUT for Realtek HD-audio codec")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # and build-tested
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/Kconfig         |    1 -
 sound/pci/hda/patch_realtek.c |    5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -88,7 +88,6 @@ config SND_HDA_PATCH_LOADER
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
-	select INPUT
 	help
 	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3721,6 +3721,7 @@ static void alc280_fixup_hp_gpio4(struct
 	}
 }
 
+#if IS_REACHABLE(INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -3853,6 +3854,10 @@ static void alc233_fixup_lenovo_line2_mi
 		spec->kb_dev = NULL;
 	}
 }
+#else /* INPUT */
+#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
+#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
+#endif /* INPUT */
 
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
