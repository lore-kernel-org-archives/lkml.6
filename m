Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA766C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4221104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="WoMJG2+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C4221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=enneenne.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeKZVn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:43:59 -0500
Received: from smtpcmd02101.aruba.it ([62.149.158.101]:35946 "EHLO
        smtpcmd02101.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeKZVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:43:59 -0500
Received: from [192.168.1.9] ([93.146.66.165])
        by smtpcmd02.ad.aruba.it with bizsmtp
        id 4aj61z01a3Zw7e501aj7yx; Mon, 26 Nov 2018 11:43:08 +0100
Subject: Re: [PATCH -next] pps: using ERR_PTR instead of NULL while
 pps_register_source fails
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        richardcochran@gmail.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20181126102422.24028-1-yuehaibing@huawei.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <44edc27b-e679-24e8-aef1-fe5b7570f982@enneenne.com>
Date:   Mon, 26 Nov 2018 11:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126102422.24028-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1543228988; bh=MluToJhWCZX1nXl3wYU9v5bVHpn+Q0Lqn+8O9JqB60s=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=WoMJG2+t+5t20Vr8fdBEpN50FCGp8tlZk4FNWAyoLDu063xiZZwYmEvVA3fahCizA
         7zKQRy8oV01FNC9zdpa/GBzAn41tQkBT0yL7QWk1tNqkF+7G14z+M2xZjCmjUAkT89
         ZxSt93+eT+YIMXYpqNjZ/7YmXFwOoZOugrVBQPOcgnGtNKga5ymeriHu/0N9LEqDhL
         xRhI0IulLaCuI1gxPE5r0eTRzjDZhwxf3Ww0+1t2FTahuEtKwx0JQry80WndvQe9qE
         SRc84o3DmwAcsn6iWUDc3bakUAJfWx+su4eQd38D8eGiAcExmarYwRqPRKFtktfot7
         B2PfWhNDfSjww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 11:24, YueHaibing wrote:
> pps_register_source() has keeps error codes in a local variable,
> but it does not make use of the code. This patch let it return
> the errcode in case of failure.
> 
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>
