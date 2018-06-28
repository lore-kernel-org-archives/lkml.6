Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF3C4314C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27E275AD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD27E275AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966774AbeF1PBV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:01:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:47019 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966385AbeF1PBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:01:19 -0400
Received: by mail-ed1-f50.google.com with SMTP id r17-v6so5365587edo.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/GoQlwvUgniSEQJxAdN1gQL3TALrFVFw1tzMpl/2/Ic=;
        b=W1CJqsTjH3LsIvynLl6YUagZmFdoNW1YsnAg63+YUTqAVq6VQ4MRLE3CqtcCgeoyl9
         uvXLEN3dCx10elWqR1rcVB5mDcpVCd+9tJzP+Ebobb2MZ5UtjKuMND9GBvTsh9guBJoU
         pvaoYF46Y3BO0AAO5DoaMNNJt/VqGjRyTGi+ypnkTNnCTDVrUzOzmxBthTsNBtLHjNDi
         YUDEnzJ6bvS3jSf7mQ1l0XUqaUSSxpECNwO0q97gDRQB989PgvPstLNYT4rhwJGRA9xt
         ZMyrfplrshgxSUQxeljwl9L8/hx170ymNmr5lO60W0L4q1/VSH9thwxXEOPhcxtcMvX3
         c2bA==
X-Gm-Message-State: APt69E1QxjYkisA+LZJElLg5BxO2DopAKYcg7o/+U01UM9fQ6qgyba0Y
        nO6V5hCCJdbKa/bzN//ARxVmSDy3ad0=
X-Google-Smtp-Source: AAOMgpcZzU1O6d2igxCrN0OrZauWQcsJjO0mSHTs8ljY8BuBtgG1HjsY1qeQXFXPGDDls41fmxVCBg==
X-Received: by 2002:a50:a446:: with SMTP id v6-v6mr2891872edb.237.1530198078384;
        Thu, 28 Jun 2018 08:01:18 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t20-v6sm2988671edd.93.2018.06.28.08.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:01:17 -0700 (PDT)
Subject: Re: staging: rtl8723bs: bug or pointless if else ?
To:     Michael Straube <straube.linux@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
 <9b1993c2-0b81-35cd-fe27-293f9e8f45c6@redhat.com>
 <b5f394c5f8395cd72ecdd5b6f9b2ff2d24253cf7.camel@hadess.net>
 <817fd3cd-bc10-fc63-f04f-6262230ee2f8@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db3a8adf-c617-af85-2ac8-10c109954393@redhat.com>
Date:   Thu, 28 Jun 2018 17:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <817fd3cd-bc10-fc63-f04f-6262230ee2f8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-06-18 17:00, Michael Straube wrote:
> On 06/28/18 11:34, Bastien Nocera wrote:
>> On Thu, 2018-06-28 at 10:22 +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 28-06-18 09:43, Michael Straube wrote:
>>>> Hi,
>>>>
>>>> I stumbled upon the following if else construct in
>>>> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:618
>>>>
>>>>           if (pwrpriv->bInternalAutoSuspend)
>>>>           {
>>>>                   ret = rtw_resume_process(padapter);
>>>>           }
>>>>           else
>>>>           {
>>>>                   if (pwrpriv->wowlan_mode || pwrpriv-
>>>>> wowlan_ap_mode)
>>>>                   {
>>>>                           ret = rtw_resume_process(padapter);
>>>>                   }
>>>>                   else
>>>>                   {
>>>>                           ret = rtw_resume_process(padapter);
>>>>                   }
>>>>           }
>>>>
>>>> It does not matter if the conditions are true or not,
>>>> ret is always set to:
>>>>
>>>> ret = rtw_resume_process(padapter)
>>>>
>>>> Is this a bug or is the if else construct just pointless?
>>>
>>> It probably is just pointless, my guess would be that once
>>> upon a time there was a difference in the paths and at some
>>> point that difference went away.
>>
>> Quite:
>> https://github.com/hadess/rtl8723bs/blob/7d36e26f78bbc709844c12ad0c62e3e8503fdbc5/os_dep/linux/sdio_intf.c#L1757
>>
> 
> So it can be safly removed?

Simplified to a single:

	ret = rtw_resume_process(padapter);

Yes that should be fine.

Regards,

Hans

