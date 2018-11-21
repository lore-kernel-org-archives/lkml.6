Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8D9C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E000E2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E000E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeKULVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:21:39 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:44470 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725926AbeKULVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:21:38 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wAL0mNVQ097116;
        Wed, 21 Nov 2018 08:48:23 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 21 Nov 2018
 08:49:06 +0800
Date:   Wed, 21 Nov 2018 08:49:03 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     David Miller <davem@davemloft.net>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: faraday: ftmac100: remove netif_running(netdev)
 check before disabling interrupts
Message-ID: <20181121004903.GA28845@andestech.com>
References: <1542692266-17720-1-git-send-email-vincentc@andestech.com>
 <20181120.102843.2033247081781930217.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181120.102843.2033247081781930217.davem@davemloft.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wAL0mNVQ097116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:28:43AM +0800, David Miller wrote:
> aFrom: Vincent Chen <vincentc@andestech.com>
> Date: Tue, 20 Nov 2018 13:37:46 +0800
> 
> > +	/* Disable interrupts for polling */
> > +	ftmac100_disable_all_int(priv);
> >  	if (likely(netif_running(netdev))) {
> > -		/* Disable interrupts for polling */
> > -		ftmac100_disable_all_int(priv);
> >  		napi_schedule(&priv->napi);
> >  	}
> 
> This is now a single-line basic block, so please remove the curly
> braces.
> 
> Thank you.

OK. I will remove it.
Thank you.
