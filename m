Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22960C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3912082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsZ+QRh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3912082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeLEG7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:59:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36624 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeLEG7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:59:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so16092816edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iL6znx9IIzoQvbT050cXzLiwtEcBaJ4ZhQYe9U1eYU=;
        b=HsZ+QRh8/DiN0pFH4LNrfD7i6TacBw4OmtOudfyS2yB3EPFyV3izGGkartF97pOOXm
         v+5T4PwswfevdTwNk8aDbT4AQTNZmaPyileqiayDedlJLT2yeu5oBUQ8xgsfu1gTZ/au
         /c6ERUAeMTu/E60Fy1ux+Ih6i4Sku/UHC2gribk//NkWFwHZDU45wypelGIz/WQ+A98i
         Qh77tUdxHu4Zh+JVhxAIUPdjAaVa3jTyXKj7LdR/Pr7AHB5ZGqdk9VzGQoMn4E6/lji5
         lcwRHwV+76xByXCVP2jUKB6UqIlaeXtVa274PbmGa+mbWLGebrzeyQjsNcq+LI5k3U9i
         3xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iL6znx9IIzoQvbT050cXzLiwtEcBaJ4ZhQYe9U1eYU=;
        b=HRvwCUq8+lhOs36zNFrzP46PjPoPlWyr95WF/f4OIlLUYEaiLa9TC4P4m2M/cyi/sG
         zOQOeskLrEeyMvt9euCnFiKi4XpEuvl/cU0e1KI8Mea8suLV7qpFg7kycrJ9l2XSZ9nC
         379HVGxbe05N1yXTiVU7xayb+H9VLd0aRGoV0XmOZ9Wjrvs/7fVOswW8GRT6xYSp9dW/
         xUm2qvomOJkMn7NZ/kToftCn8p15wZW2aQzsIm4t7JXLsP9PaOFtMh3EBYtxusWCc/3K
         caRCbpEK1DPsdfufNqB84tAdZWWdYrdAgRDlHu/so6B1Crjgv/0wwDsFTQKI2Hrvu96w
         3YHg==
X-Gm-Message-State: AA+aEWbWCbYc883HtvLTiWHWkS3yuiuoTl5HNqVRpwOsjeob4dv3eIIk
        a8w1CONSokrbM7McsE9/WlM=
X-Google-Smtp-Source: AFSGD/U7ZhK0EOaSjeYDXst2+DeljXnjXcoM6+NInbYIa7rH62wEE7/lDL+P69+yQi80CqVKzxYQbw==
X-Received: by 2002:a50:fa0c:: with SMTP id b12mr19565303edq.138.1543993160148;
        Tue, 04 Dec 2018 22:59:20 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z9sm5161370edr.61.2018.12.04.22.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 22:59:19 -0800 (PST)
Date:   Wed, 5 Dec 2018 06:59:18 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Yueyi Li <liyueyi@live.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Message-ID: <20181205065918.tvgajb3iag6745s4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181204030415.zpcvbzh5gxz5hxc6@master>
 <BLUPR13MB02891C690507E91D0581E79FDFA80@BLUPR13MB0289.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR13MB02891C690507E91D0581E79FDFA80@BLUPR13MB0289.namprd13.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:37:37AM +0000, Yueyi Li wrote:
>
>On 2018/12/4 11:04, Wei Yang wrote:
>> On Mon, Dec 03, 2018 at 04:00:08AM +0000, Yueyi Li wrote:
>>> Found warning:
>>>
>>> WARNING: EXPORT symbol "gsi_write_channel_scratch" [vmlinux] version generation failed, symbol will not be versioned.
>>> WARNING: vmlinux.o(.text+0x1e0a0): Section mismatch in reference from the function valid_phys_addr_range() to the function .init.text:memblock_is_reserved()
>>> The function valid_phys_addr_range() references
>>> the function __init memblock_is_reserved().
>>> This is often because valid_phys_addr_range lacks a __init
>>> annotation or the annotation of memblock_is_reserved is wrong.
>>>
>>> Use __init_memblock instead of __init.
>> Not familiar with this error, the change looks good to me while have
>> some questions.
>>
>> 1. I don't see valid_phys_addr_range() reference memblock_is_reserved().
>>     This is in which file or arch?
>
>Yes,  I modified valid_phys_addr_range() for some other debugging.
>
>> 2. In case a function reference memblock_is_reserved(), should it has
>>     the annotation of __init_memblock too? Or just __init is ok? If my
>>     understanding is correct, annotation __init is ok. Well, I don't see
>>     valid_phys_addr_range() has an annotation.
>> 3. The only valid_phys_addr_range() reference some memblock function is
>>     the one in arch/arm64/mm/mmap.c. Do we suppose to add an annotation to
>>     this?
>
>Actually, __init_memblock is null in arch arm64, this warning is due to
>CONFIG_DEBUG_SECTION_MISMATCH enabled,  the help text in lib/Kconfig.debug.
>

Ok, thanks.

>
>
>Thanks,
>Yueyi

-- 
Wei Yang
Help you, Help me
