Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeDAUon (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754489AbeDAUok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:40 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 44/45] C++: Can't declare unsized-array in struct cgroup
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:39 +0100
Message-ID: <152261547956.30503.7547243896586878189.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cgroup can't be defined with an unsized array in it (ancestors_ids)
as the struct is embedded in another struct.  Fix it to have a 0 in there.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/cgroup-defs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 9f242b876fde..86fe9c6c6466 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -428,7 +428,7 @@ struct cgroup {
 	struct cgroup_bpf bpf;
 
 	/* ids of the ancestors at each level including self */
-	int ancestor_ids[];
+	int ancestor_ids[0];
 };
 
 /*
