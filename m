Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeFERHr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbeFERHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:07:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 53/61] hwtracing: stm: fix build error on some arches
Date: Tue,  5 Jun 2018 19:02:14 +0200
Message-Id: <20180605170121.047178541@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 806e30873f0e74d9d41b0ef761bd4d3e55c7d510 upstream.

Commit b5e2ced9bf81 ("stm class: Use vmalloc for the master map") caused
a build error on some arches as vmalloc.h was not explicitly included.

Fix that by adding it to the list of includes.

Fixes: b5e2ced9bf81 ("stm class: Use vmalloc for the master map")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -27,6 +27,7 @@
 #include <linux/stm.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/vmalloc.h>
 #include "stm.h"
 
 #include <uapi/linux/stm.h>
