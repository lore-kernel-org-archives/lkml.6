Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50772173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50772173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbeHNLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:54:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:54:24 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MVHys-1fNXDo1bf4-00Ygb5; Tue, 14 Aug 2018 11:07:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Greg Thelen <gthelen@google.com>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] rds: fix building with IPV6=m
Date:   Tue, 14 Aug 2018 11:07:42 +0200
Message-Id: <20180814090752.1681486-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:XLnGQc1Ak8KkURlpq7/RmY4jPmXCaWU2eESTXVBiizR39pPgR/Y
 K5SgtPUgWBL5RkFSQWmaS2mD8JuQt2yuZU11O0M2PVm1pTyniIQOdCmaYTdCEUk9mAC6rWk
 t/CgdFL1o1jDK19exyfepYlynNEl79qzAtuvMkYB0S1xD3L/eEZjfG6gdK69x+TrLJ4YNoN
 /Ac0zX073PEEqtZDrz+mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S+X/Wd2/ZgA=:0rn3zvOHzDTS72sy9aAVaC
 Zqn6Heyak0diw10Kgx3o7EHD/6l49ZXi0y1/bTRGDYvJzON+LsgJk94BLIHvIH6ze3hZ2jOlI
 m64T6am8F07B+snqXk1fUMtbqCf68fNDfTwmBqAgNMA9L1QHVIXFRYomLlhzY+K1IAJZNnmgd
 EEPGlDl3gEwyP55lZjg9/echFyXHuvV20jHrw1rye5hb933XQl0+kRInFuGaaI1YYhz/IqZrZ
 HvjXoJEkW+Y1+66CmYGWWy0W/O1zv38AjgMuj7ug4enaSlAuN4QPQwh7MSC3KrLoPT4BJ8b5E
 k8jc2Oiz2O4kqlTwcvHcgHwE4mbxVWtxNMYxEge/8fMQhmCOzC0cJjHaVIeAD8oep1tbYhbNx
 3RpCwtTMZ4HLubjDo6qeF2DQGO679O90jIhgvnjNGzqmOeOw0nN8GCZ02MVGYLRFk0ZcU0TU6
 AZRKEfkzEHYxUo84rkVoI/GDtWdkgzcZ0yiW5Bs/lwJXi5MypOMUT2f2wUzX43awaTjBkTYN1
 tNO/nwAibJgFuJx564dXgmzfs+itAtRjlqlE+h1225CsOgcbGDUb5S/hET58fPJJIJPYs/3ZE
 tRktfWd/JFYYsd8XMf3geptw048INhwKJXt58wuafPtKpQWO3XVlvhRphLjGzn92Mb9/QUml+
 T3pDjTuox9foUm1ijYPsBQOUuCjSC+NXHPiiQp6v7vcxP4aYCSnOle1zWsqrY9YwIxT0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RDS_TCP is built-in and CONFIG_IPV6 is a loadable
module, we get a link error agains the modular ipv6_chk_addr()
function:

net/rds/tcp.o: In function `rds_tcp_laddr_check':
tcp.c:(.text+0x3b2): undefined reference to `ipv6_chk_addr'

This adds back a dependency that forces RDS_TCP to also be
a loadable module when IPV6 is one.

Fixes: e65d4d96334e ("rds: Remove IPv6 dependency")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/rds/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 41f75563b54b..01b3bd6a3708 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -16,6 +16,7 @@ config RDS_RDMA
 config RDS_TCP
 	tristate "RDS over TCP"
 	depends on RDS
+	depends on IPV6 || !IPV6
 	---help---
 	  Allow RDS to use TCP as a transport.
 	  This transport does not support RDMA operations.
-- 
2.18.0

