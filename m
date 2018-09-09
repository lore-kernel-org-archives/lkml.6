Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C5C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E9720833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV2pYzf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E9720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeIIUou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:44:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46858 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeIIUot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:44:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so35644357oie.13;
        Sun, 09 Sep 2018 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yZezEVJuh/3DrjoS93wbbtrMCoQTpfSGtYJoWQJaPTk=;
        b=lV2pYzf1r7GaNBR0PsbbFZrO3YaBBEsK+kwYwOuQTnfhmnLNmhSNpTSMKE6+W3NCGX
         ZsC9AOkFu0g4I4JfBPW7q6i0MeZdsGmWilZ9O3cKFNO6FQRlg8L1A1+jMcHK0iF6JmrC
         AUD4V1aM4R34Kuab37ATVeDPUlASzaigD7oPfBpfQALykWvU8oHi96YfWBRppg0zrnTD
         2Te+Cac91Qvj+nd7drDWhma03mv1veu2SG+qVomz/PxQtuXrfPsdODtJfIq4fTNO+W3L
         fD+qGsCMURqv0jq2BXkloCXMd3T3k08gAY/kKbMpNPuatx36pnomsRVTVkJ6qG0WL/0t
         qWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZezEVJuh/3DrjoS93wbbtrMCoQTpfSGtYJoWQJaPTk=;
        b=b3vW8EBVKqKsT39FokEdb8tH7Q2i7jK7Wdu6SojBBoOD6y3pbLdTd3HSy4f3g/Proa
         Bd2JXKGjSkQGkRuHvnGqT2kn6zJixZJYSO36R0mngdhrveYU05bW6llPxO4Bqt80KAn1
         Zoz9/cJKCDFgsmZ/ivzUO++rlPl8M6Hnk3u8cI6aixjVsbwzN66qRyl9/usj9cKXdLSg
         KDT9+grYgt4g69SuP/GGL2cXoUnfACbF+lRryPgBEEPFbq0KEfRHZBG0kXbTeMxaGqTK
         5vaR5UaUCdjZbCqzzAoUVJ3/foEsnquhXccDC4bNnBdssmLNbCWxFIF3J3BS+F0onuAa
         8lnw==
X-Gm-Message-State: APzg51DF3pn3jBMQ/NVmxd05LnNPVPkTBhQLlacMBEhfohLCX6PAfUHP
        1D5L5xbrLAqhsfAVhIl08FHCP6cV
X-Google-Smtp-Source: ANB0Vdb2JBOAECjnX3bGbK1CPJ08ArTkZh0BdslOZl6RELmtGDT78HEG3cR4OzMRk+UW2VDaXVaIwA==
X-Received: by 2002:aca:2111:: with SMTP id 17-v6mr16214613oiz.241.1536508483341;
        Sun, 09 Sep 2018 08:54:43 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q85-v6sm19095902oic.56.2018.09.09.08.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 08:54:42 -0700 (PDT)
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
Message-ID: <1231d8c4-0788-6d02-308a-176666b4a71f@roeck-us.net>
Date:   Sun, 9 Sep 2018 08:54:41 -0700
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

For v4.9.125-65-g0f793f1ec4f3:

Build results:
	total: 151 pass: 150 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 301 pass: 301 fail: 0

arch/powerpc/kernel/fadump.c: In function 'free_crash_memory_ranges':
arch/powerpc/kernel/fadump.c:738:2: error: implicit declaration of function 'kfree'

arch/powerpc/kernel/fadump.c: In function 'allocate_crash_memory_ranges':
arch/powerpc/kernel/fadump.c:757:14: error: implicit declaration of function 'krealloc'

Guenter

