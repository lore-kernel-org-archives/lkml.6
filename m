Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71304C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2654C2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PizKpX6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2654C2241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeKMIF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:05:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41756 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeKMIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:05:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so11073876wrt.8;
        Mon, 12 Nov 2018 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcbVxHpza+mdGoRqM65Skb/eLdbTyMb//kFTONunI0U=;
        b=PizKpX6gyMqwv33vYfjW0lfnQVwxeS6Urht/48nWQ91FtMSk3+CecDBA0PdQVmIifN
         9UUdMJAGZQFn2Emy76ldQ6GE7ApiaDdw8nUP3mbCVs5cHZOhpH2lN0983GW5uN1p9wgV
         7JDBSMWe+joWoRECRJdxtDyDpVoVN5OMfaKcUZYvBF36/Y8jlSiVLNULPJ7SLIIKG3jx
         Fg+fEQ/Yinb3Kp7WZAIDDv+V/UjTJ0MRDWfat1TC+2YhLQrPVISeWdcEK/IWNcn9SZR2
         IeRMDVmigYaUVOwTXIopM+O3GpiEBpl+V+wzbDlZ86R8yHYJB5C2hHNvjzIfV9/GIAKy
         wppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcbVxHpza+mdGoRqM65Skb/eLdbTyMb//kFTONunI0U=;
        b=HjEXi7r05tW/KF/l4+bbKcVj0gpV82h3fJvX/TDW9DdmOiTj/HqVU9hxlovrfuARta
         3rWIbLGdGbgCw/LKhknBGM2jSzmCZckndhV0JxIktrfdtVrH6D0LIHM3BQhvKNySrmaq
         FcxKon8rSF5Zm9dWXFzv2wuQJeXnjTl2dld30lCSrBiEwYe8o/Tcd4fkUAsDF91Trng1
         K/Jt+Cel46+uoCKVqRX/zxSHK5CXI+jQIZlFafT5gmnhflBSEhtlM53O8txKJnygBIQz
         raCQuyQgIHlIAAQ5APGDBkkiSe/VEM2+YrJjvTv7qYSFdw5QgirRsu4cqBaOQdaXah53
         ShFQ==
X-Gm-Message-State: AGRZ1gI6nGxTkIPlVUorSU+yb1WSSvUC+kb6Yx9x3edOduq6eGd67I15
        YQ4VbjeG4LaCkaUh3kJZVAwC/nZK
X-Google-Smtp-Source: AJdET5fFGNZ9g3HEykexoQa47dmqwED8gXIQDPO6XZcr7mEhkpgcj0ikyqAKpZVq639GmoBnpTPaUA==
X-Received: by 2002:adf:f148:: with SMTP id y8-v6mr2682520wro.303.1542060650194;
        Mon, 12 Nov 2018 14:10:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h5-v6sm27400508wrs.51.2018.11.12.14.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:10:49 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] bpf: Remove unused variable in nsim_bpf
Date:   Mon, 12 Nov 2018 15:10:42 -0700
Message-Id: <20181112221042.11160-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/netdevsim/bpf.c:557:30: error: unused variable 'state'
[-Werror,-Wunused-variable]
        struct nsim_bpf_bound_prog *state;
                                    ^
1 error generated.

The declaration should have been removed in commit b07ade27e933 ("bpf:
pass translate() as a callback and remove its ndo_bpf subcommand").

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/netdevsim/bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 6a5b7bd9a1f9..a1b29173ca1c 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -554,7 +554,6 @@ static void nsim_bpf_map_free(struct bpf_offloaded_map *offmap)
 int nsim_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct netdevsim *ns = netdev_priv(dev);
-	struct nsim_bpf_bound_prog *state;
 	int err;
 
 	ASSERT_RTNL();
-- 
2.19.1

