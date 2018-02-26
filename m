Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBZWCO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:14 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44731 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeBZWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:09 -0500
X-Google-Smtp-Source: AH8x224dNbs0KcHfqB8f9M0NogP0mutO2L/sLMrxEJlkbsAPaQXwiljnNqKyomN0yIoTUTzrqc1xuA==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH v2 0/2] of: remove kbasename() from core
Date: Mon, 26 Feb 2018 14:01:21 -0800
Message-Id: <1519682483-19828-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

(One line description of patch 0/2 is now misleading, but leaving
intact to make it easier to find v1.  One line description of other
patches updated as they will be part of the git commit record.)

Struct device_node full_name no longer includes the full path
name.

Fix some broken overlay code that was not updated to reflect this.

Clean up the unittest changeset test that calls into this
overlay code.

Version 1 of this patch removed kbasename() for other parts of
core devicetree code.  But Geert kindly pointed out that a
devicetree created from Open Firmware (instead from an FDT)
could still contain a full path in the struct device_node
full_path field.  This version (v2) of the patch leaves
kbasename() in place where needed.

Changes since v1:
  - update patch 2/2 one-line description and full description
  - no longer remove kbasename from resolver.c
  - add_changeset_node(): add back kbasename() when comparing nodes
    in the livetree against nodes in the overlay
  - add_changeset_node(): add header comments to document assumptions
    and behavior, and to explain why kbasename() is used
  
Frank Rowand (2):
  of: unittest: clean up changeset test
  of: overlay: do not include path in full_name of added nodes

 drivers/of/dynamic.c    | 21 ++++++++++-----------
 drivers/of/of_private.h |  3 ++-
 drivers/of/overlay.c    | 18 +++++++++++++++---
 drivers/of/unittest.c   | 48 +++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 66 insertions(+), 24 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>
