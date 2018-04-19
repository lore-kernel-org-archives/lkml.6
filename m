Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeDSInN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:43:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35800 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeDSInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:43:00 -0400
X-Google-Smtp-Source: AIpwx497LhZQFzeif/fowDCe1PTrAvKlIFbd6IGMHucY6D5cBAjAgICF8NsuR3Qoac92Zh4RQP3bqw==
From: SeongJae Park <sj38.park@gmail.com>
To: paulmck@linux.vnet.ibm.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 2/2] atomic_ops.rst: Use `warning` rst directive
Date: Thu, 19 Apr 2018 17:42:45 +0900
Message-Id: <20180419084245.17096-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180419084245.17096-1-sj38.park@gmail.com>
References: <20180419084245.17096-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One warning message in 'atomic_ops.rst' is not using 'warning' rst
directive while others does.  This commit modifies the message to use
'warning' rst directive.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/core-api/atomic_ops.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 4ea4af71e68a..2e7165f86f55 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -466,10 +466,12 @@ Like the above, except that these routines return a boolean which
 indicates whether the changed bit was set _BEFORE_ the atomic bit
 operation.
 
-WARNING! It is incredibly important that the value be a boolean,
-ie. "0" or "1".  Do not try to be fancy and save a few instructions by
-declaring the above to return "long" and just returning something like
-"old_val & mask" because that will not work.
+
+.. warning::
+        It is incredibly important that the value be a boolean, ie. "0" or "1".
+        Do not try to be fancy and save a few instructions by declaring the
+        above to return "long" and just returning something like "old_val &
+        mask" because that will not work.
 
 For one thing, this return value gets truncated to int in many code
 paths using these interfaces, so on 64-bit if the bit is set in the
-- 
2.13.0
