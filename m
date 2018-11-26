Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C11AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1902082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ75yOJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1902082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeK0KqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:46:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeK0KqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:46:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so14636061ply.13;
        Mon, 26 Nov 2018 15:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=grNT8urlfGkQR6eiAZwsxYHTuDqyaP8WhnbfyjDd4So=;
        b=jJ75yOJf15tK3fjpT9tHCoeQ0LrfbYLmpLp/yIoq/8imkgxNwfFMtDXGbYyZjbRL+u
         KDWNOqJZyq2kHTVx0883CYODUOYa8mdF+MaNXHFjlEIk4gxxHjfslIKFXUuiFj4/m9rx
         1cXh5PoM2mJjhdcE9Vx2YqrgFDAtzInN7TtMSdnEJ7Tty/yCgqNu+QtLa/36h14eMhm+
         icn85UsC19hPBwWaZoRYY2wwMXbuULF8lvrKveWfBv9ftZ8orKfbg8l7ksmqTicSLIiZ
         vYvwQ8kRG7EJv7Gti2QtAy9mkoNZZem0d4/2Ll8d4wRri0oNNnf0Y7zgWD3yOgxf/H+C
         Bbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grNT8urlfGkQR6eiAZwsxYHTuDqyaP8WhnbfyjDd4So=;
        b=t1jBjh4RqrvlPhFm8nx/7wjjtIcD48R6ZNQfS7JRRBxzgRW6DvXfgitFGpplxr32oO
         kOExG5cFo+WvCl36OJYDhNeigU6h3la2ATP0VZy8ZZdIPFsiu39cxd01Wa/ZjqB0qSBz
         weySn7N/8+G2nC2wnv9DIQvmvH/sr2tldrsyaX/lSsx1A09vflcLlo3nkoLY0sFqxAbi
         oYAgy2UtRuq4ojDblLZFrRhHeF/E0n15xC/k0nBFn0wi2rTZjupa70ZWG8CYmfvIsG4R
         xOhgl0XeoePlqskXip7Q7+m6BXDj5AfS5uNYU3G7g/vlh4anExTQPKFrF8JwP2Zo02+Q
         FgLA==
X-Gm-Message-State: AA+aEWaw0Zw2J0kz29rPacMu8+buRffI1D3ZcHO4yF5Y9omM0IKEo8e1
        u8aw+lud0DDCEzT/SGapOdqCnD2k
X-Google-Smtp-Source: AFSGD/W2jkh18VvY0SySTUnOdJuWqPIZGIZsR9oF58009VK31/tqzacFhPl0VknR/jhoPxW3ubLeUA==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr29835169plo.67.1543276211035;
        Mon, 26 Nov 2018 15:50:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b68sm1939332pfg.160.2018.11.26.15.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:50:10 -0800 (PST)
Subject: Re: [PATCH 4.14 00/62] 4.14.84-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181126105050.592727680@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e0557919-4b1b-192c-46c0-062850f739eb@roeck-us.net>
Date:   Mon, 26 Nov 2018 15:50:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 2:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.84 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 28 10:50:20 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.83-61-gc203efd3a8fd:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 295 pass: 295 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
