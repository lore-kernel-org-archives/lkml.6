Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeDIOhs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:37:48 -0400
Received: from mail.us.es ([193.147.175.20]:33464 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbeDIOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:37:46 -0400
Date: Mon, 9 Apr 2018 16:37:41 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: fix CONFIG_NF_REJECT_IPV6=m link error
Message-ID: <20180409143741.dzooqrzcgi2bnvd5@salvia>
References: <20180409105322.2247296-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="iojt55x3tnaul5vo"
Content-Disposition: inline
In-Reply-To: <20180409105322.2247296-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iojt55x3tnaul5vo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

On Mon, Apr 09, 2018 at 12:53:12PM +0200, Arnd Bergmann wrote:
> We get a new link error with CONFIG_NFT_REJECT_INET=y and CONFIG_NF_REJECT_IPV6=m

I think we can update NFT_REJECT_INET so it depends on NFT_REJECT_IPV4
and NFT_REJECT_IPV6. This doesn't allow here CONFIG_NFT_REJECT_INET=y
and CONFIG_NF_REJECT_IPV6=m.

I mean, just like we do with NFT_FIB_INET.

BTW, I think this problem has been is not related to the recent patch,
but something older that kbuild robot has triggered more easily for
some reason?

Thanks for your patch!

--iojt55x3tnaul5vo
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="x.patch"

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index d3220b43c832..b48c57bb9aaf 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -601,7 +601,8 @@ config NFT_REJECT
 
 config NFT_REJECT_INET
 	depends on NF_TABLES_INET
-	default NFT_REJECT
+	depends on NFT_REJECT_IPV4
+	depends on NFT_REJECT_IPV6
 	tristate
 
 config NFT_COMPAT

--iojt55x3tnaul5vo--
