Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0908BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A412082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXg2v0Sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A412082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJ3DCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:02:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34245 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3DCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:02:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id n26-v6so6818735lfl.1;
        Mon, 29 Oct 2018 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5a6ry7YS/1XocQEq1IL80cJaCAab2eR6B7M0r5JjgFc=;
        b=WXg2v0ScrzR9IYVwfUfjD37ZnceesvUK34sTAfMJUnhu1hne6NOMw5luNk5cOQyGcS
         TAAjXbwPfFO1P4BBydaPRj1Kbm8ZqVxiJI9vq1FwEBd0/0Ha2AucxC3COLyjBgoKg2d/
         0QXKSj72Ek95PHJMmY8QP+Xpbt6Vp5VXpUCkd+YIbhnEqQg5tzRqi0t1AR9AVDZATmCJ
         yRUMxCjUHi73rbZW9zziNcxMUf99lQ31tqI3ufksnPEhVvT3pP57s8WhLlpNHXS/L0eX
         ROCsdGjeetoJXAe8L2ChEOop147Cenx98dmxF6hSEmai/hzONbvjdjvdblTeMyQkcgZ1
         15lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5a6ry7YS/1XocQEq1IL80cJaCAab2eR6B7M0r5JjgFc=;
        b=K9tLH5cAb6nyUG3Z1Do9eFztFR+ujp9hkSSlCLGWmYrpcGArrD/my//WIcq01/33z0
         P0qVeXBhrxtESrXPodn9mjnAPMKBX2dsuKExygdQ1jPKy6Yxu7jSC9Y1JPV6HtZXtfNa
         Alkdjm0y1uSgZPqiy0GcUTLZks8qper5ecPD1NceondUVoppzw+GLVIHFdK685QK14YX
         lRFFa1cX0G5RZQSzffQtUnXoabEo5oMV2gen9zyqqJRozXq+OdiLX/Z7TZmzs2erSv/k
         lYBv0fzgNRseSglbLhBozOBhwaijtZhivLi+xT5fKnHHFeSG/XfFY4cECYrBagHFRxzc
         /RMA==
X-Gm-Message-State: AGRZ1gJTLqGRNuT+SHsrAqprP4gHlZFehwAWu1GLSOGKsXyaEclLE7Dq
        pKO642+jk3MB/tRpJ0OVZzWP9XlXpTDTzw==
X-Google-Smtp-Source: AJdET5esv9xYVJMVq/i2+fiVUUAXZ9a1k5j+eVp1q5Nhca5Us3zfvSRM578DxByYPyH93j4ryxQ1VQ==
X-Received: by 2002:a19:4c02:: with SMTP id z2-v6mr8555753lfa.48.1540836755411;
        Mon, 29 Oct 2018 11:12:35 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id e201-v6sm3310177lfg.42.2018.10.29.11.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:12:34 -0700 (PDT)
Subject: Re: [PATCH 05/17] prmem: shorthands for write rare on common types
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
 <20181023213504.28905-6-igor.stoppa@huawei.com>
 <fbb38802-3dc3-4890-c981-724b9096a6be@intel.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <aa6d9911-c5f8-d759-a117-810d59763467@gmail.com>
Date:   Mon, 29 Oct 2018 20:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fbb38802-3dc3-4890-c981-724b9096a6be@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2018 01:28, Dave Hansen wrote:
> On 10/23/18 2:34 PM, Igor Stoppa wrote:
>> Wrappers around the basic write rare functionality, addressing several
>> common data types found in the kernel, allowing to specify the new
>> values through immediates, like constants and defines.
> 
> I have to wonder whether this is the right way, or whether a
> size-agnostic function like put_user() is the right way.  put_user() is
> certainly easier to use.

I definitely did not like it either.
But it was the best that came to my mind ...
The main purpose of this code was to show what I wanted to do.
Once more, thanks for pointing out a better way to do it.

--
igor

