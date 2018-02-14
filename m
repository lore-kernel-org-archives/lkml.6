Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162042AbeBNS0Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161943AbeBNS0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:26:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13975217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Wed, 14 Feb 2018 10:26:13 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: boris.ostrovsky@oracle.com, jgross@suse.com
cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] pvcalls-front improvements
Message-ID: <alpine.DEB.2.10.1802141023400.5392@sstabellini-ThinkPad-X260>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this small series introduces a per socket refcount to increase the
efficiency on socket release operations, and makes releasing passive
sockets safe.

Cheers,

Stefano


Changes in v3:
- remove pointless initializers
- reorder pvcalls_enter_sock

Changes in v2:
- add acked-by
- fix check in pvcalls_enter_soc
- fix code style
- nicer checks in pvcalls_front_release


Stefano Stabellini (2):
      pvcalls-front: introduce a per sock_mapping refcount
      pvcalls-front: wait for other operations to return when release passive sockets

 drivers/xen/pvcalls-front.c | 197 +++++++++++++++++++-------------------------
 1 file changed, 85 insertions(+), 112 deletions(-)
