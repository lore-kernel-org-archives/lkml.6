Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C059ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E2F2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0du+S2yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E2F2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbeISVtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:49:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45292 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbeISVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjFNFLt7BYlowH5qa+05w09D+l6YWxTXkBW7qecxaqk=; b=0du+S2yTZq/Y0U/epW49OepByi
        RJtjcUyibrvAiS81lWj+no1UAECwGZQgN2ZV5oQ9DHTxBEyosIAvBvpJMvIQ476rYxA2cqexfhKHE
        30Snw53TbLiYR3+uIEl7+RNvi4MEO1y9QxI4rIQQZwjw9xBuz33r+IYcOTB5370nK6tm7DZMFV6R+
        T74x/2lU7q+xHO2rgr6EJMGQsDTYDa/k6CEOiose+liDPAPnnC0Tl3Tk8FYJXnpVtr30PsJDcBhcJ
        x6MgT+jjoev5CjEdw9b2LnenNCzrBlmAk1mjjvXLZuRhIaOCagE2LgpQXs9PrUokN5kv9PoXhCTYF
        4KOdufDA==;
Received: from 50-233-148-155-static.hfc.comcastbusiness.net ([50.233.148.155] helo=[10.18.6.178])
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2f3x-0003eJ-Ja; Wed, 19 Sep 2018 16:10:49 +0000
Subject: Re: [PATCH net-next] net: toshiba: fix return type of ndo_start_xmit
 function
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        kou.ishizaki@toshiba.co.jp, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20180919102339.13988-1-yuehaibing@huawei.com>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <44f9d0cf-e842-696a-2e49-e16643ea668e@infradead.org>
Date:   Wed, 19 Sep 2018 09:10:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919102339.13988-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue, 

On 09/19/2018 03:23 AM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I tested this against Linux-4.19-rc4, and it seemed to work OK.

Please remove the irrelevant line 'Found by coccinelle.' from the
commit message.  With that change:

  Acked-by: Geoff Levand <geoff@infradead.org>

-Geoff
