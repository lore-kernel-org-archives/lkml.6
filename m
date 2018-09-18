Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B94C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7708A214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNF/1XOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7708A214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeISAIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:17 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46203 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeISAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:17 -0400
Received: by mail-qt0-f193.google.com with SMTP id l42-v6so2645011qtf.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KaqrSlOsDAIRdWFr02aG5v9lyyLF1qH5s0tqYFFLJic=;
        b=ZNF/1XOMFdB5dcYBWdR30ceU/XoJSAuxaOcCjsI6IobAUe11XPfTSLutxPf6zClYEY
         Fl1c3XbhQqLC952eWNMphkmTBlvyWdHy3KPLDtNj0ql+KNZHlW2jura/5rvwk+SX0wre
         VXAS2nAYQ9qHcsDZ92F0pybyx+xxSuTK7DwNRIPz634rUO0HAI/gvAPADsFRgzbLkkdG
         FZgqoOCnRF6lB2DHnqJjWS9nfBu4vp9f2+gyixzqdgIWCN7gZDwvoY6zq4IxGYIh0qkd
         a1TOnd8iiaLAlNT/OpJuyxq904fPH8N57G7kv8RyE7dpreUQC21Ki3H6RtPjojj/8VEH
         zLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KaqrSlOsDAIRdWFr02aG5v9lyyLF1qH5s0tqYFFLJic=;
        b=c0JIRNaJT+EOXLjSA8V6IaowQbVkgUB469pj9/DpqNCJNtgc5ln4p7P+C3pmK1XAQ+
         RKrisuL5WmLc9NseKTEh1YpNOLWd6FnQNYsl8FAX9Qya2e/ythwbuqBtxTHL/45Nh0Z9
         CWPnDrLpuCzU6pK9XUQfpx+59wd/Ck1aQX48uMniC9B9TbiuiBAOed1Ri1OSPmKe5s83
         J5msYW3kXwRmc3JFq4fqLJltlIZ4jNYVLi4T9Hjw53czYmO6yNn03iEBLZ/+guhFBalk
         CKjumiUJPVwbepFuqdr4Co5Fs/l6dmjDOckfU1ylqtaUE4Pje7+oPIjPBV98E4dS2dCR
         Iu2A==
X-Gm-Message-State: APzg51AoTVkp+mtLwsL1+b/VEviTTIIP3rNdZAijgXpe/NHhetBoGGrQ
        DBJTz8Tn6dusD+bLw0a1Nk6X4Owz
X-Google-Smtp-Source: ANB0VdaXHrZNcvdK0EbvEQ5kIobWF3hJdnI0mZy2XFkM53qlkQ7zvroSbHrhom8BAb1kOEK31cG5/A==
X-Received: by 2002:aed:2d01:: with SMTP id h1-v6mr22190127qtd.11.1537295665722;
        Tue, 18 Sep 2018 11:34:25 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:25 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] Add support for Sound BlasterX AE-5
Date:   Tue, 18 Sep 2018 14:33:28 -0400
Message-Id: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Sound BlasterX AE-5. I have
personally tested it, and had others test it as well. All outputs work,
front headphone, rear headphone, rear line-out, surround, digital. The
only issue currently is that the microphone suffers from inconsistency
like the Sound Blaster Z does, and Creative may be willing to help fix
that, but if they're not, I have a few ideas.

I also have the ZxR working currently. That will require some more
complicated changes of the driver, so I have left it out and just
focused on the AE-5.

Connor McAdams (15):
  ALSA: hda/ca0132 - Define new verbs and control params
  ALSA: hda/ca0132 - Add quirk for Sound BlasterX AE-5
  ALSA: hda/ca0132 - Add pincfg for AE-5
  ALSA: hda/ca0132 - Set AE-5 bools and select mixer
  ALSA: hda/ca0132 - Change ca0132_mmio_init for AE-5
  ALSA: hda/ca0132 - Add AE-5 pre-init and ca0113 functions
  ALSA: hda/ca0132 - Add AE-5 regular init setup
  ALSA: hda/ca0132 - Change firmware name and usage
  ALSA: hda/ca0132 - Merge post-dsp functions + cleanup
  ALSA: hda/ca0132 - Add DSP setup functions for AE-5
  ALSA: hda/ca0132 - Clean up ca0132_alt_out_select
  ALSA: hda/ca0132 - Add output set commands for AE-5
  ALSA: hda/ca0132 - Add input selection commands for AE-5
  ALSA: hda/ca0132 - Add AE-5 specific controls
  ALSA: hda/ca0132 - Add AE-5 exit function

 sound/pci/hda/patch_ca0132.c | 1283 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 1038 insertions(+), 245 deletions(-)

-- 
2.7.4

