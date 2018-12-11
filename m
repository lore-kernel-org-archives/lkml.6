Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD880C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AC32081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="pTG+OiJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AC32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeLKKy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:54:56 -0500
Received: from mout02.posteo.de ([185.67.36.66]:50951 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeLKKyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:54:55 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C367A2400E6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544525693; bh=y6BKJpuq47BGi3QByc6H+DyANGz5gJa5v2JQ3Me17aY=;
        h=From:To:Cc:Subject:Date:From;
        b=pTG+OiJgM+2JPsWvkBDDb+OvKCWXo2qaqkVlCerQRgqrVIFZTkKOBQ4UW+sT7XspB
         9EjayZ7USZtx49Uz42QehGirJYj80LyOisbIR/oZ7qpHb4SkGY6787eGO/N6m43Eov
         y/m/d+VQU8DHhoqelUYLp63bXhpFqcFxFL41uzLtk4EVjRsJEAHR8SPsc/Lucyf3YI
         dt8nle8XlwxY8PnBUBq9Q34ORvECsTfuXOrKygqmauwoV8udnEyXYzHyWZ1fY0EUQn
         86hF+mgXPZ0dd6cdjRMhCXSYH1HSYnUKWuWPwXgWuhr3eWKRg5fB3zTZaUWd94UC4+
         l2yO22QVVJilw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43DcK72CK6z9rxX;
        Tue, 11 Dec 2018 11:54:50 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH 0/5] drivers: staging: erofs: Fix styling issues
Date:   Tue, 11 Dec 2018 11:54:38 +0100
Message-Id: <20181211105443.21826-1-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed several styling issues and one error, reported by checkpatch.pl.

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>

Aaron Strahlberger (5):
  drivers: staging: erofs: Fix alignment.
  drivers: staging: erofs: Fix comparison to NULL issues.
  drivers: staging: erofs: Fix spelling issue
  drivers: staging: erofs: Fix parentheses error in macro
  drivers: staging: erofs: Add blank line after function

 drivers/staging/erofs/data.c     | 65 ++++++++++++++++----------------
 drivers/staging/erofs/dir.c      | 12 +++---
 drivers/staging/erofs/erofs_fs.h |  5 ++-
 3 files changed, 42 insertions(+), 40 deletions(-)

-- 
2.19.2

