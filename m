Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE17C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42357205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYJoKQ3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42357205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJMBAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:00:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51729 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:00:35 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so19887197itw.1;
        Fri, 12 Oct 2018 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1c8CzJ13SCIpEhVf+sCWxU+rNfx1+0YK8EYSi19xYkI=;
        b=MYJoKQ3NyRWaUYBHomHu0Ip1MnozaJKS7+BsXIiy/WDLyjHZCUTXhJjeh7aMn39M0s
         cXTnTgA2z/G5MsvRtuwhDwdteaHd6h8uagd15//7jj+nd8gFiToTvv/u7jfcBKwijnCg
         JSdfHEBPCmYu0I7/1HIrQ8FKLtxDFiX1OLyIaAx5kZ6/DkQcuIiHAS2a1WnyQEFITSFr
         MzmuyWUpB+WUlNNhiRyvuJ5yFOPOFFM6YIpqbYAp96q/NnfzCtBu5JwFkru7rE/r7r6L
         xaAb8GNaWHgvSvDjzO9IGaqkNpyIeVM+zVPNtAym9laxnzAQwEb0q2d2uGeJn4be4vlE
         q+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1c8CzJ13SCIpEhVf+sCWxU+rNfx1+0YK8EYSi19xYkI=;
        b=nDd1icSg+kRc9QwkAf4zmsToyjht8XJkGvEvUPeYFz8QMq8bSXHWeSuNR2ROQCd6u3
         TkOfvI6cQhsXS22VVwX8kbLke0aA3zmlajWYTa7gtP3WoK0mElJQpND9RcvKkrztnhFZ
         YEUWkQ9deL/Np9TMRK6da9uldgk6sl4FlQoZqIqSsJKnvIqe2WMg39lHEwXuiLxG56pD
         7gO3J7qSVEUiXMhlx6/0X6XfX9eoTZ4vjEYTZOMd6RoffQO9HFmqycRwKw1jt0EtgUYe
         gwD0SvpMHsGLsZdn0laEIxy2BWO3ycNCKGthZI505bOncZW7v2aPZnDZaBvSYPNLi/Ph
         e6EQ==
X-Gm-Message-State: ABuFfojN/bENr/UzAJj99Qw9cPuWeVF0P7vdfampwmabBeDWpOSt5qwY
        O7gSwDicAK6tjzZo+MU99iBwtFsn
X-Google-Smtp-Source: ACcGV63XEYOAIyvR4FY1ax6BObNpHbQDhDcbqWCI8Hwgvdsf24iT8fYxSCMj0U2jAQTmo0hraBtxCA==
X-Received: by 2002:a24:4169:: with SMTP id x102-v6mr5620897ita.128.1539365222366;
        Fri, 12 Oct 2018 10:27:02 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s10-v6sm876799itb.38.2018.10.12.10.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:27:01 -0700 (PDT)
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jejb@linux.ibm.com, dhowells@redhat.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
 <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <80837c90-0425-aadd-38d7-c3c866d29a0a@gmail.com>
Date:   Fri, 12 Oct 2018 12:27:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

>> So maybe I'm misunderstanding something, but the issue seems to be that
>> unsigned char is promoted to 'unsigned char *' by Clang and probably
>> unsigned int or int by gcc.
> 
> No. This is extremely well defined behavior in C.  In C, integral
> types are NEVER promoted to pointer to integer types, only to larger
> integral types through rules more complicated than the correct flags
> to pass to `tar`.
> https://xkcd.com/1168/
> 

Ah right.  Thanks for the correction.  So looks like bool won't work for 
the same reasons.  But unsigned int should work right?  But then again 
this is a boolean value and if we want to be paranoid we can simply 
tweak the 'c = h3' assignment to be something like:

c = !!h3;

So in the end, I'm happy with int or unsigned int.

Regards,
-Denis
