Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0277ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819C420881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819C420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeGXKzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:55:09 -0400
Received: from mail.tricorecenter.de ([217.6.246.34]:46092 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeGXKzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:55:08 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2018 06:55:08 EDT
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by root.phytec.de (Postfix) with ESMTP id B2EF8A00266;
        Tue, 24 Jul 2018 11:40:15 +0200 (CEST)
Received: from [172.16.26.80] ([172.16.26.80])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2018072411395168-673669 ;
          Tue, 24 Jul 2018 11:39:51 +0200 
Subject: Re: [PATCH v5 1/2] mfd: rk808: Refactor shutdown functions
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        linux-rockchip@lists.infradead.org
Cc:     zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, linux-kernel@vger.kernel.org
References: <1522335000-23057-1-git-send-email-d.schultz@phytec.de>
 <20180416093821.sqrcc6mmnc23njul@dell>
From:   Wadim Egorov <w.egorov@phytec.de>
Message-ID: <ac1420fa-7916-813e-a4ef-b7ea403e275b@phytec.de>
Date:   Tue, 24 Jul 2018 11:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180416093821.sqrcc6mmnc23njul@dell>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.07.2018 11:39:51,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.07.2018 11:39:51,
        Serialize complete at 24.07.2018 11:39:51
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 16.04.2018 um 11:38 schrieb Lee Jones:
> On Thu, 29 Mar 2018, Daniel Schultz wrote:
>
>> Since all three shutdown functions have almost the same code, all logic
>> from the shutdown functions can be refactored to a new function
>> "rk808_update_bits", which can update a register by a given address and
>> bitmask.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>> Changes:
>> 	v2: Re-submit with recipients from Rockchip.
>> 	v3: - Added devicetree property to enable the PMIC reset seperate from 
>> 	      "rockchip,system-power-controller".
>> 	    - Dropped the first patch of this serie.
>> 	v4: Splitted refactoring and the new reset feature.
>> 	v5: Removed null pointer from rk808_update_bits.
>>
>>  drivers/mfd/rk808.c | 46 +++++++++++++---------------------------------
>>  1 file changed, 13 insertions(+), 33 deletions(-)
> I'd still like an Ack/Review from the Rockchip guys please.
>
can someone from Rockchip reply to this?
