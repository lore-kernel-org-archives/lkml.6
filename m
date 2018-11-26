Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95630C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F163208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LktRq5oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F163208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeK0Kub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:50:31 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:40505
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbeK0Kua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276478; bh=q3ZwNVKWIQFkGRgaOEndkUgGeJo8IZZCX1iJ8ynimVY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LktRq5oHeLoROVC93cWVRk/4AdXOQEGy7vMXD8pdJeqv8GuxzDPvGRGbraCwqoiHZFjkaBFRS85GIA9buy5vVXdIVJ/Z7Kev1JHS3rEGqLVch/HvKxSEqloXic8ppP8bf3Fmp6Kwgesuf6BStgrAn5rnJ4ZKWA9qSiBHrL9bIhbaF8brncmqIS3pwnuJ/FiTI+lgRbQ2FODngUaGOO6n37jNUseBneHgwF8m1Y8U5Nsh/AzFUbz25Lwaw6sQAy21EHcGfJomiSODg5fdvisTf48TtmCWAxgW8PnU5bPlGrxlp4tKjrqp5Yw2scVYDgazWsdhHMfdbYlSe+7Rqp/JTw==
X-YMail-OSG: 6jbfc.YVM1k59bAQ79GuJKFoPYDPbFypNl6k.1npMFvGbDEP0o4yfvKlfkyETgX
 8F8oo1QWJNEXXNbS2iLvlIRJwRHw3EN9SalWxv78X0nDbm41n.1D2XtA3UGDyk9eNW_xDAfcD8lu
 dtHRFZVHeOSsaSmuoJrGiat0RUk8swy_3yP3CpkNltDYdVwu31pOslGEDZQmnl9YwbXRuMtQyNqN
 bqHLsmKsRULAhD21hK22eFXs9tIImhDUywSjVQ_qIfR7GeD31aCliIwovzr4o59SrIsWye8fDLQf
 r0oDy2rZmdZo64T0aFKpxVQ5gyIRRWCErUaBZxL8qAEPqixJ6GqS_4dO2O0x585PZaUO3O_zo8RB
 d0_Cq_q7mydCFlPio5MlQDMRDFyzjetTjegVgwUx01yS6tt9e9s8BlqJwFCStQ.N.e6O42rKnw10
 1mzyMRZatLlhz2jkPlyUm5o2hiSKbFyaVE.vUC8pxb5_rWWhHnJ0s7auNlxIX6q3t1Sbb70DCV0b
 u0DbBhzmRS13DF8_51UEmRvHeoBdFRraiXAlKm73lP8y8QP7pLpnDt4.4XqjjESAuzB6yX7RPieT
 MB54y4krgYW8GtGuQ.ObIHa26GGGNpRmhlnEPdVElXhulA7w11MaiRMqS2ijol6.UzfRhFqhuZDj
 7UsVQNxPwP_m1xRQnz0PiFXYtltB.ZQGs8v3WRoTIn1_fCPzppM_lvk35e5DHGAUQ18HIscAPo8U
 jYXB9gEI4Xpb2oByBjTUGmcAQVZCBfe2TH36b7tUmvmLPKJH9kHNO7waqIaWOnQFs4oQdaOeU2wd
 vBJhdl.kNXWjPQG_pyrctDeJMfsjBy6shQEEyUiMwqqYnOeCPFG_tUNSE9Z_XTprX1A9IpnssImg
 PdqWXroigyXPJPHSCRw8hy05ok73Zra6yjL9DBoqZNxJycNjfEt.COGf6nVb7hCvUh.NQH6WyqUm
 3ztAFQzqFqCBb0cJBX_bJci7mBOivfyiEX58tgs2j4V70yIXdcrj3kSiEdxgv5oN5NFoevrU.S58
 pdZUhxsXWizUaUDs7xPJRJMG_PPbzAMHnO4vr6_ylwXTbIrJH1E_vJWANEr_WJ10brsyULD5NyPE
 2uQ2xMQpm1xWZtUXY_jD5qav98LsqwioKpe5uhw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:54:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9072484bf06eed14b19ec38255730e47;
          Mon, 26 Nov 2018 23:54:34 +0000 (UTC)
Subject: [PATCH v5 35/38] SELinux: Abstract use of ipc security blobs
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
Message-ID: <2b9fa6ed-c7b9-49a3-c4e2-957ef1d31243@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:54:31 -0800
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

Don't use the ipc->security pointer directly.
Don't use the msg_msg->security pointer directly.
Provide helper functions that provides the security blob pointers.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f0e7ac26f3a9..1e56b036018a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5889,7 +5889,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = selinux_ipc(ipc_perms);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -5946,7 +5946,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->security;
+	isec = selinux_ipc(msq);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5995,8 +5995,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -6043,8 +6043,8 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -6097,7 +6097,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->security;
+	isec = selinux_ipc(shp);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6194,7 +6194,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->security;
+	isec = selinux_ipc(sma);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6280,7 +6280,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	*secid = isec->sid;
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 562fad58c56b..539cacf4a572 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -26,6 +26,7 @@
 #include <linux/in.h>
 #include <linux/spinlock.h>
 #include <linux/lsm_hooks.h>
+#include <linux/msg.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -175,4 +176,16 @@ static inline struct inode_security_struct *selinux_inode(
 	return inode->i_security + selinux_blob_sizes.lbs_inode;
 }
 
+static inline struct msg_security_struct *selinux_msg_msg(
+						const struct msg_msg *msg_msg)
+{
+	return msg_msg->security;
+}
+
+static inline struct ipc_security_struct *selinux_ipc(
+						const struct kern_ipc_perm *ipc)
+{
+	return ipc->security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.14.5


