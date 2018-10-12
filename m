Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC40620835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCw5596U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC40620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeJLWq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:46:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43366 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeJLWq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:46:59 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so9451253ioa.10;
        Fri, 12 Oct 2018 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OX0jD8o5jFFMWMMxlWPTg+rLnbH5CF/R0JGC9Srfuo8=;
        b=dCw5596UuGVifnScmeUSHblReg2vSTtdwfxx0uX8gMmwpnabDh02aLmoRHOdj2uhYK
         qG0PGd5vCkK+oOgu1YH/VMN/GDKQgyggcpO1++qVeqkHfCyTPtmrIlDiRWn5HOeYyFyR
         524cUUR56TTVbNUCzLoP5N0FGMTIa1dyQYZ72sM3GP3BUFy2ag4DBZ1wmub1+WwSD/Sd
         OqSqAoStd/8XkvBso7ZA0SqgGAG2PAQqmed96RvmkRPVIAQ3NIN3RyPmzCQga/OLPDC6
         2DPn6jKrTmu2OC5eK2AZ91vvv7LNOJ1KhCjEtfV2C3EAJ2nCEFoykih4cW0qEeIyTOq4
         PQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OX0jD8o5jFFMWMMxlWPTg+rLnbH5CF/R0JGC9Srfuo8=;
        b=KEaSrfeZy2jhNQhqWxotEYXMr6wwPspbb8WdO/AIMOEWvXPvAM3r0W4yEKauqXUkgA
         kBTdZ0BexbLMRN+rA9oHdjrU7xSAOm+W9cySpKfqZ+nS5DrD4Zz3AV3l0c9oysAqYS7e
         xsV5K0ZWri/yP5pRnCvljbUIhdNDI3No6BQMc2xWt5v/EayBt94kVz4wk2wq53IHokzY
         bVACsM32QMOAtZSDmIU3DChixDcvBiJOTPuS4uI4ZUXJ6w0QI16/xnsIdR6HKIX2ZrYN
         diO2kJCABaFlrjey1ZMKVBgqaXGZ7Qb45bKLqXlnL5EwFvLRDXWTsJgkriSf6fHwqWrV
         NDMQ==
X-Gm-Message-State: ABuFfoiTJuvDWVs0INEpbYuUTuJjT7gQrQKeP6cO7ZNYexn4Zfh5FVOP
        Ku5pTGxsfadHwVMTqt/B1cuaDRQ5zcY=
X-Google-Smtp-Source: ACcGV60+saWOTdthyC0uEkZ9FJkIyVcNWu2SZ7aFPiuisI1NNFgaluYsXNZr3XFEqjZkeSbRIjCBpA==
X-Received: by 2002:a6b:e217:: with SMTP id z23-v6mr4401215ioc.70.1539357243273;
        Fri, 12 Oct 2018 08:14:03 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x21-v6sm722203ita.6.2018.10.12.08.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:14:00 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
Date:   Fri, 12 Oct 2018 10:13:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1539356751.2656.5.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

>> So can't we simply use 'bool' or uint32 as the type for h3 instead
>> of re-ordering everything
> 
> The problem is the standard is ambiguious.  The only thing that's
> guaranteed to work for all time is a char *.  If you want to keep the
> order, what I'd suggest is inserting a dummy pointer argument which is
> always expected to be NULL between the h3 and the varargs.

So maybe I'm misunderstanding something, but the issue seems to be that 
unsigned char is promoted to 'unsigned char *' by Clang and probably 
unsigned int or int by gcc.

So instead of having unsigned char h3, can't we simply have bool h3 or 
unsigned int h3?

Regards,
-Denis

