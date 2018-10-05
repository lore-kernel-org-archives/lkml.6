Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3DAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70055208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg4BLvr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70055208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeJEUvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:51:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41620 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:51:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so5113212pfi.8;
        Fri, 05 Oct 2018 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QXoq3UrZtfynLarfRQWJL6dhAj4DCwm8xnJG//V12xg=;
        b=Wg4BLvr0T8GqL9FrxOgPoJNyqXuMLo0vocueExOpEJ9I+HnfpRrRODE9Nxwle7dRbX
         aeZm8LGCts3IMf2ykGupjp3pe+Cp+haGpNObxU24zYqo8K8lC43hvZyAWEPszZP5l4V+
         RzJTbSDBdInJJOLwOUC3wEeR5DFWm+L0KvJg7qsWzw9byM66n1SvN/rFE3x1wTiFwdtb
         vVc3w+GYFAgaxFecpMuHJN24Qjrw/xcKxukdtIvbGRd5m6T5gNplGHxf/MYBdAee+wj8
         zlrQ+SVyHFvAj1p4h0X9ONIPdeXIANpIxPqInu9uotb0PfiQVzMJdSnROoBJuw1oQwOG
         pwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QXoq3UrZtfynLarfRQWJL6dhAj4DCwm8xnJG//V12xg=;
        b=p4rUPUGdsPHhRrw1afffF+Fav3jor9e725S9Xx0DT2NADgm8/2Iz43vTaI8SZp86R9
         EVK440jFgk2P2ucVEZ6QchDLyf9dXlHQuzJ4sxD190udzXJ8CClRHi/K59uFRw5JFHDL
         KztHlnV2Xw6/00O6ryLkQcjeS0dMmxndpe+2aej/ItMbJ0GGWTi0oKnhuNh2z0O096aT
         +oqmGbhydR42gsrwn4nST5C+BW204YTmS8CsXY5qOSZiJKs2dkXAkFzeiOoud/MtwKtd
         cFFxlmEXGSrR1DJWESwE05Ke1j7VqPfTj/fqucHVL47AO5zij8+pR8MkDnYaoGN6jFM2
         PCZA==
X-Gm-Message-State: ABuFfoiutmypoD9CRzTvWEoyvxJ2mt3MX2uxrXahB6ZWfUMJJ7wiHkSA
        b2aMB16Ga2wEkJOVS8/xC4lEdqsU
X-Google-Smtp-Source: ACcGV61mGJ0NGAjcFJ6PSIJP2Ftg9jappVHrFqu2Wc00z3Fwi/c+MS4dm+CZzvXQd8KD/id2OA81hQ==
X-Received: by 2002:a62:4586:: with SMTP id n6-v6mr11835877pfi.3.1538747539236;
        Fri, 05 Oct 2018 06:52:19 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id s80-v6sm11721115pfa.114.2018.10.05.06.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:52:18 -0700 (PDT)
Subject: Re: [PATCH net 2/2] rxrpc: Fix the data_ready handler
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk>
 <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <bf1d0734-d73a-83e9-c8e5-0fa4d447bc51@gmail.com>
Date:   Fri, 5 Oct 2018 06:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 06:43 AM, David Howells wrote:
> Fix the rxrpc_data_ready() function to pick up all packets and to not miss
> any.  There are two problems:
> 


> +	for (;;) {
> +		skb = skb_recv_udp(udp_sk, 0, 1, &ret);
> +		if (!skb) {
> +			if (ret == -EAGAIN)
> +				return;
> +
> +			/* If there was a transmission failure, we get an error
> +			 * here that we need to ignore.
> +			 */
> +			_debug("UDP socket error %d", ret);
> +			continue;
> +		}
> +
> +		rxrpc_new_skb(skb, rxrpc_skb_rx_received);
> +
> +		/* we'll probably need to checksum it (didn't call sock_recvmsg) */
> +		if (skb_checksum_complete(skb)) {
> +			rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
> +			__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INERRORS, 0);
> +			_debug("csum failed");
> +			continue;
> +		}
> +
> +		__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INDATAGRAMS, 0);
> +
> +		rxrpc_input_packet(udp_sk, skb);
> +	}
> +}


This looks a potential infinite loop to me ?

If not, please add a comment explaining why there is no apparent limit.



