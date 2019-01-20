Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9F2C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0B92084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRGbexfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfATIMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 03:12:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40857 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfATIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 03:12:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so8006613wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 00:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kk0/2aMF7NjdjMM+Qd0KA0QosFWzOgYVFrzMkwSdhI8=;
        b=eRGbexfUr6W2PMcbE9zEX6CBLAcxveq0Y9pL16CNxOQCNxz72Cr/pUkNbd5SSvRAQ3
         8LisxFv+7yRiwGP8jRV22EZP03dCg+HeepTNzY6PkFHm/tmH1TIIb9jVszh5FFAVoe1Y
         6+Zni4lh5DH+4pnJF8BBTDcumtgKfAoBAomsFxzurqFwFltkbUD56ncAw2CAOGHI8YxF
         LDe0dYsehOVD8VgIfnOwTe3bDnmxZiIokqrPOaH1M2x7h2hjxVWTzszTiOAtZWmUS5/g
         gdlISnxAGOeBRgXdeR0U1aR/sMY8e7Ie3CSXpdyq5vHM7t4+uotR1dTD3AwK4Bmkj/Wj
         /3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kk0/2aMF7NjdjMM+Qd0KA0QosFWzOgYVFrzMkwSdhI8=;
        b=uFkiRXq0F+m991D6gfk9KxGq93mBx3C01KsD0ueIJTqC5EKbI0D47hbmhSwyA2tBEx
         worUUNtdVk1z+EKdXpegKNknInzF9BpzMZwJiTjBNtEOamt2sfBXzQxzk+JhxAjFAoaW
         sf/euRP3Jlf8dODj8YpAOG+4+BCoc+cZUDvn3PbP3bx4ULTM0LO68a/AywHBcpgXBB0r
         24yLbrIwbFJRlgBR8zDex5sSqLVEqReIgr5FDwfRRBkcr3Q+3D4L+u6dxmrzSbtCLbjY
         VTNKMnFRPffTJvvgeDUwG1qyrKwnxO21WkM5Ghbg9fQvZvu1YrxXWqtsTYvloxiPCdqh
         a0qQ==
X-Gm-Message-State: AJcUukfNJatN5OIbDfhINKFuwI/HgSs4iXIGmAFMTgromtx1mOyd2ybL
        SfDJtWH+PJd8Zj+Yu89XpUE=
X-Google-Smtp-Source: ALg8bN7/m6L2H445l2jrP0aMoPmcMmPi9frIfIf3MKfqG7myzMJ91uDoAfHzHtMU3idE3tHc6Eo3ag==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr20495057wmr.7.1547971962287;
        Sun, 20 Jan 2019 00:12:42 -0800 (PST)
Received: from localhost ([2a01:4f8:1c1c:6057::1])
        by smtp.gmail.com with ESMTPSA id y34sm244173674wrd.68.2019.01.20.00.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 00:12:41 -0800 (PST)
From:   Yang Fan <nullptr.cpp@gmail.com>
To:     akpm@linux-foundation.org, will.deacon@arm.com
Cc:     Yang Fan <nullptr.cpp@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/mmap.c: Remove some redundancy in arch_get_unmapped_area_topdown()
Date:   Sun, 20 Jan 2019 09:12:26 +0100
Message-Id: <cover.1547966629.git.nullptr.cpp@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset remove some redundancy in function 
arch_get_unmapped_area_topdown().

[PATCH 1/2] mm/mmap.c: Remove redundant variable 'addr' in 
arch_get_unmapped_area_topdown()
[PATCH 2/2] mm/mmap.c: Remove redundant const qualifier of the no-pointer 
parameters

Yang Fan (2):
  mm/mmap.c: Remove redundant variable 'addr' in
    arch_get_unmapped_area_topdown()
  mm/mmap.c: Remove redundant const qualifier of the no-pointer
    parameters

 mm/mmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.17.1

