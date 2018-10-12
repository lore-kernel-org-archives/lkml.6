Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531AFC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EE920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQufs+6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EE920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeJLX0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:26:54 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:51493 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbeJLX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:26:54 -0400
Received: by mail-it1-f177.google.com with SMTP id 74-v6so19448347itw.1;
        Fri, 12 Oct 2018 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wNLSJKUU5zXLjOjVF17hVK61QMMaYTLJ9qx/1sQMUfU=;
        b=TQufs+6W7sg/L4cpQUEp4ordO5yIZRic7jRt3QCBy1NKlkAhGkc355bqj+GpMqOYQ7
         a3yqgvZynXu3PB2YzfIE+DVVxbHKgImS9H4N4D+f/4iA98Mi8VhulSEoGYJDl2Rima4l
         DphTS6FhUfybstj6+ltbxDbR7wjrvoKSzzLs5BOLaEXJWc8uzXTkXtn6KjLmVav6B9EO
         LoY2xwIa+rpQnvSd8P2PubQBKKl7YifP0R17oZGry/e3XC/WUZmD0CeGKc7QM+RdXCRc
         dhLsml/aIrlPvzMB+ynfmQYg3jNODM0CddKZWzk4Em9gXEQwbmnkYSrcRPwbkYoRzA4F
         mWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wNLSJKUU5zXLjOjVF17hVK61QMMaYTLJ9qx/1sQMUfU=;
        b=PRU2nm45G6qIcH5EAZfCDCrEJMfabVxZGhKDmytihXxqUcD4iMRmvVApSahPZRsnTW
         oTgS5y48SLl6v1ijBZj+uNe/gJaG/R2YCFbr5uBVx1uYgVfbUXmQvufNjCA+misRrhBw
         RjyPyvBCbdGH9ZUii42I79wpXh384cio/2PC1xj+lTgoehN6+8ExKW8ZD8kHH9bTLFAN
         tRJljZ1jjn6zLbphJ8HJmVMLYbvF0wXp8yEEqgVEun0brdXt/k6BY40LrcaG3q9k8heQ
         4pWsli+JREqfVsJDtMjOML8DYVQiS5NOH7B7cut9jdE6+ujc7UAeFfV5/eQZ18SZis6V
         vn8g==
X-Gm-Message-State: ABuFfohZ7r7tw2StthkdUtJd9QyWFO2IvXtk+ry0tVxsh8NW8BttrZoZ
        sLnxVm3YWG4IqdWctXH7ac1ymcfc
X-Google-Smtp-Source: ACcGV62TQXlIH30dOgYAdODYOEYISwwVQdukRloAR4LmkWH851BJcXkgHH3naOVQvYbnpsUXRVa+rA==
X-Received: by 2002:a05:660c:fd2:: with SMTP id m18mr1543644itn.92.1539359626595;
        Fri, 12 Oct 2018 08:53:46 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y4-v6sm414057iom.73.2018.10.12.08.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:53:45 -0700 (PDT)
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     James Bottomley <jejb@linux.ibm.com>, ndesaulniers@google.com,
        dhowells@redhat.com
Cc:     natechancellor@gmail.com, ebiggers@google.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
 <1539357759.2656.7.camel@linux.ibm.com>
 <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
 <1539359181.2656.13.camel@linux.ibm.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com>
Date:   Fri, 12 Oct 2018 10:53:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1539359181.2656.13.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

>>   From the links provided in the patch it seems that one cannot pass
>> char/float/short to va_start().  Fair enough.  So if we make h3 an
>> unsigned int, the issue goes away, no?
> 
> For the current version of clang, yes.  However, if we're fixing this
> for good a char * pointer is the only guaranteed thing because it
> mirrors current use in printf.
> 

All right.  I guess I wasn't aware that non-printf like variadic 
functions are now considered harmful or of the impending crusade against 
them :)

But in the context of this patch, can we please use something less 
invasive than changing all the arguments around?  Promoting h3 to a bool 
(if possible) or int/unsigned int would get my vote.

Regards,
-Denis

