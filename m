Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F9CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C7320865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOVwl1L+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C7320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeJMMaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36370 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeJMMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so6757215pgv.3;
        Fri, 12 Oct 2018 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c+T5WeyUd4YTdCOVh2FHvd2NJyZ8yxwwZN2BSmF6eIw=;
        b=jOVwl1L+HlLHzaOlhJd8EqxIpsMdEIesOmN9vmuILr/qcNGDbAin4zrxyN9GbIBJyA
         IuJ3IYmbBPo4NhwX3NZYQrajYxVAMARvb0zE+2rrq1UK8dDBPgcnIXGa026HuCAH1XgO
         OshrpRdezShbBhERAUBlU8+bM3F7i81P7X4m0xBm3QnooeZIG86xdP6wpexpGSpTXHDR
         JwBzPVtQS1LDP6s60WvS9LEL3HlRfXpCaqDiFDbs9iPxtEIxRohb/bgNhFch4h1aT3IF
         515QxBPmnNgp7tlPRWrUJ1p/+nNWKVlxVjX2EEgxFq0bIkyBAygnXCg392lk/JLZbWMq
         QrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c+T5WeyUd4YTdCOVh2FHvd2NJyZ8yxwwZN2BSmF6eIw=;
        b=IruO/QV+/nKDtDcO6dmAnVRE1Ly3GwFq4dIvKqTmgDxsK82AhPRgmf2Ph2niLY8NTj
         tNi3KHWWAkzTq5SjgfxrR04Ekdf6Vqsok+Re1/U28GmGF9rGCEPpAM4C05B0qAJYehSj
         FKn+tLgz+P7g7zr9sM35aOkr/j+9Mmg4wHz0JAimAwzoHmKf9y/kYw7xWnUjlW4Dy7ao
         2uGSydoDHft+pfclZ53ZgqUMv7QxDIuqlhq1ZTfHqUQdxzdKG8brS/sIa5Fh4q1s0EJ2
         53mzW9ClCOxQ1qzwH5upvcM6GLdnEpjwxdF37aTRMGzHSMezR5Tpz2h1LZzSK5PVEU2M
         ZdPQ==
X-Gm-Message-State: ABuFfogJd4hhTz8tRe5eJOQgt7NKBKcJjklPx7zvSORwxhduTAxjyqr9
        59YDK118fDJmOAbtf1olNnJoudvx
X-Google-Smtp-Source: ACcGV63JSpKjokCTQ+cFSRF0UHh244sEb/YZE7KiG3NOgBi+ZixBy6mxYQztL50mEcsPJNIUdtEFEw==
X-Received: by 2002:a62:3047:: with SMTP id w68-v6mr8886318pfw.19.1539406504497;
        Fri, 12 Oct 2018 21:55:04 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:03 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 00/18] of: overlay: validation checks, subsequent fixes
Date:   Fri, 12 Oct 2018 21:53:20 -0700
Message-Id: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Add checks to (1) overlay apply process and (2) memory freeing
triggered by overlay release.  The checks are intended to detect
possible memory leaks and invalid overlays.

The checks revealed bugs in existing code.  Fixed the bugs.

While fixing bugs, noted other issues, which are fixed in
separate patches.

*****  Powerpc folks: I was not able to test the patches that
*****  directly impact Powerpc systems that use dynamic
*****  devicetree.  Please review that code carefully and
*****  test.  The specific patches are: 03/16, 04/16, 07/16

FPGA folks:

  I made the validation checks that should result in an
  invalid live devicetree report "ERROR" and cause the overlay apply
  to fail.

  I made the memory leak validation tests report "WARNING" and allow
  the overlay apply to complete successfully.  Please let me know
  if you encounter the warnings.  There are at least two paths
  forward to deal with the cases that trigger the warning: (1) change
  the warning to an error and fail the overlay apply, or (2) find a
  way to detect the potential memory leaks and free the memory
  appropriately.

ALL people:

  The validations do _not_ address another major concern I have with
  releasing overlays, which is use after free errors.

Changes since v1:

  - move patch 16/16 to 17/18
  - move patch 15/16 to 18/18
  - new patch 15/18
  - new patch 16/18

  - 05/18: add_changeset_node() header comment: incorrect comment for @target

  - 18/18: add same fix for of_parse_phandle_with_args()
  - 18/18: add same fix for of_parse_phandle_with_args_map()

Frank Rowand (18):
  of: overlay: add tests to validate kfrees from overlay removal
  of: overlay: add missing of_node_put() after add new node to changeset
  of: overlay: add missing of_node_get() in __of_attach_node_sysfs
  powerpc/pseries: add of_node_put() in dlpar_detach_node()
  of: overlay: use prop add changeset entry for property in new nodes
  of: overlay: do not duplicate properties from overlay for new nodes
  of: dynamic: change type of of_{at,de}tach_node() to void
  of: overlay: reorder fields in struct fragment
  of: overlay: validate overlay properties #address-cells and
    #size-cells
  of: overlay: make all pr_debug() and pr_err() messages unique
  of: overlay: test case of two fragments adding same node
  of: overlay: check prevents multiple fragments add or delete same node
  of: overlay: check prevents multiple fragments touching same property
  of: unittest: remove unused of_unittest_apply_overlay() argument
  of: overlay: set node fields from properties when add new overlay node
  of: unittest: allow base devicetree to have symbol metadata
  of: unittest: find overlays[] entry by name instead of index
  of: unittest: initialize args before calling of_*parse_*()

 arch/powerpc/platforms/pseries/dlpar.c             |  15 +-
 arch/powerpc/platforms/pseries/reconfig.c          |   6 +-
 drivers/of/dynamic.c                               |  68 +++--
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/overlay.c                               | 298 ++++++++++++++++-----
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |  96 +++++--
 include/linux/of.h                                 |  19 +-
 11 files changed, 439 insertions(+), 122 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

-- 
Frank Rowand <frank.rowand@sony.com>

