Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1349C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B19C2086E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="nub6WkYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B19C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeGCNtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:49:04 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43464 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbeGCNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:49:00 -0400
Received: by mail-io0-f193.google.com with SMTP id i23-v6so1758545iog.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ky8+0m0Ddzop6PJnmQWI1RlpXv/BNFjbautD21r8vP4=;
        b=nub6WkYmdna+z1t+NUSUrLS/KQ/L4qV6kADV7+pe9l81wUX4aEH6uVDSRUV5BzhGV/
         DlaZoqaBYw0Tl0T0DvOIRsfuSatkbBNlrry5aYzNI7M1wBXmGIHwzX0OiLQdTAMf4TQu
         UTb6yLxowmX0WIrsUcFvfqgkx6NGKTGKxVsvkkOqDM9xeOZWen1CQnVij7SaPTxxXU0o
         Zd6Pnw2MjYPiCQ+ykDVtPfEw2oxE40YHOeugn/SYyOmIKCfZXxDO+BubCGp+ftxfhhKS
         qd3l7GV2VTX5OShD9xRmLT5Yp1C/18rD+xTaCjdXTfBAfnVSMS4gMXd8zMwEtl9biwqI
         1SJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ky8+0m0Ddzop6PJnmQWI1RlpXv/BNFjbautD21r8vP4=;
        b=r+93D7ZhqQRXJcxtDnhSJLWPoWbiFArcK7AcjIjrhwsBIK8nb8fhiLR9A6ETONl5HP
         JDkD+OiNxT5Oae2lcxwdTKXX2sgq7Oi/CiLLS5FmknQ4ZiMev1vtoSxbSUUkur03t3D8
         EahPOgSSCyn+L8LV8PN5mOjUks79MouRXyFVEEnBPSsDKXQoQBuz+9wwtOcLVuJ3fgbY
         oEqdFzxFIalMx17z9Hvga/49h7yDgQoLmxjt3RWiqpU6Ci95ZjNL8/aOREAJ/2/xPlGG
         fZ5rDwsWJrmcvmhGwir1/3mU7aree88gzWta4bv/mC6t7bni84+ZEzxuZvELNWnmew5I
         z0kg==
X-Gm-Message-State: APt69E0W4JedL4wIqkvabh4dsBCbv993Ji5F9nVSMFYoDEujYbeRL8kW
        ApwfJLMtsf7jl94fAEpk5qS/cw==
X-Google-Smtp-Source: AAOMgpeCxlWv3/qvuFha/bPoXs9reJdpHx8WnurPE2g35chTHwIIvBCt2vMVXwnEQF2C92cfvQSYag==
X-Received: by 2002:a6b:bc83:: with SMTP id m125-v6mr25128659iof.80.1530625740130;
        Tue, 03 Jul 2018 06:49:00 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id g17-v6sm563167iti.1.2018.07.03.06.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 06:48:59 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:48:57 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Michael Scott <michael@opensourcefoundries.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
Message-ID: <20180703134857.aauhsrbrbtiwyj7f@x220t>
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

Acked-by: Alexander Aring <aring@mojatatu.com>

Thanks!

- Alex
