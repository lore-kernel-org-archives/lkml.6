Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152ACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74A52082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrChuLIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74A52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeJ3IVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:21:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41030 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeJ3IVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:21:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so4650825pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hUbPNmx2bcjDHSLcHk7b9X77/1rxadrqozMOyMTmB+Q=;
        b=YrChuLIbLr5i/mRhGV0GU3Bqcg6tpILDoLSVNGPQIWfgPYZEILwS0muc4NJGuisdW0
         h9wrPiPnocqiJqsffahNFA6X/VDy/E62of7wVgCcBnx1VbATmBj7P653NeynZox7BfQ/
         OUC0zPvuONAW1T4GD6GI56bBy2IU7hPMsESdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hUbPNmx2bcjDHSLcHk7b9X77/1rxadrqozMOyMTmB+Q=;
        b=mp/g0911VJVVC8+K2wLqC+ZOQa94MdyEeRr7O9Ch098vIzpgZl0so/1OC1DBE3TIAe
         Yw88clH+lNykG6G5caovGKJqzjpDr4sQlIFXHZmxB7GFYhkuzzAshQDzefzmoo4nDfDr
         bu/12lkoyDm/w9NaZDrZU5fmZZ+ypjbDel/Qt3kZclK0RQ1QxAXa1cw4hOYfK6b1aWfr
         DEi5M2eYDl/y4NmdANSeS2iUk6RLtcXVETohdYNUdC7TZoMTgktMKfC2LBugp4gCO1++
         TUwbOXAk+00ofjd9MlJsuYX9kPPQa1u/wcx/9yliEr+Zwbl7frWtO+MYCC2guTlEOHL3
         0r7A==
X-Gm-Message-State: AGRZ1gJA8OzQdZhLo0syMMGCg16qesF+bT6zHNKtOLYpIiKjaJPfoeyf
        CHwdIrA6NOMZRbZpFeyo0/VPrA==
X-Google-Smtp-Source: AJdET5cKMIK9RsYeRfqAY79r0KKfS8SZVCqyBAZ+jWHrotqT97N0GIQqcJFoizxgXTs8TL9NWWl1qQ==
X-Received: by 2002:a62:1e83:: with SMTP id e125-v6mr401721pfe.231.1540855803034;
        Mon, 29 Oct 2018 16:30:03 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p11-v6sm5282981pfn.53.2018.10.29.16.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 16:30:02 -0700 (PDT)
Date:   Mon, 29 Oct 2018 16:33:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Colin Ian King <colin.king@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] rpmsg updates for v4.20
Message-ID: <20181029233330.GW12063@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rpmsg-v4.20

for you to fetch changes up to 928002a5e9dab2ddc1a0fe3e00739e89be30dc6b:

  rpmsg: glink: smem: Support rx peak for size less than 4 bytes (2018-10-03 17:04:32 -0700)

----------------------------------------------------------------
rpmsg updates for v4.20

This migrates rpmsg_char to use read/write_iter to allow being operated
using aio, removes the message size alignment requirements from glink,
closes a potential memory leak in SMD and switches to %pOFn for printing
device_node names.

----------------------------------------------------------------
Arun Kumar Neelakantam (1):
      rpmsg: glink: smem: Support rx peak for size less than 4 bytes

Bjorn Andersson (1):
      rpmsg: char: Migrate to iter versions of read and write

Chris Lew (1):
      rpmsg: glink: Remove chunk size word align warning

Colin Ian King (1):
      rpmsg: smd: fix memory leak on channel create

Rob Herring (1):
      rpmsg: Convert to using %pOFn instead of device_node.name

 drivers/rpmsg/qcom_glink_native.c |  3 ---
 drivers/rpmsg/qcom_glink_smem.c   | 14 +++++---------
 drivers/rpmsg/qcom_smd.c          |  9 ++++++---
 drivers/rpmsg/rpmsg_char.c        | 27 ++++++++++++++++-----------
 4 files changed, 27 insertions(+), 26 deletions(-)
