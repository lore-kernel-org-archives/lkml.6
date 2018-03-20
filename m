Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbeCTGos (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:44:48 -0400
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:42786 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCTGon (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 20 Mar 2018 02:44:43 -0400
From: Gang He <ghe@suse.com>
To: teigland@redhat.com
Cc: Gang He <ghe@suse.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: prompt the user SCTP is experimental
Date: Tue, 20 Mar 2018 14:45:27 +0800
Message-Id: <1521528327-882-1-git-send-email-ghe@suse.com>
X-Mailer: git-send-email 1.8.5.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you know, DLM module can use TCP or SCTP protocols to
communicate among the cluster.
But, according to our testing, SCTP protocol is still considered
experimental, since not all aspects are working correctly and
it is not full tested.
e.g. SCTP connection channel switch needs about 5mins hang in case
one connection(ring) is broken.
Then, I suggest to add a kernel print, which prompts the user SCTP
protocol for DLM should be considered experimental, it is not
recommended in production environment.

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/dlm/lowcomms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cff79ea..18fd85d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1307,6 +1307,7 @@ static int sctp_listen_for_all(void)
 		return -ENOMEM;
 
 	log_print("Using SCTP for communications");
+	log_print("SCTP protocol is experimental, use at your own risk");
 
 	result = sock_create_kern(&init_net, dlm_local_addr[0]->ss_family,
 				  SOCK_STREAM, IPPROTO_SCTP, &sock);
-- 
1.8.5.6
