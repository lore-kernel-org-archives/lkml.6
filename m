Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D5F208A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="Upb2qtQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D5F208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeGBUnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:43:55 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53184 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:43:52 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so156898itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6Q6Pz62yXotXW3zyTdsIVn8Lr+MQtonEfNPYK8QiKM=;
        b=Upb2qtQ5S8xZoej9E99PhzyPoNjTASKRcgPbQhNKiRDFwj+OXpMIZfXQGBL6DHxZPw
         GMIVmL6EJEvliXo0ePSdm6JnpV8XSBDEZl8axyX/Jpujev3KqoTkpYUY2NOsEIyir1Ch
         /O41hMXvgG7Rlex443ZBPi//7tEsiCnp4ElitenpgMHzvYPbT0HiHux+f7Rva3sMFknr
         bFEbGH3LPZ1QyUY14Oc4mcGCBNo1f2QXD/A3iqE4qI30WUMLH9xi+bMdQK7q9xhUbkh5
         U046ZqgIIcyKYs5nOa3F48xEBsFAjlrsyUFZyR6Fg7wdgjjRJFJAN7eeCo15zk9Np2E8
         jaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6Q6Pz62yXotXW3zyTdsIVn8Lr+MQtonEfNPYK8QiKM=;
        b=WTc9tvCNwHvf4LuUlyvbyJcmCLPb8lai5d+jE4f/EukRJWi0q4bsOGip7RdbRx7hj/
         qdkQ2XpFBH+co5PTiqdu6B0PNfJ9o53avWTQqbs8JOiB7fiKv8fEsmti032m4TcQo9JQ
         T+O5RyUgTJGiFLeN4BH3Hv1cvF5zB2i7L5eio40C6nitRb+Vq8uUxUO+Fg7ujqwWqjHP
         WWIq1D0cFa7iI1InFtbe6iAQn4FvelLR01gLb2YAKhyJ//8lVH3bdIxnu0+jFMLv3N2/
         PF27UNJdGw2sJbSNPmNofNSMkdo+3FpSvwu65EJ6MimgQSQyYOIKjeTsc1Gie5z6Ab4i
         5AxA==
X-Gm-Message-State: APt69E0zau/sTUMs/wRBD4L0uTHs88jioKFPZIA1yayAd5ICWO5pU2I/
        nNgyapVqyvEW4W/dq3EwPvm5BDFv
X-Google-Smtp-Source: AAOMgpc15KQyEpQDgWjQO9goEcRgI0LQYAG+Xhua9VcTr5kKJhF1gD0khEy4nH70hBoxQqqvqe6P5A==
X-Received: by 2002:a02:62ce:: with SMTP id d197-v6mr21975269jac.36.1530564232314;
        Mon, 02 Jul 2018 13:43:52 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id x7-v6sm6907612iob.49.2018.07.02.13.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 13:43:51 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:43:46 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Michael Scott <michael@opensourcefoundries.com>
Cc:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
Message-ID: <20180702204346.d7bynetvzw3ayn5m@x220t>
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
 <20180702185438.dqqjg6k45iefj5is@x220t>
 <516fbc65-cc4b-8016-de5a-e2240b779d15@opensourcefoundries.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <516fbc65-cc4b-8016-de5a-e2240b779d15@opensourcefoundries.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 02, 2018 at 12:45:41PM -0700, Michael Scott wrote:
> Hello Alexander,
> 
...
> > Question is for me: which upper layer wants access MAC header here on
> > receive path?
> > It cannot parsed anyhow because so far I know no upper layer can parse
> > at the moment 802.15.4 frames (which is a complex format). Maybe over
> > some header_ops callback?
> 
> I was testing a C program which performs NAT64 handling on packets
> destined to a certain IPv6 subnet (64:ff9b::). To do this, the application
> opens a RAW socket like this: sniff_sock = socket(PF_PACKET, SOCK_RAW,
> htons(ETH_P_ALL)); It then sets promiscuous mode and enters a looping call
> of:
> length = recv(sniff_sock, buffer, PACKET_BUFFER, MSG_TRUNC); My host PC
> kernel would then promptly crash on me. (I'm going to purposely avoid the
> obvious point of: this probably isn't the best way to parse packets for
> NAT64 translation as you will get every single packet incoming or outgoing
> on the host.) Turns out, testing the program on an 802.15.4 6lowpan
> interface exposed some of the issues which this mailing list (but not
> myself) is well aware of (no L2 data in the RAW packets) and also led me to
> debugging this patch to stop the kernel crash. TL;DR: To summarize, any
> PF_PACKET SOCK_RAW socket which recv()'s IPv6 data from a 6lowpan node will
> cause this kernel crash eventually (checked on kernel 4.15, 4.16, 4.17 and
> 4.18-rc1). - Mike
> > 

"any PF_PACKET SOCK_RAW" can't be otherwise I would also see it with my
sniffer programs e.g. wireshark or tcpdump which use libpcap.

There need to be some different in the handling. This is what I have
currently in my mind.

I currently not sure how to set skb->mac_header if interface is RAW_IP.
It seems there is an indicator that mac header is not set. Example:

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 6b1042e21656..e6ec2df3afe0 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
                hdr.hop_limit, &hdr.daddr);
 
        skb_push(skb, sizeof(hdr));
+       skb->mac_header = (typeof(skb->mac_header))~0U;
        skb_reset_network_header(skb);
        skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
 

Maybe we should lookup what skb->mac_header points to on tun interfaces
then do the same.

- Alex
