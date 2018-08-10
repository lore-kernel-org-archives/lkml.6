Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11926218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbX2K+Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11926218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeHJWhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:37:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37575 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:37:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so4475288pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aReJ29jYQ8bobJjMjf4pYgO5bFnpNozuOLjtF3Cm+c=;
        b=cbX2K+Nk69v91+7AZT2NSfXaMLmWPniARMHg2Vt2GCUfbLHxbDrBP/iLKI/Z8p2poj
         lgmmuvo9S33EDP/cAq2cdnFcO85DoKZDIcGkeW30OjICZKMzQfq2WYYjvFw080ll2DHp
         O5beqC92SiotZxQ6aWG33BqBqQcGVVBkYvxZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aReJ29jYQ8bobJjMjf4pYgO5bFnpNozuOLjtF3Cm+c=;
        b=NXpZVALj4k+auJlRKW7hsxXdAUceD7bXYDXcKDte0krzo9oexe6BsnmrN0e/zJptsP
         SzQUsC3lIgA3WyopiKIBsOB1kiyqaAAazW9+wD2B4M6VEzp/UIglHxYHKiXKcf9DuYXW
         bp/k1E3NztjvNRtEm9bvM5psFPbFSU+B+5zsQuT7ds6eD+O+w8FVe508FB2AKEtts4Ql
         kGlOrtViuNyAHGv501AxDHOYnS6E3T05zaTcM6w256GXVKBmMO44Adf3FMWTrdnEJh/X
         DUsW/dDUuTe4bTkzP29ByTB9AA3Ogsbjd+fLlT0SDW8szU/Wk0tYqWrMyy+rUF0e3oaR
         mA1Q==
X-Gm-Message-State: AOUpUlF+ZZt+XUqh8BToGKY/wOn0GTUijZ6hnaywgGJmOtMsc1OPBcXR
        5Gqvl/Ep6wz+wy3m3v2NnNHMPA==
X-Google-Smtp-Source: AA+uWPw9VXQT6vghz23vbf8q39EugEobLMZRzODhQkz15XgzCTdPj9DDzvXv8xwNcvYAxD9GbBD6Ww==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4-v6mr7351695plt.50.1533931561290;
        Fri, 10 Aug 2018 13:06:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id a15-v6sm17547875pfe.32.2018.08.10.13.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:06:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: qcom-rpmh: Add stylistic breaks in the default cases
Date:   Fri, 10 Aug 2018 13:05:31 -0700
Message-Id: <20180810200531.88409-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change here but it can make the code more readable to
have breaks in the "default" case even though it's the last case.
Let's add them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/qcom-rpmh-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 9f27daebd8c8..b8434e521d72 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -504,6 +504,7 @@ static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
 		break;
 	default:
 		mode = REGULATOR_MODE_INVALID;
+		break;
 	}
 
 	return mode;
@@ -537,6 +538,7 @@ rpmh_regulator_pmic4_smps_of_map_mode(unsigned int rpmh_mode)
 		break;
 	default:
 		mode = REGULATOR_MODE_INVALID;
+		break;
 	}
 
 	return mode;
@@ -566,6 +568,7 @@ static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int rpmh_mode)
 		break;
 	default:
 		mode = REGULATOR_MODE_INVALID;
+		break;
 	}
 
 	return mode;
-- 
2.18.0.597.ga71716f1ad-goog

