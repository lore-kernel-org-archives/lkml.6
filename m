Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7415020883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820293;
	bh=sOpXAIN4LecoePI9h86jXJx8DTadSwOnlv6VplT2l7s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GgqagSbxk8w1HsXRbn6f9fQg3cL/HNSBDlCsfm6hHvwIIJu/6frVwWFMSZ3HjX+tk
	 4HSnADOuSPqPT3bD0KF5WCygYztD/uv2Xfi3OVlwB4EMwV5SbLE2RdLIVOwTRrjaxl
	 bFLW3qZDESqF0ZWzHpepHW+isZK0M7LpdskVvZdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfAROEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37453 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfAROEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:04:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so11741570ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6s0qcmO7aLfyfOw7s9z/Yj/ilkWPQG8suncvc1U/E+c=;
        b=MoJOVgQCEoXdhoMbE8HQayJYAbRmhV9y6HAZuubHvpb+z8TXtSuCFo3Q04F7I7hzW4
         OTwGBjRkFDnfZHwqwEoza+Ad0X7Fic6NMfRMEgeH+p2T9b8Y53c6vCsUYITnHYaZdYpl
         mJywbt3gSIfOLFGoZTffaw+kfRSX9vCjoN2OePFvIaE48KnhvAVqAguQ6omYluWU9Rw2
         mACApTA3WvM+YurzTjvDbLIQ9/EfoG6pc6qcYKaPYpe/+BdH/7M5ODrDFvQdJqwMUvHN
         NqoDpl53/+JVQs0viiC7IzDu9GdPpnqXddFZE1Gs1ZBcNLq+8oZVSTXkyYUCndtvd760
         dECg==
X-Gm-Message-State: AJcUukdFGmPJXoz9J5SU91jl9otVEsn+neoimhS4HwtyILG83c/kNjjw
        nX/U4gs8qKtexNLWVBpx2LY=
X-Google-Smtp-Source: ALg8bN64/LFaxgPtmOG1WY9K4KR8K2Fq6zla9/G9/fJ0S2sFKUtlfG32I3QTc5UBnKjNhY8cSR5cdg==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr13063600ljf.127.1547820279081;
        Fri, 18 Jan 2019 06:04:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x21sm809546lfe.6.2019.01.18.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:04:35 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gkUlB-0002Vn-2C; Fri, 18 Jan 2019 15:04:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] riscv: minor fixes and cleanups
Date:   Fri, 18 Jan 2019 15:03:03 +0100
Message-Id: <20190118140308.9599-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix up some minor issues found through inspection.

Note that the fourth patch changes which cpu (hart) devicetree nodes
are enabled by following the Linux convention of considering nodes
without a status property as enabled.

These patches are against the riscv-next (and fixes) branch with Andreas
node-reference fix applied:

	https://lore.kernel.org/lkml/mvm8szwwo1o.fsf@suse.de/

and have been tested using QEMU.

Johan


Johan Hovold (5):
  riscv: add missing newlines to printk messages
  riscv: use pr_info and friends
  riscv: fix riscv_of_processor_hartid() comment
  riscv: treat cpu devicetree nodes without status as enabled
  riscv: use for_each_of_cpu_node iterator

 arch/riscv/kernel/cpu.c        | 28 ++++++++++++----------------
 arch/riscv/kernel/cpufeature.c | 13 +++++++------
 arch/riscv/kernel/ftrace.c     |  2 +-
 arch/riscv/kernel/setup.c      |  6 +++---
 arch/riscv/kernel/smpboot.c    |  4 ++--
 5 files changed, 25 insertions(+), 28 deletions(-)

-- 
2.20.1

