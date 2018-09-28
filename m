Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A1C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D2D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D2D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeI2E1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:27:11 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:56528 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbeI2E1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:27:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8955118004A73;
        Fri, 28 Sep 2018 22:01:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kite97_c6242f8cb220
X-Filterd-Recvd-Size: 3279
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:01:24 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Bad MAINTAINERS pattern in section 'NETWORKING [IPSEC]'
Date:   Fri, 28 Sep 2018 15:01:23 -0700
Message-Id: <20180928220123.30999-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	10233	NETWORKING [IPSEC]
	10234	M:	Steffen Klassert <steffen.klassert@secunet.com>
	10235	M:	Herbert Xu <herbert@gondor.apana.org.au>
	10236	M:	"David S. Miller" <davem@davemloft.net>
	10237	L:	netdev@vger.kernel.org
	10238	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
	10239	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
	10240	S:	Maintained
-->	10241	F:	net/core/flow.c
	10242	F:	net/xfrm/
	10243	F:	net/key/
	10244	F:	net/ipv4/xfrm*
	10245	F:	net/ipv4/esp4*
	10246	F:	net/ipv4/ah4.c
	10247	F:	net/ipv4/ipcomp.c
	10248	F:	net/ipv4/ip_vti.c
	10249	F:	net/ipv6/xfrm*
	10250	F:	net/ipv6/esp6*
	10251	F:	net/ipv6/ah6.c
	10252	F:	net/ipv6/ipcomp6.c
	10253	F:	net/ipv6/ip6_vti.c
	10254	F:	include/uapi/linux/xfrm.h
	10255	F:	include/net/xfrm.h

Commit that introduced this:

commit 5826bdd1816fa2baa122b62e14905c0ad8e7b96a
 Author: Fan Du <fan.du@windriver.com>
 Date:   Sat Jan 18 09:55:28 2014 +0800
 
     flowcache: Bring net/core/flow.c under IPsec maintain scope
     
     As flow cache is mainly manipulated from IPsec.
     
     Signed-off-by: Fan Du <fan.du@windriver.com>
     Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
 
  MAINTAINERS | 1 +
  1 file changed, 1 insertion(+)

Last commit with net/core/flow.c

commit 09c7570480f7544ffbf8e6db365208b0b0c154c6
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Jul 17 13:57:26 2017 +0200

    xfrm: remove flow cache
    
    After rcu conversions performance degradation in forward tests isn't that
    noticeable anymore.
    
    See next patch for some numbers.
    
    A followup patcg could then also remove genid from the policies
    as we do not cache bundles anymore.
    
    Signed-off-by: Florian Westphal <fw@strlen.de>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 include/net/flow.h              |  34 ---
 include/net/flowcache.h         |  25 --
 include/net/netns/xfrm.h        |  11 -
 include/net/xfrm.h              |   8 -
 net/core/Makefile               |   1 -
 net/core/flow.c                 | 516 ----------------------------------------
 net/ipv4/xfrm4_policy.c         |   9 -
 net/ipv6/xfrm6_policy.c         |   9 -
 net/key/af_key.c                |   6 -
 net/xfrm/xfrm_device.c          |   2 -
 net/xfrm/xfrm_policy.c          | 108 +--------
 net/xfrm/xfrm_user.c            |   3 -
 security/selinux/include/xfrm.h |   4 +-
 13 files changed, 2 insertions(+), 734 deletions(-)
