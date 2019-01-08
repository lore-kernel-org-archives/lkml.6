Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A3820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wigner.mta.hu header.i=@wigner.mta.hu header.b="U9k0JbBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfAHUIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:08:09 -0500
Received: from smtp.wigner.mta.hu ([148.6.0.56]:48525 "EHLO smtp.wigner.mta.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbfAHUIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:08:00 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 15:08:00 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp0.kfki.hu (Postfix) with ESMTP id C078067400E8;
        Tue,  8 Jan 2019 21:01:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wigner.mta.hu;
         h=mime-version:user-agent:references:message-id:in-reply-to
        :from:from:date:date:received:received; s=20151130; t=
        1546977703; x=1548792104; bh=c3b66ItOhfDm2Rjp/pmDPB8GBxlsG0f/MqQ
        sK7IOBck=; b=U9k0JbBdanMqn4F50ljAjN9wLYwe2wAT6eDhE/vxIAkJzfdfUiH
        klz64/CfdlP/ocNIIIqPCdaV8LDC7rFwL61/XfF54ovOMCqnop1tCT/vsEY1MBbu
        wWqeXT9xsE55VuxX6OudBcKZj+3tSchvnoBOPcsp8x26cr2YJXH7qVz0=
X-Virus-Scanned: Debian amavisd-new at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
        by localhost (smtp0.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Tue,  8 Jan 2019 21:01:43 +0100 (CET)
Received: from [192.168.62.8] (host-79-121-41-212.kabelnet.hu [79.121.41.212])
        (Authenticated sender: kadlecsik.jozsef@wigner.mta.hu)
        by smtp0.kfki.hu (Postfix) with ESMTPSA id 4C30867400E5;
        Tue,  8 Jan 2019 21:01:42 +0100 (CET)
Date:   Tue, 8 Jan 2019 21:01:41 +0100 (CET)
From:   =?ISO-8859-15?Q?Kadlecsik_J=F3zsef?= 
        <kadlecsik.jozsef@wigner.mta.hu>
X-X-Sender: kadlec@localhost
To:     Aditya Pakki <pakki001@umn.edu>
cc:     kjlu@umn.edu, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] netfilter: ipset: fix a missing check of
 nla_parse
In-Reply-To: <20190105153150.2600-1-pakki001@umn.edu>
Message-ID: <alpine.DEB.2.20.1901082101100.21270@localhost>
References: <20190105153150.2600-1-pakki001@umn.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 5 Jan 2019, Aditya Pakki wrote:

> When nla_parse fails, we should not use the results (the first
> argument). The fix checks if it fails, and if so, returns its error code
> upstream.

Patch is applied in the ipset git tree, thanks!

Best regards,
Jozsef

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  net/netfilter/ipset/ip_set_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> index 45a257695bef..3ee0fda05a3b 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -1546,8 +1546,13 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
>  		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
>  		cmdattr = (void *)&errmsg->msg + min_len;
>  
> -		nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
> -			  nlh->nlmsg_len - min_len, ip_set_adt_policy, NULL);
> +		ret = nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
> +				nlh->nlmsg_len - min_len, ip_set_adt_policy,
> +				NULL);
> +		if (ret) {
> +			nlmsg_free(skb2);
> +			return ret;
> +		}
>  
>  		errline = nla_data(cda[IPSET_ATTR_LINENO]);
>  
> -- 
> 2.17.1
> 
> 

--
E-mail : kadlecsik.jozsef@wigner.mta.hu
PGP key: http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address: Wigner Research Centre for Physics, Hungarian Academy of Sciences
         H-1525 Budapest 114, POB. 49, Hungary
