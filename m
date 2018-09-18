Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970DFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5061220858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="J4Fjv9J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5061220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeIRNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:34:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40492 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeIRNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so1106000edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkvbk2VYUdLp9dsxGT4L5gPQCojU+B7XTPlqFhhzO/s=;
        b=J4Fjv9J0bA/eDy7/b7dDCihOTFZUY6QAAyhgQfinEI2LC7hoQF5oRxcwp9n8RGBPaj
         yhI2niRagf+9x7v21zNBCrpYcTfUejQfCq/l1a9GPz542hTz5oDTxNUQYz68XkJHF5BE
         z4a+Bof6DQWsbOBMeCvPC3jRfTRA+zIpLHFwVB7xV15wnUbeKls8cNkVqU3wuXWm8aXU
         PtSE0QZiYROHcfKi4b6hx6f7fyPiSs8TUSHHFB99GveK4FOTgenxOy3VO01SSCaM+al0
         rW+SCf4O3zxJROn8NQMd7VP7nOZ5sBn0UejNErIujEUYInw4egDMT5AWbWajpqvWHo24
         BC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkvbk2VYUdLp9dsxGT4L5gPQCojU+B7XTPlqFhhzO/s=;
        b=ozREY3DJNtBzUcRkMfcO1psZcs3+Fjxue7ETBgRiiyEsKk8+ynjsHze7Knhk/ZP5ez
         i/Kix4qmtNoZqiVSA3VHsz7/DzkOwB9Sri8a1j+yu1aqXzyqUfP5/cx4b5/RLVUQIpZH
         RhjxAR3LPtVaeaYchffW64NrHYcAz3bG8bISQsOU0guppsb5JJ7eyuqmy8H6CxGH5j/1
         qHL+iZ+qFFhQoeqOIeEzBZH0SSE8YE3Q6Vcnbj667L+6+q6ofjur5lH5q0sXjgELfQ80
         3DwcCoa1pEnZWG8AGgJavgAb+3+1efS8esJCZ+Y3kE8KFbJg8pBk8TKGevd++jIJdTEi
         r0OQ==
X-Gm-Message-State: APzg51CBcQZTbd2n0NQmbkL5SC138sbyOzFKEJi3FZbaNHdRhH8EWa4y
        xxmbDJhr7kfpUk2nP3C+tl85YA==
X-Google-Smtp-Source: ANB0VdbcKCNZ4gxM7gtU4CRrkzh4HCwK+Ly4Qpu1VE99v/TdLQcelIDTpyNeLsIJvzVbgMkzDIJtaA==
X-Received: by 2002:aa7:c5cd:: with SMTP id h13-v6mr48955626eds.27.1537257792640;
        Tue, 18 Sep 2018 01:03:12 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id l48-v6sm7221062eda.94.2018.09.18.01.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 01:03:12 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/4] lightnvm: pblk: fixes for read buffer
Date:   Tue, 18 Sep 2018 10:03:01 +0200
Message-Id: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchet's main motivation is to account for a corner case in which
the read constrains imposed by the device are not respected by pblk. In
the process, it also refactors parts of the read ring buffer to simplify
creation/deletion operations and improve readability.

Note that the checkpatch warnings on missing comments for memory
barriers are false positives.

The code is also available in the for-4.20/pblk branch in the OCSSD github
project.

Thanks,
Javier

Javier González (4):
  lightnvm: pblk: remove unused function
  lightnvm: pblk: encapsulate rb pointer operations
  lightnvm: pblk: move ring buffer alloc/free rb init
  lightnvm: pblk: guarantee mw_cunits on read buffer

 drivers/lightnvm/pblk-init.c  |  21 +++------
 drivers/lightnvm/pblk-rb.c    | 100 +++++++++++++++++++-----------------------
 drivers/lightnvm/pblk-write.c |   7 +--
 drivers/lightnvm/pblk.h       |  11 ++---
 4 files changed, 57 insertions(+), 82 deletions(-)

-- 
2.7.4

