Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E695C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CC02133D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LLMXk1Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfAOWlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:41:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33049 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbfAOWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:41:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so2019898pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 14:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=geXaSVEWs6LE1rIkZivOjUut+JxyUtZy42EGp1ow4K8=;
        b=LLMXk1RykLJNt7AnWx6zld47izrbXPivBbDFHBCTJRbQrw83+WUHAIbRf27pd5r+tO
         TaJ9R3KmrFGahEd86sxW408ViN5RnyarllknC7YFLSqa7kpicwhSX3osj/jtd+p//KJJ
         KCaZs8fvPqNrn2gTfbm17enZlrmS3IV+DIM5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=geXaSVEWs6LE1rIkZivOjUut+JxyUtZy42EGp1ow4K8=;
        b=rg9s1YdZZyLqDou/idIFNJQefSmzjO8AqCXvpEfx+3R45bXQ0nNgYx2dytY+aCVKsk
         DEP1L/GICqlUM0eytnm8g7d7N6xXmJ6nfdA5O1Z6ScXwpp+RHXYFVI9VyomklO0IfuOv
         ah3QqCC3iUO7KmrJrXI7zsNwOca292MIm4SVH0uDiMHXfaG2v3AKgM1aoZfZdMy3irHn
         z+XyajL9/X/EEVu9cmnpJuAPdmOFU4VYxO1yAOWW2jTgSxQ9Lls5zCeHg3J5te+C2lo2
         ryqtVM2vsf1+8LJ/8hzC5uh2fzMdabFW+4P0b3p96VHFnp2zgvnxq8gUlN5VFTsYdP9S
         yBpg==
X-Gm-Message-State: AJcUuke0tUzreE6cdimf/gU6zOb1jgEKUee76H54cTT/IMmhjlJ6DktG
        wc8R0kNKYkbdO8Qnr2jjwrHXvg==
X-Google-Smtp-Source: ALg8bN4Wi9mPBkrFPh1dGubAdx83iKaBWg4MuSApuxvGfuTcOSusL3jqISVdKAdWsvHAyQUcKRnaPg==
X-Received: by 2002:a63:165e:: with SMTP id 30mr5887565pgw.103.1547592081070;
        Tue, 15 Jan 2019 14:41:21 -0800 (PST)
Received: from [10.69.52.190] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r8sm4791269pgr.48.2019.01.15.14.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 14:41:19 -0800 (PST)
Subject: Re: [PATCH 5/8] scsi: lpfc: change snprintf to scnprintf for possible
 overflow
To:     Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-5-w@1wt.eu>
 <CAGXu5jKu5br-pB3U+3PDtgcgq_nmt0C7gHLYQXV4tz3pN=S11Q@mail.gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <de134f7c-7516-cfb4-7cd2-6d96b45bdb48@broadcom.com>
Date:   Tue, 15 Jan 2019 14:41:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKu5br-pB3U+3PDtgcgq_nmt0C7gHLYQXV4tz3pN=S11Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/2019 5:15 PM, Kees Cook wrote:
> On Sat, Jan 12, 2019 at 7:29 AM Willy Tarreau<w@1wt.eu>  wrote:
>> From: Silvio Cesare<silvio.cesare@gmail.com>
>>
>> Change snprintf to scnprintf. There are generally two cases where using
>> snprintf causes problems.
>>
>> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
>> In this case, if snprintf would have written more characters than what the
>> buffer size (SIZE) is, then size will end up larger than SIZE. In later
>> uses of snprintf, SIZE - size will result in a negative number, leading
>> to problems. Note that size might already be too large by using
>> size = snprintf before the code reaches a case of size += snprintf.
>>
>> 2) If size is ultimately used as a length parameter for a copy back to user
>> space, then it will potentially allow for a buffer overflow and information
>> disclosure when size is greater than SIZE. When the size is used to index
>> the buffer directly, we can have memory corruption. This also means when
>> size = snprintf... is used, it may also cause problems since size may become
>> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
>> configuration.
>>
>> The solution to these issues is to use scnprintf which returns the number of
>> characters actually written to the buffer, so the size variable will never
>> exceed SIZE.
>>
>> Signed-off-by: Silvio Cesare<silvio.cesare@gmail.com>
>> Cc: James Smart<james.smart@broadcom.com>
>> Cc: Dick Kennedy<dick.kennedy@broadcom.com>
>> Cc: Dan Carpenter<dan.carpenter@oracle.com>
>> Cc: Kees Cook<keescook@chromium.org>
>> Cc: Will Deacon<will.deacon@arm.com>
>> Cc: Greg KH<greg@kroah.com>
>> Signed-off-by: Willy Tarreau<w@1wt.eu>
> I think this needs Cc: stable.
>
> Reviewed-by: Kees Cook<keescook@chromium.org>
>
> -Kees
>


Reviewed-by:  James Smart <james.smart@broadcom.com>

-- james

