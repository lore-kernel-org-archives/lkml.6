Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C6ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832EF20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfxM/Q2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832EF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeJSDMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:12:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38769 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeJSDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:12:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so11665208pll.5;
        Thu, 18 Oct 2018 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwpwnYRgUa/crfPYjADA11QX441Pokb9UOZ9HNVy7Bs=;
        b=AfxM/Q2aBvY9vYZRpW874dOnMJ2mnuapnlPFuKXnFoGGxeURI89nDTg/VHvBqlDHmR
         GgBeX19kSeMfjkYWl48ZYxNdVOY4vcsBsm/G7R0r2McIg8aDrPMdmwDy5EgTVK5vqgBi
         jBEdbc/14mXxyD8VtHmWL9LuhdL34Da7AQ7lK3wz0EtlSSloefyCkvWpRRzzpkT5CnDd
         qWUbx5GPyAkvTO75hJ0o62WgI1ETvs6Uh7Y768rUAu0qfsTRrTVtoBGryfjxFA4ie0RF
         FgzoXDo9h8960TT4/1I0VSXh0iMarUTMUG9XtKUWl16alAWlNbEZ7ngr7BfMbUJVTCX8
         PqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwpwnYRgUa/crfPYjADA11QX441Pokb9UOZ9HNVy7Bs=;
        b=b3/BpF76VFcIZsbgVXDgkyP557IbBYve0jvakVcLImuJpF63J3Nx1e+fxT8zcXj8yX
         +eYfDrMzkotE4CwqQWwp6kUzbMikOOzo5ABDteoEUrRJmoYZQLFlz13jUB00Ih/g+hFX
         B9q2uEFeCYcT1gRNBaIOqzAz6dvifIjvTglWPz/WqCMNvh8mjh6TKTm/Pw9K6VKANwaV
         UFTH3zXfvYu3w8J1yyQ0Q70FlOtmjpv1EB65a/Q9+UewUuTEVHbUbnY9cPZriYMp+WWB
         Y+KiVkinuzRwLY03kirSBqAVA9jJZ+imaGQ8hi3AiffGMAYD3mSKWUGSrcfsH6l7/pZq
         +kkQ==
X-Gm-Message-State: ABuFfoioVgTM6MuPUjhsQKw/4mb4YjpKwBhCfWTPVvsYnp4sBhDZfnRn
        2mGJenSDLZxl9eW1QYvcaME=
X-Google-Smtp-Source: ACcGV633+wB4s5caGXF6vAE26jGvwIa8sOWt1duDDoeZ7e6xwoZokDjTfZ5K5anlTVhfiZScDJ4G9w==
X-Received: by 2002:a17:902:ab93:: with SMTP id f19-v6mr30735680plr.63.1539889787347;
        Thu, 18 Oct 2018 12:09:47 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 64-v6sm42475226pfq.10.2018.10.18.12.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:09:46 -0700 (PDT)
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
To:     Rob Herring <robh@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
 <20181018170931.GC15557@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
Date:   Thu, 18 Oct 2018 12:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018170931.GC15557@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 10:09, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
>> added a missing of_node_get() to __of_attach_node_sysfs().  This
>> results in a refcount imbalance for nodes attached with
>> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
>> to __of_attach_node_sysfs() is:
>>
>>    dlpar_attach_node()
>>       of_attach_node()
>>          __of_attach_node_sysfs()
> 
> IIRC, there's a long standing item in the todo (Grant's) to convert the 
> open coded dlpar code. Maybe you want to do that first?

I'd like to avoid extra delays to getting the current (with necesary
fixes) series accepted because the series is rather intrusive and
could have conflicts with other patches.

I'm also worried that I don't have access to any of the systems that
use the dynamic overlay code, and I don't have any way to test the
changes.

Can we encourage the users of this code to convert the open coded
dlpar code?


>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> ***** UNTESTED.  I need people with the affected PowerPC systems
>> *****            (systems that dynamically allocate and deallocate
>> *****            devicetree nodes) to test this patch.
> 
> Can't we write a test case that does the same thing?

I could write a simplistic test case, but I'm concerned that
simplistic is not anywhere near sufficient.  And my test case
would reflect the same assumptions I already have when I
wrote this patch.


>>
>>  arch/powerpc/platforms/pseries/dlpar.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index a0b20c03f078..e3010b14aea5 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
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
>>
> 

