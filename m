Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B63EC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA86320833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTlsAYB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA86320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeIIUqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:46:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:47018 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeIIUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:46:20 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so35648135oie.13;
        Sun, 09 Sep 2018 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o01vwN9b3qBQQyl7uoQ6lLdEl1cYhVJPME5sgVTqEqQ=;
        b=CTlsAYB+t50V/x0askESPQQKTTV4iJJf6xk2xIsKM4c3iWabXs+B18KnWNIKc+gRB+
         FP+Xsq7FDX8iNMGNts7s7ZL9RJqu94xOTvluo7K2HhNnnHHX+J9uFp3l0beqggMS0HIk
         lz/ovLOFzayPAjZ1LlXwgc6HQ0v8ay8NZx5nk85gPXz2nixiuv25ODYPORErsY/8QHdt
         BEyYtepgNYX9HTdzKCJUoTvzcuKboKjM3aefXDKkZjNy1aRfCDmFenqZhberP2YponLz
         XQ692MU3s2kmEBeoTbw6TAVqmCOAzX85w9J2LEMOcwZkMQIqRdK+zIGhFCkt9+MIOj4a
         89Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o01vwN9b3qBQQyl7uoQ6lLdEl1cYhVJPME5sgVTqEqQ=;
        b=MOiaHaW+c+65J6RC8wMC7pUzWvdWyqUsfBKThAf6Hob+Lvwu+hGSQVzc4gxeulVWay
         HmGn2FgAW12PtfN2tVgtUnRXabrLyzzHIUU0vGFxrai2EXemTgi9P9XpwMldBO51PZkJ
         oFeyK2gIlJZynCNanJVASTH6KfhvvSYDSJPvBTL/EuWfCnl5wtTB6S1uAFwJTF6X6l6e
         H30AS70oysK7KVoy/cyjKCizu8vy80Orgei/phTbOYf55VPnAhcuvSUThQVnWFvMjpcX
         osupgdHwLs9v0r+UFCALqkDxqkHNU4Z0WxeDq4GBGWTaf1qupMKz+122PU3+8TJda7aN
         LrPw==
X-Gm-Message-State: APzg51DP7S5Fa/lGZjUt7oL9Qm4QgSGwTeCZvvFqkNlE93Hb4GfnWZYe
        4NlQtfEa/TonFItLt+zMZjYkqmfQ
X-Google-Smtp-Source: ANB0VdbFgNp8VyM5LBpS0ajMql4rD1cFI14UC6DL21XYi7jzc+R/OMroHHEAwLtmW54GgR0UAKrhvQ==
X-Received: by 2002:aca:b702:: with SMTP id h2-v6mr18594169oif.66.1536508574030;
        Sun, 09 Sep 2018 08:56:14 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s145-v6sm26012111oih.16.2018.09.09.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 08:56:13 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/89] 4.14.69-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210852.341064285@linuxfoundation.org>
 <7cfd62d8-e287-aff0-3e9e-2b59d7db42c7@roeck-us.net>
 <20180909084346.GB14455@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f1cbe6c-e0a6-1672-d5ff-076a257ec0d4@roeck-us.net>
Date:   Sun, 9 Sep 2018 08:56:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909084346.GB14455@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 01:43 AM, Greg Kroah-Hartman wrote:
> On Sat, Sep 08, 2018 at 02:16:02PM -0700, Guenter Roeck wrote:
>> On 09/07/2018 02:08 PM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.14.69 release.
>>> There are 89 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Sep  9 21:08:28 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 151 pass: 149 fail: 2
>> Failed builds:
>> 	powerpc:defconfig
>> 	powerpc:allmodconfig
>> Qemu test results:
>> 	total: 311 pass: 293 fail: 18
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
>> 	powerpc:pseries:pseries_defconfig:sata-sii3112:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:initrd
>> 	powerpc:pseries:pseries_defconfig:little:scsi:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:sata-sii3112:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:scsi[MEGASAS]:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:scsi[FUSION]:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:mmc:rootfs
>> 	powerpc:pseries:pseries_defconfig:little:nvme:rootfs
>> 	powerpc:powernv:powernv_defconfig:initrd
>>
>> Details are available at https://kerneltests.org/builders/.
> 
> Should now be fixed up, I've pushed out a -rc2 for this.
> 

For v4.14.68-91-g3101c84a1a08:

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Guenter
