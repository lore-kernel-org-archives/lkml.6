Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AAEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23F22064D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lirhgy8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23F22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbeGKTX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:23:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:23:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so10028878wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Q9aiJ7zDAqE5hwpcixDRTaE5QLtNxXAZd6xwTTw+oI=;
        b=Lirhgy8FpafAIgYOfjMRpU+9iR6Aol9SqYKcE/ACJjJBI0HtVq61cDDBi8mT14MKF1
         Q9dniZULw01RPqO9N/asNUUFSMlmNhhDv9/usg6Mlxiu3xfmF2ifAufEbmXCaTrp1c3J
         hAn2jENXXgjSmsvg1/YE69a/Pw/V7AwOtIrS5y3zGielTPi+CIKijVL7M7fcgrcWUs5/
         5r16wdRD/lDM/WwMf6eoCdkjaNGGXT5aDnxXSjnO/szRjSvClYE8ab3hKkJthXZ5O1np
         NZ6L/zH6zvMJE2lOL8qI2C7+EbmUF/a1WBOunpfj8LP3/BA0H4EwmV2inNgt+6EpmmGo
         eLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Q9aiJ7zDAqE5hwpcixDRTaE5QLtNxXAZd6xwTTw+oI=;
        b=jt+6OtEhE05OnduBYR+dX7wzBFdXMCDLi55WJdPgmgH4b16CHvNArFPUg/0F2zU7Ro
         v2yIJ721DznS+MCgRbAauYGIv8ER4vTj6Nns5L8+OUQy+XVJDZpl6zTwj9ohiEpz8gjW
         0Vrvc4PQq3KUcH69WrOtDGPWwiOAns4XX2vdbQZOn+YW7LJJi05pKwt2WEWGezcrktYc
         Z8c7AOBbjOOuAphTXSQ88kBo+VbXUtVtrnZOXftQPAAAU0acf2dGjchUmJM4bFHcmubT
         q84VQTyB4u1Q1EGJWn0zz6IhweOvrFZqvPDU2aN8L5JM3RoYGEc/wAfZcg+IvpS5YWBt
         TDjw==
X-Gm-Message-State: APt69E0UJOekcJtszGjqcPD0KmJ3OumuNxHSsXPxYyBLJku2CdzhriNM
        38mCvzPRsxvDPg9xwgfw2Nf7P2Kp
X-Google-Smtp-Source: AAOMgpd4mWZZeCiFuy3t+DAZWdhT2OG5f7SZ7OFl221ICeGbRcmUF/xReLTEeDJA37t1DA6gPodGcw==
X-Received: by 2002:adf:fc86:: with SMTP id g6-v6mr17996568wrr.216.1531336664574;
        Wed, 11 Jul 2018 12:17:44 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:c02:3c30:6d6d:86b2? ([2a02:8108:85c0:57c8:c02:3c30:6d6d:86b2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1942114wmc.8.2018.07.11.12.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:17:44 -0700 (PDT)
Subject: Re: [PATCH 3/6] staging: rtl8723bs: fix indentation
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180708103855.12473-1-straube.linux@gmail.com>
 <20180708103855.12473-3-straube.linux@gmail.com>
 <194c5239a1ef9a1f472bad7c5bcc6e3b7675b0ec.camel@perches.com>
 <b7468cdd-1555-ef61-b475-3d4677aa423a@gmail.com>
 <005bbcfc-402d-db85-8f5a-1b64cfe6b612@gmail.com>
 <2ebdcea56cc0d8e5cff906c7991c74fc6b01ee76.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <37fbe6af-3496-0754-5c48-49f0e34941fe@gmail.com>
Date:   Wed, 11 Jul 2018 21:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2ebdcea56cc0d8e5cff906c7991c74fc6b01ee76.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 18:03, Joe Perches wrote:
> On Wed, 2018-07-11 at 15:57 +0200, Michael Straube wrote:
>> On 07/08/18 19:36, Michael Straube wrote:
>>> On 07/08/18 18:46, Joe Perches wrote:
>>>> On Sun, 2018-07-08 at 12:38 +0200, Michael Straube wrote:
>>>>
>>>> uint rtw_is_cckratesonly_included(u8 *rate)
>>>> {
>>>>      while (*rate) {
>>>>          u8 r = *rate & 0x7f;
>>>>
>>>>          if (r != 2 && r != 4 && r != 11 && r != 22)
>>>>              return false;
>>>>          rate++;
>>>>      }
>>>>
>>>>      return true;
>>>> }
>>>>
>>>
>>> The patch has been added to staging-testing already.
>>> I will send patches with your suggestions the next days.
>>
>> Would it be preferred to declare the variable at the functions beginning,
>> or doesn't it matter regarding coding style?
> 
> Not really.
> 
> It's generally preferred to have declarations in the
> nearest possible open brace to allow the compiler to
> reduce the overall stack space consumed by the function.
> 
> For example prefer:
> 
> int some_function(int arg, void *pointer)
> {
> 	if (arg == 1} {
> 		struct foo a = *(struct foo *)pointer;
> 		...
> 	} else if (arg == 2) {
> 		struct bar b = *(struct bar *)pointer;
> 		...
> 	}
> }
> 
> over
> 
> int some_function(int arg, void *pointer)
> {
> 	struct foo a;
> 	s
> truct bar b;
> 
> 	if (arg == 1} {
> 		a = *(struct foo *)pointer;
> 		...
> 	} else if (arg == 2) {
> 		b = *(struct bar *)pointer;
> 		...
> 	}
> }
> 
> as a and b could use the same stack in the
> first example but not the second.
> 

Ok, thanks for explaining.
Michael
