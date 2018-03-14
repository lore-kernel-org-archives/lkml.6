Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeCNGQP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:16:15 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:33964 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751272AbeCNGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:16:14 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Quarantine-ID: <I8prlsk701eE>
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3e7:2500:bfbd:dba3:49d6:7204
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8.0/8.4] block: sed-opal: check size of shadow mbr
Date: Wed, 14 Mar 2018 07:15:41 +0100
Message-Id: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
References: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I managed to extract the usable shadow mbr size out of my 850Evos
OPAL_TABLE_TABLE and added an appropriate check into the write function.
As this involves more than just a few lines, I decided to split the v2
of this subpatch into 4 separate patches. I am unsure what whould be the
best practice for such an situation but hope it is okay like this.

Also the userspace exported pointer is replaced with an u64 value.

Jonas Rabenstein (4):
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: unify retrieval of table columns
  block: sed-opal: get metadata about opal-sed tables
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  18 ++++
 block/sed-opal.c              | 245 ++++++++++++++++++++++++++++--------------
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |   8 ++
 4 files changed, 189 insertions(+), 83 deletions(-)

-- 
2.16.1
