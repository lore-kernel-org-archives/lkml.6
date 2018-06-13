Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1AF1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97297208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9QadMAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97297208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeFMFrW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:47:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40192 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933696AbeFMFrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:47:20 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so1946450lfc.7;
        Tue, 12 Jun 2018 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wjisFhaJgLsvoiRk5nR3SaXLQ1GZ6+SMxsLjJdtLPpo=;
        b=d9QadMAPI51EIUQ8WiJwHdl1cC1//A17vU65XA7h/UIIAqlT8LdyfkM4cAasbuV1jF
         5EjlHDZQBPNe1Tev4ztmMRVdeiTwF5KZBBTfWuhZlUV2r8xsw1LdbN56Jq1+zJ+zZ/jS
         K+b72hfXYacEdno1Yeg1daaUGpoDCq7pe0lNRA5YqwkFMhpLyTqEoI+SAteJ6T0tc+WX
         XtRaUDp9Ylc2fYOcbn4Q3Ljfo9cXp3njey2DUQLVJRdXlhQd6yUrkhPFY0RnIKxMuuE+
         5iJvvb4TVgJbjnN7Wi8RmK+6wDr4AAXCW/gm+hMqkLJTlsZFMPsj5XwNMB+pYONtS/uD
         RAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wjisFhaJgLsvoiRk5nR3SaXLQ1GZ6+SMxsLjJdtLPpo=;
        b=WyNPO9cOjZmcItjema1IzZbZxeqmD4XkClTpwg14Nz/0/AgH7xOVRNFidXY4bB04AT
         J1+x3dPhOsfC5qtgVcEOHwqyrtfjuNjkgGxI4Gv71YsMZ3ywuWKg4MZh47Akxz7AljCN
         Gg9pZQFxJ3eVs+nuXeaHAEmqg+aew4f+jlKFs/NZR4U60s+vzQ3DXXcuTFevDzjvUBsm
         nklWNma/oar2klYrxdQopDPS2B84Kj30qIeDYMbV7dWqRn25A8W8oAwT4HYBylINWexr
         qn3++1L5CbGVjUxd1wPELhoNnpF/RJxCSOv6G5R0h5c2+2yTDHIKZpxtmBSHF0x2vxNc
         mBOQ==
X-Gm-Message-State: APt69E1m2d9Y55UEA6QCj9Wn/Cot4dTIInKQuuWb1b3+r8fw+yHm30xp
        vvhZPheCY/l2G+2dYp3up2I=
X-Google-Smtp-Source: ADUXVKITqTaCgSgs/dnXOCgUhJ6mkttoVOvqov95N9gWjzkxt/iKRG8RVFgrolLDEilB9+Wr0dxNDA==
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr695124ljh.78.1528868838926;
        Tue, 12 Jun 2018 22:47:18 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id o68-v6sm380969lfc.85.2018.06.12.22.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 22:47:18 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] Input: xen-kbdfront - allow better run-time
 configuration
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-4-andr2000@gmail.com> <20180612220722.GA38773@dtor-ws>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <f9354bee-3e44-eb93-05bc-58b8a9078b72@gmail.com>
Date:   Wed, 13 Jun 2018 08:47:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612220722.GA38773@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 01:07 AM, Dmitry Torokhov wrote:
> On Tue, Jun 12, 2018 at 10:48:56AM +0300, Oleksandr Andrushchenko wrote:
>>   
>> +	if (!(with_kbd | with_ptr | with_mtouch)) {
> I changed this to logical "OR" and applied, thank you.
Yes, that's better, thank you
>> +		ret = -ENXIO;
>> +		goto error;
>> +	}
>> +
>>   	ret = xenkbd_connect_backend(dev, info);
>>   	if (ret < 0)
>>   		goto error;
>> -- 
>> 2.17.1
>>

