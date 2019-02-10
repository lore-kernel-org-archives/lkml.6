Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BDEC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 04:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547BE20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 04:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF7wpINY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBJER1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 23:17:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37798 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfBJER0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 23:17:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so3396169pgb.4;
        Sat, 09 Feb 2019 20:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=S5r5D+13XhqVwobVbf13PllfyUkqCEcGoKn7zFkM/jI=;
        b=LF7wpINYLHC97Incll52QCeuAl2urSXhc3qtH5lgmrfaKv/aYK8LI1/4JvrIBmTjES
         FwzT9tBBj57CWDq1cNJOaxdlec9Axw3zElO2FiSSVZLpqluyaN0hmga3SVVhba9sDUiC
         LYQ4OWwCG7NnOcoe+ELRNohxKfkIEoYeH3XTacrrJlENM9dVrfDFOuDC+iXKExjG4FjC
         pnDCy0SBof4jYutMPQExW1CG9TwI8Kn37ewqWsvKtHgV55XkVEhhRQgrfnwVbboS1Izu
         ASKRkSSlVvQW6slc3hDiqmjgwuRfBwpLmapwbxqLu6ITjFQd87d5gPAsWbn+r1TfpxI0
         avJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S5r5D+13XhqVwobVbf13PllfyUkqCEcGoKn7zFkM/jI=;
        b=HxDF2nWY20HWv6fhHMsSSSrlMJxKTtLnHVGF8vS6YyPqeRYWUsdcghqSFEGXk/0VBC
         pnfctZl7TT0rIMMm8Ve2K1PLbudvK/ApXj1oQBgrRheHcQ5OSUkgNIThXFPbv8/EmraK
         13fYUtBSME06pJfSEbllOJO0CGSUZ/kPtWaB4o1tjI3Jqi/S3VRHNDUkm+IgC4JEnoiH
         NIYAg/yzDxSborFIrse4cBGeoMN3PyOmvlFeCwCupHSjXWLD7Y6yOctr9H+E1zs30tbp
         jRuGknBC3vKvVEVK74HkUVtSo5SPtLgXyJhbZ9azxND7vxP7aIMGzEzroL/5h283vUVX
         tjxg==
X-Gm-Message-State: AHQUAuZy9nT5NjuoLXuoFPUi6aAXfIOaITIvKDIX3+r/fXDugwQAjpkW
        HlSqlyIVHLVA9piXM7qMHq0=
X-Google-Smtp-Source: AHgI3IbKygx0okM4QWFdtZXFNbmuPqbLS7BJkWAoeNnnsI59UfOIrmFxPgtNhS60l+7ARGHY5Oi9GQ==
X-Received: by 2002:a63:96:: with SMTP id 144mr27955914pga.315.1549772245933;
        Sat, 09 Feb 2019 20:17:25 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id q1sm10601286pfb.96.2019.02.09.20.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 20:17:25 -0800 (PST)
Date:   Sat, 9 Feb 2019 20:17:23 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
Message-ID: <20190210041721.GA2805@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management fixes for v5.0-rc6 with top-most

bf78f133cd39e0ed41551150909e41513958a738:

  thermal: cpu_cooling: Clarify error message (2019-02-05 15:50:13 -0800)

on top of commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

Specifics:
- Minor fixes on of-thermal and cpu cooling.

BR,
Eduardo

----------------------------------------------------------------
Amit Kucheria (2):
      thermal: of-thermal: Print name of device node with error
      thermal: cpu_cooling: Clarify error message

 drivers/thermal/cpu_cooling.c | 2 +-
 drivers/thermal/of-thermal.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
