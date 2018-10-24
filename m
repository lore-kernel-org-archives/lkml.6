Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59316C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2023B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq4xOPit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2023B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJXWw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:52:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40250 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:52:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id n3-v6so4125907lfe.7;
        Wed, 24 Oct 2018 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EacAJt177YLzPE8oeya/HZifyz3262DmkdK5FVCZxak=;
        b=Fq4xOPithePGaeg35/vJrK9nJS5UZ2GgnIZ6h4wUg/fCMTfD+fFsWimmX8c+OW1diu
         YgVrk214QPrbcJgRxBgYcLkifBsIe+1Z4MMzAxmhJzOLIOPoFoujBKn25IuPF2knOhaC
         snjq4gOte+Y7fDPqTjAEdTgnbIcnmuPCgubAhCVC03dhBq91vX8Q9BFAng3ADN6/5DvO
         FNuqKCNCRvBuVskYqvn1ZsbPI26g2EwRcqj7fWA8nBi2dYfu6CF0kFBMBnLhuOhJ0qab
         ntqaBG/H4vy4RF23pL5iQiQ+UJVDVuc/xwHEiBRvcYKetGrt89CNOgQJMxYOu+66Djv5
         aI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EacAJt177YLzPE8oeya/HZifyz3262DmkdK5FVCZxak=;
        b=PlWp90SuK7oOUBlLO43ZAvcoAVgFVs9D7nR58xrtPH0YRRAgoAiyUthNRiHAh+pL5Q
         i0fMj/LRR/DHkzn2tBtyrpV7IVgQZGfZ6luuidyQnI92MnCbhopOvM/8PdzmPT+mmjj9
         g2hS9B/efgtUG2TspgwbfTYN9/aPfLue+wmXJAvk75j9MFYiZ5S/0pwixw/5NwuMVssp
         9MHoHnPzu1XtR20uQM5bODcjzIGwV99+SrEgNip61NoRUs+VKg/dN5N/oN/rbly5GRMt
         T8VwWDpfcoN60pxSbxkCp5ibGK9xCnwa9XeDYx0oVkziU5mnk4e1ZKHwJJAag1wQgu1K
         MZwQ==
X-Gm-Message-State: ABuFfojTrMNBGTIPsLjxGXQcamZXQocD+KMO9mlkJGYbs3+BpvrWbxIc
        BIASu5nWLwf5gZ+3EjNmyxtyYhPKV8E=
X-Google-Smtp-Source: ACcGV62R7eUxS0xluqH27JngGN4Hn0g+MRp8GFJ098I3bbjq86ku0WSZ3MIxWfCItmTTIGXcA5eeEQ==
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr14643936lfi.138.1540391045923;
        Wed, 24 Oct 2018 07:24:05 -0700 (PDT)
Received: from [10.222.93.64] ([212.213.198.112])
        by smtp.gmail.com with ESMTPSA id q5-v6sm760455ljh.60.2018.10.24.07.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 07:24:05 -0700 (PDT)
Subject: Re: [PATCH 06/17] prmem: test cases for memory protection
To:     Randy Dunlap <rdunlap@infradead.org>,
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
 <a6c74bb1-bd0c-ed8a-1dd3-b04f2e3c78d4@infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <00461c0a-a214-1984-5614-c7a4a2a7ff83@gmail.com>
Date:   Wed, 24 Oct 2018 17:24:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a6c74bb1-bd0c-ed8a-1dd3-b04f2e3c78d4@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/10/18 06:27, Randy Dunlap wrote:

> a. It seems backwards (or upside down) to have a test case select a feature (PRMEM)
> instead of depending on that feature.
> 
> b. Since PRMEM depends on MMU (in patch 04/17), the "select" here could try to
> enabled PRMEM even when MMU is not enabled.
> 
> Changing this to "depends on PRMEM" would solve both of these issues.

The weird dependency you pointed out is partially caused by the 
incompleteness of PRMEM.

What I have in mind is to have a fallback version of it for systems 
without MMU capable of write protection.
Possibly defaulting to kvmalloc.
In that case there would not be any need for a configuration option.

> c. Don't use "default n".  That is already the default.

ok

--
igor
