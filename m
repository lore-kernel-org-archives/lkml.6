Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E7DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077FA20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077FA20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJDMUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:20:19 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:38936 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJDMUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:20:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 255F9200BA;
        Thu,  4 Oct 2018 09:28:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ib3BFjvyNoob; Thu,  4 Oct 2018 09:28:28 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id D2C7B20087;
        Thu,  4 Oct 2018 09:28:28 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Oct 2018
 07:28:45 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 5A3CF318100F;
 Thu,  4 Oct 2018 07:28:45 +0200 (CEST)
Date:   Thu, 4 Oct 2018 07:28:45 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        "Florian Westphal" <fw@strlen.de>
Subject: Re: Bad MAINTAINERS pattern in section 'NETWORKING [IPSEC]'
Message-ID: <20181004052845.GG3823@gauss3.secunet.de>
References: <20180928220123.30999-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180928220123.30999-1-joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 5D56EB6E-E200-4CDC-BC47-08208C5E4AC8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:01:23PM -0700, Joe Perches wrote:
> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	10233	NETWORKING [IPSEC]
> 	10234	M:	Steffen Klassert <steffen.klassert@secunet.com>
> 	10235	M:	Herbert Xu <herbert@gondor.apana.org.au>
> 	10236	M:	"David S. Miller" <davem@davemloft.net>
> 	10237	L:	netdev@vger.kernel.org
> 	10238	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
> 	10239	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
> 	10240	S:	Maintained
> -->	10241	F:	net/core/flow.c

This file went away with the flowcache removal.
I plan to apply the patch below to the ipsec tree:

Subject: [PATCH] MAINTAINERS: Remove net/core/flow.c

net/core/flow.c does not exist anymore, so remove it
from the IPSEC NETWORKING section of the MAINTAINERS
file.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcb0191c4f54..4ff21dac9b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10130,7 +10130,6 @@ L:	netdev@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
 S:	Maintained
-F:	net/core/flow.c
 F:	net/xfrm/
 F:	net/key/
 F:	net/ipv4/xfrm*
-- 
2.17.1

