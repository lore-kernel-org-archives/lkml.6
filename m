Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C804ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AEF2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FATU+veu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AEF2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392217AbeIVGLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:11:13 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:34571 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391758AbeIVGLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575594; bh=i/FeXI6VaSffmX1y1gpuicpe9EtDrQAWHmEzOnUriC0=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=FATU+veusBAp8RqgiYFYB8uBdP/nTVGcHrDWb3KefwqQsHUnRf9W3GDiJ5QIkYTl4CIaUuOsu5+nuZWaW5pShWncSLDJrlME48sXRDpiDee1fR7vYE+/FnvL11UEpza/6zQ4O3H4r5Peo92RX8pBX3glh2LUegLLevzmdWZVeue1dCs7Ciby1Y0rEsQvWlaO1WIua1IMifJ7jP5xuAdB+W8hixwBM9YUcHpKNafgnA5s/Lt3gS63yJAHHEYnvmVEJkPzctN/XDY940IQlLlLxcDzLPWXgAQu7zvGnSXn3QIDFk1FglV2yzmeFFZeSirNkLs/untperhR4/GECDP2bw==
X-YMail-OSG: XuaOVtEVM1mikCscWceS8.HCm.CdAuEC6YfliI6G_vFCTRqznqbIa6p8F0rskD7
 uZvg1h9_7b8ihb6tZHQZY979Su_pKSuzDFR1hvr6ZEWCJG1j_C02Rgc8e_thtwgp_QDWbImMAgOe
 G3xevsva0JwZKTo3151ZcNtHAXzKY8JbbRdiPYMlEDU_J8cEgM5Ssu_IF6OGLVLEM5H4cTZtMl2R
 OsnOYOj6RjsV4qZ9e9RhSD6vnWvxDb71S8Uz_sGuJ.DDldaM4SHvz2GMcVLJzFc.PoPaB.E.7W3A
 0kOC_ND9kI9CO.vZKBLojJLD.Ft2u5iEqvh0U8U5SbzZ4R7xobeMxn8PM1pKeBYw68dfeMSd7WR4
 gPlu2XvaMeM64k2W_gtTq8qqnbCOLWgN7df2PsLL7H8HzVs315KB7ZAyoE.FC09GGP64s333M3fK
 TVsDdrBxl66JEHrWwEX88oL7rdfEUrisC75ZT2H.c8d_RgGvD2YzR1Gi.JUAXb7xBf0HvMxl2dz9
 PykWeApB33u2ggXRc5XpTw2fBTQD8ZfRxFdp9zyc_U1rF37lWWYh1Rqb34LWN2msUAJLq1PtbPHZ
 J4nJuEr4ApvAiauVhi4tMcKRGhEnjo7FwIjCiMVCcLYO5i00g0Vnp..WlNEqlgl8A1Jdd3Eoza_h
 SAxReyWoE.f3jO8i0dUjqJaP62YmoyAJ7dMmUoLunvWb2BaYbIcqdp394bdlSxYNUAglQrJzBYrr
 DS4O6r6zEnAWYOoYaKAgtWr.8F15zPQS1MAerCeHtZ4G6Yskc99Fk7WUIY8WgODPq.KKqOXSDHuj
 Bo3LqnCG1jzlsa8n_c2VR3yq7Bqq0iwjNEptm9ZWIL3fYW_aY6XTbE8gXOuDLdXnXc437pVFRtAm
 xPVi3ssbbn71fxgucZSMOz6VgFTsFZ1aakVETYj1XJgdPDfEK3HUFdLscGrDpighGCWoa7zyuZHr
 SeRbkgGMPfq8X7BGzKyzKdHIuOo8J1UNa2bAK9VFuQtD0wcPQRp4dOM__37DQPzLj04D8SXX46H8
 rpGLlOwkqCZep8g_Exhscyw63C7ynnGW8bDqxBBo9ZQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:19:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c77f6ae516e03a89627c63bd722d43d2;
          Sat, 22 Sep 2018 00:19:49 +0000 (UTC)
Subject: [PATCH v4 16/19] SELinux: Abstract use of ipc security blobs
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:19:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
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
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 389e51ef48a5..e6cb5fce5437 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5884,7 +5884,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = selinux_ipc(ipc_perms);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -5941,7 +5941,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->security;
+	isec = selinux_ipc(msq);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5990,8 +5990,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -6038,8 +6038,8 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -6092,7 +6092,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->security;
+	isec = selinux_ipc(shp);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6189,7 +6189,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->security;
+	isec = selinux_ipc(sma);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6275,7 +6275,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	*secid = isec->sid;
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 591adb374d69..5bf9f280e9b2 100644
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
@@ -173,4 +174,16 @@ static inline struct inode_security_struct *selinux_inode(
 	return inode->i_security;
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
2.17.1


