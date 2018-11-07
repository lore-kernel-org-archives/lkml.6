Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4F320883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwBlWuhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeKHA3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:29:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40109 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeKHA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:29:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id x2-v6so3716770pfm.7;
        Wed, 07 Nov 2018 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=od9qZ/u5DMHeveh8MRZfHbr5BBNuRmqZVRi36J9gC7M=;
        b=mwBlWuhuVV4OEqMdCiTCZGTq8R6w85WZJC3puF8AB9KVZcrb21AItbT1kH5FL1YNTa
         gueduavt2Ar4pmDxu59eVDmqvvavL6bxmcOCTUX9jHzV1KzwnChlAxq3+nVugH0OTXAK
         up62uhSe51SIF9x8UE6426RzRmqoarNVyt0nNc5fodIbrDMo1nHojSxBC6ZzE6LDlJf7
         +DIR3FzYOgcZnDR9zUWHH3AHbMlPSX0zrcyIc74mMC5Osa+Ko2TBKgTKCjvAcrllCR09
         d4E97Z4xUT3UUFG7ib6aPLH2hogy6+2LedTw7CTAt7uxiF8O2hDw+3p0gHS8O5xYqiGg
         CIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=od9qZ/u5DMHeveh8MRZfHbr5BBNuRmqZVRi36J9gC7M=;
        b=LYwHI4y54xdDfGoI/DPpWqKQuDcBYMmy5t9r34H5odcmZHUiYiSCRyT4/5ZG6YNqkc
         J8iuIDldmY0/avE7lla8FyCtlxbB2GKlcRuxk1n+GgmB1SJr7QmjgRIm0Lyy575pNN3V
         EO9NGX3ui01y7wpIP53OOhHRGimd2erK1xiisk92TycltrUYiw7m57toj6G4NKlEgSfP
         XP6CWN16bQB6swOQb3K412n5gB8GMKjYMpcP+0zf0Sm0EY0aTamzGtDbECLljkaZWkzb
         yepjO3iaSa5qNW6FQ/HH5Kh11nrXlyu8/FplHKg8IR2bZiYuTPeQFMbt4IkYqzBOEYbu
         2kCg==
X-Gm-Message-State: AGRZ1gKWStl1jAuWFNuqmZ95P1lkTflXRErBvPf1GD/QiYsvfKrR+L5f
        uHcNSM9XRuSa7CA0RJPf6w8=
X-Google-Smtp-Source: AJdET5eybj016H4i7jCX1MaaScdtaAhLZVgIKPMJaEFr+lTE2129ISBBIRoMTsi6f14WihoFLRVr1w==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr556795pfm.18.1541602738039;
        Wed, 07 Nov 2018 06:58:58 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id q76-v6sm1155163pfa.18.2018.11.07.06.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:58:57 -0800 (PST)
Subject: Re: [PATCH v6 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
 <87muqlqdog.fsf@concordia.ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ea4d4314-a7e8-f4cd-f9e0-15fedcd3510f@gmail.com>
Date:   Wed, 7 Nov 2018 06:58:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87muqlqdog.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 4:23 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> 
> It would be clearer if you said 'The previous commit "of: overlay ..."

Will fix.


>> added a missing of_node_get() to __of_attach_node_sysfs().  This
>> results in a refcount imbalance for nodes attached with
>> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
>> to __of_attach_node_sysfs() is:
>>
>>    dlpar_attach_node()
>>       of_attach_node()
>>          __of_attach_node_sysfs()
>>
>> Tested-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> ***** UNTESTED.  I need people with the affected PowerPC systems
>> *****            (systems that dynamically allocate and deallocate
>> *****            devicetree nodes) to test this patch.
> 
> This looks OK to me in light of the previous patch.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> It also means dlpar_detach_node() is again behaving as described in the
> comment to of_detach_node().
> 
> It would be good to make mention of:
> 
>   Fixes: 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow during DLPAR remove")
> 
> Which removed an of_node_put() in the exact same place for different
> reasons.

OK.

-Frank

> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index 7625546caefd..17958043e7f7 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
>>  	if (rc)
>>  		return rc;
>>  
>> +	of_node_put(dn);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
> 

