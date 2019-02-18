Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB37020838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jb71VZiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfBRNwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:03 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:48652 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbfBRNv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:59 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D374A10C1732;
        Mon, 18 Feb 2019 05:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550497918; bh=bx1EOQ94lWF49openRIpnt3uRY3WI1jWSJ5uiunmFUI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jb71VZiBEfigj/Kbi7mXAn7BQzWm7xmbGWJiLL2ykpE20SGVZZM2jZHdy/osYjrk7
         1F/Cyu2mU07/FzLvrqwHGpudgnsPIhpb41PD/k4x8gGpxs6Jj8NeKzEZ74esM4Fo0k
         vcmgrqsZcQqmiSdSDq4U6d8S37pLRdY+dFNSXm0n/pQnu3HDE6F63UgItZblIGcS/8
         s2sxqnVyG/D8b8nCu7MQTw2oiYyfyujpnG7KVHPEofDH6ZHCEHCIK47565slJnsjyf
         ++Qo3ANj5YyaY6BGQLULfATzmDaYF4uLWcU0yZ30w5zw1oo29C/Cf39D00W1fwvfbA
         jpMqM2iWpE7sA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 697A7A0086;
        Mon, 18 Feb 2019 13:51:58 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 05:51:57 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 14:51:55 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 14:51:55 +0100
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: dwxgmac2: Also use TBU
 interrupt to clean TX path
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <cover.1550479678.git.joabreu@synopsys.com>
 <b338784c2af1aba885b6822d2ec614774f1f78dd.1550479678.git.joabreu@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <677badce-d90b-82c5-0d11-88327d32a05b@synopsys.com>
Date:   Mon, 18 Feb 2019 13:51:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <b338784c2af1aba885b6822d2ec614774f1f78dd.1550479678.git.joabreu@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/2019 8:49 AM, Jose Abreu wrote:
>  #define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
> -					XGMAC_RIE | XGMAC_TIE)
> +					XGMAC_RIE | XGMAC_TBUE | XGMAC_TIE)

This is wrong and was a left-over from debug. Enabling this will
cause an high volume of interrupts which I just noticed.

We can only look at the status and not enable the int.

I will send v3 without this define change. Sorry.

Thanks,
Jose Miguel Abreu
