Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DDB2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBKVHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:07:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:35925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfBKVHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:07:18 -0500
Received: from localhost.localdomain ([178.7.117.106]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MDyFr-1gsTAr3Mzv-00HLLn; Mon, 11 Feb 2019 22:06:34 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [RFC v2] tlv320aic32x4: delay i2c access by 1 ms after hardware reset
Date:   Mon, 11 Feb 2019 22:06:30 +0100
Message-Id: <20190211210630.16592-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E6KikZis/CFzeZtOsu4F4F2wY5IpLP3bROQAjITvRJA5meZisF0
 Kt9h8yaP8brM7bcd/dYaWjB14beJvdM6KIWT+VsFlLaaN3lqKCdsauhhDpG96YJFq2G7IkV
 or4hbKweOIWHxOcuyGfcaNxpsI/k0sRKRjvp/Pzt/FeT1RJ+UUmixMY4Qs1objzb2RqRN4Y
 wQWbJeK4Yd491IyqF+nQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aNVp2pm79bs=:C4ahMt46qMSBvt7BdstO+X
 u6MJFzZvZzAaq+eImLGvqlO0u8pGMUHX5oRkPninVk3+s8dA+GU8qZ4wdVBjBbnOaKj4neIts
 yumgmvp3x4W7hw+A0+XKiXHmfP2+h+jQQGltnpwdr4kBGp2/NIr6lAjCmKcME200M/EOm8XdM
 ui+WsgHaxA7PlqA5tPJSJNpTrrTB+/C+8y5NzPn1Lzmg96p+cCIiSMdqL8vTzTxJYYF5uK4sU
 C9XdSpBB0ZeX9it+t4cPhvRaSU/NTuP71fexW/LdEBAwm2VfMoYGox/DifJJ83B+ce6eoSoRU
 BfBSqf5qPQWhOFT7VnVcnVdJ/OwThBS1M+qKmEhsotBcSq8bkjWXW7iUpx6Qkk4HlbqyI085Q
 SnHTGJ/9fcZSlcbGkoaGcXxS25s3+jjpBsvn5RqMjadxeciy8gAt1UlAkRjTANEAN3IKODAHa
 C8n6DccfYE3H7QALG/YIBbFqnarmxFvlAFTAdAvSdUF4SiFj0iE/xiFG/97MS4JkUFMnas1f/
 ej8qRtowEppqVhhsri5fcq51CrhVSP/DAuO+VRT1ry95BhDMX4K4rsGecc7IYNEMrGbxXt9vd
 N5lORkjSa4MXMRtuRhANQyrhKGEV5Z9l9ChznJeJilMGXCq/2lc/dPdlym7qSYoPnuYzTnLjz
 WBA56RjYTXMvYv9hURwrtcXgpVF4Kx4o1W4PDxoNEte3CQB6zkiaTARqM2E+ewI7gcsdo53wx
 GRRk/OgESdDnReyq9vwu2X3Zafk27gzQDNXOMeNVrE0ZSscIxKCrHNph05LJpmISB+YI5XOtP
 Pwl5JbJccJaLoDqo6PUy7R8y/ybl6qnatlVIj96P9QWHPwUraMKwiV7m4gCoIE5Pq5kQuJjOe
 MC112Wipf58S8xRATui2Cmvkej1XUHLqnA5apxGLzrB4VIlbxI+33BGwpe7W2b
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
Changes v1 -> v2:
  - call mdelay only in case the reset gpio was toggled (suggested
    by Mark Brown)

Note: This came up after the electronic departement took a deeper look at
the i2c-bus/vcc/reset pins with a logic analyzer and the documentation
because of a vcc/reset timing problem (now fixed on custom board).
Not 100% sure if the 1 ms is needed (as restricted to ADC/DAC coefficent
and codec block power up).
---
 sound/soc/codecs/tlv320aic32x4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e1bfba62fc08..96f1526cb258 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -970,6 +970,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ndelay(10);
 		gpio_set_value(aic32x4->rstn_gpio, 1);
+		mdelay(1);
 	}
 
 	snd_soc_component_write(component, AIC32X4_RESET, 0x01);
-- 
2.20.1

