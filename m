Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02269C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E02218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E02218E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeHNKOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:14:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41105 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbeHNKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:14:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so9566936edr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 00:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0O0KXJw2IMJ+2ctcPbDQcW5M1yERQS1qRVbvmA1tbc=;
        b=iTUbvK77veesG6bPaftd12CI0uiAs577S2aZ1sYKOjA+3sEcMNJ46B4U00XSLh1s/k
         /9yYeUp/4or8O338ei7hqgtqZ4xkRc6jUu4drVn/4S93OQfdXTWousH7OG4t5+vU9r2U
         3a1TmEmKmYu494ITQSZc/qixwOcupHooPF32SJ+1XNL/7lvTguvkUEROXUBnVy8pdpNh
         7mp2jxEVwoU3VrvFFDNgsti9/YOGl1gWuMbw7QLLvbU4yWHza2J+T5mEKL09TLXc1GKv
         rH22eh9N2XauttFALrIJ3VggBsaz+CL+tdXqmQX0nnIqTHbD1C1G4XUsUgECh5DvIEJV
         DWUg==
X-Gm-Message-State: AOUpUlFOuugP7VZbu3jj1b2jVPIED5xTQndx3tyXebiAkCfvYlYY8tfQ
        mLUDYjZk23HfjWHOraPiP+NKx84xdXk=
X-Google-Smtp-Source: AA+uWPzfC+TKRs6U5sHTwaPFuiYqrbPcgK5T8Z6MIv4QX4b0a9q8+PLfZtZMdHsLI4ACI4/SuMW4Sg==
X-Received: by 2002:a50:a207:: with SMTP id 7-v6mr25927579edl.48.1534231707080;
        Tue, 14 Aug 2018 00:28:27 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w3-v6sm15618760edb.16.2018.08.14.00.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 00:28:26 -0700 (PDT)
Subject: Re: [PATCH] Use default .cfg file name for RTL8723BS devices with id
 of OBDA8723
To:     Ian W MORRISON <ianwmorrison@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180814064742.14519-1-ianwmorrison@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <29a87a37-6dda-62c2-01b1-d4a806e19cf2@redhat.com>
Date:   Tue, 14 Aug 2018 09:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180814064742.14519-1-ianwmorrison@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-08-18 08:47, Ian W MORRISON wrote:
> For RTL8723BS devices the current config file name is a composite of
> both the config name (rtl8723bs) and a postfix of the device-id.
> 
> Given the majority of RTL8723BS devices use a device-id of OBDA8723
> this simplifies the config file name to use "rtl8723bs_config.bin"
> as a default of for these devices.

NACK, the device id is in there for a reason, once someone writes
support for it we will also need a rtl8723bs_config file on ARM
boards, which will definitely be board specific. I don't want us
to pretend there is one config to rule them all.

Specifically I plan to submit both the firmware and
rtl8723bs_config-OBDA8723.bin to linux-firmware soon, if the kernel
instead looks for just rtl8723bs_config.bin then I need to give
it that name in linux-firmware and then when we get ARM support
and the kernel complains about e.g. rtl8723bs_config-NextThingCo-CHIP.bin
not being there people may be tempted to think they can just link
to the "generic" one from linux-firmware which then turns out
to not be generic at all.

Regards,

Hans



> 
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
>   drivers/bluetooth/hci_h5.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..cce422dc1b8d 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -852,7 +852,9 @@ static int h5_btrtl_setup(struct h5 *h5)
>   	bool flow_control;
>   	int err;
>   
> -	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
> +	btrtl_dev = strcmp("OBDA8723", h5->id) ?
> +		btrtl_initialize(h5->hu->hdev, h5->id) :
> +			btrtl_initialize(h5->hu->hdev, NULL);
>   	if (IS_ERR(btrtl_dev))
>   		return PTR_ERR(btrtl_dev);
>   
> 
