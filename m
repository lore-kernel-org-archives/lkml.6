Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5224C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="G9HYU1bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5224C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJJUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:14:13 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.133]:34314 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539175929;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=07ulyTaEaQlHkUAgeDrjGoj35LT6E0ZFgSl2eMpX+NM=;
        b=G9HYU1bpzo3FVkyYIHzlHgBl+5o5E8DYe+pasC9IeCkTTtBxF9TB7otxiBHBuu10Vg
        DhRav+rURGB1FgVle36u24bECadE9O1HQRTuNw4p7pA2wiiH4TvXwSSJqroe993HuDOl
        RlzR26XVCMvwgC9o7rBffOYUzxFSEQt5NnGPIUfLfec7Ykdy+mQnXd5eS2395Nzq+A+y
        jHpkGe2lNZHHbMopAnrVfS5UmA9POFn5KCdUS7HrFIKybgtHCLk/dyGVa23RVOCsslw5
        WWoLOTHsSxjA8zXKHN3RmRmcp8gS8GiJNRRJkfuLKENoSiMc6/6BFxCQ5eWAMyIEUzfg
        ccYA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PDYctbdJxUgkU9YahDqu4JTve1szJ/gUJ8jYldl"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:2487:8500:c9b1:3000:9001:1322]
        by smtp.strato.de (RZmta 44.2 AUTH)
        with ESMTPSA id h039efu9ACq7Pcy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 10 Oct 2018 14:52:07 +0200 (CEST)
Subject: Re: [RFC] usb: chipidea: Add minimal support for HSIC interface on
 i.MX6QDL
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1539005352-10909-1-git-send-email-frieder.schrempf@exceet.de>
 <VI1PR04MB5327D0F4AA27C5AED5C535388BE70@VI1PR04MB5327.eurprd04.prod.outlook.com>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <e13ac59e-6698-8ef2-685e-75cd5ed35d98@exceet.de>
Date:   Wed, 10 Oct 2018 14:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5327D0F4AA27C5AED5C535388BE70@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 09.10.2018 03:24, Peter Chen wrote:
>   
>>
>> The topic has been discussed before: [1] And there is some implementation in the
>> vendor kernel: [2]
>>
>> It seems like two things need to be done:
>>
>> 1. Switch the pinmux of the strobe signal to use a pullup after
>>     the core has been initialized.
>> 2. Enable HSIC mode and HSIC clock
>>
>> This patch only implements these basics in a minimal approach.
>> You need to have an additional pinmux setting "active" in the dt, that sets the pullup.
>>
>> It was tested with the SMSC LAN9730 USB Ethernet adapter on the iMXceet Solo S
>> board.
>>
> 
> Thanks, I should do it earlier, I could not find a suitable board with HSIC support at mainline kernel.
> It is very kind that you could help on it and test function at real board. My suggestion is
> follow all flows in Link [2] since we need to cover suspend/resume and remote wakeup.

It seems like power management and other things in the linux-imx kernel 
are not fully implemented in mainline so there are quite a few differences.

My knowledge of USB, etc. is very limited, so I guess this is currently 
beyond my skills. Can you or someone else provide a patch to get 
started? I could help with testing, reviewing, etc.

Or maybe you can point out what needs to be done in more detail?

Thanks,
Frieder
