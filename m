Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA17C4314A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BB7275AF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7xx92J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BB7275AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966714AbeF1PAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:00:24 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39978 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966385AbeF1PAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:00:21 -0400
Received: by mail-wr0-f178.google.com with SMTP id l2-v6so5273795wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0LG6xvXg9cEkn7XwWP/pGVk6jdOgbBRmNx6SaJvi1C8=;
        b=q7xx92J2Nlz3cdzTxNwqaY7u8yeu0DOCxmV/mINTZubSHwYbmQUxvZPdJt+XXWvAq2
         m4hGs78pa+K5FZpCS6ffL3RF6OZICHlE9pnFMGbExMYAgxWDt81opCnsSp5cddH5fBHV
         u6AmV+RyPieDhjrodj8QqUsZhct2L959vik5XTB3vRQ6U+Sh3u32GYR1GDSdGZHkN644
         /iLUQpvXgO9XKrMCU4jI5QjyLtNSpdp3FHsd4rrQXGtBCHZT/4nZcU6FtLZgj81qE9b1
         VhSnjghCV5GbGhGXq3Xzpp9H50dCy2lBzQlAcizmZY1lg+5oVXGlqKT8ufENiRIcQmjp
         pmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0LG6xvXg9cEkn7XwWP/pGVk6jdOgbBRmNx6SaJvi1C8=;
        b=WKw4rLfeJML8+FwUMzE5slw7Ik0B7dgO7q+K88t8sQ9Xzf/FcaZoEib5Z/cxxhaIt+
         AbX87Hb/IZFx7Pa6jYdx/IuvSbOZq+LIgHQ9fJ//crgiucXlV8L8URqCg2sG/rKAdfmF
         X8UYiqN86sulWB4dG43Ky+LkrBlO+MCQAzPLdh446cVahHVGOywbXWG25PtJTsaSeNIQ
         JzISEZTJd9SyFoB/DE7zGT8NJ6aoFqKNH/eGMjP+94OcVJKq+xmMh938cNNMYNPmT11O
         UW4fDH3bKr7GT2zVxuQ6ZoQhmc5kFagjntf2OUssEnAzBOPFqcZ3xW4lvRcj1ZnXLLlU
         T98w==
X-Gm-Message-State: APt69E0/JbecJMRLIpzvBeoQC1fAbQrjzGwbG/EYaDhr6J0qjJTPBeYK
        lR2nZi0I5KX6e+9tfi1Akka8GEIE
X-Google-Smtp-Source: AAOMgpcb5HP0ScHErx4C2szeN4f96GAc0VN21VOYF0dxPRUwVR0koGE6myMaqRLUIdNdEZTuLRDrCA==
X-Received: by 2002:adf:c5d2:: with SMTP id v18-v6mr8830055wrg.151.1530198020286;
        Thu, 28 Jun 2018 08:00:20 -0700 (PDT)
Received: from [192.168.1.4] (x4db2000a.dyn.telefonica.de. [77.178.0.10])
        by smtp.gmail.com with ESMTPSA id m3-v6sm3776213wrs.39.2018.06.28.08.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:00:19 -0700 (PDT)
Subject: Re: staging: rtl8723bs: bug or pointless if else ?
To:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
 <9b1993c2-0b81-35cd-fe27-293f9e8f45c6@redhat.com>
 <b5f394c5f8395cd72ecdd5b6f9b2ff2d24253cf7.camel@hadess.net>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <817fd3cd-bc10-fc63-f04f-6262230ee2f8@gmail.com>
Date:   Thu, 28 Jun 2018 17:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b5f394c5f8395cd72ecdd5b6f9b2ff2d24253cf7.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/18 11:34, Bastien Nocera wrote:
> On Thu, 2018-06-28 at 10:22 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 28-06-18 09:43, Michael Straube wrote:
>>> Hi,
>>>
>>> I stumbled upon the following if else construct in
>>> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:618
>>>
>>>           if (pwrpriv->bInternalAutoSuspend)
>>>           {
>>>                   ret = rtw_resume_process(padapter);
>>>           }
>>>           else
>>>           {
>>>                   if (pwrpriv->wowlan_mode || pwrpriv-
>>>> wowlan_ap_mode)
>>>                   {
>>>                           ret = rtw_resume_process(padapter);
>>>                   }
>>>                   else
>>>                   {
>>>                           ret = rtw_resume_process(padapter);
>>>                   }
>>>           }
>>>
>>> It does not matter if the conditions are true or not,
>>> ret is always set to:
>>>
>>> ret = rtw_resume_process(padapter)
>>>
>>> Is this a bug or is the if else construct just pointless?
>>
>> It probably is just pointless, my guess would be that once
>> upon a time there was a difference in the paths and at some
>> point that difference went away.
> 
> Quite:
> https://github.com/hadess/rtl8723bs/blob/7d36e26f78bbc709844c12ad0c62e3e8503fdbc5/os_dep/linux/sdio_intf.c#L1757
> 

So it can be safly removed?
