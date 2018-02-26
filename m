Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeBZM4G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:56:06 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:42899 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeBZM4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:56:03 -0500
X-Google-Smtp-Source: AG47ELsvboIafYK08YQZErZs+e2kEJiYByOirW9qyX+7s/VuLYhYqp67cOxSpj28SZ4raI+hhH/bag==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: hch@lst.de, keith.busch@intel.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        jthumshirn@suse.de,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH v2 0/1] nvme: extend log page implementation
Date: Mon, 26 Feb 2018 13:55:39 +0100
Message-Id: <20180226125540.9513-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces support for get log page offset and extends
the number of dwords to be 32 bits.

Changes from v1:

 - Suggestion from Johannes that paratheses around (size / 4) - 1 can
   be removed.
 - Make nvme_get_log_ext() static. Expose when the function is used by
   lightnvm.
 - Make sure to use unsigned long long when shifting a u64 with a
   constant.

Matias Bjørling (1):
  nvme: implement log page low/high offset and dwords

 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
2.11.0
