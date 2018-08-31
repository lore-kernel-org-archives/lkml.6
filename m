Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D72C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549BB20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nUqQeWqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549BB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHaG6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:58:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38108 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeHaG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 02:58:08 -0400
Received: by mail-io0-f193.google.com with SMTP id y3-v6so9303163ioc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 19:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rgh3coSF/DVg8ssmqtYTZm8z18qMPIW+TLoB7qeer88=;
        b=nUqQeWqwLgF63JIDmmcjb4t80K3e7qMz81LwtJB1nkcadFGgryhjjVXuxmmoGVTYYr
         XhM2ozGSr7iyEOiwghX4TAZWyeAqnsto+22YvBg1msUhegZBJNkpCbe3mr4m6yrQvf/l
         Vax0JJZwK+1BUCWFaJV9KttITocnCAdmnGEnYEbacCau4mXaab6E1Lui3S+t6Q+qCBjE
         PcSwqsb76B6ImrQIXfwKRkxP/mofWHpbxtDinWSxeDuOS19EESgZZPqL+f1qL1slpJbK
         4L6sRN4nEHllx2Btamusf//XB2CUg3sTRvlwVw3lAyMfh8Lf7XFfCAJvAMUBLaE2xg2q
         Gt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rgh3coSF/DVg8ssmqtYTZm8z18qMPIW+TLoB7qeer88=;
        b=a6KCLa/gm4LB3gO7BxxTppNWSR8FaKNCOppwepyb//bA8POxKS+jOomNoXBmQM4qbJ
         A8fVRIl5p35tv/QGHCMKEcjJ41EfbRFFrcpoSJIzCtmAkHdfa/y+/bhlqU2MzMxi/ih4
         hdwKDW/cl9TDx0RqEKxEmlDyEJVVe0fkHg0zbV0Zhg5QgInzr3TVbySLs+aJWyZYJdvK
         7/gee5RSMJN06PQcpapwwJJwHOa055PAqcryODajnpGtuL01o30kcHtMldyIHBKlRDFh
         PHM6qU2ruRV42A1yWLtuIgY9fkocDnvycf36sn2wCTgcJY+a0+/YGm2Dv0abAuoSZ3Yx
         yqsA==
X-Gm-Message-State: APzg51AlYPQEYvcSrn+qYeBntdZI8whTeN3biIZB/nF1pzpV2+LRcFAC
        p1I7sSjY6XXUzH6+j2XtOmCq/w==
X-Google-Smtp-Source: ANB0VdZDb+d3A+Cu6BaZh7C15KohB4CUZ2Qh4nWSjTC+DTqUnERdoSHlE93BECIziHHLl47rj3XwOg==
X-Received: by 2002:a6b:6a19:: with SMTP id x25-v6mr10663424iog.177.1535683975805;
        Thu, 30 Aug 2018 19:52:55 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id d12-v6sm1585884itf.25.2018.08.30.19.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 19:52:54 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
To:     Chen-Yu Tsai <wens@csie.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
Date:   Thu, 30 Aug 2018 20:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
>>> Hello
>>>
>>> This patchset add support for allwinner R40 AHCI controller.
>>>
>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
>>> by this serie, so no regression should come with it.
>>>
>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
>>> but will be resent for inclustion when all patchs will have hit linus
>>> tree.
>>
>> Applied 1-12 with Hans's blessing, thanks Corentin.
> 
> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
> merge them through the sunxi / armsoc tree. Having them in separate trees
> introduces conflicts when we have other stuff going through our tree.

OK, fair enough, I can drop those.

-- 
Jens Axboe

