Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELvzfs6Fw+O9B3ROIATOHXPf1XmPALe7M8Kywi7Wr0oJAXjls+6Ev6uTJijOtidfMrASMo5k
ARC-Seal: i=1; a=rsa-sha256; t=1519947219; cv=none;
        d=google.com; s=arc-20160816;
        b=FGieIfi4bvJ0P3u4lu9D/yxAJ3edIfdmQTy/CPHrz9BuMwzkbpnZsqpa5WkgT/NY1A
         8IuFuuUiEF4K4C09bUZMFmHpP/PpHSERLJhZEotEICYIGZLfLYLEkW8LH7NYPRX9C9/i
         +DuGfy/D/iHJWd6sT74+uEaX0nuN9pIist5e/kP/rkfYhPm5RDbG3f0EskYc4xu95OWd
         IK3s5ugKCEHn/qKdQojw5NOcOsqbFWE3vAcHss1+Av8kmXI5W3QT9UdUNHZ+oJgiQKQW
         D1Vmi8pU+7VSsUmGeR1CnybMA5ZE2b1Crws7JMFwgrdPjMjpQ38EkavVmNiId9bQocOx
         fvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=Za+VHdP7yQPBB/H/jdQqgrNuQclTtB0npTxKV+t1UoU=;
        b=oGVE8RWLpC64FHCZj0zz8voYLZg5W7LkQJPWQvVtjhxZef7K48Otw6YTnBtUx4EE0o
         lKb0X29qdJPWdMytDBC2I4vOvdHGQQCNVqKZlLBu6QwGs0/cQgB2QC9TQ0wqe8dl0O4l
         a/yqg+HvVj5Nlhe1dYmpHciTpB56awP2OIOS3rzoJ0HXxFtHhnS2ifg97C1Kxi8kflf0
         an99FIgmHTTBWAxxVRtMLlz95p27+9tvgRlIVwylUlvK0RmiHAkS0sv7VpcJji08TctI
         MDM424loWFsGa1U1yQUzPULu42My7medigi/4kR+ZYrWJS87hcqVXzFf/InfuTBBwgYY
         2hag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 12/17] staging: lustre: remove unused flag from ptlrpc_thread
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708545.7628.17939519532029157797.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780175626155956?=
X-GMAIL-MSGID: =?utf-8?q?1593780175626155956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SVC_EVENT is no longer used.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lustre_net.h |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_net.h b/drivers/staging/lustre/lustre/include/lustre_net.h
index 5a4434e7c85a..108683c54127 100644
--- a/drivers/staging/lustre/lustre/include/lustre_net.h
+++ b/drivers/staging/lustre/lustre/include/lustre_net.h
@@ -1259,7 +1259,6 @@ enum {
 	SVC_STOPPING    = 1 << 1,
 	SVC_STARTING    = 1 << 2,
 	SVC_RUNNING     = 1 << 3,
-	SVC_EVENT       = 1 << 4,
 };
 
 #define PTLRPC_THR_NAME_LEN		32
@@ -1302,11 +1301,6 @@ struct ptlrpc_thread {
 	char				t_name[PTLRPC_THR_NAME_LEN];
 };
 
-static inline int thread_is_init(struct ptlrpc_thread *thread)
-{
-	return thread->t_flags == 0;
-}
-
 static inline int thread_is_stopped(struct ptlrpc_thread *thread)
 {
 	return !!(thread->t_flags & SVC_STOPPED);
@@ -1327,11 +1321,6 @@ static inline int thread_is_running(struct ptlrpc_thread *thread)
 	return !!(thread->t_flags & SVC_RUNNING);
 }
 
-static inline int thread_is_event(struct ptlrpc_thread *thread)
-{
-	return !!(thread->t_flags & SVC_EVENT);
-}
-
 static inline void thread_clear_flags(struct ptlrpc_thread *thread, __u32 flags)
 {
 	thread->t_flags &= ~flags;
