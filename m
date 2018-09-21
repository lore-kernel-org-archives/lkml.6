Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770EECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AE621550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDF8Nzuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AE621550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbeIUSot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:44:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeIUSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:44:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so5950965pfi.7;
        Fri, 21 Sep 2018 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LcOrfYHwa/XB0eF8eJP9V7AjghAkV4G5JwefwQQzoq0=;
        b=hDF8NzuoApiVo3oAPpVaXaLob3ZlXQZTfJvbhGpzGhq0jDOgdtjs0VQWBdVFcN/oaS
         Ls/5iHVeohW6XoQFe/Foe/xz9AvHPQQHF7mIzXY2ArZLmoGrDFJhfWxhBj2dobc6Dgdb
         WSobJVUmTfQ18zd3DGrdmGiCd0D6NtCTLDfvo+nUcFEkymg01hqkt7Fu4CO/pzM6qtvm
         DiYkuCM+i3ltprUrA4db7s54jET4qPKCzfkcehbmA0Gs5bAK9Z87S6qsB2HMBgN2LKXi
         tBzl+jrF7LSxQNWwMA2mpivEPLgJyYg19/DkhmCC9G3HulKw/NNDBsZ50sMn2Wml6r9s
         nI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LcOrfYHwa/XB0eF8eJP9V7AjghAkV4G5JwefwQQzoq0=;
        b=tFd/H6Yc3pWf2EJvKX6QX79pNekOOPJkULR+jHbUn9YdnpKsCRkBq2l7xcTVZ2U/eG
         ocWwFue3bOQ4jwGsdMtHBdCbipK3joVPUpjhTJMO6bHB/rWxh/3N0wSIJ96XABm/n5CU
         KZs/o9IbF9oDpvi/dYUa3jOk39Cm8GDtYpmGF5ney7cFOxjn5EOchCcbU+Yrc7RDorlB
         2t8xHZoUG9uzSiXCSjONQgb901jXwXQzwmnzfGq0D9H/wZmGfp6N8ruU9dyqrftfwRTc
         dhUp6dv6HCn3L3kP0UlbKBzYb6Tnp/XN8TKW4tu29nmehQosUM5akTLrJLRoCZMC+RHB
         CrQg==
X-Gm-Message-State: APzg51CXcC4LRITN9sz8P4unwvXGd435C+ZKSLlCe1vxCTJunYinSGFG
        IsRJut5Mag9ern8mr9el7nHFjgi8
X-Google-Smtp-Source: ANB0VdaSZP8wPhxjLBatdmeaRR0jZ9uGJSUMGczqCMP5GvewRsd3TpJscYfLZ9Qb3X3vUDZaHt0Izw==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr46513836pfo.151.1537534562837;
        Fri, 21 Sep 2018 05:56:02 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 1-v6sm45828055pfk.134.2018.09.21.05.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 05:56:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: ina3221: Get channel names from DT node
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-3-nicoleotsuka@gmail.com>
 <21a6e8f3-c95d-43d0-ca3f-3f91ddfeff07@roeck-us.net>
 <20180921012038.GA23354@Asurada-Nvidia.nvidia.com>
 <20180921091813.GA21564@Asurada-Nvidia.nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <75741ce9-80a3-9277-b8e3-2d3c3e003797@roeck-us.net>
Date:   Fri, 21 Sep 2018 05:56:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921091813.GA21564@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/2018 02:18 AM, Nicolin Chen wrote:
> Hi,
> 
> On Thu, Sep 20, 2018 at 06:20:38PM -0700, Nicolin Chen wrote:
>>> So if there are no devicetree entries, the user now gets a sequence of
>>> "unknown" sensors ? I don't think so. Please keep in mind that there are
>>> users of this chip who don't have devicetree systems, and other users
>>> may not want to specify any specific name properties (or they use sensors3.conf
>>> to do it).
>>
>> Being enlightened by your comments below, maybe adding a
>> separate group for channel names by attaching is_visible
>> to it could be acceptable? Then, name nodes can hide from
>> those who don't want to specify.
>   
>>>> +		/* Log connected channels */
>>>> +		ina->attr_group[g++] = &ina3221_group[i];
>>>> +		ina->channel_name[i] = str;
>>>> +		ina->enable[i] = true;
>>>
>>> I also don't see the need for defining the group dynamically. The
>>> is_visible callback is very well suited for handling optional sysfs
>>> attributes.
> 
> I tried is_visible but it looks like it won't be that neat to
> implement as some attributes of this driver don't really pass
> the channel index to the store()/show() but some other indexes.
>

The channel index is not the only means that can be used to determine
the channel index. Many drivers use the position in the attrs[] array
to determine the channel index. I don't see why this would not be
possible here.

> If you are very against the dynamical group, I can drop it to
> leave the sysfs node as it was.
> 
> And for the name nodes that I was talking about above, I will
> add an sysfs store() function so non-DT users can set them,
> and I also removed the confusing "unknown" default name.
> 

The label attributes are RO. Please follow the ABI.

temp[1-*]_label Suggested temperature channel label.
                 Text string
                 Should only be created if the driver has hints about what
                 this temperature channel is being used for, and user-space
                 doesn't. In all other cases, the label is provided by
                 user-space.
                 RO

Guenter

