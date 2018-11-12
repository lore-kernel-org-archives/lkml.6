Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97471C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543DE223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543DE223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbeKMIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:31:27 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:34959 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbeKMIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:31:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B23FF837F27F;
        Mon, 12 Nov 2018 22:36:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: act87_194085efee547
X-Filterd-Recvd-Size: 1714
Received: from XPS-9350 (unknown [172.58.27.5])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Nov 2018 22:36:13 +0000 (UTC)
Message-ID: <94a6e57e1d546a5c406e31c1ed8b20531f415feb.camel@perches.com>
Subject: Re: [PATCH] geneve: Add missing braces in addr6 initializer
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Nov 2018 14:36:11 -0800
In-Reply-To: <20181112221248.11477-1-natechancellor@gmail.com>
References: <20181112221248.11477-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 15:12 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/net/geneve.c:428:29: error: suggest braces around initialization
> of subobject [-Werror,-Wmissing-braces]
>                 struct in6_addr addr6 = { 0 };
>                                           ^
>                                           {}

Perhaps just remove the 0.

> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
[]
> @@ -425,7 +425,7 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (geneve_get_sk_family(gs) == AF_INET6) {
>  		struct ipv6hdr *ip6h = ipv6_hdr(skb);
> -		struct in6_addr addr6 = { 0 };
> +		struct in6_addr addr6 = { { 0 } };
>  
>  		if (!gs->collect_md) {
>  			vni = geneve_hdr(skb)->vni;

