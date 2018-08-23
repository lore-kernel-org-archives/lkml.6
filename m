Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72010214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRRBZG/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72010214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHWUxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:53:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeHWUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:53:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8-v6so2948852pgs.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=z9oAEefnzF1bKBuUn5mb5tUX5zpIbvhD5qZYSFSs6+w=;
        b=cRRBZG/CXwz9eQYDuez9TzRu672iagblqww95SLIC9gfPskfyRAAKkscQ2CYhLNzXZ
         XK0EufXb6xgBS0Tjv2a7uXr6jxWiWNXp7xFor58V8XU9QZQT7aUsSjtqiUGsCGwe4W/i
         kK5KLH7s0zfoQVRdIDSu8zMdarTkCCtb4hrPSJaszVeqlWj/jI5gEFTcK4euEw/RWd33
         03o9VHhfYnmnGZB3UeKi6GgLBXUxH1soESGZfcY+lTFj8dWgIn4e2G99VcG46p2bb6ea
         sXqCk/mh/2RQizYpyR4B+gWf32qy/kICqVX80VjXbssTt/jXil33Q6aYKQCIEtRF9iK6
         KxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z9oAEefnzF1bKBuUn5mb5tUX5zpIbvhD5qZYSFSs6+w=;
        b=enENFELv6n0fHgv5JeCErrKMcL6gppwhMPgIq9M69PVJBYLrI/7i8eurh8jV22G0kM
         owYuUh6hThAwHNDmY43bWulaX6oiSBxnhBJsbdBYUl+hQxGC/uPkuQUMZdaeofnutzfU
         pDiKerMVgSGmw9iKqilrB1dsm+5AZND4TJiDAKizITGyhPLWuIq61okNrzLeIkVAJY9w
         LkJJVbxRfrnqurbtgAQsOU+58QoV1vE/W6N2eH9HYI492HpyjChZW0GfH0rXJmMBmfQb
         pudq8HxCcYqflgFWXcGgseEEMqkU4RP80R0GWdMaZ/gbQlF7YUoxMW+3//qp+sDpojQi
         nubA==
X-Gm-Message-State: AOUpUlGDzLZ4E8zsjUYcQacHZnBwtebxc5ZuH1OyuGa0/bFS+gi8YH9a
        cP5Upm8+OnQ2tH3TeU75nOo=
X-Google-Smtp-Source: AA+uWPxS9VoUPZNk/wr7peUxBYuv4WK7zjM2Lnv0pCO15BXNst6PdPJJqFGf0y/U0D6ovyvOCfhmyQ==
X-Received: by 2002:a63:66c7:: with SMTP id a190-v6mr56707585pgc.411.1535044951261;
        Thu, 23 Aug 2018 10:22:31 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k64-v6sm8087409pfg.141.2018.08.23.10.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:22:30 -0700 (PDT)
Date:   Thu, 23 Aug 2018 22:52:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 0/4] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <cover.1535038494.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset fixes the four debug macros N_MSG, ERR_MSG, INIT_MSG and
IRQ_MSG. Each patch fixes one particular macro and its usages.

For N_MSG, removes the commented code in dbg.h.

For ERR_MSG and IRQ_MSG, replaces printk with dev_<level> without __func__ or
__LINE__ or current->comm and current->pid. Removes the do {} while(0) loop
for the single statement macro. Further drops the macros and replaces their
usages with dev_<level>. Deletes the commented usages.

Removes the INIT_MSG macro and its usages.

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

Nishad Kamdar (4):
  staging: mt7621-mmc: Remove commented code for N_MSG
  staging: mt7621-mmc: Fix debug macro ERR_MSG and its usages
  staging: mt7621-mmc: Remove macro INIT_MSG and its usages
  staging: mt7621-mmc: Fix debug macro IRQ_MSG and its usages

 drivers/staging/mt7621-mmc/dbg.h |  33 ------
 drivers/staging/mt7621-mmc/sd.c  | 172 +++++++++++++++++++------------
 2 files changed, 108 insertions(+), 97 deletions(-)

-- 
2.17.1

