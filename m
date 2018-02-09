Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeBIJ1r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:27:47 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37251 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeBIJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:27:41 -0500
X-Google-Smtp-Source: AH8x225VQiAMFr5cLNTaRKiu5kwLh6pUtBeUXl5m6qFyf8lgez8gaFmaTk0ezdz5cjObxOwINLo7jQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH V2 0/4] lightnvm: base 2.0 implementation
Date: Fri,  9 Feb 2018 10:27:15 +0100
Message-Id: <20180209092719.10679-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches for 2.0 support for the lightnvm subsystem. They
form the basis for integrating 2.0 support.

For the rest of the support, Javier has code that implements report
chunk and sets up the LBA format data structure. He also has a bunch
of patches that brings pblk up to speed.

The first two patches is preparation for the 2.0 work. The third patch
implements the 2.0 data structures, the geometry command, and exposes
the sysfs attributes that comes with the 2.0 specification. Note that
the attributes between 1.2 and 2.0 are different, and it is expected
that user-space shall use the version sysfs attribute to know which
attributes will be available.

The last patch implements support for using the nvme namespace logical
block and metadata fields and sync it with the internal lightnvm
identify structures.

Changes since v1:

 - pr_err fix from Randy.
 - Address type fix from Javier.
 - Also CC the nvme mailing list.

Matias Bjørling (4):
  lightnvm: make 1.2 data structures explicit
  lightnvm: flatten nvm_id_group into nvm_id
  lightnvm: add 2.0 geometry identification
  nvme: lightnvm: add late setup of block size and metadata

 drivers/lightnvm/core.c      |  33 ++-
 drivers/nvme/host/core.c     |   2 +
 drivers/nvme/host/lightnvm.c | 508 ++++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h     |   2 +
 include/linux/lightnvm.h     |  64 +++---
 5 files changed, 428 insertions(+), 181 deletions(-)

-- 
2.11.0
