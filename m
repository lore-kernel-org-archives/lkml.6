Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814D4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC582082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiUhoAcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC582082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeH3XIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:08:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42322 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3XIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:08:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so8164907ljc.9;
        Thu, 30 Aug 2018 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OtYGMvIeMhIf4XN6ecDXRafl9QlB7yiIQ7VHzAiBRGQ=;
        b=DiUhoAcqXzbg2eq6edaBKlgkjVckATD6giqybsejwuHm3o0Idgp6H4Jp2+VAS5B/n8
         zm7PNbiUoloUtx2GDBfm4xvB6w7Llkvi40Gag9zvGkFgDE7JJ/ZyxUhSLZiKwEAHQOMi
         9Z8wOX+jqYHL4zkneUJOCR8Fo0SNDNn8LsGvDA/aJ5+D/rhX4x/U9RRHKX6BMPihrsCu
         ZPFVW7q2Ut5oegm/sHqJb9NwBSu6XlQfQjuFZAWwJGSmLwcNuY83z2D48C8MAXzHISUW
         pyMu2ycbqMaxbyBTphK4JUAgkbRS77xAqL4Cv0VLzDmqCaK17uV1OX2N2BNWVU3zjqv5
         BQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OtYGMvIeMhIf4XN6ecDXRafl9QlB7yiIQ7VHzAiBRGQ=;
        b=n1ULE5ONuJQGXARUvhnNYp9bSmeyJcXr5wAbBW8KsbDjrcWHl6N1DUfWqj24+cxXeG
         Q8jkr1YgJ58C9TLSGqRO2s4qoYIJMA0ExhGKW/L4nFUfOc93tD9k7wYmXigMLTwiVr/Y
         AjxFJA1kTV8B2C7JnGyPVz7jF5eQWbXzP9sYTY2Fs6kj4nGPUQay5mLj5yKXrd7DQ6lG
         t36qjg7RyjFQgGNT14E8VBR+x7Qxv45qBYWhE+WCMSk5iVLWrnN9b402JZGrpVu5KIdf
         0FCEfy8Y3I+oym5c6gr2+9ThGNA+HPzzVVn762cPMElpSlBiITqcOTgSuaCkihJtDDII
         CmLQ==
X-Gm-Message-State: APzg51CuN6dk2ev4DjgBWSR0oM18r92VMNPYa7IJH7+elOoDE8nCWsO6
        7mlqXH8kYEKkYKefxsE9C9o=
X-Google-Smtp-Source: ANB0VdZf0ExcVcXpGzkqMLO6NmzLlKyhDJO1zFSUC0Yoid2iC/rMM+DtYXKUYqq2p7Glkt2v22IvWw==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr7986772ljj.103.1535655908193;
        Thu, 30 Aug 2018 12:05:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q128-v6sm1373081ljq.72.2018.08.30.12.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: tegra: Switch CPU to PLLP before powergating on Tegra30
Date:   Thu, 30 Aug 2018 22:04:53 +0300
Message-Id: <20180830190454.8729-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830190454.8729-1-digetx@gmail.com>
References: <20180830190454.8729-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLLX is getting turned by the HW logic when CPU enters powergated state
and there is no enough time for PLLX to re-lock on exiting the low-power
state, this causes memory errors coming from misbehaving CPU and eventual
hanging of the system.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index dd4a67dabd91..d572d4b860be 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -298,8 +298,8 @@ ENDPROC(tegra30_sleep_cpu_secondary_finish)
  * Switches the CPU to enter sleep.
  */
 ENTRY(tegra30_tear_down_cpu)
+	bl	tegra_switch_cpu_to_pllp
 	mov32	r6, TEGRA_FLOW_CTRL_BASE
-
 	b	tegra30_enter_sleep
 ENDPROC(tegra30_tear_down_cpu)
 
-- 
2.18.0

