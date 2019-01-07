Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C375FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850F42085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQNEu0mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfAGIZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:25:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33930 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfAGIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:25:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so20432716pga.1;
        Mon, 07 Jan 2019 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+dzdIS2lLNlfx5pYH4BHiQ9CpbloelWYGZhqrZ3Bn3U=;
        b=uQNEu0mjCZDf383GEADhrf3cKPk4EnvChTPb605zJ9mNj/ZmbmdOaWpgSLSTC8UyV0
         L8wcEsxJE1o754C3iF73oFIsC0S1mooWx5rDb4spFxyi728cIK2vAGO07crciWV8MdOX
         R1UJLeBinnTSDXAhshbWQmMDdbNv3RfUUpbzZI2+OKhgPg/lApte80NW6w2ZGw1zLaEF
         q1/gpsaZmxgl/0RPp3hy8bVV10a4k3/5zv9W60lBwmCG0+FmvC1MfyesJ5E3WCIw/rC8
         IsR4msDB9vQ/w4eNEOHMNRQwDEdwjQXl9zND+lxWKq8MYWPYQ5RDeCgR5sOztlh/5Tc9
         QpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+dzdIS2lLNlfx5pYH4BHiQ9CpbloelWYGZhqrZ3Bn3U=;
        b=rC+rxlSxhIULO8Bf5GH0c/UZCxDteRsW+WrC75LwVCTxl8IBKvI2R0LOmv+Xmo9BUe
         zdThgnSmLWEl+Dq6YNGx12puMac68qXx0vdKcZOiH7r2JrM4UXolkyhPoSplTzZ0hBGV
         nBOu8pSD7JHrhKp3cfoAfK+Fub0x2SsO1CnenWq1cJZ+Omx7L5cIhooFZAHZCHw6Zcdl
         1EqWIQisWWsBvk6/z6LtNBbsmNrpQPaq0Cw6NrL13oS4A9zcqbeSstN7iWomn+wepO59
         AGYfOlTNwoqIpqaaH4uvzxijPxR3ZTVTrecOYk8mLRCBrQ+G/0QeLUDv7WlWVive80Wd
         aLWA==
X-Gm-Message-State: AJcUukcU3D05YvTzInvLKwVa+/zsgPUgUejjnuzENdV1sh17Daj2Ojcl
        oxxlLYMWmtvcP+NYfRZJyzxeQT1mnQ==
X-Google-Smtp-Source: ALg8bN55EPObgAtz3bUGR21XEG6MSsdZEwW6b8JyGuEvARvgzdVx6GMYMcN26WtYKODiiNXLprWJ9Q==
X-Received: by 2002:a63:151f:: with SMTP id v31mr28652279pgl.34.1546849498564;
        Mon, 07 Jan 2019 00:24:58 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm76981674pgv.31.2019.01.07.00.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:24:58 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-acpi@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by pushing forward the parsing of mem hotplug info 
Date:   Mon,  7 Jan 2019 16:24:41 +0800
Message-Id: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background about the defect of the current bottom-up allocation style, take
the following scenario:
  |  unmovable node |     movable node                           |
     | kaslr-kernel |subtree of pgtable for phy<->virt |

Although kaslr-kernel can avoid to stain the movable node. But the
pgtable can still stain the movable node. That is a probability problem,
with low probability, but still exist. This patch tries to eliminate the
probability. With the previous patch, at the point of init_mem_mapping(),
memblock allocator can work with the knowledge of acpi memory hotmovable
info, and avoid to stain the movable node. As a result,
memory_map_bottom_up() is not needed any more.


Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org

Pingfan Liu (4):
  acpi: change the topo of acpi_table_upgrade()
  x86/setup: parse acpi to get hotplug info before init_mem_mapping()
  x86/mm: set allowed range for memblock allocator
  x86/mm: remove bottom-up allocation style for x86_64

 arch/arm64/kernel/setup.c |   2 +-
 arch/x86/kernel/setup.c   |  17 ++++-
 arch/x86/mm/init.c        | 154 +++++++---------------------------------------
 arch/x86/mm/init_32.c     | 123 ++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mm_internal.h |   7 +++
 drivers/acpi/tables.c     |   4 +-
 include/linux/acpi.h      |   5 +-
 7 files changed, 172 insertions(+), 140 deletions(-)

-- 
2.7.4

