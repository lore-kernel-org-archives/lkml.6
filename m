Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F38C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7623520B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xBG5AoQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeLaVqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:46:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeLaVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:46:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so13058169pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UAbdU6XVTBCbP4w0w6CO/i1BzYSDORh4ljdJvWCwdCQ=;
        b=xBG5AoQ9v4jFta9QDoH7mUJedhYMC5mZ+kvQlZkMHOL2Mod4rVtiOWy/4SBL9p7ALZ
         knloyJlMaFu37ioQT7r0p6H7f3++qCClo++8NLXq7HrRGRtcGA0+/VFLtrAPMohnF0HR
         4XL1YzF4aFsBY9QTdpcrJft+vXxAuQMcFbYQ9AK4y8BoRBuO5rXh8p9L6Sn8c8wBj9MS
         WqtaztQfmxvHVX6J82Qu5jd9s2sKr3Qbz5sHf0mAfPrcT9Ijj0h3lU6C5o/Q2SHClyjg
         izUkinXtuawGXsRK5VvTysIvVpHwuviO8F6oGQ7XFky8hnsZ3xxRHgQxdHTsD8BpCNCA
         DIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAbdU6XVTBCbP4w0w6CO/i1BzYSDORh4ljdJvWCwdCQ=;
        b=bb1zGn5Jo80fijwD8WePKrZdDwkNw49q9b7w55LM5Sk80L7TAB7n+Ara8OANagRMwg
         Ytc998ccnuRdLr15B5lZjmOt+j/RhYBN8xRAWk9kNnI2MAC4uCJTWhW/xWrhzRx9Qu1z
         bhmoRObhfhD4joZ/y9ePSKk5Jt5w0+8TmrzbUslFCty2EO6S5MjGL1i4CF3LcNp3cnHI
         tSUKK+8hVu3cbly0kiR3NuXa+B4n8VTxfh91LsqJXVXw6Hq18C34Lg6eqbttgIVXPfy3
         2rwUXqdz3q+6rGrQ2rEnqK9oLO95hLmwMp7k+lSlC0alW8ljQXNg+Z+iZ32PnV+renli
         NfAQ==
X-Gm-Message-State: AJcUukdtzKMwB3+/lBrqDdGSOhInHWKTB5d/iSwfCJYdT29n8Nv96fqj
        lSecW2em1ClRDfEJ2EHPlJuIsQ==
X-Google-Smtp-Source: ALg8bN573ucsNushgoxWAuLqfz7C1ARcYqizBB+KGmFzHVMvKwDTY9pxaf7lgNrKs5n26RQo1hYw0w==
X-Received: by 2002:a63:4f20:: with SMTP id d32mr8735848pgb.47.1546292811466;
        Mon, 31 Dec 2018 13:46:51 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 13:46:50 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Subject: [GIT PULL 0/4] ARM: SoC changes for v4.21
Date:   Mon, 31 Dec 2018 13:46:36 -0800
Message-Id: <20181231214640.17015-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the batch of changes for arm-soc for this merge window. It's
arriving later than I had planned for, the holidays messed up schedules
and time availability a lot at my end this year.

As for the material itself, it's pretty straight forward. The only
branch with conflicts is the SoC one, I mention in that email how to
resolve them. Most of the new material is in the DT branch (as always),
and that pull request also contains the overview of new platforms, etc.

In addition to this we have a branch with some late-merged material that
I'm letting sit for a few days and might send in towards the end of the
merge window if things have been going smoothly.


Thanks,

-Olof

