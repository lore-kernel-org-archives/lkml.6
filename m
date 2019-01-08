Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D924C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6672183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt9xzMbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfAHE7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:59:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38284 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfAHE7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:59:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1307170pfi.5;
        Mon, 07 Jan 2019 20:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBXdJXLBYWfjD32g64OtGydvI+kFEFEoRnhk3mZRqxI=;
        b=Nt9xzMbmOte+ZCvirzP9gZ6of2gFiLypv2Pq1I591vvVgGQ4gE2hus8c8Iv9z26kXw
         Sa+rFcktukRON7aNWHw1ot4084Q6cphhFQiMJVmLc+EPW5bxZSBE7VRr7/fg96Q2nQu2
         prI/3NXeXjhS9lKNCErvWICXx+3bZaujJd6yDU8WMPG61bjefbBE+zYzaZIwuzZQ/8NA
         ZxJyBam7IYO3CIZToxKU1aYpE5o1HbpWwP6LzE0aBkEeogwlDvFmZ5/dCDVA9z5S9jQX
         aHe9a/xXV6NftHTtofHloFwS+BcxPpbpTqhvlMZPKJSMgmFuBuThZ/zGbG2mRIPbX6Mb
         PmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBXdJXLBYWfjD32g64OtGydvI+kFEFEoRnhk3mZRqxI=;
        b=CJmhsYiczI7yaXyByv1FDiR8WTPMYFHcDiiEHnI/rkHit1VK8YCyS4dQPcTjN1Vu3U
         dTmgJXO5X5l4EZq+1a4xI/x5e2UCp/h9sq+YGtStaAGnwngPWPqKMcdrQSgotYLqKxdF
         7Z49LOA3+J6Mzs1hmUtvzMkuWJTpGUwRvd7N+nCjcdj+psaC93E+LEXpm2F6Gy76jJrJ
         HvdlBoyLPfphT7CXzed0EG6FS/AS5/Y6ZX/ROgpwrAS/hRoA1PDpVUvNaJ2OZ6GCHU1B
         4e4ivaMVcO4ljrbVfkWu8vj93ec2Rab6s+ZC8RRgdB0u4sXxbn/+R/iq84vN/n67Ghrf
         TlmQ==
X-Gm-Message-State: AJcUukfrR9TpMCqwcHRKo3cYexqtrXWbBpoValBi0Y91htpATpJTaXnn
        9Z9pws1Rl9rdOGRY1gouIaXh8GZ9
X-Google-Smtp-Source: ALg8bN6fr7jPEmRUDFjmIKe9egmIXy/8SVU9xJnjYgfWqFtk2OolYKLcN4hiYXgqL+Qq9xd+La/NtA==
X-Received: by 2002:a63:a16:: with SMTP id 22mr269003pgk.318.1546923553959;
        Mon, 07 Jan 2019 20:59:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f64sm176484850pfh.0.2019.01.07.20.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 20:59:13 -0800 (PST)
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190107105330.372621917@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d86ef960-dd47-b282-5432-4ecbdd4e0daf@roeck-us.net>
Date:   Mon, 7 Jan 2019 20:59:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 4:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.92 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.14.91-100-g31e3578310df:

Build results:
	total: 171 pass: 167 fail: 4
Failed builds:
	arm:allmodconfig
	mips:allmodconfig
	parisc:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 317 pass: 316 fail: 1
Failed tests:
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs

Failures are reported earlier for other releases.

Guenter
