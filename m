Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E81C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD992082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jKFj2j58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD992082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeK0KgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:36:24 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:36365
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbeK0KgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275633; bh=8TjNx2g1chY4n2IW/puLwgiMqt54Rjm+/U9l+waY/Xs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jKFj2j5896laizVIi+a61tK4n/eScgFDr4YyxsQ1YVI4RDnDpdlQf2JvnSbnbw7FVmkagobLZunD+SMjmmT/q8LrJEfJWGvWlghmJAk9goaiQ9LJFuEu2JYX3QjK9DnzSXiEAMWXX3NZ1XPlS3kJ6u2ywIgV8ttQe1+htNgxd0cOqh6IksIQwgLnG663+uMiPGRfDjV1BVhubxHRFb+O1bm3crRcU2Gnkq9nFRjNPzDnpEWbog5Txz5b2l9CePvTnGn7JqIoB/mKOgfiYQnNSz0tkhblQQvZS1gBJHexL1rLmXUHq/MTkYZjvbFhA6BBL7nDnRSZ2ZjskF78rU4bNg==
X-YMail-OSG: E2w_pKYVM1nkY5qjpCQpRT7.o1ezIWxHCAORLUpk4Z_RTxX.51etOARD4LxG2wM
 vnfYrLW5BOUdKDV_aY.T1TT537f1rXmRT6TtQVdivE2pWGnUQRJWXHEY2QdT3aGkOL.xD.fMlp.I
 NyLY82D.Ks6bd8prCHirMVhmfLfPfsNdkQEcKvFfxNgIggnYJmqC0LycJXYs7rhIOVRQHcakSWkG
 MB4eO5mrMhmf8AXl48_VsLrWhRt8_UQvJnRQ9lzDVPKnbyWdzdnQ545U9mt6nsszqMonJkmofMuS
 srf4XTYFSBgfTbpyvgFs9H5eqHZX3PTXYt3RszKnlabec07IJ.oPJqE0dEqev.5ZLCm1xK6Xbk2T
 0E.23OWs_7Z0wcxG4GkAZQids27_e_1CWta1PJhSltZ8FGs.jygZDS6jxdalvIDrOO3t0.9uzW3B
 26VF8l7ktjYkWKsFyA8oanRTORhi7qZagY82WSA2vrNAIb96sPSONRA0xiXjfSPurA2OhT9OwHMb
 CAvxpT1cxYAEjEmtibRgJQarn3BYwH8E78U3lP7EwNoRrYYYYvUn3_LfSUPNg2.yGvWfsB4mRhio
 ABSY9XjzeaKyhb89BPpFn8_Aq3uWyYNF91k6DFBf3n4hiZDI8LLBTTpnZif27mYV0wINhlmHyR65
 nw39BZtITd3KUiVADIa6sRxvL8QWC0zHVBwtO21wYGo9tEDy1iv_SjnBKmpEZLBSnA8B29FTNV4V
 .tPsEMq1Z4PyHoGpOI18rK0M9wxghT8yRGRxaP5P1X5xHAcQbgW7XR3lSw2DgNfJM.kLheuj7W78
 g8TfHT..w9BVlY0FRAG9IhWAWOwPOrJrZ1CkDk.5mX75diSqkpSmlHJ2CaGc7PlITjaqyyhTIUoz
 T7we5ZvTgiDRi1kJS53731lRSmBFAccL4u1n23fR_.KjgUN2W_4_trGaoDH2573YUDRs6jmsXxtR
 ewT5yQ79GLCR.8RbJgKAcYHyRt1TSH_DM77IQOGMfpACiIsizwkaEJrqM2mLIaWpnBkr8X1mrNMI
 ADn1QqfD0YZPtN7BqtdpnH07BGLHBV8RORdoa5ii80TMGI1AJ.7wvJRCZbFCOCaWPvamc_rCKHbk
 09zlykYP3qQZ942ZAKHfEVUfJ0bziVqPrgxcIdQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:40:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f29ed8b68840928352cac47bd91d1b1;
          Mon, 26 Nov 2018 23:40:32 +0000 (UTC)
Subject: [PATCH v5 18/38] LSM: Introduce enum lsm_order
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <630a8aa4-67b3-4b83-7feb-ca0cbd15b3ac@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:40:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for distinguishing the "capability" LSM from other LSMs, it
must be ordered first. This introduces LSM_ORDER_MUTABLE for the general
LSMs and LSM_ORDER_FIRST for capability. In the future LSM_ORDER_LAST
for could be added for anything that must run last (e.g. Landlock may
use this).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/security.c       | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6cfbd7d78a89..83858e3df9e5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2042,8 +2042,14 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+};
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
diff --git a/security/security.c b/security/security.c
index 0c3c66dbf51c..701507174f40 100644
--- a/security/security.c
+++ b/security/security.c
@@ -174,6 +174,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "first");
+	}
+
 	/* Process "security=", if given. */
 	if (chosen_major_lsm) {
 		struct lsm_info *major;
@@ -202,7 +208,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
-- 
2.14.5


