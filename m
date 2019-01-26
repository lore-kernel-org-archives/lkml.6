Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E12AC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAEA21872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7ZQ6j9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAZRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:31:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43611 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:31:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so9810816eds.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MuegWI5u9uYEKbAebeTmxOCcNUu64QCAWh35ny612F8=;
        b=M7ZQ6j9HJnG7M5+EC5vq7jov85FUwma0euVNVvbNf3/I/0WJ3OADVhYnUP6JlaFhlV
         piViOfcW9wYF3lNWn7qc4GNfOqFBFm0jCrKYBb0k6aViefh7tbk8K1gR7YvpfbRXE7Hc
         K++WGii5wjiIRC0rkrMfa62ZmI8TzIQw/G40sPN5Gyw/al5k/Rz+0m6A5ok08UTNGc2q
         GMwZnpNF9CMq9UXYuzlF7yS/hs/sZO9L1eYEOd2y0bXtddMrd7Cv05KstFCNMBh55Wbo
         rgXv89nTNxxMD6PFXtpTL9ckPJCXP+s9szzsHx/aQcyi081j1X3zim4cuwCoXckarQUj
         cfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MuegWI5u9uYEKbAebeTmxOCcNUu64QCAWh35ny612F8=;
        b=q4xTbCKsgygOIko1xPWFPufJNbhDVK47muynEulDL3IdqBEIZDuuTh8BdWLD2sP8n9
         W89XwD8B86APPdCqbH3di/jP6fmnvlZBBKX1n6x6jsFuVOIIsh2oKBJB/0/7+4L8feo6
         2vGcWfpTyIESht8SUuzU4VIsPhoKlhBrds9qKLrbus2SNVu55gOI3aXEynzt+Fmcv8AJ
         TV9g02JB+4POakuy6dr2mORMqvKqR42Z66BC+hMyxUm/KGeDgJssQiI5gxDfDCEYbYS3
         fW72Qjf6ogvqzQ10+0niU6XvpnRCZGf1aTbA974CGlQ74of1ITnA6/jUVVT8Gi/cTk48
         zKlg==
X-Gm-Message-State: AJcUukdENF6oiTfzLyThYXovkoqIAhcZLPMDx+UvsM16qhpr2iqCi98S
        3K1LxGAPjwJIzRyHC0mfb7FhpqZl
X-Google-Smtp-Source: ALg8bN5LLsG7PKZvYah38GiX9z05QqqV0nauojQCicQZ/Q+Q4hTu80ZdhV/z490P6QDWysaC3AndFg==
X-Received: by 2002:a17:906:e102:: with SMTP id gj2mr2175289ejb.172.1548523883399;
        Sat, 26 Jan 2019 09:31:23 -0800 (PST)
Received: from michiel-dev (D47F8819.cm-9-1a.dynamic.ziggo.nl. [212.127.136.25])
        by smtp.gmail.com with ESMTPSA id a38sm12338415edd.44.2019.01.26.09.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 09:31:22 -0800 (PST)
Date:   Sat, 26 Jan 2019 18:31:21 +0100
From:   Michiel Schuurmans <michielschuurmans@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8192e: Replaced spaces with tab.
Message-ID: <20190126173121.GA20043@michiel-dev.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced the spaces with tabs as suggested by checkpatch.

This is my first patch.

Signed-off-by: Michiel Schuurmans <michielschuurmans@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 287d0c11fa38..9bff727032fc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1688,8 +1688,8 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				       ieee->current_network.ssid_len);
 				tmp_ssid_len = ieee->current_network.ssid_len;
 			}
- 			memcpy(&ieee->current_network, net,
- 			       sizeof(ieee->current_network));
+			memcpy(&ieee->current_network, net,
+				sizeof(ieee->current_network));
 			if (!ssidbroad) {
 				memcpy(ieee->current_network.ssid, tmp_ssid,
 				       tmp_ssid_len);
-- 
2.20.1

