Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AB32238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izS857VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AB32238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeHIUc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36298 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHIUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so3218029pfo.3;
        Thu, 09 Aug 2018 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wfgd7eS27CHVYb6s8wAx2iBTeRKXaiiHZGYV1m76CIY=;
        b=izS857VLce4+vKf6pqyvWHxsT8Bgz1Ctmlrp8CpmNt2rkmztvLECkl4cd2p3+KSs7o
         Nb/QtcoPrjpBe2Y845qzvrez62xM9cjEfZR9w32QjxwsXQ3Oi/anXQUus1ihRzDH00ZA
         Qehml7FvK9ujWmtqZ4qvdCrDDr486WE3/3fRAKOwE+hg8zkpFHVbFYwoaUZU5EV+dL7o
         b138nnK4WsBeQJPGVCG1xgFX8TNLFIoF7BVob30PiUao0xnEqUxYNbu6d5mWq9s2CVIl
         QU87rUOF6AEkf3Cn5hyAsAY76VvYdLZQNts4sGFZVIzfjt32AEk2hWA+56njtC0t39SR
         uisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Wfgd7eS27CHVYb6s8wAx2iBTeRKXaiiHZGYV1m76CIY=;
        b=mmafWhlQNukbVf6JnWx9OXEdE1XmTVLjSb3vtNafLE8aBcjX9PeQWvEu74Kx60J4eY
         hYl6CaEBwdhZYoOIv0hFTvHGPXgzZ/2MbwlZEtmofTicpafxJBHfo0SlkJ4wO+U2/gpm
         9QrnAfyVfPu4uFZP+ygltbOpycKG6Lw9mSY0hP2CEpu2plDa6uB9yPFACSuSr7Viuyxr
         NFyv9pH36dEZrNXZ9DcnrfazXt0ukHla6Uiz0MrlZdh2U5DXXUvbnFduo356SX9z3KFV
         +qjkOV0Vb9LGuQYpMcT5HSshfVKnqhNrUCXO4BG9ZsLWntOw6yg5t/mvRmsgq0w9vUEr
         d2KA==
X-Gm-Message-State: AOUpUlHqOV4xp1/rEf56RkWici6Dp5DOaml7Bk92YT1EVOjRhiJKPDIt
        SdHWrsa/uT840lN/s2QMFJs=
X-Google-Smtp-Source: AA+uWPwrVxd4tn6bfhVEl1tX8DwkGv9HOAYehio+lN69HdFII4YgZNqD6anJMdnwLrXY9bW//25phw==
X-Received: by 2002:a63:951e:: with SMTP id p30-v6mr3131052pgd.318.1533837989628;
        Thu, 09 Aug 2018 11:06:29 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id o21-v6sm12661852pfa.54.2018.08.09.11.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:28 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 17/17] btrfs: enable to mount HMZONED incompat flag
Date:   Fri, 10 Aug 2018 03:04:50 +0900
Message-Id: <20180809180450.5091-18-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This final patch adds the HMZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
system.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8f85c96cd262..46a243b2f111 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -271,7 +271,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
-	 BTRFS_FEATURE_INCOMPAT_NO_HOLES)
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.18.0

