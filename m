Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CFB208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aGS7c8/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CFB208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeH1Ncn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:32:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1Ncm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:32:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so941545wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ExI13v1fJqqBjr18SDJMb+h91Mx/RUyY7N4pHJEIe+U=;
        b=aGS7c8/sWgPucAXuByklIY7H6PxlaOy5dXUXvzraR46pvE1SGdgY7map7lOePJqY8e
         H4YHI8zVpUPfcIWZgUNxnr9GOChT2mMujMCd9a6BxBHeUsIFJ3uvPFmKNcmQznXO5Dyd
         DT1lKtveROdAoyAlsA1Ctl7hE1hd1P4nmQ4CRJt8rPjHoSeR8Jly9bAUkPIwaF7E3J+f
         JiOm2xhpXseoEUY0P9qAksb1wzvLn2Gag/EzucnwLO3M/h4XWcWo+XDX4T8HDDOjjK7x
         QEILVxDygb9T925HKprjiFKpGLKps9rP2w4LXVtLTXeNuRYzsgdMDwzp85AaDkeBp5Ze
         pM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ExI13v1fJqqBjr18SDJMb+h91Mx/RUyY7N4pHJEIe+U=;
        b=sYfowR6N/RecIaqTZlB9A+tDryJwMtosZ0XUXyXxui1gk9DUHTDjeq9scmfmIf2FRB
         q56+3p4+Uvyxcq/JQG23KneIXxcP1WEMnkPUmKDO/SZRHoEbrRWmd1aObQiZkeeEoSyS
         qQswAbCgjXBAHyiE/FoBmUFbPScGjlyLaq8PwN1ZiVocCGkG+ylmp+WvTrvBgiS+CLWm
         cnlBRGxIMngFhMbse4NLcQoOc3ctol5Dq3jptj5hztQV0UYgMEQqjPuxhjGVtr9WME24
         VKWf27cEs9rL6NZYU9UQE0oVkpSDI6bHRgagjJc6w0mTBTIzegLRRlwrXtoj16yrXYDg
         3SKw==
X-Gm-Message-State: APzg51AjNiCizvA5lO6LHFsb9U94kbJ/lK2dVOiRX+MDo7Scm0vxvVRW
        FyCOT4HfJi2gwB40X7rj8aqsxQ==
X-Google-Smtp-Source: ANB0VdYa5AF38DRseFlTuOWHQN7gTWlFUJ1y07mwmkWFARomcv5Lg5daORMRcRAwRjs0rUdd744RVQ==
X-Received: by 2002:adf:9b9b:: with SMTP id d27-v6mr568289wrc.240.1535448844824;
        Tue, 28 Aug 2018 02:34:04 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l18-v6sm952276wru.75.2018.08.28.02.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:34:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/4] devres: provide and use devm_kstrdup_const()
Date:   Tue, 28 Aug 2018 11:33:28 +0200
Message-Id: <20180828093332.20674-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements devm_kstrdup_const() together with some
prerequisite changes and uses it in pmc-atom driver.

v1 -> v2:
- fixed the changelog in the patch implementing devm_kstrdup_const()
- fixed the kernel doc
- moved is_kernel_rodata() to asm-generic/sections.h
- fixed constness

Bartosz Golaszewski (4):
  devres: constify p in devm_kfree()
  mm: move is_kernel_rodata() to asm-generic/sections.h
  devres: provide devm_kstrdup_const()
  clk: pmc-atom: use devm_kstrdup_const()

 drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
 drivers/clk/x86/clk-pmc-atom.c | 19 ++++-----------
 include/asm-generic/sections.h | 14 +++++++++++
 include/linux/device.h         |  5 +++-
 mm/util.c                      |  7 ------
 5 files changed, 63 insertions(+), 25 deletions(-)

-- 
2.18.0

