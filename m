Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B2B222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6rbCGeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfBPPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:55:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36600 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:55:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so6480811plo.3;
        Sat, 16 Feb 2019 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tjQv0fgoF2ugLmzvR+YqhTeOU0ubMwDIuRiy+frfHa4=;
        b=L6rbCGeuyDS2nN8eyqrS4j1R8AIjAFMj8PHGiOArUasXToxhYwAZwWk+OCNeo9Z46i
         7GxnE0rT5O3xTrfVdrwDzxxZwFnk3NS1JgorueZIUMij7OJ2T16QaZWWnA1TAnV2en52
         FPXE/u2ovb/dbut53bMpX2E/1bCVBRRJlEyljvohQI148zf2Vn62Hlbhjchc/gO2NADa
         1MtcKo0mdtzBcIP1eyGthj0hPZrGx0W3p7+OMhkunnnfXNRl8CVoMO3Sufbt0rzOD15p
         hkgGRrlwLEPJJ2rC6z6i1g7rHD0va9/h4muL8R2FQLuOJ2BfBjO+AuAjJkNWjwI4V0lX
         Hp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tjQv0fgoF2ugLmzvR+YqhTeOU0ubMwDIuRiy+frfHa4=;
        b=sW0nbkwvz7NG8E7IEqLRBOz8wTC1WDwAQ16ff3ZBM+uNQ0cZiucBVqivf3WS1hRfGR
         mOiFis2a/zpyo8MH7h1HHdSjT7pF18JmTyoLKuwen0VndXJ3W3A3Mxo+M7TWjG6KYX9t
         0rsM4wdtTtp45b2/IGUke4LIsIOAticpIuTzkOkWw9695zHlIAOs3UtUZ+PEOUmhRxvJ
         mkVa+IvXLvhMeEOfqI5IaiHCcNBhGJeoPuuCUE3aCiNkVmswQQxnTvWBFc6gybbgVfeV
         daAkblhwnEGZ91zVW2+e2QPc3KYTpdvMvZv6lUyyK5i8uhueTDoAt6zUpw1beA763TsK
         7RcQ==
X-Gm-Message-State: AHQUAuZbMLOJhAT/kYofoDrHgI8sYTfjQqRrQyOZmLhX5drgfKV83yz9
        Y0xPSEhuAkCwa8WNdEVALCLIF7pDj/0=
X-Google-Smtp-Source: AHgI3IYnWC/NWgbIYKQlavSyuSWNoyT2oKB+UbiGwrdWMtDkGsxyeFkjuAkATaGYMT4xjXzDNQLnQg==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr16255104pll.22.1550332533339;
        Sat, 16 Feb 2019 07:55:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p2sm18532848pgc.94.2019.02.16.07.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:55:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/2] cpufreq: do some cleanup
Date:   Sat, 16 Feb 2019 10:55:25 -0500
Message-Id: <20190216155527.11839-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The informations come from the coccinelle tool.

drivers/cpufreq/longhaul.c:854:2-3: Unneeded semicolon
drivers/cpufreq/pcc-cpufreq.c:271:2-3: Unneeded semicolon

Yangtao Li (2):
  cpufreq: pcc-cpufreq: remove unneeded semicolon
  cpufreq: longhaul: remove unneeded semicolon

 drivers/cpufreq/longhaul.c    | 2 +-
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.0

