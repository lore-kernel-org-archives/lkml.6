Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4120645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceV58Foe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLMGUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:20:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55752 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLMGUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:20:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so1068581wmc.5;
        Wed, 12 Dec 2018 22:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NX1EyyAP3eemGkNK/vkRtfNsdIgvvL0WSVyq1VJH7JM=;
        b=ceV58Foeac7+ehro5f0yLL0LNUfKLbKXOAmp/0i3Gc/wIr2qKQw+pVICcISKgaVjmT
         tEN95QHgXsc79tGcQ1xZuCICyHXtuHFVJ3KccZg31mRCICPGvjnDt6H/tfRB5/cilf7+
         HcDHVsBUIICNw+OO95WBKt+RqVMEtqiq1/ODhrLjnZS48Kc4shuh1WS4ieaJXt2KzAMD
         tYsq8lF1DAGK9PjeCNIjdB5pOWQkcXaReYKoNSMQXuVq2sqIt0t+52fFXsoDBHPGhEa1
         nW8aGY09SwOVKEO+NUl79XdBACDH/kwwQcQn/u9zOXJEVQbTlQq5bJMVWpw6sUZYkB3f
         q5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NX1EyyAP3eemGkNK/vkRtfNsdIgvvL0WSVyq1VJH7JM=;
        b=JAk8/fWTa/DG/RdCH6OdrHIyhHg8lWRTh+RxomBsgMS+5+b8T8otHTaxtY4emfCFWX
         xSXWQoNOjtXmiIgL1A1QwCj7m1CYveU0/UzWhdSIyJAhldzg9DkOTzsc0uewd0d8Pyb8
         MANKQFW+1vVPhwTsjw2Xd8doLObCzUwpwHbrMe0dDbvQTc0sxdTHgiRYSgHtozmN9mym
         uMhN5Eiu1kSE3EgoPjinwY8srI78W5ekQk1WcpchpW8ctzq98ixOlqQKchAOiD+buO16
         sYZL9Ur9s66ZO60xtsZRE6l3PP4cMczCpAZULNUdPlUn6o+TXwNo3QpkxkMBSnnJnvt/
         HmoQ==
X-Gm-Message-State: AA+aEWZYNpH+lJyxYAQcS3406vblc5xXkv3esqlWqbaTqE/SZthEWoU3
        lrlO7kC9DAsHidlEMCFH7aA=
X-Google-Smtp-Source: AFSGD/U18TI/FlBrHa8S1Rhgz7f6jc1pySfq8hMRqR04ACEcM6MJ6sfXDYZEkm3kGGJmiSA32ikjnw==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr8818537wmg.71.1544682044998;
        Wed, 12 Dec 2018 22:20:44 -0800 (PST)
Received: from [192.168.8.147] (65.83.136.77.rev.sfr.net. [77.136.83.65])
        by smtp.gmail.com with ESMTPSA id g129sm951288wmf.39.2018.12.12.22.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 22:20:43 -0800 (PST)
Subject: Re: [PATCH net] net: ipv4: do not handle duplicate fragments as
 overlapping
To:     Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Gustavo Figueira <gfigueira@suse.com>
References: <20181213022800.9D298E1116@unicorn.suse.cz>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <cb96bca9-1dda-b243-b581-91f1b51f1517@gmail.com>
Date:   Wed, 12 Dec 2018 22:20:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181213022800.9D298E1116@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 06:28 PM, Michal Kubecek wrote:
> Since commit 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping
> segments.") IPv4 reassembly code drops the whole queue whenever an
> overlapping fragment is received. However, the test is written in a way
> which detects duplicate fragments as overlapping so that in environments
> with many duplicate packets, fragmented packets may be undeliverable.
> 
> Add an extra test and for (potentially) duplicate fragment, only drop the
> new fragment rather than the whole queue. Only starting offset and length
> are checked, not the contents of the fragments as that would be too
> expensive.  Check for duplicity with last (tail) fragment first as in real
> life scenarios this should be the most frequent case and we would have to
> iterate through the whole "run" otherwise.
> 
> Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  net/ipv4/ip_fragment.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index aa0b22697998..f09e3683b209 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -436,6 +436,10 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
>  			ip4_frag_append_to_last_run(&qp->q, skb);
>  		else
>  			ip4_frag_create_run(&qp->q, skb);
> +	} else if (offset == prev_tail->ip_defrag_offset &&
> +		   skb->len == prev_tail->len) {
> +		/* potential duplicate of last fragment */
> +		goto err;

What value is in @err variable at this point ?

Are you sure callers expect to receive -EINVAL ?



>  	} else {
>  		/* Binary search. Note that skb can become the first fragment,
>  		 * but not the last (covered above).
> @@ -449,8 +453,16 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
>  			else if (offset >= skb1->ip_defrag_offset +
>  						FRAG_CB(skb1)->frag_run_len)
>  				rbn = &parent->rb_right;
> -			else /* Found an overlap with skb1. */
> +			else {
> +				/* check for potential duplicate */
> +				while (skb1 && skb1->ip_defrag_offset < offset)
> +					skb1 = FRAG_CB(skb1)->next_frag;
> +				if (skb1 && offset == skb1->ip_defrag_offset &&
> +				    skb->len == skb1->len)
> +					goto err;

Maybe we should not care, if the node in the rbtree contains the range of this
incoming fragment, do not worry about finding if it is overlap or not ?

I am nervous about adding back a linear scan.

> +				/* Found an overlap */
>  				goto overlap;
> +			}
>  		} while (*rbn);
>  		/* Here we have parent properly set, and rbn pointing to
>  		 * one of its NULL left/right children. Insert skb.
> 

Thanks !
