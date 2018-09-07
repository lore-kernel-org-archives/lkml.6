Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2A9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5392086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxQAaVs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5392086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeIGVi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:38:29 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43230 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:38:29 -0400
Received: by mail-vk1-f194.google.com with SMTP id s17-v6so1088254vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pc6TGdmNWywVoCHjitVgW2loC10NDVYwnlUtfPyXJ4s=;
        b=MxQAaVs616YPW7Z0E3cGNCDDkVpF9W6w8H8o+2iGAOLuVI3EN927DI5HHsWXP02rvm
         GHlobUeOrqw3c7R4IBSZ2iQufRk1pt9kaF7hktRFEBU/e3E+t3+i+jWqHwTmZZiuS7HA
         o+riD7KxlqNWi9Eadd2gRUzcGqGqMq2bF4x54Tf+rhlvExZnXxEOn4BndPnLB8byC6Xu
         1iyKyvPq42DXguecJLJreGCy/3NoIKghsfUTisKeXLNLzl5pmOOTqyUPvYNPym7JhgNg
         89gv9+lC7XTc5cwsX/Mu3frnd4NIfJ8Oe5X8KrYvcDj673pVE50qQ88bSfCzaC/TsLHW
         8hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pc6TGdmNWywVoCHjitVgW2loC10NDVYwnlUtfPyXJ4s=;
        b=Wx4eKumXGAzzQGQ4lU52hCsLL5gMwAs+O68xwR1GRcKhyve2yHDCwQFQS8JKtq62eL
         vVywVoSOIo6+QZpr17g0s0fQ47s2jm8BRyBFtn2tywupcRXMkcVs7xZE/BpeIC8WT4Xn
         cX6b2T3dAJwaLZyFlMLjvJ4s6no5CEzhRXdGVpj1qq7t2jjkmyZEl7aKWslqpJ+psbfG
         0eFivg0taf4VDiebw2ltPUkVVKbFQehfvGwCI6Sgpu46+CCThafw08B4cMbyrHGoJLOa
         evzGggB8DcGDe085D8YfW2LhFq42kIycNeYR/8sD4UDzyAPetVRXV57ecUxZwQBbWTjz
         ebTg==
X-Gm-Message-State: APzg51CJlizV1Zzn51fLGfXC02hhLh9XJCzUAg7gmIaeY/RIgJeMwiek
        Odb23W+7iSKQkiIzsGQAKWlB6O8=
X-Google-Smtp-Source: ANB0VdaXI50S1qeM7xKaYCBQWfSWJBJeAkUVCuTGMnrqyPdFXaGqzY8sxhKUy1ZyA3bi/BTc/2BtDQ==
X-Received: by 2002:a1f:1a12:: with SMTP id a18-v6mr2962511vka.61.1536339399653;
        Fri, 07 Sep 2018 09:56:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id q202-v6sm1039619vke.53.2018.09.07.09.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:56:38 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/6] flex_arrays -> genradix; prep work for bcachefs
Date:   Fri,  7 Sep 2018 12:56:29 -0400
Message-Id: <20180907165635.8469-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic radix trees are a dead simple radix tree implementation that can store
types of different sizes, needed for bcachefs.

The patch series was sent out previously and was pretty uncontroversial - this
is a respin that converts most users to just use kvmalloc.

Kent Overstreet (6):
  openvswitch: convert to kvmalloc
  md: convert to kvmalloc
  selinux: convert to kvmalloc
  Generic radix trees
  proc: commit to genradix
  Drop flex_arrays

 Documentation/core-api/flexible-arrays.rst | 130 -------
 Documentation/flexible-arrays.txt          | 123 -------
 drivers/md/raid5-ppl.c                     |   7 +-
 drivers/md/raid5.c                         |  82 ++---
 drivers/md/raid5.h                         |   9 +-
 fs/proc/base.c                             |  43 +--
 include/linux/flex_array.h                 | 149 --------
 include/linux/generic-radix-tree.h         | 222 ++++++++++++
 include/linux/poison.h                     |   3 -
 lib/Makefile                               |   5 +-
 lib/flex_array.c                           | 398 ---------------------
 lib/generic-radix-tree.c                   | 180 ++++++++++
 net/openvswitch/flow.h                     |   1 -
 net/openvswitch/flow_netlink.h             |   1 -
 net/openvswitch/flow_table.c               |  51 +--
 net/openvswitch/flow_table.h               |   3 +-
 security/selinux/ss/avtab.c                |  40 +--
 security/selinux/ss/avtab.h                |   4 +-
 security/selinux/ss/conditional.c          |   6 +-
 security/selinux/ss/policydb.c             | 122 ++-----
 security/selinux/ss/policydb.h             |  12 +-
 security/selinux/ss/services.c             |  22 +-
 tools/include/linux/poison.h               |   3 -
 23 files changed, 540 insertions(+), 1076 deletions(-)
 delete mode 100644 Documentation/core-api/flexible-arrays.rst
 delete mode 100644 Documentation/flexible-arrays.txt
 delete mode 100644 include/linux/flex_array.h
 create mode 100644 include/linux/generic-radix-tree.h
 delete mode 100644 lib/flex_array.c
 create mode 100644 lib/generic-radix-tree.c

-- 
2.19.0.rc2

