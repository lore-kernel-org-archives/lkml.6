Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF5C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D11B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOy8N5cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D11B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJXW7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:59:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46031 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:59:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so4964407ljc.12;
        Wed, 24 Oct 2018 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+G+J5R4KOjCZx9oUTz0EKjFR9FArlG2HBdbRs2HP5PY=;
        b=hOy8N5cFoGPRjyMfXzyQO+fKGIsldr5WXMYGX2cd9MvtXrqnOyEJL8nh+nDhO80s9A
         6DGS3HJ7INNOoG35zNvm9a66+4Um0Z6ecdTpbQ5xyDEhgt9GUStDDYmVYDphx+JII0Fu
         qC4Vo336T7tsUnp7dsq2dUeSfWd5n//PlB1+99KwDUQAXR/U+TfhbkAn5fBNOtLIVh08
         88mYBfztOn7/tGj0xxakOCH15lmPdP01X3IlVhngDqgo07WiVOHX2FkAV3mlMfhQwcnx
         aqG4fMBbT7mba0LPdTDWkYco7Q/aU0vIg4I9iDJCuyriUU9PqsynvaFKHEcQ5vjsfkn+
         bu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+G+J5R4KOjCZx9oUTz0EKjFR9FArlG2HBdbRs2HP5PY=;
        b=eSagEURttjJBUB0+3FaAVhtUNn9IYfP/ErpTfGgNu1KO4c953Zv98rX0gskswcPKp2
         sm7i+/8fJOcTtiGLX1eYuw8u1K+SZR8hQKvsekzsGnx//8ILkZwp1chhpbDsTCrfjSRi
         XbgQKddZEyY+rK88/QHNx73HyU4fnUkOC+NRTbvsFBXdNAmNp9LLCNAJOGmh7E0Q+uCH
         3az+pDtiYn02DSaMaCxk5QoIO8X4CWyTlJyO0kqYYAuDqwr/EN5axLuzntadFryNzOgo
         YvI6CSjj1Sfw8GC97FiZeHRWChNtJ6QMPAzkQpvMRkskJQdq9rSOgBSl5RYp/gTJODJy
         3C0w==
X-Gm-Message-State: AGRZ1gI0vRC6gKUWyFeiAKszQN3HIgE9i9qYuIUB5lieQf4d4O/Pgnjk
        xdVW+vKuYiu6sYNjiBoOffLbJxnZS0Y=
X-Google-Smtp-Source: AJdET5dREK9ZXVcNYM9E9tnFT1wkD5VzLdyU3DHL/xqz6T+XVsrtQ5MwHlkU0mXuPXi1z74+AxUkag==
X-Received: by 2002:a2e:651d:: with SMTP id z29-v6mr2134192ljb.36.1540391454141;
        Wed, 24 Oct 2018 07:30:54 -0700 (PDT)
Received: from [10.222.93.64] ([212.213.198.112])
        by smtp.gmail.com with ESMTPSA id n192-v6sm873329lfn.0.2018.10.24.07.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 07:30:53 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
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
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <b09b3feb-8e3d-5fab-4e2b-35e8c252b27c@infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <42e65f5f-2753-54a7-08a4-b51e56dfedbe@gmail.com>
Date:   Wed, 24 Oct 2018 17:30:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b09b3feb-8e3d-5fab-4e2b-35e8c252b27c@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/10/18 06:48, Randy Dunlap wrote:
> Hi,
> 
> On 10/23/18 2:34 PM, Igor Stoppa wrote:

[...]

>> +- The present document doesn't address such transient.
> 
>                                                 transience.

ok

[...]

>> +   are attempted after the write protection is in place, will cause
> 
> no comma.

ok

[...]

>> +        - Its usefulness depends on the specific use case at hand
> 
> end above sentence with a period, please, like all of the others above it.

ok


>> +    - The "START_WR" mode is the only one which provides immediate protection, at the cost of speed.
> 
> Please try to keep the line above and a few below to < 80 characters in length.
> (because some of us read rst files as text files, with a text editor, and line
> wrap is ugly)

ok, I still have to master .rst :-(

[...]

>> +- The users of rare write must take care of ensuring the atomicity of the
> 
> s/rare write/write rare/ ?

thanks

>> +  action, respect to the way they use the data being altered; for example,
> 
>    This ..   "respect to the way" is awkward, but I don't know what to
> change it to.
> 
>> +  take a lock before making a copy of the value to modify (if it's
>> +  relevant), then alter it, issue the call to rare write and finally
>> +  release the lock. Some special scenario might be exempt from the need
>> +  for locking, but in general rare-write must be treated as an operation
> 
> It seemed to me that "write-rare" (or write rare) was the going name, but now
> it's being called "rare write" (or rare-write).  Just be consistent, please.


write-rare it is, because it can be shortened as wr_xxx

rare_write becomes rw_xxx

which wrongly hints at read/write, which it definitely is not

>> +  tlb entries. It still does a better job of it, compared to invoking
> 
>       TLB

ok

>> +  vmalloc for each allocation, but it is undeniably less optimized wrt to
> 
> s/wrt/with respect to/

yes

> Thanks for the documentation.

thanks for the review :-)

--
igor
