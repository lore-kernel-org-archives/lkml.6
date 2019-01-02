Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B21C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8854218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEcNhZMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfABPXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:23:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43473 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfABPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:23:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so15297798pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i8HHymxUIZEMV6nVYahOhQVteAlmsxO4ge2fqEVMJhk=;
        b=aEcNhZMm1Yeah1wnmY4Kua8SXz1RtzVxLgaU8VVb50qU3crdOl/hALuCzVY88LzXrv
         q1RRCaGh47OevgZQnkafoSTgHNySJrudWLKGIqOZ4DGGU4mhqt5YvSZcSvajLhWSG6Yp
         3kQMC3kwuhKz8txb3RzpshkFqVC39lYTEmggM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i8HHymxUIZEMV6nVYahOhQVteAlmsxO4ge2fqEVMJhk=;
        b=GHI2TOxtilxeTXtNyVPv5E962JiHw44HqWKGjSGEErF1TUfaDjdveWU9v3FnkHf10j
         HQGJ2CUpImchQCqbhmSGVYF52kYUogYZQ5L2o+JKhjmzhw47KrSAY8FsMkEr/xMa7J44
         PikNSduWav/wDVemRkGJsFam5oKS7Dt+QgHBQW6a9SRVeT84ckx+6OVn6hNQtG4dmxz7
         mGl8e5OY3H34v+Dj8GQclZIYlR1bqsbd84K6a0NuwkO3k3/MmkP3ayDK0dmNVOM4kmlU
         x19u2RCuV6nQqo/FIsDhbbFYMCfYJd1cV/eeBt24Ep0ckIKBj5qtxjRDd2XuFRF/xPqF
         icEA==
X-Gm-Message-State: AJcUukdLLIVjyxpNijzQkp56+WmVYIkAsmh1PDuQl+IQQWFqzc1Vk1xA
        UepO94Ennhg7mciCEM/a9iULxw==
X-Google-Smtp-Source: ALg8bN4n/+zoARXQ/Crdvqjc5CvNf73IHcAxxLVwqcb5e3ukekKrbp2A9f8fckOgGJf+ogthDBDmJA==
X-Received: by 2002:a63:6150:: with SMTP id v77mr41030254pgb.266.1546442597956;
        Wed, 02 Jan 2019 07:23:17 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m20sm67719647pgv.93.2019.01.02.07.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:23:17 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] ia64: Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:52:45 +0530
Message-Id: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures. In order to reduce the source code across all
the above architectures, create common ".sh" files and
keep it in the common directory, script/. This will 
be a generic scripts which can use for all the above
architectures.

This patch depends on;
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (2):
  ia64: remove nargs from __SYSCALL
  ia64: generate uapi header and system call table files

 arch/ia64/kernel/entry.S                |  2 +-
 arch/ia64/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/ia64/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
 arch/ia64/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

