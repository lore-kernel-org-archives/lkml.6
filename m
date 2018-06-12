Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0361C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF672089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="iJG5tK1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF672089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935264AbeFLDLX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:11:23 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46668 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935193AbeFLDLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:11:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so7030378ywc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l7uwSF1c+axVBeZ2M50qMmhyN71XFhMZL/gBpcud2XE=;
        b=iJG5tK1YFbDhA5cUd5uf/Au6sVCIwACof4YB0E7chqEDLvKzG8vuwra+iEY0ef4TbX
         y8w2hSH+qcgTngzss8Qz4/tZi7NFBDSV7ib9VPsmW31CjLxctb6qr0TzmVldDnWDsc6L
         3Sb1UWuW+mH35BP5OekkYSFBeXpgQ4lhEzoxqekcIStYCMZ2GD4qlMb8eOT4747dUdc8
         A0dQCGWmYcAyBnEC8VnjJmdiuSERCYRsxKgeYxL3ezt3uAx2muThDL9qIqE9LKYufg95
         4Srjqy0gkWXipImBh+iCHZ2eDlAqN3Gw2Baxt4J9gl4uhygTWh6BnXISn2vfSM1R925k
         XX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l7uwSF1c+axVBeZ2M50qMmhyN71XFhMZL/gBpcud2XE=;
        b=cAeNnsPsTHaViELj98CKdbzacrsw6ER3duOuy2LrcbyYmQjVg4jIEw8mMDeMlB5UC1
         iwLEDK3dXZnhzkChON+CQI1UX4KxM+knJ938f7AqklWtkHCOc5eLSqTKOgsfECi0thD5
         eRYBRlB2cjaXdxIj67H6JCcJWTxxgnm1HntFX8r3RVG4xDPFdsZEOl8aI/bjJllsQCMr
         TOmGAqrPkFx2Vs3/SfvVXiKX0Q0p0F8LXXeFamBYEX1iKx4wf0hYsLILd4XCmD67M17T
         TaB/+hNJziufC+bGiegYypWEizlICmhZ3ZLsq4I6RLqURp1EKIYHfzNojdHzWU1+Yyqy
         Iy7g==
X-Gm-Message-State: APt69E2ENwoc08rqFoAnYuS8KpikS0+bh+Zy9oF2CH8SJz6KQ+RSE4Je
        JkQH6Ryp+YjmUzWxdqWJlFvxvA==
X-Google-Smtp-Source: ADUXVKLifkotl0F6VCtaKGBaZ64CXCUZm7Kmov5+K/QJWwqaAgNS/nz/oSeoayCH9r/LkQvBfvpGPg==
X-Received: by 2002:a81:209:: with SMTP id 9-v6mr725953ywc.401.1528773081123;
        Mon, 11 Jun 2018 20:11:21 -0700 (PDT)
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id y2-v6sm18377390ywc.23.2018.06.11.20.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 20:11:20 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin.kudzu.us>
Received: by graymalkin (sSMTP sendmail emulation); Mon, 11 Jun 2018 23:11:18 -0400
Date:   Mon, 11 Jun 2018 23:11:18 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB changes for v4.18
Message-ID: <20180612031118.GA11519@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB changes for v4.18.  They were tested earlier today by
Dave Jiang, and have been in linux-next for some time.  Please consider
pulling them.

Thanks,
Jon



The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.18

for you to fetch changes up to c9160b69258ef46ab62c27a09decb8fef311e700:

  ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_create_queue (2018-06-11 15:20:59 -0400)

----------------------------------------------------------------
Reorg and clean-up of the Intel NTB driver, a trivial comment change,
and changes of GFP_ATOMIC to GFP_KERNEL where appropriate.

----------------------------------------------------------------
Dave Jiang (3):
      ntb: intel: header definitions refactor
      ntb: intel: split out the gen3 code
      ntb: intel: change references of skx to gen3

Jia-Ju Bai (2):
      ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_setup_qp_mw
      ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_create_queue

Wolfram Sang (1):
      NTB: ntb_hw_idt: fix typo 'can by' to 'can be'

 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   2 +-
 drivers/ntb/hw/intel/Makefile                      |   1 +
 .../ntb/hw/intel/{ntb_hw_intel.c => ntb_hw_gen1.c} | 713 ++-------------------
 drivers/ntb/hw/intel/ntb_hw_gen1.h                 | 182 ++++++
 drivers/ntb/hw/intel/ntb_hw_gen3.c                 | 597 +++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_gen3.h                 | 110 ++++
 drivers/ntb/hw/intel/ntb_hw_intel.h                | 203 ++----
 drivers/ntb/ntb_transport.c                        |   6 +-
 8 files changed, 1001 insertions(+), 813 deletions(-)
 rename drivers/ntb/hw/intel/{ntb_hw_intel.c => ntb_hw_gen1.c} (74%)
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen1.h
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen3.c
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen3.h
