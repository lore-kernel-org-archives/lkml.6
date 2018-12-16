Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7239FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323DF206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXC/bEqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeLPH74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 02:59:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33483 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeLPH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 02:59:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so9250173wrr.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 23:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hBzaKmkCqJ8LjtL6OJ5uWNvomxlE9VbuC1gJBa/goiw=;
        b=CXC/bEqc79w41KXydpRS5emLxrASSfUdva+c1lcrzsC8ljMc2GdaXfHhrs8nWm5Mhz
         czizWzf3Ymr2B380gQO/dCn7TRvxeL/sdEG8y42p+rcztLoCjHGWeLi8/MhiHqU6X1k5
         yNBUQUbDDGGYVCZ3myB+r72WYJygEyzGoSBtxD4jj9tNI+iuxw+V2yF6gr7aoxKBC0zw
         dKUGNIKmHBZv+hoaMfRkHQVylNchh1+Q2EUiQwruNakDANKJBLrdmBgXNnHeBOowmAch
         CPyw1pyEZXDEmooD7xJktJXmqqEek7PMV+cL8PqO1BemHdPR6FetX/itXZWdFcqKmKR7
         IsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hBzaKmkCqJ8LjtL6OJ5uWNvomxlE9VbuC1gJBa/goiw=;
        b=I1OpYRMu9Om3hEBOV9Tb9wpywvhs4EB+IE1BZhD6MjjxAAhZOklGHPC6wOEV8h+4nI
         jT+SU3afElSfc+nT9ufIi5VIr1G4296+42nebBqzgZo9MuOA+2p/ustkBBXVAqTgdMRm
         3H/VHUrK4Bgeg2QaVSkaXt09a2GZdSrmsfX/LorGsZ5VqCDqdCTqqi3yD2cTdLBNwF4T
         w9qILEwKOJhLTKAS8WaX4rM8KKWIARmTlIRB/U2FEPs94n9uwaizRr0dxxI0FpTeAeJw
         YW+4d1AGkYuhh3rww0h7NM5RFeuAET9tT/YdwQlc4LsGCybiANCQAUhP7xCg3PYo13ZE
         S4XA==
X-Gm-Message-State: AA+aEWZ6LYZaivcB24TSGFCSJJ6sWKVOwT1CWGCLtcwOEqzO6TNuSkzc
        iW+vpLN0HUFbNwi9UpF53FyNJAeA
X-Google-Smtp-Source: AFSGD/WEoBjweAA5IjXol+CX4k9/xpw1BT3NL4I8+FqECof6p34gvE+sHg2b8SP3GRkfI6NeOp1Eqw==
X-Received: by 2002:adf:e383:: with SMTP id e3mr7036090wrm.31.1544947193609;
        Sat, 15 Dec 2018 23:59:53 -0800 (PST)
Received: from ?IPv6:2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba? ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id z7sm7878598wrw.22.2018.12.15.23.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 23:59:53 -0800 (PST)
Subject: Re: [PATCH 1/9] staging: rtl8188eu: cleanup declarations in
 rtw_mlme_ext.c
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181215164616.2643-1-straube.linux@gmail.com>
 <2f878988b8b9fec09f3fae8e1ec5ddba89ebc6f7.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <fe241bc7-1547-b2ef-eae9-53326a3f5017@gmail.com>
Date:   Sun, 16 Dec 2018 08:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <2f878988b8b9fec09f3fae8e1ec5ddba89ebc6f7.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 5:53 PM, Joe Perches wrote:
> On Sat, 2018-12-15 at 17:46 +0100, Michael Straube wrote:
>> Replace tabs with spaces and/or remove spaces in declarations.
>> Remove unused/commented declarations, remove unnecessary comment,
>> remove blank lines between declarations and add missing lines after
>> declarations. Also clears some line over 80 characters checkpatch
>> warnings.
> []
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> []
>> @@ -22,14 +22,14 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
>>   /**************************************************
>>   OUI definitions for the vendor specific IE
>>   ***************************************************/
>> -unsigned char	RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
>> +unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
>>   unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
>> -unsigned char	WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
>> -unsigned char	P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
>> -unsigned char	WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
>> +unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
>> +unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
>> +unsigned char WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
>>   
>> -unsigned char	WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
>> -unsigned char	WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
>> +unsigned char WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
>> +unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
>>   
>>   unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
>>   unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
> 
> unrelated trivia:
> 
> Might be nice to make some or all of these const or
> even static const where appropriate.
>

Hi Joe,
I've done that in patch 4/9 of this series.

Michael
