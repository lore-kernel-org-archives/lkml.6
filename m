Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1E8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0874205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvQ3dB3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0874205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeIACWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:22:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34650 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIACWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:22:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so6116297pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q9gpixhKhXei8vYVXJ0UIyNgElKM+wyLb+91utDrUAA=;
        b=OvQ3dB3wxH7N8hlb0CofzHj72krjP0hU7KIGnn7wlYfu4kQ2mm3do36jO5k7Vn5vJO
         K9OHGzEiiMHMOODViDdaeFWVZzisVfKM8PA/IYi5HVYPo63qtfbPLO24ub+/LGNS5paO
         /aj6lZWliueQ0M9JCvdYtOCdeEXzzNbQ7GL5QfgqWXosxArnHafp+nSKtukNJEIRzNQ6
         UC9EGeVgSIHfaMnzIBqeNcRlVXFhAg7PJYczAlGscy8e9+snN+MWhjDhuAAOt6SKRZJn
         ggxeGksWk5XfWIUHzs8jmvaym9XqbNehq6xLdsqDZhsSpFovdswApxpQIZsRT7qHBURf
         IhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q9gpixhKhXei8vYVXJ0UIyNgElKM+wyLb+91utDrUAA=;
        b=StpsMz1QN+LaTPJLcs6kheQ4NaTm6UsSgccV1f57f+u49L0c2Qmpcd6dgewOZG3/r9
         6ESxDD0m/kVD7gO2ySMUw9ShZnpVVAC7ML8HLM1QZfioSodSbad8MTSEsAAJA1Av2yC/
         z9sqW98aOLlKte4TrkoBhAyIaZsEn8DrxNbs9/92k0VCzC0qAIfVzk+U1+u/iuSzraWn
         g+Yuzp9jiqz6FXlGzJ0cmT5uVMZNm7u/oQ9edauDFh3OL0QikcF1GLt/Lj7Twzwi0MIP
         3fziPupcxAkG7sz917qzymIofzvCJtVPDYCWHPrBoscQ67z8T7fSCZcyrZ2+RNNTSZlk
         /0DQ==
X-Gm-Message-State: APzg51DQK+2Ok0Zrtp6Je/YA4jCJQ8OtOsJ0BF/3BSbJjdgiJrlJ4ApU
        Ebo+QwOzUAXqiQzLctH63vKAeakkSL28OQ==
X-Google-Smtp-Source: ANB0VdYKSKupy3ZwDqBxG/pWP1kMScBeQ/ew4AjhqiS3sOHaQ4pts/RCJ0kutICbVWzCZDoK0xoAeA==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr16518715pgv.25.1535753567623;
        Fri, 31 Aug 2018 15:12:47 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id u11-v6sm19723425pgj.71.2018.08.31.15.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:12:47 -0700 (PDT)
Date:   Sat, 1 Sep 2018 03:42:39 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 0/3] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <cover.1535752537.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the three debug macros N_MSG, ERR_MSG, and
IRQ_MSG. Each patch fixes one particular macro and its usages.

For N_MSG, deletes the macro and its users as it is a no-op.

For ERR_MSG and IRQ_MSG, replaces printk with dev_<level> without __func__ or
__LINE__ or current->comm and current->pid. Removes the do {} while(0) loop
for the single statement macro. Further drops the macros and replaces their
usages with dev_<level>. Deletes the commented usages.

Changes in v6:
  - Delete N_MSG() macro and its users as it is a no-op.
  - Patchset reduced to 3 patches as the patch INIT_MSG patch is accepted.

Changes in v5:
  - Remove commented code for N_MSG().
  - Remove commented ERR_MSG() usages.
 
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

Nishad Kamdar (3):
  staging: mt7621-mmc: Delete N_MSG() and all its users
  staging: mt7621-mmc: Fix debug macro ERR_MSG and its usages
  staging: mt7621-mmc: Fix debug macro IRQ_MSG and its usages

 drivers/staging/mt7621-mmc/dbg.h |  28 ---
 drivers/staging/mt7621-mmc/sd.c  | 398 +++++++++----------------------
 2 files changed, 108 insertions(+), 318 deletions(-)

-- 
2.17.1

