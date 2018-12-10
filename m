Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F127AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CB820851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3UwiBqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CB820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeLJXnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:43:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34808 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:43:09 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so9304149itd.1;
        Mon, 10 Dec 2018 15:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4yM4WyPy3yPiJETQPYVe1V9tP+X3065yLRYA97Pk1I=;
        b=K3UwiBqI9+zlDAliqKvgsyxDGa4zDaGPCSSdmVK4nvMmBo1JSxnnAwivvnA8oKsp+Q
         VsDJnSAh1GmDga4cZOV9o+5eweT56Usyhp+mKtkHl1KtaEaLp8HsgYnwGkYoBQ0hp5Uz
         EbfyUJO6EyObefFnbUQZEEtkXqcnfCarjLXpJm5RRDZA9ANHRZyEpWmIMedgYrKqy2ic
         ZWVKZClfni2KtkvC095tc2bvwsU0lvOGUvFK6AhHYEeZ0RZRlb+up55DvpFQpZ4eH9CG
         tywIXqTA9CvKSurfl7L4HFadaEHj8xwQ5i50msrjPgNaTB2vUNFTEBMZVrbTcO0gaSXr
         KmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4yM4WyPy3yPiJETQPYVe1V9tP+X3065yLRYA97Pk1I=;
        b=tvY1k4zPcTdeDGgmkZdVLujqc8+ZjINmWfbMca7YEL9aL0a5b0YJyMsNPTWc0nW8uF
         UIh0QK3cit0C6/GW5T30ZYVze0swii5OTrR3tB2v4lHzmMB0LgUs6DCfcsZZLtwEb0Pn
         k15VT1G+/JS0b3eo364Zeryofk/kkijD1Mg6ZBFjvCvM/BN+U5ytU1tfN+m0jcqE1vzA
         OuqZVE9DKbdSVL1mi/JCNZGC0hvNEO3li7ryQdZeY0pimR//WATEXVe+FosVepllw1WS
         h7QeEO9OgCXzcLZRtkJr8M9t3x0ccvdF6vILnlb34eQxHQQO+/fqPJJh8n8p6O3KCHUc
         dZhQ==
X-Gm-Message-State: AA+aEWYEuRPcoWYzovVhNiRbiHK5WYrYFyqLvFHQZqx+OrOEvHoEgTzR
        +EsDhmkAuiJ00B2Uc9cI9DUo4e+Ry2A=
X-Google-Smtp-Source: AFSGD/XPjee+Yf2HLztlba+PjVCEPwtSDEAF3cQVjballZZP3Qz5ungsj63/OnXeLEUSNG0h6Tq6lg==
X-Received: by 2002:a05:660c:10:: with SMTP id q16mr355524itj.51.1544485388422;
        Mon, 10 Dec 2018 15:43:08 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:375a])
        by smtp.gmail.com with ESMTPSA id e68sm625346ite.7.2018.12.10.15.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:43:07 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 bpf-next 0/3] bpffs pretty print for cgroup local storage
Date:   Mon, 10 Dec 2018 15:42:59 -0800
Message-Id: <20181210234302.31327-1-guro@fb.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements bpffs pretty printing for cgroup local storage maps.

v2->v1:
  - fixed size checks in cgroup_storage_check_btf(),
  based on input from Yonghong and Martin
  - implemented and used btf_type_is_reg_int(), suggested by Martin

Roman Gushchin (3):
  bpf: pass struct btf pointer to the map_check_btf() callback
  bpf: add bpffs pretty print for cgroup local storage maps
  selftests/bpf: add btf annotations for cgroup_local_storage maps

 include/linux/bpf.h                       |  3 +
 include/linux/btf.h                       |  1 +
 kernel/bpf/arraymap.c                     |  1 +
 kernel/bpf/btf.c                          | 22 ++++++
 kernel/bpf/local_storage.c                | 93 ++++++++++++++++++++++-
 kernel/bpf/lpm_trie.c                     |  1 +
 kernel/bpf/syscall.c                      |  3 +-
 tools/testing/selftests/bpf/netcnt_prog.c |  6 ++
 8 files changed, 128 insertions(+), 2 deletions(-)

-- 
2.19.2

