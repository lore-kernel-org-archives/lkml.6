Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B75C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C222083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C222083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeJPQWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:22:39 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:38738 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeJPQWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:22:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 84A3020087;
        Tue, 16 Oct 2018 10:26:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pTYmoSsLuxKr; Tue, 16 Oct 2018 10:26:37 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 25B2B20082;
        Tue, 16 Oct 2018 10:26:37 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Oct 2018
 10:26:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id AFF0D3182995;
 Tue, 16 Oct 2018 10:26:36 +0200 (CEST)
Date:   Tue, 16 Oct 2018 10:26:36 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Michal Kubecek <mkubecek@suse.cz>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm: use complete IPv6 addresses for hash
Message-ID: <20181016082636.GY3823@gauss3.secunet.de>
References: <20181012122444.0448FA0ED9@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181012122444.0448FA0ED9@unicorn.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: F54B69C4-CE61-4812-B822-90CCA5292B0B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:24:44PM +0200, Michal Kubecek wrote:
> In some environments it is common that many hosts share the same lower half
> of their IPv6 addresses (in particular ::1). As __xfrm6_addr_hash() and
> __xfrm6_daddr_saddr_hash() calculate the hash only from the lower halves,
> as much as 1/3 of the hosts ends up in one hashtable chain which harms the
> performance.
> 
> Use complete IPv6 addresses when calculating the hashes. Rather than just
> adding two more words to the xor, use jhash2() for consistency with
> __xfrm6_pref_hash() and __xfrm6_dpref_spref_hash().
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Applied to ipsec-next, thanks a lot!
