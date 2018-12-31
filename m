Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7062133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcep8Zvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLaN05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:26:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36958 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeLaN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:26:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so18294854lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BO3tSa3J330Tpbmn9DhDXphuySXauc5hmt/7nSk40Qk=;
        b=Zcep8Zvz6K5ejGdqAAWFPNMqGIdfNmTU9r8W3nxlG4mJgeW9iAvX5wWv+iaKl6hbdQ
         TFBZ7dErCzlCQx6JePtXJyJyWB3Rih40vs3cX6Y1soTyCXjB5Syd+LaTpLy281DzZQqB
         ElL0aWLQb1bWmasM+TuOTh7uHGELeZ9mWoBqOWMMkSzOY+woWCZlheOT/z9OT//TA/md
         UuebmgKFyq4pjUCN5TL+9wS3tV4uDPavAg/i6M0GsdSP5YfIZIJAV0FrP+XxZIG3Ti/1
         W7XOQZOOSkaLYhFJgPuQgJmn9qSjxl6X9RasXPj1xov6aQSZpzTvbWa9AWYnxKXYoEL8
         0ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BO3tSa3J330Tpbmn9DhDXphuySXauc5hmt/7nSk40Qk=;
        b=Tj8AsXKQWbn35gf5x8mXklLcGDWczbxCJOAEayHMDf4gtNiHzENL74xpXskkvCPnBN
         suJ8lVsqMf4nuGOAD1Dnup5HgKxCLkfA9VOdH1jC7yH/RFgzYyAyXtbMJSpYQ4uNCvvx
         FQ73rfvYzHcxYRSf74ziJsUzeXyXWB5exMTXZ+L3sb5zWAwPpENMHXuKa3/e0FJrTwk6
         VVZLfwz/xbBg73Dvw7J0vB3Z8J35V4+Z+55s6otBfnEYayMDtMBgeRY4vCdB0Dx7rf1r
         g8nff1PHE3LaXJtgQCuMZpvExEY3Mmt3wB0aOQFElvwFz8T8ytEjMOtxnn/7U4ueAKlD
         MYwA==
X-Gm-Message-State: AA+aEWZsky120hlcFoxN6jizMO+T8k1OiKHv0CA6V9alcBX8+7CjBJK5
        DbnPBTug9avmaX4jJbxTnH0=
X-Google-Smtp-Source: AFSGD/VajcG7kguxeOGMnbGgctvhAGIngGT+CE5s5EnN/rDVpL2h5R/z46j3nX+qx8IKtOYAADdiZA==
X-Received: by 2002:a19:6806:: with SMTP id d6mr18031413lfc.48.1546262813515;
        Mon, 31 Dec 2018 05:26:53 -0800 (PST)
Received: from localhost.localdomain (mm-142-13-214-37.mogilev.dynamic.pppoe.byfly.by. [37.214.13.142])
        by smtp.gmail.com with ESMTPSA id y23-v6sm10162231ljk.95.2018.12.31.05.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 05:26:52 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v2 0/3] test driver to analyse vmalloc allocator
Date:   Mon, 31 Dec 2018 14:26:37 +0100
Message-Id: <20181231132640.21898-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The first RFC was here: https://lkml.org/lkml/2018/11/13/957
Please have a look there for detailed description and discussion.
Here i will just specify what has been done since last RFC:

Changes in v2:
    - Code cleanup to make it more simple;
    - Now __vmalloc_node_range() is exported if CONFIG_TEST_VMALLOC_MODULE=m
    - Integrate vmalloc test suite into tools/testing/selftests/vm

I hope this test suite is more or less ready to go with. Appreciate your
comments and feedback anyway, so please RFC v2.

Thanks.

Uladzislau Rezks (Sony) (3):
  vmalloc: export __vmalloc_node_range for CONFIG_TEST_VMALLOC_MODULE
  vmalloc: add test driver to analyse vmalloc allocator
  selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE

 lib/Kconfig.debug                          |  12 +
 lib/Makefile                               |   1 +
 lib/test_vmalloc.c                         | 543 +++++++++++++++++++++++++++++
 mm/vmalloc.c                               |   9 +
 tools/testing/selftests/vm/run_vmtests     |  11 +
 tools/testing/selftests/vm/test_vmalloc.sh | 173 +++++++++
 6 files changed, 749 insertions(+)
 create mode 100644 lib/test_vmalloc.c
 create mode 100755 tools/testing/selftests/vm/test_vmalloc.sh

-- 
2.11.0

