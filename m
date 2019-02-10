Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E1C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C7C21773
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBJPqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:46:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:38705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBJPqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:46:10 -0500
Received: from localhost.localdomain ([178.7.117.106]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lx5hl-1h8f3z0JJJ-016ikJ; Sun, 10 Feb 2019 16:45:22 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [RFC v1] tlv320aic32x4: delay i2c access by 1 ms after hardware reset
Date:   Sun, 10 Feb 2019 16:45:19 +0100
Message-Id: <20190210154519.2506-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KG3kZ4O3eYKm7e4S7n7GsZct1sc/fO0n8scZ8CaW8rxVb0FlmcF
 a2u6SMvPR0GgY6NGNFiTfGFOWrpYzeO4YMYp+kKQn74CVuip1/6lI5FV2aTIIvRCwwl0Pq3
 xF30iVf2/UpMznje4RUKStmUaGaEAJyykJ4gvlhMTH1fpNEFmxneHVae7E6D3AeFUapxVQK
 5lZynLDed+lCQB+/2NyiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9TkLSepWd+4=:rsAQ5q9urL4FsVdZ+GJYcG
 Oo/DKWY0URfYKpHD8mjLEsWERBAIVJgMQvFiy8BhmPlVWMhYO1tItgAJx5EMKS+ckBI1dX37P
 cT0RWbsBPYAtdQu3tXzn2uZDZg69hCr3pRXOn96IEpwcpoW/6k1uUT/AfgAqKFqQmCx2QNc1O
 pzixipc9dIlHN5pq+o9v4H6fShTNW8pgJ9QTseAXktHJLN7QQdu+Y9ljMOcBHG0IM3Lf8NUWz
 bQ0+AyUFpRMeyCKnOgCGXPtYRd917o0zWtcIOGy68cmcbaj8j3WCuRAuOm4Zz+nrWWil5yR3F
 PjUc2YWbERHjFcm9Cud60zS8KtRTE4a4UJ5ppjcjDfXigzTY0p3GEIBxgNGrVN19Au8xysi+9
 PKHEIl7jtj5eSWHzd6P7kpZh1Q3kVdek9O6KCsAXx5/BDNpaTcFUV07LpBdiiuMBEjnazUb5I
 qImWrxBCspuIyl5K6CdWvRr5sQp+cxIWC+KtqFel/O+oAflhFuuRVE0Twx/mtvjwXVb2d0VAT
 JVdhAMTPVDmPS3X4cav3BK0JrB34FoWBvtKPKx6u04KuOJk1wy42Nbss7lHfzcjwl0JL+XHfe
 Gqqaz267pOHSlycogzaKIm9MMf7x676AWBD5gQpoYC9KV3R1mjtPdXWUug58vumhk6D2w/uhE
 C7hbzsaETvhNW5MEhoByAodVrP+LRMvJ1WHrPxIdqbfPw0BR5kLdPs/Xr4kDY/4mQTwvPsc8v
 f32bS1HpaXL3Aylnj0CzuTwQC+bH4xN6RiXLLcOuJeL26voiCTBQOpgbFRK/tisGyZ8sBPCvM
 ot8t29am5QQ6lDngIjzURP+NtmlbK3gdHaFX+n8Eqh+RjxtB1f+tqszH8Kl5vAZoJcDNS65fI
 cB4k2EliXQ1kWYHv9qeQIyf2KsH7iK5EimNfyCobQC7rG3cF+jlKpsNdK1DVpC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in 'TLV320AIC3254 Application Reference Guide' ([1]):

  3.2 Device Startup Lockout Times
    After the TLV320AIC3254 initializes through hardware reset at power-up
    or software reset, the internal registers initialize to default values.
    This initialization takes place within 1ms after pulling the RESET
    signal high. During this initialization phase, no register-read or
    register-write operation should be performed on ADC or DAC coefficient
    buffers. Also, no block within the codec should be powered up during
    the initialization phase.

[1] http://www.ti.com/lit/an/slaa408a/slaa408a.pdf

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
---
Note: This came up after the electronic departement took a deeper look at
the i2c-bus/vcc/reset pins with a logic analyzer and the documentation
because of a vcc/reset timing problem (now fixed on custom board).
Not 100% sure if the 1 ms is needed (as restricted to ADC/DAC coefficent
and codec block power up).
---
 sound/soc/codecs/tlv320aic32x4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e1bfba62fc08..b3beb0ca87c3 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -972,6 +972,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 		gpio_set_value(aic32x4->rstn_gpio, 1);
 	}
 
+	mdelay(1);
+
 	snd_soc_component_write(component, AIC32X4_RESET, 0x01);
 
 	if (aic32x4->setup)
-- 
2.20.1

