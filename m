Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C68C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A3F21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMVNOv7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A3F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeKUSri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:47:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35374 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:47:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id v1-v6so4397192plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5dt7AHk++feB71ISImPMHBL9TWgWZTasMsvpTmqUyo=;
        b=WMVNOv7I7V8NGmxwJQLVySjK+B8MDQ0riSWUOXGJxRZp8tiQ2OblzVt3VIA0Z75tgk
         vr1xUHkBvqIa/RwJdOEWGHj9Kf/bwlOidJmSFOWa8x82ZsJH4f18QyZZnpbl7sWlfVpx
         Q8+CEgZkJSYEEAkqa4mhAe//mJEF3XoTSN5JATc5IG/djXTsHgQr8JF9JC/afsKcDTNZ
         QMLpQmppr5MzsM+Ygvm40RhJBtAfovfJnYga3JU95GKff3KGDDzpxbTw0f1r8t3xY5nZ
         EEbMrwI2+0QqnFFzRC1O2Z166YexVDuClQg6AhOY6+7377lKd9ZJ45cW6sGKvhowGB4n
         IbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5dt7AHk++feB71ISImPMHBL9TWgWZTasMsvpTmqUyo=;
        b=p7s+ClZyhzpHPCZOHgQw70sRRgqRqoxLkfkEhPo2tUr1o0Pg/zb+oerUsrFu/FoNi6
         z8qwd70tVaQlDO6A2s5Z6Z03sqdm8qqMGJRm/5UdrjrYy2MgUCVOnLUzIt2J6SqY4HOX
         V0w3yuFdt/2ZSOk6phu2XSgGpdi23W7l+kSRfk6IMQgQEhY+8eEEeQIaQksPkEtu3WHL
         1yoTEvkllfJKRzWuYTK6zaug+0iLNlgMh0EuiFjNBz6XF8dLK+GHrIibS2xc2bP3kMUQ
         lZ3T6VC5SASqiTeABJI+H6g+9c4cGhnDNCm1AKYnPCAUJBSCUtSrI7VNM9FiqF2dGFLr
         HKyQ==
X-Gm-Message-State: AGRZ1gI7yV8UeW6a35wX9VpN3TqT9d5g2RpNxkk2C2r74bqTnMsogVsS
        gkTHv3TA5T2ICvQhpUlPMpg=
X-Google-Smtp-Source: AJdET5faDqbVUFRIQe9p/sg7YeCCUAd+KlZKidWsgeWEch/Xtdtlq83K98H/TZibuTfENTtkU2e79w==
X-Received: by 2002:a62:8145:: with SMTP id t66mr5835727pfd.55.1542788046391;
        Wed, 21 Nov 2018 00:14:06 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m20sm45739390pgb.56.2018.11.21.00.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:14:04 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] mm/gup: finish consolidating error handling
Date:   Wed, 21 Nov 2018 00:14:01 -0800
Message-Id: <20181121081402.29641-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

Keith Busch and Dan Williams noticed that this patch
(which was part of my RFC[1] for the get_user_pages + DMA
fix) also fixes a bug. Accordingly, I'm adjusting
the changelog and posting this as it's own patch.

[1] https://lkml.kernel.org/r/20181110085041.10071-1-jhubbard@nvidia.com

John Hubbard (1):
  mm/gup: finish consolidating error handling

 mm/gup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.19.1

