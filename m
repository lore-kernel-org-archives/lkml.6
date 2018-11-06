Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2490CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E965220869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E965220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbeKFWlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:41:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbeKFWlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:41:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DE04A78;
        Tue,  6 Nov 2018 05:16:27 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911503F5BD;
        Tue,  6 Nov 2018 05:16:25 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
To:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Stefan Agner <stefan@agner.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Roman Yeryomin <roman@advem.lv>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
 <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6a59717f-8ae8-54f7-b948-b145171c82c3@arm.com>
Date:   Tue, 6 Nov 2018 13:16:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 04:49, Nicolas Pitre wrote:
[...]
>> r3 and r5 are not used above, so no need to have them in the clobber
>> list.
> 
> They are used. ldrd and strd instructions always use a pair of
> consecutive registers. So "ldrd r2, ..." loads into r2-r3 and "ldrd r4, ..."
> loads into r4-r5.

FWIW, since we should now be enabling unified syntax everywhere, I guess 
we could probably rewrite all those ldrd/strd to the UAL 3-operand form 
- i.e. "ldrd r2, r3, [...]" - if we really cared for the extra clarity.

Robin.
