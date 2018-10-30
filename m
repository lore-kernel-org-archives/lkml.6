Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C527C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8F52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5I1fqcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8F52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeJaEE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:04:29 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39027 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeJaEE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:04:29 -0400
Received: by mail-qt1-f180.google.com with SMTP id g10-v6so14847714qtq.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=zjm74yT45oMI4Ow3UZQOt1y8Cq9wGH0DB+1d1nDtGcc=;
        b=W5I1fqcDs18ZyMXBZUOSl+JAISaQn10UC4ExXe6zA1bfOGlHO9V6BbjZk40Sa+Exeu
         yjWGVgSVqPiv31D0K4A1YAN98MOtj18ZLI8c59ZqSRXTRRaplT39Jwo92E4yMSlGANPL
         CPxVZ+adMjUiXIkDMi5FmLv1ZXfHdDsrG/zU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=zjm74yT45oMI4Ow3UZQOt1y8Cq9wGH0DB+1d1nDtGcc=;
        b=VMt0F+tkb9DG8qM0YBBhWLF4DUtZOzXSLaWBnsAafl26NZJw8tXP5lyoy3D3E7dMz2
         UxleZL5yUtILFr5fgkC/Yg+F9I2IyKpO8/0OF0NkgpBO1xlprAAy/lj2Dx4g+h287VQF
         99+APntYcYv4KRa7oaS4Vxwj+LgOBlvqxvGXk3WsmyT+BHw74dk5M2QGdeGCymc94qHG
         Ndr6jGlbpCN1kNrMee3GyJ1ZEphrCO/F3tBEQu2VNsXRyxfP0kxvbEzAS4XB7SkBWrK6
         ypJmcinnE1tZZ1TO/tuP64Y1tlbw5SWJnriDztiBIrhmHlHox1ZDT/5Qda+qE38z19k4
         Cc5w==
X-Gm-Message-State: AGRZ1gKBonGwrZVhBPcSUD/8D59Y7395ouE3jNHcJgMT8sD0oHjTVTAG
        Mk9nQ3Nu/C9/jnFLhLflBqKuwLR6AFA=
X-Google-Smtp-Source: AJdET5cQHSjDe1/ytCUu/ZAL7gvHQ631uZN1021T7xj4FSXdPlBI/3IUVRUtqk7udMZWc2p94xvPGw==
X-Received: by 2002:a0c:f4c2:: with SMTP id o2mr136362qvm.236.1540926585364;
        Tue, 30 Oct 2018 12:09:45 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id k184-v6sm14362114qkf.48.2018.10.30.12.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:09:44 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:09:43 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Cramfs fixes
Message-ID: <nycvar.YSQ.7.76.1810301455170.1498@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

  git://git.linaro.org/people/nicolas.pitre/linux tags/cramfs_fixes

Make the Cramfs code more robust against filesystem corruptions,
plus trivial indentation fixes.

Tag: 37b13f91069f87579018f4870da082bd172be005
Branch: 56ce68bceeefa38e5b3509bf3d39259138e2d76a


 fs/cramfs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
