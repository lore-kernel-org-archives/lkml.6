Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639AD24C6A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="X4TB7uvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639AD24C6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeGBSyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:54:44 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52997 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeGBSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:54:42 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so13543405itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WBlBrLbAf1ehG+UvI9ifO+hjSZiqWGnIYhWj9iU7ukY=;
        b=X4TB7uvjlWdU/5flMRZ9eW72nVl4jFXMKJ+pC6VLbm7Y+0JBU9BUU+czcI0l09VRHa
         VrwTZXM69O/NGwUkbG6vLsq7BNuAb551H87tzWzetFVSp1qi2cu0hDM46scg6b51Sw4N
         j/N6l7cFrG5JxLSVNv02rqfCD3bQ5k1KILfIh/fH3g+CEUwLkrVYDFnRb0+Lb9QWsQ1K
         fdubyzsL3XpPkO0v1hEw6oy6N5sm+ddRgBO5+cVjKIFojip9DTorcBntoDNbeBWqOaRx
         RDQ3d+L5MDUo4PvMsOxyCkVKQQ9W1VS2DnsDHj+ia/iySWegdQTaUSBR6BxsMAO9I4uW
         S9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WBlBrLbAf1ehG+UvI9ifO+hjSZiqWGnIYhWj9iU7ukY=;
        b=NW1UYxCc1X/ARXGHcw3FVyW6x5GrHprzB+SbuYdhv8zh0u0X45/hKvm+8sVt5trGKi
         rI7QTH8Gqi+nEsnNSg3iIjAzBML1vTbqi4f5BxAIcqOYSUTl2DdLLSSOt+yn/TZWxIUG
         VAz3tcB9i1G8OL0O4N1YjsRW7HdlW2dmgDf4WK+X8WH4xYHvzB8AxLLKP9UPFwlxxKnK
         Ix+0j8W43kX2rqWEWuUmO3r+OKu9YBL8PCPu8zq8Dk9fBnTTEiLf+k43mxJB6UWkw8kl
         6v2tX5yS+ss4a98nOoEe/gxX1oxQ8iwm4XmbR9NnzOlEVyHbWpH5M6JhqBDujofnTeyP
         3Txg==
X-Gm-Message-State: APt69E2iEB/NW8U6FEdk0btJz/3oL0UOEAieaOPreUT+DWr+/wSk19B0
        DSzHGy0UByzebhrkMX6/5GILEw==
X-Google-Smtp-Source: AAOMgpesgYjwXglzlZ17sOjrYWnb2iRgVycdsQuHjsKFfFHhNCbT454KFYa8PaVZ+1dk3LbAzgqL3A==
X-Received: by 2002:a24:f444:: with SMTP id u4-v6mr7125772iti.132.1530557681066;
        Mon, 02 Jul 2018 11:54:41 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id d76-v6sm3529183iog.84.2018.07.02.11.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 11:54:40 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:54:38 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Michael Scott <michael@opensourcefoundries.com>
Cc:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
Message-ID: <20180702185438.dqqjg6k45iefj5is@x220t>
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619234406.8217-1-michael@opensourcefoundries.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 19, 2018 at 04:44:06PM -0700, Michael Scott wrote:
> After decompression of 6lowpan socket data, an IPv6 header is inserted
> before the existing socket payload.  After this, we reset the
> network_header value of the skb to account for the difference in payload
> size from prior to decompression + the addition of the IPv6 header.
> 
> However, we fail to reset the mac_header value.
> 
> Leaving the mac_header value untouched here, can cause a calculation
> error in net/packet/af_packet.c packet_rcv() function when an
> AF_PACKET socket is opened in SOCK_RAW mode for use on a 6lowpan
> interface.
> 
> On line 2088, the data pointer is moved backward by the value returned
> from skb_mac_header().  If skb->data is adjusted so that it is before
> the skb->head pointer (which can happen when an old value of mac_header
> is left in place) the kernel generates a panic in net/core/skbuff.c
> line 1717.
> 
> This panic can be generated by BLE 6lowpan interfaces (such as bt0) and
> 802.15.4 interfaces (such as lowpan0) as they both use the same 6lowpan
> sources for compression and decompression.
> 
> Signed-off-by: Michael Scott <michael@opensourcefoundries.com>
> ---
>  net/6lowpan/iphc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 6b1042e21656..52fad5dad9f7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>  		hdr.hop_limit, &hdr.daddr);
>  
>  	skb_push(skb, sizeof(hdr));
> +	skb_reset_mac_header(skb);
>  	skb_reset_network_header(skb);
>  	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
>  

I think it's good to make that if the mac_header gets a dangled pointer.
But we don't have a mac header at this point anymore...

There exists also some functionality that the MAC header is not set, I
suppose this can be usefuly for tun like interfaces e.g. RAW IP what we
have here.

skb_mac_header_was_set

which does:

return skb->mac_header != (typeof(skb->mac_header))~0U;

maybe we can set it as (typeof(skb->mac_header))~0U and then everything
will run as far the kernel will not crash anymore.

Question is for me: which upper layer wants access MAC header here on
receive path?
It cannot parsed anyhow because so far I know no upper layer can parse
at the moment 802.15.4 frames (which is a complex format). Maybe over
some header_ops callback?

- Alex
