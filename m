Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C805C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BCA21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6XaFakR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BCA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJDPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:12:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJDPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:12:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so8844473wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kyEeTjaTExqJyJMJXTMGlCOUVx6p7HnXFrjwKusRlYE=;
        b=o6XaFakR7hDHTK7UVRkJmqmFUq3R5oTyFUnlawwO5hRilcNVxALnVT/0alVo8xaFMA
         9vxQCoFHAnZZKaG4htbVQHtDdjMfemkN8L2dPZlA8q6tVdQvzkLZB4yVfibqKzFYkNWg
         zN+dOc67t1HyIjxegvT68r99BIUP+yoQzI4ZUIv77/BPyL0FynoFbikYMTqi8771oOpX
         T2GN9eJA+DnvNKrpt5moqJwal2oeOmvCRLZhL3F+snEkzXeh4YV6dOH9SFTcM3qCiioz
         X/7HIjY9VyjWXzsHAUeeRNVNoXMJTxuc7+iHuJIEZ8JGBJ59jfKu4X1DHQn4YLh5/s52
         mJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kyEeTjaTExqJyJMJXTMGlCOUVx6p7HnXFrjwKusRlYE=;
        b=sVrzWtfpOOQpCEkT8T/4UHQwTg+jeCgj5fvVUPNT7+Mmw87+S4cIbHVhWJwGtilAHG
         /YT9LPcQZa/QZJhW8q3ntMtcuF3ZGrm6U5zvwpNJ1gkuA98BvxBk+21VfwY0s3jXM29w
         lNtYvTmg9da/mLvH0cHUJ/FyKT11gPy9ec/kI0HDdU67j6Y9j8D9fKGzev+EPVBF2EY7
         3c3M+L1fraIzHAQGJyducfBp1ElCRctJh5y+Df8zYeDAmWsz4NcWLMJql8x86aDAubzn
         //4qHGS45LFCYMlCZOq3E9K7SSfvokCP0+3ckGc0iLdqtoQBIifEQheAP4ZzxFGrnyIg
         lM7w==
X-Gm-Message-State: ABuFfohPtd9IfkOfN89GX/WCILZJ2dFbvkHHSosH6ch5YjFx8zyKQeqJ
        7fu0AVjMLX/4BX7suj/Ljv3Amkyy
X-Google-Smtp-Source: ACcGV63bP4spcyGEXda3HUZi/6z79JmEjz3mSd/QoEQupQSWJmpmvvkK2m2pZbbJWNcJLP4aGU5mzg==
X-Received: by 2002:a5d:4589:: with SMTP id p9-v6mr4022064wrq.122.1538641207226;
        Thu, 04 Oct 2018 01:20:07 -0700 (PDT)
Received: from [192.168.0.19] (ip1f12fd1c.dynamic.kabel-deutschland.de. [31.18.253.28])
        by smtp.gmail.com with ESMTPSA id z69-v6sm3732325wmz.18.2018.10.04.01.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:20:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: rtl8188eu: cleanup array declaration - style
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181003204359.30676-1-straube.linux@gmail.com>
 <20181003204359.30676-2-straube.linux@gmail.com>
 <223920513380c40710a833be02d86d8d6258cdab.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <87089eae-3cf2-8cea-b381-6e721b87ce94@gmail.com>
Date:   Thu, 4 Oct 2018 10:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <223920513380c40710a833be02d86d8d6258cdab.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 11:30 PM, Joe Perches wrote:
> On Wed, 2018-10-03 at 22:43 +0200, Michael Straube wrote:
>> Cleanup array declaration to clear two 'line over 80 characters'
>> checkpatch warnings and improve readability.
> []
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> []
>> @@ -3836,24 +3836,20 @@ Following are the initialization functions for WiFi MLME
>>   *****************************************************************************/
>>   
>>   static struct mlme_handler mlme_sta_tbl[] = {
>> -	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
>> -	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
>> -	{WIFI_REASSOCREQ,	"OnReAssocReq",	&OnAssocReq},
>> -	{WIFI_REASSOCRSP,	"OnReAssocRsp",	&OnAssocRsp},
>> -	{WIFI_PROBEREQ,		"OnProbeReq",	&OnProbeReq},
>> -	{WIFI_PROBERSP,		"OnProbeRsp",		&OnProbeRsp},
>> -
>> -	/*----------------------------------------------------------
>> -					below 2 are reserved
>> -	-----------------------------------------------------------*/
>> -	{0,					"DoReserved",		&DoReserved},
>> -	{0,					"DoReserved",		&DoReserved},
>> -	{WIFI_BEACON,		"OnBeacon",		&OnBeacon},
>> -	{WIFI_ATIM,			"OnATIM",		&OnAtim},
>> -	{WIFI_DISASSOC,		"OnDisassoc",		&OnDisassoc},
>> -	{WIFI_AUTH,			"OnAuth",		&OnAuthClient},
>> -	{WIFI_DEAUTH,		"OnDeAuth",		&OnDeAuth},
>> -	{WIFI_ACTION,		"OnAction",		&OnAction},
>> +	{WIFI_ASSOCREQ,	  "OnAssocReq",	  &OnAssocReq},
>> +	{WIFI_ASSOCRSP,	  "OnAssocRsp",	  &OnAssocRsp},
>> +	{WIFI_REASSOCREQ, "OnReAssocReq", &OnAssocReq},
>> +	{WIFI_REASSOCRSP, "OnReAssocRsp", &OnAssocRsp},
>> +	{WIFI_PROBEREQ,	  "OnProbeReq",	  &OnProbeReq},
>> +	{WIFI_PROBERSP,	  "OnProbeRsp",	  &OnProbeRsp},
>> +	{0,		  "DoReserved",	  &DoReserved},
>> +	{0,		  "DoReserved",	  &DoReserved},
>> +	{WIFI_BEACON,	  "OnBeacon",	  &OnBeacon},
>> +	{WIFI_ATIM,	  "OnATIM",	  &OnAtim},
>> +	{WIFI_DISASSOC,	  "OnDisassoc",	  &OnDisassoc},
>> +	{WIFI_AUTH,	  "OnAuth",	  &OnAuthClient},
>> +	{WIFI_DEAUTH,	  "OnDeAuth",	  &OnDeAuth},
>> +	{WIFI_ACTION,	  "OnAction",	  &OnAction},
>>   };
> 
> Perhaps const here too, and as well, the struct
> declaration could use const char * instead of char *
>

Just to be sure, it should be

static const struct mlme_handler mlme_sta_tbl[] = {

?
