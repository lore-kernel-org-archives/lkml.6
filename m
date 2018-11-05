Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA155C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3402081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPwnSO6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3402081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeKFArG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34258 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeKFArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1-v6so4388200pgq.1;
        Mon, 05 Nov 2018 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ohI4tMiL0is4e2DRvrk1E24XyRqu88FeHCyzFLIfPNM=;
        b=ZPwnSO6BxBga0ylOhcVw11sJDKal76OLqKfiXMDpIk4ZcNRybk0fxwl/Z/7Dyh65bX
         7ypLhpVPmHQ1FVPiF/EIdzzuNb4AD7KgsSzpIFJy9kNYEMDpnbiahmc72/z2ISUyKXqS
         Txy57rdSVeyWvv5M7uYyGyef+UZ5550661/V6ccTEGAPt+rmHXaB2cRNOopuF8xPY9Ac
         vZn1lmJ+NMgfwUbtvKxyMAVTc7LCiy5J0oQEbpPVVr9hnpSMGTPnN7bOtnSa38L6/ig0
         utaU2LELFhOO1srnfjvxACQGAM5AijPt60Wg7rEdcQEqNByuYU4ieTmZ1XLiqxhWTDgR
         WjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ohI4tMiL0is4e2DRvrk1E24XyRqu88FeHCyzFLIfPNM=;
        b=ahxdfikavrgQ8Hi7aJRMdIKATwK02R9J4N1OG5Ee8ZdaqZlshqnCC3HE1d4W+JDrQ3
         OMvcRxasOoftDzfgprKeISca/DgwjTO1sr+94FUCm02g7pMd96CRK+GEoeJd2pU1OGhL
         Bgh0K28fgwi3IY6IgBuezjzfULvLlcFZT2AQ40Xthg3VS3s0pH56KigXIFwZ6ZEfiL8k
         xUPc9Yn5LD8ZrUzDDUpx/sW8Y6XESVXm2C5DsUOR7FXHTmC2H5PNj/wk86W6xjMFToYY
         V+Y0B7iQFsODPnEtojX/go1P9eM6mM2HBBwIGbqBggHwmRifkIG0teiihSjxU8kripge
         h3fA==
X-Gm-Message-State: AGRZ1gKYHpWfGCAE/9f9SnGvsMwvEw9g2GGfEgD02OEL2hl7Sv+rXsiM
        hAaEZ4DSDPnoTUTcAYpRX1g=
X-Google-Smtp-Source: AJdET5eN93h0MjaNiJ0RrFcpEOZeBf3zq+hj/cCsaUpEUHioZnVfEbcreonE4KsGGippuXb+EJQsLg==
X-Received: by 2002:a65:4646:: with SMTP id k6mr20211614pgr.153.1541431612269;
        Mon, 05 Nov 2018 07:26:52 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:26:51 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
Date:   Mon,  5 Nov 2018 07:24:57 -0800
Message-Id: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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

Changes since v5:
  - move from 4.19-rc1 to 4.20-rc1
  - all patches: add tested-by Alan Tull
  - 05/18: update for context change from commit a613b26a50136 ("of:
    Convert to using %pOFn instead of device_node.name")

Changes since v4:
  - 01/18: make error message format consistent, error first, path last
  - 09/18: create of_prop_val_eq() and change open code to use it
  - 09/18: remove extra blank lines

Changes since v3:
  - 01/18: Add expected value of refcount for destroy cset entry error.  Also
    explain the cause of the error.

  - 09/18: for errors of an overlay changing the value of #size-cells or
    #address-cells, return -EINVAL so that overlay apply will fail
  - 09/18: for errors of an overlay changing the value of #size-cells or
    #address-cells, make the message more direct.
    Old message:
      OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
    New message:
      OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed

  - 13/18: Update patch comment header to state that this patch modifies the
    previous patch to not return immediately on fragment error and
    explain this is not a performance issue.
  - 13/18: remove redundant "overlay" from two error messages.  "OF: overlay:"
    is already present in pr_fmt()

Changes since v2:

  - 13/18: Use continue to reduce indentation in find_dup_cset_node_entry()
    and find_dup_cset_prop()

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
 drivers/of/overlay.c                               | 292 ++++++++++++++++-----
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |  96 +++++--
 include/linux/of.h                                 |  25 +-
 11 files changed, 439 insertions(+), 122 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

-- 
Frank Rowand <frank.rowand@sony.com>

