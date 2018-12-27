Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1959C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0B921741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="y+tqJct/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeL0Irs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:47:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35127 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbeL0Irq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:47:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so8543399plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SHKNXe4HKNONv4KdYPKssXR4FAHILgSub4oCw/+Li5o=;
        b=y+tqJct/633ICXGqSLUc88a6tw/uoHc1WrN61RsSjq2b4by3bFhLfnoWCjOOW550B5
         MaCcD0VhWlL9ed55s4t7fW2cCv1wa9RXQxy8LpNhctRjH8FBnqn7SMI7QekPC2Vt/2JY
         bs0ADv9tzRvJJ/1bnoG0rHsb1ewP8m3/X1NmbtdrZDUBNEIvy4TtzkRdMCVmIxihFese
         XQecM8r0nTxVFZc2swgF2+h79fNQ/hj8ODnTy27zdc6240n+cZgclSNngok4Gz8XLpiS
         NAMazU3Iw78AyO1lFNK5n8P5jlKieVU6XlwcdwDOGr93lyCrvHCBeDEd9lxmbDTcfrPc
         2WpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SHKNXe4HKNONv4KdYPKssXR4FAHILgSub4oCw/+Li5o=;
        b=m9ENlFXP6kwZKXIM7NDRwyJHkrluDkDuQo8vtM4yJz2me5yKmLQbp23wg4XwE56weA
         kvxIO0f940JzKPklaHZWsW+cT6/pl2JELpTlGCQkYqgPRs8y0kCjSQKiSs8O8Oi8kC7R
         G2H1GLEYia8RQZWJ6+3TrMbvY6+bvGqoTnpV5hi8RogPS+1eklxPa7xG6Iaf3PFuMaWg
         p5o9giJa6DGExol9e0QeblNj+EhFtwS2HdqqCW+CpCPeem4iTd6+fEwFIK3fN+UrdXe9
         FPXvHflGTkdocJJ82Kw4dkoRPLrzCbHyQqu4efKJ6EJXnYp+rRW34i0NRgXABciGJhVy
         bp6g==
X-Gm-Message-State: AJcUukdYipwhd6tYze0+9fvjq6FU1yaXTegk7VG/qjR2yYWImtNfz4FD
        F3sa9U7sJ16KrcNpc8ECVm3LeQ==
X-Google-Smtp-Source: ALg8bN4v9LQkH6s7wKN0SSbOJ3xWB+HfkiJ6/UZbR2FUKVg11PnVwMRkhF+pceGdOmI69Z2Y1WDyvg==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr23464949pla.228.1545900465562;
        Thu, 27 Dec 2018 00:47:45 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id j70sm53017068pfc.43.2018.12.27.00.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 00:47:45 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable the headset mic auto detection for ASUS laptops
Date:   Thu, 27 Dec 2018 16:46:31 +0800
Message-Id: <20181227084631.2934-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headset mic of ASUS laptops like UX533FD, UX433FN and UX333FA, whose
CODEC is Realtek ALC294 has jack auto detection feature. This patch
enables the feature.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a4f4a9dd488d..aee4cbd29d53 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6501,7 +6501,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x19, 0x01a1113c }, /* use as headset mic, without its own jack detect */
+			{ 0x19, 0x01a1103c }, /* use as headset mic */
 			{ }
 		},
 		.chained = true,
-- 
2.11.0

