Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 906E5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447F62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMD0JBks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447F62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935172AbeFMBQd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:16:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45349 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeFMBQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:16:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so407812pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 18:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2M4LvDzSto+yO4CYLIJlZrz7C/x4bWVu5D8XV2DxTM=;
        b=IMD0JBksXDC3vGmcoUXuwYftOuCxZ1cmIfpJ4dyarR/aUqOLJrtPY8eMrtaZ8+Oonq
         8BNEvKFVPXboZH21UL5QgFUWB6ByobVPM6lsdJRbqCTylfAglPIPovq6dEum2+MWja4W
         7GrjhI+lvfxCcI6amThhF9Kh5Wag3FuirWAD5SrnHWEC7awxyZQwpWbZPuA68deUTQcI
         OGTssybkBRzcaEVznotXptCgvRJJr2h7l0JPoekmsD+wjARsF6HMqdLtN/wGVLT1QIaG
         6SBLN0m4gMEMdpmsCOCLLi30vp2ZvF1r1xv0NOZgJVBg5pcC7fo1yNkr6a+ztSKFlRI4
         NmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2M4LvDzSto+yO4CYLIJlZrz7C/x4bWVu5D8XV2DxTM=;
        b=T9diSefcLTOnImZEgL8MiSwNfuviqcwDaiRlfVuGaM2U6det3LCOJVOFTHW1QgU5of
         je0HwqkLCxQiC2v1Zb5P8IIBswTSYlx4pEU4lCJb+zQAol/nyE/RP3XnrEcYzhoq6Ysm
         mveGDzQ23EI7gp6r58NCI3jiSXPhKTmRQ/e4oYEqdTRyLg7ANoryBF03REYXJ1qRUxDi
         nbYxsPnKzl8Mv0Jquwa3Hxlcu9qqkQoHERq/HAIwZUfhCvv9+LXn9WjcTUEliLKvdZ/8
         5Q7ORuygf0nv/JcTVFoaCO1AejkLcqHoth3rQLFb15FZ3CZlD6kHtwo8dtnX43gbEbup
         rg6w==
X-Gm-Message-State: APt69E0i/m2PGUDqgnQ8QarATHCaycKvhpPA+bbgiMSbqcDd4gtjkACM
        KYhVz9d5z0V6EUo76muxh5c=
X-Google-Smtp-Source: ADUXVKK8wVs4uzFV3tbmxNM7dqqjENbr2QtRubvALkb4VCNvELsTtNbji7lvv2oxbZzxE3FrUHajIg==
X-Received: by 2002:a63:b91b:: with SMTP id z27-v6mr2242367pge.240.1528852589343;
        Tue, 12 Jun 2018 18:16:29 -0700 (PDT)
Received: from localhost ([123.117.176.200])
        by smtp.gmail.com with ESMTPSA id z28-v6sm1587910pfl.169.2018.06.12.18.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:16:28 -0700 (PDT)
From:   Peng Donglin <dolinux.peng@gmail.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 0/2] Re-use DEFINE_SHOW_ATTRIBUTE() macro
Date:   Wed, 13 Jun 2018 09:11:57 +0800
Message-Id: <cover.1528819790.git.dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
References: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

Peng Donglin (2):
  ARM: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
  ARM64: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro

 arch/arm/mm/ptdump_debugfs.c   | 13 +------------
 arch/arm64/mm/ptdump_debugfs.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

-- 
2.7.4

