Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970464AbeCSShn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:37:43 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:33478 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S970421AbeCSShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:37:35 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Quarantine-ID: <4EzassA7Buht>
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3db:1800:60b5:55d8:d757:229
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/11] block: sed-opal: use correct macro for method length
Date: Mon, 19 Mar 2018 19:36:43 +0100
Message-Id: <0c681a486d73d71dde21b573dbe802d1267a8514.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also the values of OPAL_UID_LENGTH and OPAL_METHOD_LENGTH are the same,
it is weird to use OPAL_UID_LENGTH for the definition of the methods.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 945f4b8610e0..5aa41744b8f1 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -181,7 +181,7 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
  * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
  * Section: 6.3 Assigned UIDs
  */
-static const u8 opalmethod[][OPAL_UID_LENGTH] = {
+static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
 	[OPAL_PROPERTIES] =
 		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01 },
 	[OPAL_STARTSESSION] =
-- 
2.16.1
