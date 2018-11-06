Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1050E2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPhyZ43N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1050E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbeKFVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:05:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35637 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeKFVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:05:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so3531252wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxzAYWpM49Fw1Z9tzK3LV85YzZ9oDQkw9ghVKjeFX9s=;
        b=GPhyZ43NfKh/DqCb7tZ5xMz19FEgunLKWhHHEwf41gL2geOR2GBIESHFZ3zosWeOSn
         j28B0A2AHe3O7ipZq1168dkEI8OqCcq/rty7Kw6NwcdyZMy//fjUIXmiki3N/RB3+Nbr
         myn6GjNzBNu0g9QYZr75g8vBCBLFZmkq5hmU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxzAYWpM49Fw1Z9tzK3LV85YzZ9oDQkw9ghVKjeFX9s=;
        b=t/WdWRYt2T3+ORlTe/po6+octJRFfofqbYaZRzZFS9PiPlHyH1ov7eNgqgMvQhgwRJ
         Gt2TKHXZqgE23fLU3Vdm/eSJirPICv8LFPRDsPVCeyTYeq7wyIbOP8kc/3qVagRcW1Xr
         cOQD+bJJSBIDjQEBSzYwT7xvgfMScrEMtYd9V/vi0MEZ+v8ANyzsWcqKT6x/hsLaiwnQ
         kB40fO0EGLLg7nk0p0gtDT4SC0Fehr3/w4NL0xNuTucbMRc2Qo5Hwg7aGe5SqBwU9n/p
         gPW37qk0w3m0yjJ7pTxqU4kW4cVOfoh4BOK1Ncgxz2nZTC01Szay2im6Clcpo25X2dPU
         x39A==
X-Gm-Message-State: AGRZ1gLsw12iFognWuY6RM///d4DPsR4WNA+ObJNU+qzVyEATShu+NsR
        vPc7TmMDWZ4i2JjkAUp/Ogd9yw==
X-Google-Smtp-Source: AJdET5fQwVnNpM+WJiWoed986j4p0x8EQDxi05n6Y0kNMvMhsTu2w4sxlWQTDuEMuQoR40Jc+voGfQ==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr1768949wme.12.1541504461009;
        Tue, 06 Nov 2018 03:41:01 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b5-v6sm1990114wma.17.2018.11.06.03.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 03:41:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: qdsp6: few routing fixes
Date:   Tue,  6 Nov 2018 11:38:55 +0000
Message-Id: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jimmy and Rohit found a issue w.r.t backend dais being powered
on all the time on there device. Looks like there was a bug in
the driver since start. This patchset fixes it and also fixes
another bug where asm routes are added each time at dai probe.

Thanks,
srini


Srinivas Kandagatla (2):
  ASoC: qdsp6: q6asm-dai: Only add routing once.
  ASoC: qdsp6: q6afe-dai: Fix the dai widgets

 sound/soc/qcom/qdsp6/q6afe-dai.c | 208 +++++++++++++++----------------
 sound/soc/qcom/qdsp6/q6asm-dai.c |  33 -----
 sound/soc/qcom/qdsp6/q6routing.c |  19 +++
 3 files changed, 123 insertions(+), 137 deletions(-)

-- 
2.19.1

