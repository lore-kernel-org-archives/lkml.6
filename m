Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeEQOdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:33:45 -0400
Received: from gateway20.websitewelcome.com ([192.185.69.18]:36438 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751647AbeEQOdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:33:44 -0400
X-Authority-Reason: nr=8
Date: Thu, 17 May 2018 09:08:43 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/2] bpf: sockmap, fix uninitialized variable
Message-ID: <11073635016901e9e84c2f34f20d412073b26297.1526565461.git.gustavo@embeddedor.com>
References: <cover.1526565461.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526565461.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fJJaG-000BKQ-5P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:58220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable err is
returned without being properly initialized previously.

Fix this by initializing variable err to 0.

Addresses-Coverity-ID: 1468964 ("Uninitialized scalar variable")
Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work
with hashmap")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/bpf/sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index c6de139..41b41fc 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1713,7 +1713,7 @@ static int __sock_map_ctx_update_elem(struct bpf_map *map,
 	struct smap_psock_map_entry *e = NULL;
 	struct smap_psock *psock;
 	bool new = false;
-	int err;
+	int err = 0;
 
 	/* 1. If sock map has BPF programs those will be inherited by the
 	 * sock being added. If the sock is already attached to BPF programs
-- 
2.7.4
