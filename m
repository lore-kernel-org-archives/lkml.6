Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17353C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3D20854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av7rfvGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB3D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeIISWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:22:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeIISWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:22:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so7294952pgb.5;
        Sun, 09 Sep 2018 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8pKHvxMXlmqO4Gji242FDuFftvTWSYCW9hCt3WnVx5Q=;
        b=Av7rfvGOoD8Bo3EOFeGSJYW662jbbuFt8MeLoM+/U0BUXCV6kcuIMfvt5rKwfdIcgM
         T4eWQMJ/1aLPRiEq28eRGTE3p4D+Ed+JrYJph3+Oe1cjlKqohIjO0re73sjc724sdI47
         T/QHA0vtk6XApMkKaxV8QDxJSOlHk7XtQiEm3CGq/KBwt9JdPjnL9YnBc505j2ZPhXLD
         eEyemTM3zu7apa4k7LPvuLAaAMbKr+5P8wTI/p/JvVqowOrt6VIoeuqAYRIl1r4JMXfQ
         qZSTTo2Axe+/rEYrJaybLtkZ3GF/hQObCfaULySMF2r4dAIv4y/RswjMD/4jfBhzeN0g
         YMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8pKHvxMXlmqO4Gji242FDuFftvTWSYCW9hCt3WnVx5Q=;
        b=i6yG6A65UVReLSSynyx1aGAC52b/aLKETX1EhTTcoB7K4Hs78IqOeBQrwOsOxwRBgT
         JYh15RPMSO5JjMehzi+w+79X9CdN2utWU8Vs98Az3NPFWq/g4Xk2JZgVui4fQt2ez1eq
         /ZET+kF0fhjPZege4/823Uhno6x0kNCEyJ2+4ug1VcPzypBHZgx3+kYhg2vqfWQiuByI
         i1c1qX+/78weq3rblw0N7n9A6NglZkJt0iV9VT+LVznTe9emEZVqeHaiXH7+2UC2a2sa
         JdHywp9ZEO0n9u3d1M5ZIZDh2bFN+1wp1n51BA2dhRoxaVsY7F2qPsaCF6FDCrVQNmJu
         oCEg==
X-Gm-Message-State: APzg51AxEhVBHa3plNeG5Oh1rPJ/c+AgTL68ZXkxdvUCwdNJKH6SakOm
        hUEDO/Bv2qePd9gHWl/nhHlfbRKs
X-Google-Smtp-Source: ANB0Vdb+WL41+iPzUIyBRBOXFx3DCwChy/W1WoJv1C847QJa/tndtZtqZJ/X9Z2DnH6UK32t1tdtmg==
X-Received: by 2002:a63:9409:: with SMTP id m9-v6mr17781832pge.13.1536499988678;
        Sun, 09 Sep 2018 06:33:08 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r18-v6sm16511820pgj.51.2018.09.09.06.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 06:33:08 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/63] 4.9.126-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907211012.965501324@linuxfoundation.org>
 <e1fa8fda-e277-3c83-5e35-826df83f3cd5@roeck-us.net>
 <20180909085530.GC14455@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e68e4449-1605-c906-b611-c4b596acb0cd@roeck-us.net>
Date:   Sun, 9 Sep 2018 06:33:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909085530.GC14455@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 01:55 AM, Greg Kroah-Hartman wrote:
> On Sat, Sep 08, 2018 at 02:14:53PM -0700, Guenter Roeck wrote:
>> On 09/07/2018 02:09 PM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.9.126 release.
>>> There are 63 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Sep  9 21:09:58 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 151 pass: 149 fail: 2
>> Failed builds:
>> 	powerpc:defconfig
>> 	powerpc:allmodconfig
>> Qemu test results:
>> 	total: 301 pass: 285 fail: 16
>> Failed tests:
>> 	powerpc:mac99:ppc64_book3s_defconfig:nosmp:initrd
>> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:initrd
>> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:ide:rootfs
>> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:mmc:rootfs
>> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:scsi[DC395]:rootfs
>> 	powerpc:pseries:pseries_defconfig:initrd
>> 	powerpc:pseries:pseries_defconfig:scsi:rootfs
>> 	powerpc:pseries:pseries_defconfig:mmc:rootfs
>> 	powerpc:pseries:pseries_defconfig:nvme:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:initrd
>> 	powerpc:pseries:pseries_defconfig:little:scsi:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:scsi[MEGASAS]:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:scsi[FUSION]:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:mmc:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:nvme:rootfs
>> 	powerpc:powernv:powernv_defconfig:initrd
>>
>> Details are available at https://kerneltests.org/builders/.
> 
> I've pushed out a -rc2 to fix this.  Hopefully.  There were a bunch of
> warnings for power that I don't think were caused by these series, I
> don't know if they have always been there or not.
> 

The warnings in the assembler file have been fixed with commit 8a583c0a8d31
("powerpc: Fix invalid use of register expressions"). It is not marked
for stable, and does not cause actual failures, so I would not bother
applying it.

Most of the "may be used uninitialized" warnings are still reported in
ToT.

You missed this one in v4.9.y:

arch/powerpc/kernel/fadump.c: In function 'free_crash_memory_ranges':
/opt/buildbot/slave/stable-queue-4.9/build/arch/powerpc/kernel/fadump.c:738:2: error: implicit declaration of function 'kfree'

Other kernels build fine so far. Builds are still ongoing, but the ppc problems
are fixed in those.

Guenter
