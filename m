Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7315DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1610F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oA6Pu4cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1610F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeGPSws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:52:48 -0400
Received: from sonic308-15.consmr.mail.gq1.yahoo.com ([98.137.68.39]:33415
        "EHLO sonic308-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728359AbeGPSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765451; bh=MoQJkYuFed509vjRUdFjjE1QBxKzlFFF1OeYh+kznCM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oA6Pu4cEEs/BrHrZqWU0AU31MfMIMHo/vLSo5iECrERRpsIHdIow+rCB2PvxXNQcoTK7gEcJODTAmZZAeztBlhnDwBwReWrQd0sevdAkcpbXmR8B5o89eucnRSIvt0oZCoqxqGBWRCCl5701nCC8cpQzjmBE3B7QGaWCBhsFM0ti9QahXj8A4HaNeuD9wg8YgB5wGdb+LmKb+mp0+8ZcJcSz/GFl3my20JrPijDwTk5iobT5s7vUnjtCfGfe3X0UB4wOfB8Ys4nMD4wgJTS1U8RUWKSVirf8pKw0QXPnMzWFjVHYAFc/N06QkDYo8yOrxc1qK+QgsjlXT39570v48g==
X-YMail-OSG: l6KYnpwVM1m8kklYhjBGSU6tLMvfM4IO7x_RuDaPGszGrQD7MpZC505u_16dDVr
 ysvgWrXQaHAHCM1tWEeaM5oZiEFohGsbRssIzWf8aryCnZGb5_h43GXA5S59eoafVMpUlJojj0QK
 Cws2wcOLTsEEsrvjP8O6MrzzRnbG8MEL4kM00NITmhuib83jP55ujECMqjxQi.fK.whClTyG_9IE
 WiMpAke.3.tGx2ZkDJnWBJNWSml7Y2m7qgdQAbb18w6x4yaC6S3q1gg9hYPASZfBQQ.dyHoIJ.Bu
 sHxft1VjBx.CFGtv1sRNoxmziRA6mSvFiFEehYC76RM.dj04ZJNtv4XWyTES0ykoM66BD52F8tx8
 xIA73n1.c._exQ.Ns3RGrTFAARgxEBMhFfU9qDHKoCB1xXsHIdlPDMzOb3dZaXhMz9C5luk50cNp
 2X7.eaSPg0hBfPVvGtPbeckbcWJeTz11x4Of_ervdRBje0dTyR9CgkAUftdWU8nU63Tlson0nSlL
 S4JQPLAXaVsNO.2MTfcfx1r5og3E_d.ajXTn5VNNgnKKOIujI8fAMfBPEjt7FxPwsXZsGq3dgrTy
 Ho8GZYEbZtZXydtAFCG5MZhnRfjGEwGLKThFuXzJVE.yHIY9QkXRYzNIBro6ZEHhQZiZdrUQ2h8u
 kY3ZFD8xq6vgSmy.3IdtIaO640m51ozWOeW6RBwCHsi9S6V0yRxSgE4PBU346..FcyZo4QbbPe_Y
 XaQRQgEGj7iCW9xe0mEA_u8x_kzaDUiNOPrHNi6E1G9fej5vcjmlMrANCYAkyYBHNH_YNeaUkbiw
 iT9CUM6yka7BkwaQKZ24.kpYmM1Mhkfa_v.txNTYEf673RVy.9oo6URtHXfeMcaNj.61JaOzapex
 jjy3Q7j3S98.WkPxBPc71EudDZlMVQSDWY.Xhwl6TNk3qzU6wUtu1uKup8b.dCSAgBNa0WHC6NV4
 894sQmpOxN2TOoctO7dGzCSDas9bpEstOnDsKWtZFgwuzY8bHTnN7WTG_aoMIB9Q6fGxNTfVgN1z
 z3DFrEakUJLOLN7tEa55dsIZntEaJZHQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:24:11 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 649367fcb4d1728d37eae30bfa4328e5;
          Mon, 16 Jul 2018 18:24:10 +0000 (UTC)
Subject: [PATCH v1 15/22] LSM: Mark security blob allocation failures as
 unlikely
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e22d6647-fa1c-6f7d-975d-2dadf38b8f6b@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:24:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM: Mark security blob allocation failures as unlikely

The allocation of security blobs is unlikely to fail.
Mark the checks thus for performance reasons.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index b95a151f7347..de5008d6715c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1245,7 +1245,7 @@ int security_file_alloc(struct file *file)
 {
 	int rc = lsm_file_alloc(file);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(file_alloc_security, 0, file);
 	if (unlikely(rc))
@@ -1368,7 +1368,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
 	if (unlikely(rc))
@@ -1388,7 +1388,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(cred, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
@@ -1409,7 +1409,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(new, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-- 
2.17.1


