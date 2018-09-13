Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F69FA3755
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FFB217C1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpFG7r/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FFB217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeIMWlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:41:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeIMWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:41:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so2971690pfn.13;
        Thu, 13 Sep 2018 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GZT/mWDmQ0lUKamsyGENfL+7LBls95gbKzwOeeFrUkA=;
        b=SpFG7r/eXUbKTvAxOpAyaapnuaRbU8rRXgnQQA74WxmFb8sOQ4E7MezRcsqAuUHZto
         /Asf5IphJFaZaCgZgXo6Pela/v2Ozqcrwf5Kxft2JJXkVjrKbxwqUFfuKFXUOCAtpWGD
         ErQtiWv6WCWZI7tFcLoUayJM4IMrUFj1Gdb2BZ1+BgwuhEa0rShf0/d63vLXn+nrWDV0
         9Yxf1YnmHN82mRtEVKmU/fR77swsxwu+b59FDZrlbyT8KzpkyypREQCSi0ZhEBwUrI7m
         BKSjac7okcSHsSdkeyS4afg5zYEbC+cuk4I1c90P4SEzurLnqiILW8US497p9mwUyku9
         nq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GZT/mWDmQ0lUKamsyGENfL+7LBls95gbKzwOeeFrUkA=;
        b=bYgHil6tSXoXiRCXkCMRSUrAE1gZEfxFVpB5shyvHRWt6sWquw4GHGgSyIFI/897PQ
         yzbcsddguNyynf2NgUDkwmbn3jnKygUz6diknCd0sSYKBQ4XDs+ao5VqVqQhbc4hhN0W
         m7qvGT0RLdsK2C17K9EwP1IwoKIIEb46dOwrkCrnfU8vtqCqWexo+hfPTmtwJme6WRfv
         pmzZcqzbmN1On3chZSGfJ9xx/oFMzLeIqgttf1JuAhGqpqChEHjQaetvA3S0jMt8KQ4p
         NJ4zvfy8dcfXAPFTI23qtXCo/TYqtg+Ia/70mMMc63VO0wRfWO2+atpDziYZOPRNLRrj
         YhcA==
X-Gm-Message-State: APzg51BoNjw73hgb+SdEJe3ydrZQDelSviXHmIs/idNJ2NaB1Pn+w4d5
        7gSyK+WHjigPVRCdjuSb2MU=
X-Google-Smtp-Source: ANB0VdZ0MlzD7iGvwVRKIjATgueNZy8u6yYoZO865QqEQ3J7RqtMYeCr5JrimyX46kH1tdO+V269Eg==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr8332074pfa.63.1536859878236;
        Thu, 13 Sep 2018 10:31:18 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id i25-v6sm7967848pfi.150.2018.09.13.10.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 10:31:17 -0700 (PDT)
Subject: Re: KMSAN: uninit-value in pppoe_rcv
To:     Guillaume Nault <g.nault@alphalink.fr>,
        Alexander Potapenko <glider@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <0000000000004624c30575a9fd40@google.com>
 <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
 <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
 <CAG_fn=WXPsQBWR1GDsprY3aL4oW0v6EGhNB5wrvPJCOMh_U7wQ@mail.gmail.com>
 <20180913161929.GA1507@alphalink.fr> <20180913172344.GB1507@alphalink.fr>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9b41183c-34ea-33d3-a1bf-b0d283675af2@gmail.com>
Date:   Thu, 13 Sep 2018 10:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180913172344.GB1507@alphalink.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/13/2018 10:23 AM, Guillaume Nault wrote:

> Nothing to change in tun.c. Just some more tests in pppoe.
> Can you try this patch? It only addresses this particular report, not
> the problems spotted by Eric.
> 
> -------- 8< --------
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 5aa59f41bf8c..77241b584dff 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -429,6 +429,9 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!skb)
>  		goto out;
>  
> +	if (skb_mac_header_len(skb) < ETH_HLEN)
> +		goto drop;
> +
>  	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
>  		goto drop;
>  
> 


Yeah this probably will help ;)
