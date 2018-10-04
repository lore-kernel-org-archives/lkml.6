Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B242082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHoHl7BC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B242082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJDX2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36346 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeJDX2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so3653882pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0QYPyjEm+0HqDlJmYvJ32LhqYpQf57Eke9W2q5A9ilQ=;
        b=KHoHl7BCf3K2B/UHoVnI8QADrOSs/de7VPqHBZKRymRxXsPseLNAR3b4/MDWKZC2Om
         f7Gdq4BF5crhcgrVUGJ0J06dvU9g4VKupRumN5ZpJV4UXBBgt3AZ8iui12ZkkkhuDGKk
         xmvKgRErFnfamGqELcvP8Xz0xMS3YiOG09B4ve30mBE+rt+QbC00bVleosaJkt+/siEd
         DEmrSOCpKAJ95UENCAzEdEJmLgLW1xSihknqJNZDyPe70A18ePcVppNeF4E4Ala4YxsL
         D+++so77zrpUnsW1tVgfzAVHliq1adS7otpLiUq6iUCbAs02njXDR/2uaK6C36ts/haB
         qVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0QYPyjEm+0HqDlJmYvJ32LhqYpQf57Eke9W2q5A9ilQ=;
        b=eEpWn+vFCkyzElUy85HH9X1slddb7pZnrrrTv2G/4HQzpaVlX9zH9Q2uECL1jBkZAs
         tHhlqAWaxneStmTY8FGL/Qghl2TOf4jF4mICRCYT8wYTVQEED1ojK/62yK3FFsW7RFAc
         EJz+91/adbHyhPa3JiQDJZHRF9/2Io2rkQZJ+uIAE2pt51JU7H0aaWs4t87rgqohyDQi
         Y67tYkVhWdZMSN7KX0tvQmNW7wSANO1pnS8Fo2x+KDlpr5o9eZ/g34P49ssPtMzqJ/yn
         0HI8JffKpZ5mQL2YvifIMjWQ9CBpaGdtFHfNQqnM8RWJAqdZICIG6DowsCnRpk94Quzq
         Otzw==
X-Gm-Message-State: ABuFfoivxS4hqPccGIpJBW1koCEgNLGgKIy4Eb2vf7/7GpywVurznJb/
        Utgr+UoZL1ugOtoCi4k85e8=
X-Google-Smtp-Source: ACcGV62SMjgffSluML3okaDkVbeNO/rZVFveRZn18jEenCTHjmRWusrQcAhLVbswuhbWGc7z/LQUsQ==
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr6240371pgp.139.1538670886335;
        Thu, 04 Oct 2018 09:34:46 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id a64-v6sm8093814pfe.32.2018.10.04.09.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:34:45 -0700 (PDT)
Date:   Thu, 4 Oct 2018 22:04:39 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 0/3] Remove #if 0 blocks
Message-ID: <cover.1538670306.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes #if 0 blocks in sd.c, dbg.c and dbg.h.

Changes in v6:
  - Split the #if 0 removal patch in three patches.
  - Each patch addresses one file.
Changes in v5:
  - Split the patch in three different patches.
  - The first patch removes #if 0 blocks.
  - The second one removes msdc_irq_restore() macro.
  - The third one removes other unused macros. 
Changes in v4:
  - Removed #if 0 code blocks and usages of functions defined
    in the #if 0 blocks in dbg.c and dbg.h
Changes in v3:
  - Remove the #if 0 code blocks and usages of the functions
    defined in the #if 0 code block.
  - Delete msdc_irq_restore() and replace its usage directly
    with call to the function being called by the macro.
Changes in v2:
  - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
  - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
    msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
    with calls to the function being called by these macros.

Nishad Kamdar (3):
  staging: mt7621-mmc: Remove #if 0 blocks in sd.c
  staging: mt7621-mmc: Remove #if 0 blocks in dbg.c
  staging: mt7621-mmc: Remove #if 0 blocks in dbg.h

 drivers/staging/mt7621-mmc/dbg.c |  21 +--
 drivers/staging/mt7621-mmc/dbg.h |  15 --
 drivers/staging/mt7621-mmc/sd.c  | 249 +------------------------------
 3 files changed, 2 insertions(+), 283 deletions(-)

-- 
2.17.1

