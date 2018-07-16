Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A610ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BDA20877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/IHJK4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BDA20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeGPPfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:35:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39777 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeGPPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:35:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so33112813qtp.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vQuN1RvoFxxyWnZJy73XIMu9xpRV7ynieYvdAgfDMsQ=;
        b=M/IHJK4o2eokr1/zhLkW2EFGw225RXoelcKW52LyHdczFuCq+/yq+ugmJPmP7GPtUy
         S4vekyfJusl5PX4hgv75+rzL5NHSO9FEzEYkA2isoAHhWDvuzRfxsH7DvxeOIU06i5md
         M+m1TcYoLq2Xotfvsd3U9nFPWb8vpOIQEK8tchakrPIzkBheFVbsKS0e0UQl0GxvBNnG
         5dBK2MFmJ6uGLJijKw+fBMmeQj1nEZ1zZbQnytcbwJ/8aEp+Idrqc6qPR5AqwSXCSWRp
         SNFBsxS+lH76hLfI7qO1jEDDNuc4axFS7+/bxcSzhuapDyZR1hnYYsdbZt6bPtBnx5j2
         K2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQuN1RvoFxxyWnZJy73XIMu9xpRV7ynieYvdAgfDMsQ=;
        b=NMbJIWGIMZGsL/PNTYh8KdQNQ1exWU7gwH4f3j6deJLxtCWSos7nTvNq+LRzBYvQoz
         Dz1dXb9zAqQv1YRQ3dL3ZV1Nf1h6skfJ8mV4ied5/YmGJRUWGNRhzmh9k8zbOzUB78fN
         cTod4oppgxI+VBliWkADrjRAvjVkGZKtksPEVUOJmqnIhwWxKimwym4J5xE00KpbD2/E
         bSIHAVROXJEaf5Uj5BxFVks2mrBbA6NS5a0y7hx+U2aSsk+JU+jiYvUsVKk+Dw6pASih
         5uMxr5TeghfwysTfbpZ/1I7Ig2bIxRBaDEtoiErtk4JV4fs1xxKxuMenHQ6/6IjyOhjG
         qIBQ==
X-Gm-Message-State: AOUpUlGc6yarOo8CBEL1tKCz+mbPUllDX7tG2BUvML0l6L2Ffm/a8Iw0
        didIjy3W2oFHw853UT266E8dLFA=
X-Google-Smtp-Source: AAOMgpdd7qLEGHUZf64C+TXIkTMXodXJabb+AWdEGmwV63fXWL4UfmFq3Xgns1l87cjOfNPeI1Z/CA==
X-Received: by 2002:aed:3d2d:: with SMTP id g42-v6mr15455692qtf.195.1531753629301;
        Mon, 16 Jul 2018 08:07:09 -0700 (PDT)
Received: from [10.18.17.172] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l5-v6sm3729646qte.20.2018.07.16.08.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 08:07:08 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
To:     kan.liang@linux.intel.com, mingo@kernel.org, kan.liang@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
 <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Message-ID: <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
Date:   Mon, 16 Jul 2018 11:07:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/16/2018 10:29 AM, Liang, Kan wrote:
> 
> 
> On 7/15/2018 6:34 PM, Ingo Molnar wrote:
>>
>> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>>
>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>>
>>> commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
>>> Broadwell CPUs") introduced PCU.3 for Broadwell CPU. Unfortunately,
>>> the driver_data of PCU.3 conflicts to QPI Port 2 filter.
>>>
>>>      { /* QPI Port 2 filter  */
>>>              PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>>>              .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
>>>
>>>      { /* PCU.3 (for Capability registers) */
>>>              PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
>>>              .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>>>                                                 HSWEP_PCI_PCU_3),
>>>                               // HSWEP_PCI_PCU_3 == 2
>>
>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>> @@ -1030,6 +1030,7 @@ enum {
>>>       SNBEP_PCI_QPI_PORT0_FILTER,
>>>       SNBEP_PCI_QPI_PORT1_FILTER,
>>>       HSWEP_PCI_PCU_3,
>>> +    BDX_PCI_PCU_3,
>>>   };
>>
>> So we use a magic '2' enumerator in the 'QPI Port 2 filter', and that overlaps
>> with HSWEP_PCI_PCU_3, right?
>>
>> Shouldn't we clean up all the enumerators and not use magic numbers, and this fix
>> the conflict?
>>
> 
> Yes, it should fix the conflict. I will clean up the code.

Thanks a lot!
I would appreciate if you could add CC to me when you post the patch.

Thanks,
Masa 

> 
> Thanks,
> Kan
> 
> 
>> Thanks,
>>
>>     Ingo
>>
