Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCMNLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:11:23 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:38803 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752181AbeCMNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:09:49 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Quarantine-ID: <yqYOoIjZ4wbn>
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3c2:e00:dbd1:5c46:f440:b630
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] block: sed-opal: print failed function address
Date: Tue, 13 Mar 2018 14:08:58 +0100
Message-Id: <55b2d57015c4088fcc3685045415cba02f9aa931.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add function address (and if available its symbol) to the message if a
step function fails.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5a448a3ba1df..f7925e6f607c 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -394,8 +394,8 @@ static int next(struct opal_dev *dev)
 
 		error = step->fn(dev, step->data);
 		if (error) {
-			pr_debug("Error on step function: %d with error %d: %s\n",
-				 state, error,
+			pr_info("Error on step function %pS: %d with error %d: %s\n",
+				 step->fn, state, error,
 				 opal_error_to_human(error));
 
 			/* For each OPAL command we do a discovery0 then we
-- 
2.16.1
