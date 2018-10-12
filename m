Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528CFC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191732075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDvRO5nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191732075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeJLXRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:17:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36577 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLXRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:17:55 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so18827673itd.1;
        Fri, 12 Oct 2018 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xjp22+qgvLfc6zC63ECVLUiRfRlo2/9g+3Wm3uV09tQ=;
        b=pDvRO5nM7xJIN5tTGvHi9Zr1DzhNfWGa9vfdVQp+Roap+Df3v/6jDdJXsDcj0t4tPD
         ggpLc9Xt0cEV91gfzeSHw4QqBc2ZgncpxmQsO+Fnw9IiSlgHL0vujJ+4cYghVvvsOrq0
         0+CFEiOBfhPilZ3owSp3RKTcCc5dLEn7u4biRLeu3JHKbr2wzJ/N/X7XBdMc5bORJqjM
         3fgMOtaPwBIqIyzLiGVz5K0Bassyr8sJnK7cutcA9ZTMUusx25tXiO6qTlzI7DHsHQ7/
         UyamjVuSXf50kHagCByXikh7IgD361E+0k+SP3gCkQZV6CnoJO35MwMItQemaZYQinsM
         Zkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xjp22+qgvLfc6zC63ECVLUiRfRlo2/9g+3Wm3uV09tQ=;
        b=F6a/BBsvj3YvrlO0JYnKzv+0R5yE70uyyKaAprH2vhgSE3pLmpEb272SHRhg8tPHeg
         3R0+Nojx3qkD6X2LqP4UiMGCZxL1aNdJWeiBTGgruBZTc/JiqltyWVWr+S1GFzjnD3Wq
         vkkM5yGdjnwJxBr6pLWpxJ2PYCgnRK0hv3mf3JAjXNIqdAb5iZX0YUbv9iLI+ohHz4jO
         hdiODEhLycCkAaOnFKDuqq8MfF14jgjkQHqXMPPHF248/B2e/f3j0g1Of+eE846JO1Sm
         fHFZKXOvmR3pgjrxWAt0XC+I2fj80leq77GtCYIhPLf6yOaR/4sdv1o30GjGuLzYjGt9
         93AA==
X-Gm-Message-State: ABuFfogU/7PH8T66p1RWQOkidrUWJz7hVgzJuqt7S0UibpDdO5vfl8Ih
        Jo/KzARV264ZG0N3RPDb4TFkTVoF
X-Google-Smtp-Source: ACcGV61JWOwEPQTYvSdzNRUR0tJg67OF6isu3QHtsh6JOPCprFhGvL9SM6hqGofVQO3wRH3ysWI5bA==
X-Received: by 2002:a02:3f5d:: with SMTP id c29-v6mr5498107jaf.107.1539359090100;
        Fri, 12 Oct 2018 08:44:50 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e78-v6sm11657170itc.4.2018.10.12.08.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:44:49 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
Date:   Fri, 12 Oct 2018 10:44:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1539357759.2656.7.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

>> So instead of having unsigned char h3, can't we simply have bool h3
>> or unsigned int h3?
> 
> Given the ambiguity in the standards, the safe thing that will work for
> all time and all potential compilers is a char *
> 

All right.  You state this with certainty, but I'd still like you to 
educate me why?

 From the links provided in the patch it seems that one cannot pass 
char/float/short to va_start().  Fair enough.  So if we make h3 an 
unsigned int, the issue goes away, no?

  int TSS_authhmac(unsigned char *digest, const unsigned char *key,
                         unsigned int keylen, unsigned char *h1,
-                       unsigned char *h2, unsigned char h3, ...);
+                       unsigned char *h2, unsigned int h3, ...);

Regards,
-Denis

