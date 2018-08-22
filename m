Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F458C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A41220BF3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPJxJ+xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A41220BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeHVL5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:57:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41966 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbeHVL5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:57:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id p4-v6so569730pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=igmYK5wTCcbbNJaaKg+mmaEJOr9JSxukdLdSU+d//JI=;
        b=UPJxJ+xpadANKJd7vO3ndjuzwVwg8Ht3sGMi2c8jCLAyNfcaeNH345FpkP1u/+1V2+
         KoGYb00KX0vP5xll+lbpuCAfrrVqpJ+6xknva87sVINX//+GxPxyTP6pCEgmZuJHVXSb
         vzOPlDQMFdLFjjiRm/lSIsLelR45FeVc6PfzE62tYhA1WZKhkWFBMtSNU3X4FlHbAN6v
         0C9uWnd41nlKUs+lNfownQO9Q1cpUNsjhz4x0jJbf/+knZYFX8Gd16ckRY5L/xYokdgw
         E0axi9eY9Kk62OTotFLCfoUHt1vWihY9JFKICqJyn2OIH0tR0CUBS4pq+HjOF5xXfNtM
         iv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=igmYK5wTCcbbNJaaKg+mmaEJOr9JSxukdLdSU+d//JI=;
        b=OUr2fZexzIZKxwcGZ1QDnltXs+GdiQrijPZK52r7TT8lpr6If6JLg7sybaEAcpYFVp
         AXK4C7JcqGSyegzezGff0xlDMnMTz5StqkCd6/oEBmWBpQ8bQNLyJndIt1jnh2xkE7cv
         SECHL0NcqW2AcOxMCPEfwzv7qjmvg2tqmnVBUQYcPcYJvLX2NCDBjYQ2rSXtwwASiQCJ
         0LXFQRo1OtvHIWg3kzUBm+ZYzHCUGeF8e1D9mEo3G3OugYXgVLPHFm0WZF3OLSMBL9SH
         0Si+Onxkf6iNIiQBdXhlv1V0ori7JfVztPKSyW1nFHrMmDkIr2qqgwiu4CCbr6kbNxFH
         N7bg==
X-Gm-Message-State: AOUpUlGjj43OBrDJgW81DDtXpWrzi5rBucohm2tn7f3633HT7v9vEwqv
        6KpgpDeyQYhiYmsGMDHVjz8=
X-Google-Smtp-Source: AA+uWPzu4GvcTldrFvdoC/fVwEUqrRhXgFZ9ihz8Kr88uf0qP5o//hTTDY6dBWRro1T0w5LGegMLAw==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12-v6mr53719539plr.163.1534926789051;
        Wed, 22 Aug 2018 01:33:09 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id e8-v6sm1265341pgi.24.2018.08.22.01.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 01:33:08 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:03:02 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 0/4] Fix debug macros and their usages
Message-ID: <cover.1534923403.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the four debug macros N_MSG, ERR_MSG, INIT_MSG and
IRQ_MSG. Each patch fixes one particular macro and its usages.

For N_MSG, replaces printk with dev_<level> without __func__ or __LINE__
or current->comm and current->pid. Removes the do {} while(0) loop for
the single statement macro.

For ERR_MSG and IRQ_MSG, makes the same changes as those for N_MSG, but
further drops the macros and replaces their usages with dev_<level>.

Removes the INIT_MSG macro and its usages.

Changes in v4:
  - Create multiple patches, one for each type of macro being
    deleted/changed.

Changes in v3:
  - Replace usages of ERR_MSG and IRQ_MSG with dev_err() in code itself.
  - Remove all INIT_MSG usages.
  - Drop ERR_MSG, INIT_MSG and IRQ_MSG from dbg.h.

Changes in v2:
  - Replace printk with dev_<level>.
  - Remove __func__, __LINE__, current->comm, current->pid from arguments.
  - Remove the do {} while(0) loop from these macros.
  - Modify commit message to include other changes.
-
Nishad Kamdar (4):
  staging: mt7621-mmc: Fix debug macro N_MSG
  staging: mt7621-mmc: Fix debug macro ERR_MSG and its usages
  staging: mt7621-mmc: Remove macro INIT_MSG and its usages
  staging: mt7621-mmc: Fix debug macro IRQ_MSG and its usages

 drivers/staging/mt7621-mmc/dbg.h |  36 +------
 drivers/staging/mt7621-mmc/sd.c  | 180 ++++++++++++++++++++-----------
 2 files changed, 121 insertions(+), 95 deletions(-)

-- 
2.17.1

