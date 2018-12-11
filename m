Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A7CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB292082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB292082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLKI1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:27:08 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:55531 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLKI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:27:06 -0500
Received: from localhost.localdomain (unknown [88.128.80.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id CFBA4C8C29;
        Tue, 11 Dec 2018 09:27:00 +0100 (CET)
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow in
 ca8210_rx_done
To:     David Miller <davem@davemloft.net>, yuehaibing@huawei.com
Cc:     h.morris@cascoda.com, alex.aring@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wpan@vger.kernel.org
References: <20181211031339.21048-1-yuehaibing@huawei.com>
 <20181210.220107.751606140724107779.davem@davemloft.net>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <87dbac94-8b2e-8cef-5166-8c130529ceb9@datenfreihafen.org>
Date:   Tue, 11 Dec 2018 09:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210.220107.751606140724107779.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave.

On 11.12.18 07:01, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Tue, 11 Dec 2018 11:13:39 +0800
> 
>> gcc warning this:
>>
>> drivers/net/ieee802154/ca8210.c:730:10: warning:
>>  comparison is always false due to limited range of data type [-Wtype-limits]
>>
>> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
>> This patch change the type of 'len' to unsigned int to avoid this,also fix
>> the gcc warning.
>>
>> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> WPAN maintainers, I am assuming that as maintainers you will be
> picking this up and sending it to me.

That's correct. On driver patches I always wait 2 days or so to give the
driver maintainer a chance to reply before I go ahead and apply it.

I will take this one directly now and do some smoke testing. It will
come together with another fix as pull request to you.

regards
Stefan Schmidt
