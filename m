Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD90C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB145256D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLqNCWwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB145256D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeGBSxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:53:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45669 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbeGBSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:53:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so4930475qti.12;
        Mon, 02 Jul 2018 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3/isBrlL86YnFTHHKRy7etWt5GUXy9hxpfht62BgfOA=;
        b=bLqNCWwGzno1Y1yck1WpXoos++oT/EPe5kypMthucY4p+GPba1V6lSiba7oAtUnPHO
         9sRaP4rXIZkgGlWjBWNUGx3LvMHexGAD7xCS0acfBPx5OrmP7k8NommVdMUPnoITobp7
         xpnrkuzQj+0d/eidy2zFil/pbkVwnkJLoMHopjK9o4C97LB2fO1f2gHfnWfB7//1tbXk
         iQ4a8f4pkTXBpqp+ggGAg2gB3H3KNqgtdjDYdJbH/Uu2uUXXV7XdBoQnMvTFUHRhjtVi
         LdOkRFKAhVnGKGVa/HtgFqxZFZ66gfX8m9NXgK3la4w3xpfmHwd6amPkR5cEgtsIvpjr
         46cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/isBrlL86YnFTHHKRy7etWt5GUXy9hxpfht62BgfOA=;
        b=SEHzhFspUHr/JXLDN55Y3x1YgPxpKm9lTRQXGhjkfaY3djrQIQ/7J+d9IwWynHs3oV
         mL6zciBMNJMfN3mGoRM4HfeHS8nx51gEStsLbk7mcQLDGKaQIb8wr1F2HJIXFi134dmw
         1vAE1COaTQR8zgX+rv9tQDI6+OXA/qmR/roZ8ayYAP+AX5t9T6sNaZ7WILoFBbYr74IA
         KqCb3kvubIr4jB039P6m9iorFnAJelSlOmQAYQZNR4BHkUGq8CcDVQW71Ljlv2O+dVu+
         e8xsjZo2IS6L8XEvqgz0CsU6Wunvq7yjkakLyayN06Owre3LKxF6zf28r3Nrmv6tkKJS
         lY8g==
X-Gm-Message-State: APt69E2vAC/A7sPlnBpa9D5AIvidUw8EXABKVkXD28qvXah5zz5R15lB
        ngTSSz+E/1YGCKasAGyFW6B5sqzNhvw=
X-Google-Smtp-Source: AAOMgpeESRaXyBKAc94rAvx9HwXui2KQgGRD1Db/rOk/MOww4UjfmyHxy8e0K80hBlGhcxxBF+j3vA==
X-Received: by 2002:aed:3c42:: with SMTP id u2-v6mr24688100qte.198.1530557591347;
        Mon, 02 Jul 2018 11:53:11 -0700 (PDT)
Received: from [192.168.44.96] (203.sub-174-226-3.myvzw.com. [174.226.3.203])
        by smtp.gmail.com with ESMTPSA id y49-v6sm13443786qty.91.2018.07.02.11.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:53:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20180619110027.16935-1-digetx@gmail.com>
 <d99935be-797d-4676-c186-a045a590f01b@gmail.com> <11534185.70fb5jbPr6@dimapc>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
Date:   Mon, 2 Jul 2018 14:53:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <11534185.70fb5jbPr6@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2018 10:48 AM, Dmitry Osipenko wrote:
> On Friday, 29 June 2018 22:37:02 MSK Peter Geis wrote:
>> Good Afternoon,
>>
>> I have tested these patches on the Ouya T3 device.
>> They work great to enable the L2 cache controller, however they do not
>> respect explicitly disabling the L2 cache controller via the kernel
>> config nor device tree.
>>
>> With CONFIG_CACHE_L2X0 disabled, but CONFIG_TRUSTED_FOUNDATIONS enabled,
>> the L2 cache controller is silently enabled and allows all four cores to
>> boot.
>>
> 
> I don't see how cache could be enabled with CONFIG_CACHE_L2X0 disabled, there
> is no code to do that. Could you elaborate please?
> 
> Secondary cores do not depend on the cache state, disabled cache shouldn't
> prevent them to boot.

On the untouched mainline kernel running on a Trusted Foundations T3 
device, I observed the following indications:
With the L2 cache controller enabled, all four processor cores were 
enabled, but it would immediately panic for writing to a secure register 
from insecure mode.
With the L2 cache controller disabled, only the boot core is detected, 
but it successfully boots.
This is the issue that I inquired originally to you about.

With your patch running on the same device, the following is observed:
With the L2 controller enabled, all four cores are active, and the cache 
controller appears to function.
With the L2 controller disabled, but trusted foundations enabled, the L2 
controller enabled kernel message is missing, however all four cores 
still enable.

After looking through the code a little more deeply, I see you modified 
the reset handler for handling offline cores.
I am wondering if you fixed an additional issue inadvertently.

The reason I discovered this is I am working with kexec as a bootloader.
On a device without trusted foundations, kexec works without issue.
On a device with trusted foundations and your patch, I found that 
disabling the l2 cache controller and trusted foundations allow kexec to 
occur.
I haven't tried an either/or scenario, though now you have me thinking I 
should.
> 
>> One must also disable CONFIG_TRUSTED_FOUNDATIONS to stop the L2 cache
>> controller from spinning up.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>
> 
> 
> 
> 
