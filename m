Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBA9208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBA9208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH0PMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:12:52 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45478 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeH0PMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:12:52 -0400
Received: by mail-ed1-f43.google.com with SMTP id p52-v6so10166393eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=heTNB2cH7gTMhMGFyyS2ItQcdfSPp8FISFRvmSga2s8=;
        b=VGqCF7m8aB0Vj/EMMuXaSTUjczWzTn34GZIQ+hmv51SwQjZQaXakgSwIP4StSyo7tD
         b4YBibL3/+jC3Ptl+s+F3E6q+NyXSayR8AzNWDuwvx+yIn6B97xzMxjx+lrhsPge83DF
         A6Y4Pvn7unScVF7/seXEW/K+gNkdC0drcY5F9Vb26pldqW6gx3TM/nSFJmjzf8w49+yR
         7rcTGMMCjPXdbMskEa4hwBecwRwB0RbamajVKoIkZ0AURPXo9j9hPHV47gpibvV6r3Ke
         QNLpSBOQrkY0sRmdae0WZvnTy+fxG2j+COFI3nTr4Piz11M3IIdTW7+lVZagFnTzWBmm
         90HQ==
X-Gm-Message-State: APzg51BxGYtWq0doxisYv6bkaykVwBVHStU00EnY2+6rqRaFCA8g1dH0
        HODifSdAjYmlI6J4skkRxNQ=
X-Google-Smtp-Source: ANB0VdaVRIq9ha7ZCyK3oivEWpVKqAcCZtVeptnrah7xk39WVY3k0eTR/LiYQ68qmSiySo0IAQEotA==
X-Received: by 2002:a50:8c45:: with SMTP id p63-v6mr16745307edp.84.1535369195849;
        Mon, 27 Aug 2018 04:26:35 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6454416edf.3.2018.08.27.04.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:26:34 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] mmu_notifiers follow ups
Date:   Mon, 27 Aug 2018 13:26:20 +0200
Message-Id: <20180827112623.8992-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Tetsuo has noticed some fallouts from 93065ac753e4 ("mm, oom:
distinguish blockable mode for mmu notifiers"). One of them has
been fixed and picked up by AMD/DRM maintainer [1]. XEN issue is
fixed by patch 1. I have also clarified expectations about blockable
semantic of invalidate_range_end. Finally the last patch removes
MMU_INVALIDATE_DOES_NOT_BLOCK which is no longer used nor needed.

[1] http://lkml.kernel.org/r/20180824135257.GU29735@dhcp22.suse.cz


