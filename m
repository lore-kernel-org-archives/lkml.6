Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBEWvj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeBEWvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:51:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ABF20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Mon, 5 Feb 2018 14:51:24 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: boris.ostrovsky@oracle.com, jgross@suse.com
cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pvcalls-front improvements
Message-ID: <alpine.DEB.2.10.1802051448460.10160@sstabellini-ThinkPad-X260>
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


Stefano Stabellini (2):
      pvcalls-front: introduce a per sock_mapping refcount
      pvcalls-front: wait for other operations to return when release passive sockets

 drivers/xen/pvcalls-front.c | 196 +++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 112 deletions(-)
