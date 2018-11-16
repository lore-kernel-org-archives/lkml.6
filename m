Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06458C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F72087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRq8v/CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31F72087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeKQFjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:39:02 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54662 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeKQFjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:39:02 -0500
Received: by mail-it1-f196.google.com with SMTP id a205-v6so30859957itd.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JmWv68rT8eZ5OjzTu5h0e565aszA4Z+zoynmw9B262U=;
        b=RRq8v/CGugjnLBy3QAuYI5fYntFhoNVNfXoF/9w/0K7Ut7hvxStOhLa+eLkp5boC0m
         7mt3FbwQYyKrEZIo1IA2XwVWyfBIJHFohW+QKGQ/d4Om4DBZkWunPnzkuFZRuLDpelOl
         tUGOQjsLKS2NgZJtssmjt+f/ImuPxcC28mh+LWz9X4yE7077ZaRKyMCHZDVmRpzOyTsn
         cm5k6H8dkIQfmQ9TBZpM9ivx6ngPIot/d3ZvrB4JuA52kfhPzB/PaEnqL43eK/7UFO+y
         Fi3r09aqgxwePVBEaLQt+oYQv9QcmmsCgigmRecHZK622E3INsep5TkTmBLWrHMT0/d1
         tflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JmWv68rT8eZ5OjzTu5h0e565aszA4Z+zoynmw9B262U=;
        b=q3RpIByEQUQus4gFrAVsTpPeQskeFP86HH0ISys6KBLmqt89zQAhkopGyYOvCB4emi
         kDl26gi0F+P4wBrWefSSWm54mbFb3OOVx7iFmWTFSMx/jCud6E1EKjXw2T4SK3LrDSB5
         uq7ttXNUyp9XcAodhuvrcT0BLx5MDDHWvah8nt9DJLSWXXEFA+x1/ypOdY5k02kEgUuz
         7q6b6uAHthuL2uIfVB+AY2B75Ef4ImwZcChTvs2SBeCeMxU4AnKk0Mwv5ZsN8YOaNdxD
         wTzUmPkf5KBZllNSZ/YxxLH1dlaV8OfN1agAcqN8wJmNLekzcPHUR/vomD8pKIcsw113
         mKwg==
X-Gm-Message-State: AGRZ1gJjJH1v82cOu5rCtq2ABOq2x0sA6D7FbbfVzJefTbK02haED3HA
        am+Ia5wrDyYQuASwl+8sYaA=
X-Google-Smtp-Source: AJdET5d/mD8t4QBCb2xijK/KXAf+burkY97LL1+Qn55DDWOvJnzXeqia2iWfMwzZSfi0QQR7W0gK0A==
X-Received: by 2002:a05:660c:984:: with SMTP id z4mr11010980itj.77.1542396321293;
        Fri, 16 Nov 2018 11:25:21 -0800 (PST)
Received: from localhost.localdomain ([2605:a000:1316:611a:feaa:14ff:fe2b:c4fa])
        by smtp.gmail.com with ESMTPSA id b66-v6sm11047288itd.35.2018.11.16.11.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 11:25:20 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/ca0132 - fix AE-5 pincfg
Date:   Fri, 16 Nov 2018 14:24:56 -0500
Message-Id: <20181116192517.5128-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181116192517.5128-1-conmanx360@gmail.com>
References: <20181116192517.5128-1-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the pincfg assignment for the AE-5, which was
previously using the Recon3D pincfg's by mistake.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4c21bd24bcbd..eee432287c15 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8527,7 +8527,7 @@ static void ca0132_config(struct hda_codec *codec)
 		break;
 	case QUIRK_AE5:
 		codec_dbg(codec, "%s: QUIRK_AE5 applied.\n", __func__);
-		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+		snd_hda_apply_pincfgs(codec, ae5_pincfgs);
 		break;
 	default:
 		break;
-- 
2.18.1

