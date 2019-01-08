Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF8C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FF62089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg98qffj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfAHE5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:57:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42234 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHE5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:57:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so1157790pga.9;
        Mon, 07 Jan 2019 20:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8IKW9kJpwQrQ8nugO5x4C0wbJO4j5pEsKD+V5bsky8=;
        b=Jg98qffjqJJ0IEMxLCwX66hTyXz6r3K0nWJqCA6Rpaktn7bZP/GMuGVYYUViiSuwqn
         d0xwJ3KC95sjtZf6jikOZRNJ0gV9REW3nim19FLDLIWt0rY/gP1i0lv0U9vg3lLlWkn4
         +o+dOyjrBOHS2yNPYLi+1W/SJBAnuXpqJNGACRibiLFOvg3gZHN7m/3Ii+w7Z5wlzZP/
         YvPbVMAJbkJxY0A5/s+xo3zq6k6tQW9li9it1enG0jCFjDArrNcs0jUz0QlB+1qT9T28
         vcfxQ0J3aJifbvzU/gRInPd6htMYnF0RPifx1h7apWKosx5/LUGghvZHjeRoPhQj4PLk
         q57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8IKW9kJpwQrQ8nugO5x4C0wbJO4j5pEsKD+V5bsky8=;
        b=SBWaaBuQIbYYLFbbG2N0lzD2hbHNwkob+Z1ZkB/E1SNWpy2unAC9y/dcpjq2GCeA4o
         AYpGALVBsPwg0n7VE6xcKdrWeLSF7owOIOxrnIHyCCpWDhUAJrfnOmovMhUv8fcl69sZ
         ZlHKQ+1gwpJBcitPKINe11JgPYQgELZ/Eu+AjGVL9qZog0YNC1u30pc9xDmjTWccTUug
         qIaau+jUPgX4lLd1Thv5s614ZJ8udzhiGPrq2M+iJa/YExFt0rgB1MX1qrAzvXcDk5tz
         H/VU0YhjqkMZesUF/+A00vticUB2Sp8KIWnx9rCH8/X6at7sW+nS6O9FtQD18ANh3vyn
         VOjg==
X-Gm-Message-State: AJcUukcvqbGfViCQkNHZcVoQLbHmh88wSjZYwSQvFqsZazcnOAsXM/+C
        8O67tZNRglDtCuFAB3blgXEhLPQZ
X-Google-Smtp-Source: ALg8bN4kFW3tXS+OWdtYY8k+k3aTe/bLdE+MPC8TIe3vu50skmhmYAMzShrMKkvaVNnu/ehKViTbGA==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr246351pgi.275.1546923469522;
        Mon, 07 Jan 2019 20:57:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm111026483pga.92.2019.01.07.20.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 20:57:48 -0800 (PST)
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190107105330.280153213@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bf44008f-62d8-cb3d-1f7a-235f8b127895@roeck-us.net>
Date:   Mon, 7 Jan 2019 20:57:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 4:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.149 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.9.148-69-gd1d800b1ed7a:

Build results:
	total: 171 pass: 165 fail: 6
Failed builds:
	arm:allmodconfig
	mips:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	sparc64:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 305 pass: 305 fail: 0

Failures as reported earlier for other releases.

Guenter
