Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD3AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC812084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnWvR3pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC812084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeJ3DGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:06:06 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39332 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbeJ3DGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:06:06 -0400
Received: by mail-lj1-f173.google.com with SMTP id a28-v6so5755572ljd.6;
        Mon, 29 Oct 2018 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2qPBh/q69nky92IpEBTdXdD93mcC/g6otc1+JAUVzKA=;
        b=pnWvR3pa0Yeus7BQZPQ6Bemj50E7NWlnwuQQe4eA3B8lJ+5YtoAyu3eQoB8fihxe9t
         iuhebRIXMQpzgtNiU3K91YKIG2R2s9mNbpmbgPGZqg8CQivKcoQo+2Q+3jOBu8KApXCV
         rVbf9RRov2NpVyWRgYmlqd/dzCcyjw0ptHTAKOhxXIYhGGVbaAyGmtxOCk1R/rI3ODSp
         v4Pcg4CDDN2jm5hpYwjazBSoEtIija2v8rTqQ4YR8N+3OKNTWE7K8CU7BNJg4FoIp9cP
         9BAIvrOom3K66kcK5C0VX3XwhIaN1OlubTAh7CCrap9yE7OBtnETRWWnHKWWNa7F8cTw
         TuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2qPBh/q69nky92IpEBTdXdD93mcC/g6otc1+JAUVzKA=;
        b=aALuJ9+Cplfv4ZisVgAsYRGtzc12WrvstB+XODADebg0hIgXXk5IfkEC7sggPrH8nJ
         TVk4PbX8pVK3oBwOUHOT5aJ8XOXw6hjoan87BgeCXs0doAfTPV4DwqoHoMmineld347j
         L0WVKpELOfKsFPzXAoFzVQaa537K1jNghYaeKBm6yHtD7gXjzOnfz7fE50hLYLdbrVay
         vK5dAsTV8CX0xHbzaoPLncOhks2KXzdWZUDEx5ZM/lL6xbXwxlfSEtSbKKI2G04V8Obi
         IUgJCFGZIE7faKb9islRqT+kk3F3tWF22otRK62qBL4RZC+tF9OF59KYpx6W1wXFkS/h
         nr0w==
X-Gm-Message-State: AGRZ1gLs0H+e/0FZz5pnKgrMnT4fO8Sbhd8akUDCstslgVsohugz0Jnb
        oLL+7A6dsomBtJFTIKuWc4zN7ATedm0xiQ==
X-Google-Smtp-Source: AJdET5eIzwFHEMs9QrGGRWyam3ClbO0ICpli7rSZR6iwnWaEiQI8koujzbdsJLCSVD678H5FByMLHg==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr10225514ljd.36.1540836977341;
        Mon, 29 Oct 2018 11:16:17 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id c19sm576788lfg.86.2018.10.29.11.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:16:16 -0700 (PDT)
Subject: Re: [PATCH 06/17] prmem: test cases for memory protection
To:     Dave Hansen <dave.hansen@intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-7-igor.stoppa@huawei.com>
 <0175ca6a-40d1-0fde-350c-891488432ecb@intel.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <1ef1168c-0c44-274a-5942-257b84609051@gmail.com>
Date:   Mon, 29 Oct 2018 20:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0175ca6a-40d1-0fde-350c-891488432ecb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2018 17:43, Dave Hansen wrote:
>> +static bool is_address_protected(void *p)
>> +{
>> +	struct page *page;
>> +	struct vmap_area *area;
>> +
>> +	if (unlikely(!is_vmalloc_addr(p)))
>> +		return false;
>> +	page = vmalloc_to_page(p);
>> +	if (unlikely(!page))
>> +		return false;
>> +	wmb(); /* Flush changes to the page table - is it needed? */
> 
> No.

ok

> The rest of this is just pretty verbose and seems to have been very
> heavily copied and pasted.  I guess that's OK for test code, though.

I was tempted to play with macros, as templates to generate tests on the 
fly, according to the type being passed.

But I was afraid it might generate an even stronger rejection than the 
rest of the patchset already has.

Would it be acceptable/preferable?

--
igor
