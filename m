Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFEQHV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:07:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeFEQHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:07:19 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/5] afs: Enable IPv6 DNS lookups
From: David Howells <dhowells@redhat.com>
To: viro@ZenIV.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 17:07:17 +0100
Message-ID: <152821483785.16494.3444913276394175009.stgit@warthog.procyon.org.uk>
In-Reply-To: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
References: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the restriction on DNS lookup upcalls that prevents ipv6 addresses
from being looked up.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |    2 +-
 fs/afs/dynroot.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 7587fb665ff1..b49ccae07875 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -216,7 +216,7 @@ struct afs_addr_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry)
 	_enter("%s", cell->name);
 
 	ret = dns_query("afsdb", cell->name, cell->name_len,
-			"ipv4", &vllist, _expiry);
+			"", &vllist, _expiry);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 983f3946ab57..7425f416ed73 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -46,7 +46,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 		return 0;
 	}
 
-	ret = dns_query("afsdb", name, len, "ipv4", NULL, NULL);
+	ret = dns_query("afsdb", name, len, "", NULL, NULL);
 	if (ret == -ENODATA)
 		ret = -EDESTADDRREQ;
 	return ret;
