Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeDAUk0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:40:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:22 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/45] Use UINT_MAX, not -1, to represent an invalid UID,
 GID or project ID
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:21 +0100
Message-ID: <152261522136.30503.14306229915768504613.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use UINT_MAX, not -1, to represent an invalid UID, GID or project ID as the
parameter is an unsigned integer.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/projid.h |    2 +-
 include/linux/uidgid.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/projid.h b/include/linux/projid.h
index 613730622a1a..7c60a79424c9 100644
--- a/include/linux/projid.h
+++ b/include/linux/projid.h
@@ -30,7 +30,7 @@ static inline projid_t __kprojid_val(kprojid_t projid)
 
 #define KPROJIDT_INIT(value) (kprojid_t){ value }
 
-#define INVALID_PROJID KPROJIDT_INIT(-1)
+#define INVALID_PROJID KPROJIDT_INIT(UINT_MAX)
 #define OVERFLOW_PROJID 65534
 
 static inline bool projid_eq(kprojid_t left, kprojid_t right)
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index b0542cd11aeb..75f602075b63 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -55,8 +55,8 @@ static inline gid_t __kgid_val(kgid_t gid)
 #define GLOBAL_ROOT_UID KUIDT_INIT(0)
 #define GLOBAL_ROOT_GID KGIDT_INIT(0)
 
-#define INVALID_UID KUIDT_INIT(-1)
-#define INVALID_GID KGIDT_INIT(-1)
+#define INVALID_UID KUIDT_INIT(UINT_MAX)
+#define INVALID_GID KGIDT_INIT(UINT_MAX)
 
 static inline bool uid_eq(kuid_t left, kuid_t right)
 {
