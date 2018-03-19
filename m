Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970418AbeCSSha (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:37:30 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:51163 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967496AbeCSShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:37:25 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3db:1800:60b5:55d8:d757:229
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/11] block: sed-opal support write to shadow mbr
Date: Mon, 19 Mar 2018 19:36:42 +0100
Message-Id: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was advised to resend the patchset as a v2 where all the patches are
in a flat hierarchy. So here is a complete set which hopefully pleases
all requirements.
As the previous fixes have by now all landed into linux-next, no
additional patches are required for testing.

Thanks,
 Jonas

--

Jonas Rabenstein (11):
  block: sed-opal: use correct macro for method length
  block: sed-opal: unify space check in add_token_*
  block: sed-opal: unify cmd start and finalize
  block: sed-opal: unify error handling of responses
  block: sed-opal: print failed function address
  block: sed-opal: split generation of bytestring header and content
  block: sed-opal: add ioctl for done-mark of shadow mbr
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: unify retrieval of table columns
  block: sed-opal: get metadata about opal-sed tables
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  18 ++
 block/sed-opal.c              | 619 +++++++++++++++++++++---------------------
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |   9 +
 4 files changed, 339 insertions(+), 309 deletions(-)

-- 
2.16.1
