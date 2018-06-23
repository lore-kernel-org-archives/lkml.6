Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8476CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4814124BB1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4814124BB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeFWMMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:12:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44159 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeFWMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:12:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCCTHd463908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:12:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCCTYk463905;
        Sat, 23 Jun 2018 05:12:29 -0700
Date:   Sat, 23 Jun 2018 05:12:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-9af4c0a6dc1a1abf5336f2c3f951444db6b71da9@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, reinette.chatre@intel.com
Reply-To: reinette.chatre@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <5e29cf0209ea2deac9beacd35cbe5239a50959fb.1529706536.git.reinette.chatre@intel.com>
References: <5e29cf0209ea2deac9beacd35cbe5239a50959fb.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Making CBM name and type more
 explicit
Git-Commit-ID: 9af4c0a6dc1a1abf5336f2c3f951444db6b71da9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9af4c0a6dc1a1abf5336f2c3f951444db6b71da9
Gitweb:     https://git.kernel.org/tip/9af4c0a6dc1a1abf5336f2c3f951444db6b71da9
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:02 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:43 +0200

x86/intel_rdt: Making CBM name and type more explicit

cbm_validate() receives a pointer to the variable that will be initialized
with a validated capacity bitmask. The pointer points to a variable of type
unsigned long that is immediately assigned to a variable of type u32 by the
caller on return from cbm_validate().

Let cbm_validate() initialize a variable of type u32 directly.

At this time also change tha variable name "data" within parse_cbm() to a
name more reflective of the content: "cbm_val". This frees up the generic
"data" to be used later when it is indeed used for a collection of input.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/5e29cf0209ea2deac9beacd35cbe5239a50959fb.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 2c23bb136ccc..b3da5b981dd8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -87,7 +87,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len = r->cache.cbm_len;
@@ -128,16 +128,17 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
  */
 int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 {
-	unsigned long data;
+	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
-	if(!cbm_validate(buf, &data, r))
+	if (!cbm_validate(buf, &cbm_val, r))
 		return -EINVAL;
-	d->new_ctrl = data;
+
+	d->new_ctrl = cbm_val;
 	d->have_new_ctrl = true;
 
 	return 0;
