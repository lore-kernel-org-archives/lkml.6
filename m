Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C4C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1492C20878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjfFe8Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfALRoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:44:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46289 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:44:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so8206406ply.13;
        Sat, 12 Jan 2019 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=17QXsKfxgVOd7rIZD2JlwCjJBsmGKzovqxr44vJA0kk=;
        b=PjfFe8Pn0fKa1S+ZrHS0LYlBT3h2d5Pu6QTKyKGAGFpK+I9igGY+YZ7oLxREpVzeOA
         FnyCXGA7Lab728VENFKlvRmZ1Wpwq2Hxidegd20uMBYnUW+dwnBJ0N4YQyP4NtOn+XnP
         d08ymhCnoczTh2F2aGj6pUHkh/MqbV5YW0uiChNkuEP5apAbm+folSgng3CMQUSMMTNr
         nF+OiQLUCJA/Ds++bC73KAyA713sMs+WYWVJtrefZ/kEOUr+ESKTDlFUL/8H9scc9iPb
         xX6fDWuuP8vgvq6QjPxeVaTWKWg5NGnn4s7DVmH0vH2rfmR/WOG7t2+bUbExNRctq+da
         lNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=17QXsKfxgVOd7rIZD2JlwCjJBsmGKzovqxr44vJA0kk=;
        b=Nsn7HoJIEpj2a6seKNxa1Qs1xE3dQYuitCcFqglrgvMAoau8I4aXnwxoxchioLhgHg
         LujTgIiaCNG5ZDbLltSKytaOMOH0DLLVbzbIyqzvhQsWp0uDgLKZUn2RQLAqkpQYjYMf
         dtsKmXqmZAreKysJ8LA8+jBf5Py9DuGwnlg4ttMEMTT/kUvFIlHZkpkOcojdem5EMTPA
         crw1V1BKguNt6xOR3ukyymOrq449ZgAy3J2cQcFZzgKJydstG+9i106OUFR37CMzXDO1
         e0qzuW+lsEYJwb2iIh8Rmp+cD18wrUhoMetlOpPgEH9nHskksKo4Q9gZNvL0U65B2XOT
         hC4w==
X-Gm-Message-State: AJcUukcsnWAwECKg3hgMuXMj+sBaraHfHSNDxnbw5t87Zj4k9T4aLidX
        XOVnuFArf+ywoutT2Mz3sUJQ9+Wt
X-Google-Smtp-Source: ALg8bN4SdxOSNSj0zZgZxnRVZIF6RR7E6IXd0ILq0mD4f2cn7egbHEj1bi6/uRzqUMJfo5re5/KdkA==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr18389399plq.278.1547315047411;
        Sat, 12 Jan 2019 09:44:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm106949782pfh.61.2019.01.12.09.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 09:44:06 -0800 (PST)
Subject: Re: [PATCH 4.14 000/105] 4.14.93-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190111131102.899065735@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <104261fc-a0a4-53f3-2fd5-2d2e99d9671b@roeck-us.net>
Date:   Sat, 12 Jan 2019 09:44:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.93 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:10:07 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 317 pass: 317 fail: 0

Guenter
