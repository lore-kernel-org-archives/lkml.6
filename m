Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0521241D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="QFf8Zwe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0521241D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeGBVbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:31:53 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40705 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeGBVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:31:48 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so291441ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Zp6nYT7ohtg5N4EKzH7tH1wx8wtCu49ByVfc4wvljE=;
        b=QFf8Zwe6QyO+/r5vk8cRj+35PrretoLZd03+ArW+YGI7Q18PiUgCAPZw979JOwhEHf
         2tGXdw8lmg19EcIeZTSfzIb5+mfPQRD6bgHAS+9yTOU5BOo6iGjFi06aUqIcN7zlRLlL
         JQ2rZBnYl4W9MSJTTq0Jx7O1WHd0SCsCqqr7p6/elUG5MA/bWvI2ne6ULg4yEw705G0C
         yvM1Z9nXZGu5Bc5vWh7JP4zW03v+NtXbjssE93Ycwr0bKnqIBi9JREEUDCEGGh3Qv9zX
         xVHVDopLGcMkLXiRcvFZWhqIXEuEp3fF76TFbL+vQQizocs49wIYOYf5IPbisVPpR0FB
         eAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Zp6nYT7ohtg5N4EKzH7tH1wx8wtCu49ByVfc4wvljE=;
        b=Pl7zAB0iZadcI+RKF8wM11GZ4uRMWmpuKJfWJ7ONA1nkURvRaMPb9CSc+XKIjLDf/T
         UKAni/ZcSwt9rVS2e7Bn384BsSsuwpWA0yLPCHZ3cuIYjfmY5ZzbGs2y/8nwPxQYhMhO
         QT5qxpWHollOu7kycEp9qCqZQMKHsurkIDtRKtdTZYUpKyKbRB6YwILcxhKPrA4+QR27
         VZ2+0GTHJBjroGqXvjoC3ue2UWdl5t8NmjlW76rAUMu4viQoJxSaK3nXXCPMDbK3NwKl
         O5+j2QFzoPhQo5IBvOVsyiRLXx2TnnJ8+1fjyTRPKPmqLqIOT/YFRm58EkKbla0EzcOe
         odIw==
X-Gm-Message-State: APt69E2mqo+UMO8y/7qhb5V1cdPEEPIYnHQoA0cc1BanCk78B8n9l4vf
        jTrbORwWluGqo1D33t9Kq4HyKsYc
X-Google-Smtp-Source: AAOMgpd6Jfw4UhTLxFZUfm8G2qR+cfDCLLdWfHCtxxwLvHlsubv/0GbBndX2p4N2+C7PaYzsKu4Dqg==
X-Received: by 2002:a24:8201:: with SMTP id t1-v6mr7540360itd.51.1530567106826;
        Mon, 02 Jul 2018 14:31:46 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id e11-v6sm5363370iob.20.2018.07.02.14.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 14:31:45 -0700 (PDT)
Date:   Mon, 2 Jul 2018 17:31:40 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Michael Scott <michael@opensourcefoundries.com>
Cc:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
Message-ID: <20180702213140.noxt6vr46xpiwjaq@x220t>
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
 <20180702185438.dqqjg6k45iefj5is@x220t>
 <516fbc65-cc4b-8016-de5a-e2240b779d15@opensourcefoundries.com>
 <20180702204346.d7bynetvzw3ayn5m@x220t>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702204346.d7bynetvzw3ayn5m@x220t>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 02, 2018 at 04:43:46PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Mon, Jul 02, 2018 at 12:45:41PM -0700, Michael Scott wrote:
> > Hello Alexander,
> > 
> ...
> > > Question is for me: which upper layer wants access MAC header here on
> > > receive path?
> > > It cannot parsed anyhow because so far I know no upper layer can parse
> > > at the moment 802.15.4 frames (which is a complex format). Maybe over
> > > some header_ops callback?
> > 
> > I was testing a C program which performs NAT64 handling on packets
> > destined to a certain IPv6 subnet (64:ff9b::). To do this, the application
> > opens a RAW socket like this: sniff_sock = socket(PF_PACKET, SOCK_RAW,
> > htons(ETH_P_ALL)); It then sets promiscuous mode and enters a looping call
> > of:
> > length = recv(sniff_sock, buffer, PACKET_BUFFER, MSG_TRUNC); My host PC
> > kernel would then promptly crash on me. (I'm going to purposely avoid the
> > obvious point of: this probably isn't the best way to parse packets for
> > NAT64 translation as you will get every single packet incoming or outgoing
> > on the host.) Turns out, testing the program on an 802.15.4 6lowpan
> > interface exposed some of the issues which this mailing list (but not
> > myself) is well aware of (no L2 data in the RAW packets) and also led me to
> > debugging this patch to stop the kernel crash. TL;DR: To summarize, any
> > PF_PACKET SOCK_RAW socket which recv()'s IPv6 data from a 6lowpan node will
> > cause this kernel crash eventually (checked on kernel 4.15, 4.16, 4.17 and
> > 4.18-rc1). - Mike
> > > 
> 
> "any PF_PACKET SOCK_RAW" can't be otherwise I would also see it with my
> sniffer programs e.g. wireshark or tcpdump which use libpcap.
> 
> There need to be some different in the handling. This is what I have
> currently in my mind.
> 
> I currently not sure how to set skb->mac_header if interface is RAW_IP.
> It seems there is an indicator that mac header is not set. Example:
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 6b1042e21656..e6ec2df3afe0 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>                 hdr.hop_limit, &hdr.daddr);
>  
>         skb_push(skb, sizeof(hdr));
> +       skb->mac_header = (typeof(skb->mac_header))~0U;
>         skb_reset_network_header(skb);
>         skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
>  
> 
> Maybe we should lookup what skb->mac_header points to on tun interfaces
> then do the same.

So far I see [0] tun does the same as your patch approach does. network
header and mac header points to the same.

I think then we should go with your patch.

Then we just need to solve the issue to get mac header information on
top of lowpan socket layer... out of scope issue but indeed we need to
solve that. As we talked there exists even UDP protocols which needs mac
header information. It's in a pretty early state, I have no idea how
this fits sometimes with fragmentation handling together. At least for
L2 address handling and fragmentation it should be fine (one of the
fragment indentifier).

- Alex

[0] https://elixir.bootlin.com/linux/v4.18-rc3/source/drivers/net/tun.c#L1912
