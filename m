Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61170ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9A5214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvpwlODK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9A5214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeISIIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:08:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41289 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeISII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:08:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so1929766pfk.8;
        Tue, 18 Sep 2018 19:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QwN+RnceLvYA7JXwUchgq/S3E/qYuxyfp1nzPZNr01w=;
        b=OvpwlODKBLLXLs0Url/5cPDWL1nals/PmnGch5j3PAr5g0V7TsMl2odErlHyNW34iO
         Sw0dmRziv+bvrvlN8gS5XqTzTJiw1B7b0HRztHuiMhOaUyf3c21cGtdx4o/crxRUyLYQ
         nmSfgxGqzBQgIVdfEn+tQWGqC8p8jIhUQwd/yOtRuXFFWL+GOQFA37WtGIHZpS4PpqcU
         hEWEctH2rC9b3AQ04Nk6Y/RkgXDgZ5xwcZAQZTHY8FJ39j3Jo3abMFT1cgebGoM9Jsb6
         blaO+TsijU5+j5Kryy1iAd2Ifb85rfrovU2wPSc2VCsK2qqJsC51E1gKIADf/2tJRDUd
         /c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QwN+RnceLvYA7JXwUchgq/S3E/qYuxyfp1nzPZNr01w=;
        b=WlSeou0KgBDy3hPQmaqDAgzUrM9FJHQVyHUhsmBkc+7YygpIY+QCt8VkcZIur/3PQf
         pL4ILgRmX2OFXq1idjlJTrotUtrCNIy1aDJvecQtfGqZVOoQh2HeMkGNMpxEmjE+MY/M
         UcqCfLMIDiIsnEr5hVqH3hTF232YYZR3etbpRbFMqtuRN0G2QidIBpYbcq7xHFr6QqOr
         jRTOUTVjMlrlcD3RcaI4VEcYYCyA9e+2wcyHMj7Ik+vACinZSzqilJL2P1aV+bVRnuwL
         RH/rjRyyD0cUFuZ548LjqgGx4yyAspOtgXjlh6nONEIljbpOXsND0al8WNzZ3cX8h6/4
         7Qiw==
X-Gm-Message-State: APzg51B3/v7zOUIW3k7Tc+5FdSe9cSqER1Wtdjdl8AloFnUPQMyXHMVY
        HuJTs+xJ7W0i8tOi+zIj/Dc=
X-Google-Smtp-Source: ANB0Vda+MXj/n0raxsodVnEuP+k0BEvJB5hNR/i9/MqpylXCIFYQzsByV/5Nof9Jc96pJUGMqnCCDA==
X-Received: by 2002:a63:cb0f:: with SMTP id p15-v6mr30717805pgg.197.1537324375950;
        Tue, 18 Sep 2018 19:32:55 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id d12-v6sm25095564pfn.118.2018.09.18.19.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 19:32:55 -0700 (PDT)
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
To:     Florian Fainelli <f.fainelli@gmail.com>, ahs3@redhat.com,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isubramanian@apm.com" <isubramanian@apm.com>,
        "kchudgar@apm.com" <kchudgar@apm.com>,
        "qnguyen@apm.com" <qnguyen@apm.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
 <20180917.193531.1424852853827678152.davem@davemloft.net>
 <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
 <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
 <cdb8a00c-a3bf-72e0-38b2-3c4b2427270a@gmail.com>
 <c32598b4-3f80-f83f-9b86-1c168752d1e2@gmail.com>
 <29258606-8255-847c-b22f-8793999ce6fe@gmail.com>
 <0e0f3aa6-9b6e-edd5-226f-2e23de9b5a0f@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <95391269-73b7-933f-27ee-2c4a17c8c6b1@gmail.com>
Date:   Tue, 18 Sep 2018 19:32:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0e0f3aa6-9b6e-edd5-226f-2e23de9b5a0f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 05:03 PM, Florian Fainelli wrote:
> On 09/18/2018 04:56 PM, Eric Dumazet wrote:
>>
>>
>> On 09/18/2018 04:27 PM, Eric Dumazet wrote:
>>>
>>
>>> I remember one of the napi_complete_done() change had to be reverted,
>>> for some obscure reason.
>>
>>
>>
>> That was not exactly a revert,  :
> 
> This is what I have so far for the drivers that both use
> napi_complete_done() without checking the return value and implement a
> ndo_poll_controller() callback:
> 
> https://github.com/ffainelli/linux/commits/napi-check

In fact, there is still to explain what the bug is.

napi_complete_done() return value can be ignored, unless drivers
have to disable IRQ in their interrupt handler, using the following
construct :

	if (napi_schedule_prep(napi)) {
               .... disable interrupt ....
               __napi_schedule_irqoff(napi);
        }

                 

It _can_ be used by other drivers to not rearm interrupts needlessly.

The bug discussed in this thread (re-balance IRQ usage) is of the same kind than
the one fixed in commit d7aba644ffdebf756e51e26a2229055211838e89 ("amd-xgbe: Enable IRQs only if napi_complete_done() is true")

