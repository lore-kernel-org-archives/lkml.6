Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELsL2yDf9FfcVOd6MRd5O1EARcHHI7FZL2XE6CMjIQW5ScXXs5swocBfd3thzuWQmKhSsykp
ARC-Seal: i=1; a=rsa-sha256; t=1520946279; cv=none;
        d=google.com; s=arc-20160816;
        b=QI4oxxysHOfcaQNS8rz0wWMbKZQTUjqkVedPCyMiBkkSihjOzwZ8FoctQNicwwHX1j
         lxCgZqIVQegjwpON5DZNh1JXnEp/Ygv+XyedCJG5P2GETNLaPBdh2A7UTOZhu7A2u1uG
         9rA/eMYwO+N+TzG4kx4jx+kiYvDjbrRB2CVXHc5dz7SpPqYOV6+7AAg1sLMpRLr6u7XQ
         2GuCZl8hWUThEmqgI5ZdGBOi26pI1aRqVdTtvLAuymGL1Rtxat3bMabVrjes6hYcqClq
         uM6mp01BGJTvRAQv1CVWWIZ5FN6DuT/UUUDyPpLeZSJTJdoHnYa68KJxrr4t8ensT29B
         JfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=mYwu6PYiPbZCshEsng96HBd+bJFkDhrLUYWRbU28HIM=;
        b=GPrFih1rroeTVjZKmORYfNmZsQk/P0Y4P06B6bc7hGleeTFl+wErJAo6KpXp7PVAhH
         70WFEtMMmS0yuU8pkgJXqVH/R1z3c7qRriLzfpLZryuzaoEHs6BNd553mXLXmnVBPBnH
         hdEGeVw9WyJXMYRcIkNMGAz4H8v9KDM1iwEPd02ElkrLFV8O36SOZTkXRKbF5Fryp/7j
         UqtZgid3aYgn9fYwEJUYCOQbmjf42bRzhVtiGyIbN7qLUIwp9hnDISLf9oDRj/WtyPal
         FN5wZZO5osLi3OAnJeR7v4NhJKi1abF6SiNu9L8KJjZOiSw5PrFBq0VOPxL+lyGrinGe
         hCUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Oleg Drokin <oleg.drokin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	NeilBrown <neilb@suse.com>,
	Aliaksei Karaliou <akaraliou.dev@gmail.com>,
	lustre-devel@lists.lustre.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: lustre: use module_name() macro for debug printf
Date: Tue, 13 Mar 2018 14:03:44 +0100
Message-Id: <20180313130425.3975930-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:fc9YuYrJ713TPvQg3TjkQhYpocT9qT4sZK/RGiGJBhoLJ8x2vff
 JzcZw0h5dcFiRY+K8OtQZawBxjMYUuqFyIABgxQ+mJ+bTU7eYsVIqClOC0o6qL7W2xWlJJ3
 hJhZs0dkdal8WfeuB/LPFrCWSAemHv5oGhTH6pmAiyY0ZebPkKVR1ODixUYi4620jvHroUe
 BqHzS8VfGJluZ/28tAbEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8zzGvBnANzc=:E3pIG0k8Be2vcqYy9CH7pr
 XU2DyWW2Vb0xlgmQm0xPVHGunW1saxiQIfDPjDuI2tuzJVglHyhXs/KWRfxARpnx8pW6pp3bY
 OviE9JxlfgG+yCZVhN9Lv+QtFDfxF6gmXN9449U88ek6jzb2mxrvCHsh9sm0BWzOAFR5EBA+I
 Sqj7v5ExAmzKMwle9A8kbuflDSXdwiQxKmfI8nE0uN7Tnv5C838qAnvdWlo9atlist2tOKsqC
 7lGXtbEdgLSVddRDtK3ld6RYNv+PAchTAHgplffIQMosx7S6RTV+IDlNfQhUjPtcisR4VObk8
 pi13pi4JM9LGiw5H4cy15eA1gZ7mcSom5Ut5e4tpMtamx/fJFfL/Xy4R7LPGoww5kYz1QqQw5
 DigiAM2DGstNO0CNxJRUJYSiUvtT0Cui+0Ueca2I3kd3PvQWDmGjOwIlWZygKCohW5/XIWaLg
 Qha7iFO7MmzbwRBNvqP/XnggtiXus9n/ePJASzGHHepUC0T+rPlF6y6N1syXwDNnztBSMr0Ph
 B9SLYydSW4zavIoUXFSDRvQnL8zZZBSH18qgZAI0SmET0NVDRA47D2FpanF/xVyIh2sODExL3
 TgYGYXe/0I7Mn1AXArVg21kD6e+vfKpXhRy7jJMUklCOozRIs9ZRpr+hF3IaUXnTNNqtXxsbs
 J4CDxJjQwMerpa5HDf342QzeV4ur5kpDhCBlmwPLqJ09nexAb4kpa194syXjtb7Tr3NquO9Ut
 MXjJU8jlNAy9nEEbTr1AK/x2EXCX8DMHHjS8RA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827765427449356?=
X-GMAIL-MSGID: =?utf-8?q?1594827765427449356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We now allow lustre to be built when CONFIG_MODULES is disabled,
but that causes a build failure:

In file included from drivers/staging/lustre/include/linux/libcfs/libcfs.h:42,
                 from drivers/staging/lustre/lustre/obdclass/lu_object.c:44:
drivers/staging/lustre/lustre/obdclass/lu_object.c: In function 'lu_context_key_degister':
drivers/staging/lustre/lustre/obdclass/lu_object.c:1410:51: error: dereferencing pointer to incomplete type 'struct module'

This particular case can be avoided by using the module_name()
macro that was designed exactly to handle printing the name of
a module in all configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 8ddf23b82a2c..3ae16e8501c2 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1407,7 +1407,7 @@ void lu_context_key_degister(struct lu_context_key *key)
 	while (atomic_read(&key->lct_used) > 1) {
 		spin_unlock(&lu_keys_guard);
 		CDEBUG(D_INFO, "%s: \"%s\" %p, %d\n",
-		       __func__, key->lct_owner ? key->lct_owner->name : "",
+		       __func__, module_name(key->lct_owner),
 		       key, atomic_read(&key->lct_used));
 		schedule();
 		spin_lock(&lu_keys_guard);
@@ -1547,7 +1547,7 @@ void lu_context_key_quiesce(struct lu_context_key *key)
 			spin_unlock(&lu_keys_guard);
 			CDEBUG(D_INFO, "%s: \"%s\" %p, %d (%d)\n",
 			       __func__,
-			       key->lct_owner ? key->lct_owner->name : "",
+			       module_name(key->lct_owner),
 			       key, atomic_read(&key->lct_used),
 			atomic_read(&lu_key_initing_cnt));
 			schedule();
-- 
2.9.0
