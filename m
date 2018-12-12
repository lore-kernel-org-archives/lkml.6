Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB36C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA912084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAV1yTtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA912084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeLLLoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:44:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51372 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLLLoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:44:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so5458293wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHFlcLyssafzhIoDM0HeBmC0baromqcUgS2h1RN55/0=;
        b=BAV1yTtPTIKbDOO79e1jxl3WyGzIriNKV1+5wyLlfuDFojJiuWD9aRZ9GJRjcicztS
         6xNkeK33FnjiKIDRsfM2ZUdtHNK+REAvlhzzxYKvtjFpp8AMr8GFLd4E56yqZ0aqAjzZ
         KG/gb6ALx43jPw0vljnwTEQn+3uoIlC/hLw2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHFlcLyssafzhIoDM0HeBmC0baromqcUgS2h1RN55/0=;
        b=BYhCfvizR5Ium4oDmoJhQB8PPwSGsQa6sUhYNy4XSNk7oPeshtYN6ZnLnDgFG4m2Qu
         DOMQGqffd+HBElSqD6gBiMC2veIBBOSLFQ6z9jZtNclp3V3YOsaJyk1Wq5yYzI9ytQmD
         X2PHOzoFdBFyofKCXaco3T2O+I2ink/BWRxpCWrOBXJgooqUNEX03SqNUDHjjxlvNGSr
         sALokAlvE3JDKJf+hnGUYXf370M1++sNzGvoyMkup+haZmEuyydpmMdEmtaOKVHx/IdC
         LfC+CZo4Cw1PF2/7H6sqqqg7GSmdgwNfFbFIJto+EMWt3+8lezB588u43BkjckFXf1lz
         tMvQ==
X-Gm-Message-State: AA+aEWaFS8bCG9HuFbX+hWBOnTlqa+6ygv4AJfruqAZPCGRmT68/Jxx/
        bsINH7GMtZA5gtvxymdyr60wxQ==
X-Google-Smtp-Source: AFSGD/UxmZSca41XXrgLFNZrXCCe8d40GvtR/YfQfHlWxl3Bz0D1ZwY4WzUUoHe/ut7AfuqU9Ez5hg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr5840415wmc.5.1544615047129;
        Wed, 12 Dec 2018 03:44:07 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t70sm4281748wmd.36.2018.12.12.03.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 03:44:06 -0800 (PST)
Subject: Re: [PATCH v2 6/6] misc: fastrpc: Add support for compat ioctls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
 <20181212105932.GA1990@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <864aaef3-8d60-3beb-ce20-a9f41f78a32f@linaro.org>
Date:   Wed, 12 Dec 2018 11:44:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181212105932.GA1990@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments,

On 12/12/18 10:59, Greg KH wrote:
>> This patch adds support for compat ioctl from 32 bits userland to
>> Qualcomm fastrpc driver.
> Ick, why?
> 
> Why not just fix up your ioctl structures to not need that at all?  For
> new code being added to the kernel, there's no excuse to have to have
> compat structures anymore, just make your api sane and all should be
> fine.

Yes, I did try that after comments from Arnd,


> 
> What prevents you from doing that and requiring compat support?
> 
I removed most of the compat IOCTLS except this one.
The reason is that this ioctl takes arguments which can vary in number 
for each call. So args are passed as pointer to structure, rather than 
fixed size. I could not find better way to rearrange this to give a 
fixed size data structure. In theory number of arguments can vary from 
0-255 for both in & out.

current data structure looks like this:

struct fastrpc_invoke_args {
	__s32 fd;
	size_t length;
	void *ptr;
};

struct fastrpc_invoke {
	__u32 handle;
	__u32 sc;
	struct fastrpc_invoke_args *args;
};

Other option is to split this IOCTL into 3 parts
SET_INVOKE_METHOD, SET_INVOKE_ARGS and INVOKE
with some kinda handle to bind these three.

with below structures:
struct fastrpc_invoke {
	__u32 handle;
	__u32 sc;
};

struct fastrpc_invoke_arg {
	__s32 fd;
	__u64 length;
	__u64 ptr;
};
I can try this and see how this works before I send next version of patch!


--srini
> thanks,
> 
> greg k-h
