Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0954BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6040218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="BSp9/nVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBHVkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:40:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:40:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so7897155wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JtYsIJMBQi0vtP7DpovmthczfVtlb0mp9thjyJS3IU8=;
        b=BSp9/nVFDZQm/FJYXWLkjEHZA1U1CdQwjdKWyCRlt92UXgwAlpzzyMPwArrE2nW0ef
         GYMIQpIf0FAvnW3UOy/EwY98ViqUHwuo+hRq3kKjyvhWo497KwzliWpn9wRTeGSFC/el
         NxYjugSRZDUd2WINXf8H93PAvzAD68QqbtrhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtYsIJMBQi0vtP7DpovmthczfVtlb0mp9thjyJS3IU8=;
        b=EYxco+CFHepFLLjg2UF2W1If4mmA+wCtxX63jMNfA0+EtXq3wBM08kHVuWOtc4B+7d
         E3PfVF2oDIG+9zkC+SWS++45Y2IdEf2YZbriqd9738Bn1nh/TOPemjqPxzIffKEDrLc+
         WlKVVSQIqFMGiS+C6UA+I5C+AZjkMMqky9sOoxeezZTIBjwVoHBhIDTw70OttdNEXntg
         SP4qZjLv0vjSD/kDuUJhEHVCHjtPy2FyKpsViDv4kTY+QLf01jR3ReUrpEr5XVnc19kL
         Rb4UKrwGAMiqq5+7mpIyA/u13r4O/E5JMW0jgkpCAm1fJ1tdVJLzJAf8bLVl2/SyOMaV
         rPfg==
X-Gm-Message-State: AHQUAuYStKmUrIOFpUfAgWG+BuJRdEQBeB7icH5Rgl9o8+OA4IfiZ8rI
        5aelGvB9hsRUSnQAM10pSgvUS1xxnIc6yQ==
X-Google-Smtp-Source: AHgI3IaIxUWHMrF/NHwOSeNQkRW2jM/xh/HeKDbQbr9D1xGsmZExM1CuLgcPRcJlVQHSru9EUBjF+w==
X-Received: by 2002:adf:deca:: with SMTP id i10mr4243579wrn.312.1549662038024;
        Fri, 08 Feb 2019 13:40:38 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id v6sm6297728wrd.88.2019.02.08.13.40.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 13:40:37 -0800 (PST)
Subject: Re: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     nicolas.dichtel@6wind.com,
        Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190208041103.31299-1-callum.sinclair@alliedtelesis.co.nz>
 <20190208041103.31299-2-callum.sinclair@alliedtelesis.co.nz>
 <be9e655b-6911-c644-de63-9aabcd131763@6wind.com>
 <5597e8bc-c23e-1f59-0442-260a7b4ca83d@cumulusnetworks.com>
 <31a5155c-ce6e-4c0f-61c0-35a5472549aa@6wind.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <31565295-16d2-89b5-0e35-8852c49345ec@cumulusnetworks.com>
Date:   Fri, 8 Feb 2019 23:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <31a5155c-ce6e-4c0f-61c0-35a5472549aa@6wind.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2019 17:08, Nicolas Dichtel wrote:
> Le 08/02/2019 à 15:43, Nikolay Aleksandrov a écrit :
>> On 08/02/2019 16:18, Nicolas Dichtel wrote:
>>> Le 08/02/2019 à 05:11, Callum Sinclair a écrit :
>>>> Currently the only way to clear the mfc cache was to delete the entries
>>> mfc stands for 'multicast forwarding cache', so 'mfc cache' is a bit strange.
>>>
>>>> one by one using the MRT_DEL_MFC socket option or to destroy and
>>>> recreate the socket.
>>> Note that if entries were added with MRT_ADD_MFC_PROXY, they will survive to the
>>> socket destruction. This is not the case with your new cmd. Is it intended?
>>
>> I think you're referring to MFC_STATIC entries (sk != mroute_sk). It
>> doesn't matter how you add an entry - they all get cleaned up if added
>> through the mroute socket.
> Yes, right.
> MRT_FLUSH_MFC_STATIC ?
> 

Sounds good to me.

