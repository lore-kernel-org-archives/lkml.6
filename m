Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851EC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNza+gnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986A120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeK3XGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:06:51 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55121 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3XGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:06:50 -0500
Received: by mail-wm1-f51.google.com with SMTP id z18so5529302wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cE9Q36cKXVXOI6DrhkdIBfu2zo3QZjnrJU4SAhkTCTE=;
        b=VNza+gnKB+pqJS2oUYfee4Fu9orpmPKJp2d8Ppn734tpUs2GFQ0WxDr5wyELoFTqla
         pA6lriU5jArLkV5WFn8wL9HnQcWQNgC3yTjUt9QxYCWsDZR7L7VJl//WaEurgveTzK9g
         /WDSPQa12XKCrzHmQbr0TUvCNA3Bm1R++aoQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cE9Q36cKXVXOI6DrhkdIBfu2zo3QZjnrJU4SAhkTCTE=;
        b=O5Z7RAwHm0YKGmKp4gubqZOSZ3+1DMv603l1Xxa0W+DxAb8lCLnvnLHjVIgEw5ujFk
         P/zxJXftdNrPvYyK2GYfo+Od5fsMvs6R2HZOz+ismEDMe8gutfdEGyrpQlFuhUrN8Wv1
         hfT8JAeYxZbFhBmkmKCWwDi26ITxbbmK9i/TjJtJGF3gCdD0MQr+w2WjUbn07XaaJbQz
         Fgidv9hCR1AlYHuQ2NX9wCyscu1415hQboBNAOLIdcQcg7poiylXPzZZ6xOJ9VJfwGaO
         9E/A8h50H4xeZfY3DrW2X/OKahPdopBurcDhoqR4TwEb1XTBTAyTPkTAaB4uS5F+Dr3u
         RVfQ==
X-Gm-Message-State: AA+aEWbG+TEJfdIqQTwhUGL0GAJC2M5ok1LuJbPW/1FZPvfmn3kXUw9S
        v0iUbaVlU9srvOc38R3Cezqg5Q==
X-Google-Smtp-Source: AFSGD/W2u4Ns8nDhD3+5jFYHmPVOHKdJ07jUAUZg7m5FziTLtitL/RsYhUq68vmim0EE9pJ4aPxv4A==
X-Received: by 2002:a1c:8cd0:: with SMTP id o199mr4953528wmd.56.1543579067186;
        Fri, 30 Nov 2018 03:57:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c12sm3861303wrs.82.2018.11.30.03.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:57:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: patches for 4.21
Date:   Fri, 30 Nov 2018 11:57:40 +0000
Message-Id: <20181130115742.16813-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are few trivial slimbus fixes.
Could you please take them for 4.21

Thanks,
srini

Colin Ian King (1):
  slimbus: ngd: fix spelling mistake "exeeds" -> "exceeds"

Wolfram Sang (1):
  slimbus: qcom-ctrl: simplify getting .driver_data

 drivers/slimbus/qcom-ctrl.c     | 6 ++----
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.19.2

