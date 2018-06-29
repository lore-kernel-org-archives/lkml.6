Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C340BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612FC27FF8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovXMvENE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612FC27FF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936377AbeF2Oub (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:50:31 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36242 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeF2Oua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:50:30 -0400
Received: by mail-wr0-f170.google.com with SMTP id f16-v6so9117625wrm.3;
        Fri, 29 Jun 2018 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h8YH/3BRM4lpJRJG8KEqKb9DYNBFLEf51rUKGhQlfio=;
        b=ovXMvENEZMAQhHvr9mvjWHo+1TzWAhqn6Elju3g/rmVk42lQXEdksceyP8tttvp9K4
         FnswbONcvIH69jFxN44lkDapEKVKtJaoY5kT1U8ivjXdFJT1aOBhMkdeViIkf967xRgH
         b/1YGtEJD/t7AhNXvm/Y9RCpeiDOPlAgcuXFmUTUrjn8UWOzP/iB4FfFH1OC5zkFFg9A
         TtI84f1YAzrh3bhAP0PMcA+vlV8l7mW3BYHnjJsSPrB8WTZv9B1VNKThvgEcISPZO4WU
         e1CGg4fnYvbHZGeBDSlZpxBJ56rPZgGsg8wEuOQv6h6dz+k81MePuV0aaFwowrZ1+YVM
         Swwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h8YH/3BRM4lpJRJG8KEqKb9DYNBFLEf51rUKGhQlfio=;
        b=FD0BmC0xtUuKXeDHos8Zjn0xppw7g8VNRX+zZeCaYi4X0l6vMtzS4alYO1P3ay5clJ
         2hdQXsXLOT/h1oWszmxD2j6hTUXmnyztSyPRN43peXt3npiA3MEQBQ8ZpAk8ixo2EHp8
         dOseWD12AXZ3Y5Z3O9iWnKq8WeQGGt7rnD28E9L57nLgA6z8pI2loE9edtoxPAJxfX9b
         kUZKD88kr1GAiM63QT5JReQ15/5APmaaGmk/IS2selOmchOPJBeE4nbFr0v+JRgcopnx
         SzqF8QTT5zgA8Ev6qOUgM3xOgvVBsjNYRIkM7XKr7hptryqPYNCrnMpvlkfWCAdqoc3D
         05mA==
X-Gm-Message-State: APt69E09Q7fWF2WqwxgdWLSWHV4h0+Gk5jX0CpDE2vV1G1XcypgCl6Zi
        YuYxd4E72eHj7saYPdMxn2CPfIQg
X-Google-Smtp-Source: AAOMgpfytG9CeNhnwWJbv1aOrcpY1x728HPEnNSI91w/yINV2hfWbs/m1JYbEcq9i6p1islkZp83jA==
X-Received: by 2002:adf:ec89:: with SMTP id z9-v6mr13080135wrn.160.1530283828984;
        Fri, 29 Jun 2018 07:50:28 -0700 (PDT)
Received: from orange.redhat.com (ip-62-245-115-235.net.upcbroadband.cz. [62.245.115.235])
        by smtp.gmail.com with ESMTPSA id r2-v6sm2382905wmb.39.2018.06.29.07.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 07:50:28 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 4.18-rc3
Date:   Fri, 29 Jun 2018 16:49:57 +0200
Message-Id: <20180629144957.32584-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.18-rc3

for you to fetch changes up to 8b8f53af1ed9df88a4c0fbfdf3db58f62060edf3:

  ceph: fix dentry leak in splice_dentry() (2018-06-26 18:42:44 +0200)

----------------------------------------------------------------
A trivial dentry leak fix from Zheng.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: fix dentry leak in splice_dentry()

 fs/ceph/inode.c | 1 +
 1 file changed, 1 insertion(+)
