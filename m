Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16500C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCDE217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEH/41gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBSOMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:12:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39252 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBSOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:12:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so2962650wmg.4;
        Tue, 19 Feb 2019 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjDqUzdZkibV4qu3MfEIt7cV/E6+gEWu3RlxVhAbGT8=;
        b=bEH/41gD3aVuuGywbpjvTiM9owJd/3MRX003Up/swf+7HKM+DWkuU1VocRaQ2xmVHd
         4pllY3Uo44VOUQx5G/RSmce/6DrtPlTY5azbqgboOFjs8bChR+iPKc2VbsWmJp5dxRZl
         7jGazRgN9CyJD9vKNy82QAf+cvrEZ5k/7E0QtwfGCEQVbyfEh4ooiKhzfrtLM+PzL46s
         Oiofe3vM5ttM0QutXDRU1tqiF2S5twRiicBjIkNsLUnJSxeTlL4wWcuKXATLVPkd6NOQ
         dmIiw+OhHbXEqduuNLQBdK51UpvdnNdsYmn2eXWlrGxPYoSsNlnz37xrTDrGEHAsXqtt
         deCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjDqUzdZkibV4qu3MfEIt7cV/E6+gEWu3RlxVhAbGT8=;
        b=jf3fQX2OW/HWxznB+WkYM1so+FRoJReaf1TbQL/scLQH5Hax+IRv+giwQMKGpAuSDA
         vIInH82K6B7bL/9k7lquzE+nUnCw8s4T0e56FI/IZdB7VuiarYQcWweXpPMxXrU6gj1R
         eCPcZn8DuZcxl2F1oY3SGOlo5VVos+ddTmo18HT5LfgB/v3itT3pmcjGmrOzBpSP/cxL
         mx0V48xK30Enmkn7QUQse+5XqwPP7eJLbe/Th6JG+JTbbafuOATMZvrJSYHBnG7B5Dc9
         9x7Y17UMVH4I1zW6LVY9PsSjRR7FmDPgHDhIB3lIAjEbcs+fzwfgYacGZPN0YdO9iKEf
         ZnCw==
X-Gm-Message-State: AHQUAubyDIu+TE5vt/Z3BqZX0aMHlDfDzqtt4KZ4sEm/bfwuV9KRc138
        GvTjnPjPSMuNMskDZRrPB5c3FgP3Y8y/jGPM
X-Google-Smtp-Source: AHgI3IZANVOVWVW33fABS/pDtjKrFkhGy8LIRXwK+7PXVCpuwp2ce3rcyLlBxYs5drYDghLCci7BZg==
X-Received: by 2002:a1c:4006:: with SMTP id n6mr3172604wma.137.1550585561682;
        Tue, 19 Feb 2019 06:12:41 -0800 (PST)
Received: from localhost.localdomain ([5.2.196.146])
        by smtp.gmail.com with ESMTPSA id w4sm4510587wrk.85.2019.02.19.06.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:12:41 -0800 (PST)
From:   Bogdan Togorean <bogdan.togorean@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, tiwai@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@gmail.com>
Subject: [PATCH 0/2] ASoC: adau1977: Add support for micbias in DT
Date:   Tue, 19 Feb 2019 16:11:37 +0200
Message-Id: <20190219141139.24216-1-bogdan.togorean@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently micbias voltage is set based on platform_data.
If driver is instantiated using DT only default voltage for
micbias is possible.

This patch adds the possibility to specify an optional DT 
property to configure the output voltage for micbias.

Bogdan Togorean (2):
  ASoC: adau1977: Add MICBIAS example in DT bindings
  ASoC: adau1977: Add support for setting MICBIAS via DT

 .../devicetree/bindings/sound/adi,adau1977.txt       |  7 +++++++
 sound/soc/codecs/adau1977.c                          | 12 +++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.20.1

