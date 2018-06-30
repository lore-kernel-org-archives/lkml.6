Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A752C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB07526AEB
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVEkIxVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB07526AEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936890AbeF3Kwo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:52:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41555 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936205AbeF3Kwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:52:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so11047308wrq.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A09mRPxCI3TXO2gKLokIl5WDuEa2/30+gdvZII+W3gU=;
        b=TVEkIxVizAJZ/74YbPGiB7hWkS8pFeez+lgGlXbxuoNbF935JAxOt1TvKE1J30GSQn
         ORYk9osnPUy1LE5PmSx4zaD0GSj9rXXmW/d+5TdrKbMwkjVG8zkefLP8HevkWRnW6s/g
         Jo7dwS0Ig6aqVDaiZk7HAWtsjyskIvMlB6YAZ32vzel4Ii1s9o+R8XHfk1/npZ2C3x3W
         baXL6sgpy9IBUO0b+wNssmqrglKlPvv/CA1u5mtJ+TkAE637eiHgqVsn2v7vNe95e9z9
         Iot5AD9nK010rGLAruHU2PezfLW/JA5vcQtm7xFWbWLUzSa77ocW5jzCjw2uaLS1ASih
         gVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A09mRPxCI3TXO2gKLokIl5WDuEa2/30+gdvZII+W3gU=;
        b=Nx4gDLa0njW6eD29wmX9pK+qEU0n7FHnd2ybnGzh7nti5wAyBGkTsdZpKcVcLVn0kq
         gHnYmcpRdm9cJC1+SgJTiTxH3VhKyMI4YV1sYLOdA3YKqIE1mnlFOAVfJMppOhA4RrEm
         b/AgAjGvSN+8T9AQJnb/9awOtTreTtPY7Pf22ahYul3Cqn+whYfh322Wc1nkqguU4gyO
         LAdkcYKqODeF1/qqRWXAcqdjx24tTC+KLrIqkxZi3jwXFii4odWjIeqNaszmLOgRzoTb
         TWtnvjMAedVAUgLAxMM750nQdUxKVSMIJDnYydRU2B+3J6IjjJ9UfwVBn6dF9Z2O0NNW
         ykYw==
X-Gm-Message-State: APt69E3veUG6IQ4p1fgM2khuQJtG3AquhdSCwJgWka4H7oaCFLMyrifZ
        K3cVok9YwOKMW7Z9b+xQXRxwZdex
X-Google-Smtp-Source: AAOMgpdOjoWntQn6T8sPXFpseLlgzB/CL+sijY3Pw5y+rhQYZZRGaVClJ7+yuH4wkorv+nS3JypW2w==
X-Received: by 2002:adf:c4a7:: with SMTP id m36-v6mr14279466wrf.103.1530355961327;
        Sat, 30 Jun 2018 03:52:41 -0700 (PDT)
Received: from [192.168.1.4] (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2516405wmh.41.2018.06.30.03.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 03:52:40 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: fix comparsion to true/false and
 brace issues
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180630100252.572-1-straube.linux@gmail.com>
 <m2tvpkegdj.fsf@linux-m68k.org>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <f150191b-3458-75d0-e338-f609503b177a@gmail.com>
Date:   Sat, 30 Jun 2018 12:52:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <m2tvpkegdj.fsf@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/18 12:08, Andreas Schwab wrote:
> On Jun 30 2018, Michael Straube <straube.linux@gmail.com> wrote:
> 
>> @@ -115,11 +115,10 @@ s32 rtw_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter)
>>   
>>   void rtw_btcoex_SetManualControl(struct adapter *padapter, u8 manual)
>>   {
>> -	if (true == manual) {
>> +	if (manual)
>>   		hal_btcoex_SetManualControl(padapter, true);
>> -	} else{
>> +	else
>>   		hal_btcoex_SetManualControl(padapter, false);
>> -	}
> 
> aka. hal_btcoex_SetManualControl(padapter, manual);
> 
> Andreas.
> 

Ah, thanks!

Michael
