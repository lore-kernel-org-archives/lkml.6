Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD771206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW2xUKTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD771206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438185AbeKWDP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:15:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33708 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388792AbeKWDP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:15:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so9480161plo.0;
        Thu, 22 Nov 2018 08:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Puu+35r8Wu41xD6vwbNz+LfJlTmPBtC1n+pgO67/7BQ=;
        b=TW2xUKTDF0zxHlhzz01YsJUgBdH/GdpAFjeNrD5jzvw7tZO0df/4YCRWR2740I/Xse
         5MU21rM9jFAiUMYCfUwRe8l7YXyx3qLnE91aJCIC1VyEUZboz22o/eMhG6Wy8RBZfhK7
         Cbf/M7d5A8bponziOwLmuUrEroZ3GjGk4MPmSxYpfGIZ8mlCwo/XCc/P8Ovtlq3TPVFL
         6hwKtcH2y5Wr4Y3N0SKb8fZw+tuVTZI3yCypb/dSEM242G7ePgjX/ld6wsyynIBSTQOM
         DFgWF2BQCn+QWQyjuf/KtToSr/Rp4XnAsGVDKN6zgDOAdI167zzwrmD4dxEfDjnlCp4Q
         oy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Puu+35r8Wu41xD6vwbNz+LfJlTmPBtC1n+pgO67/7BQ=;
        b=ZKGQreGy9MqU8CNJW1a8B/Uwsf22YDpXwSDdbNgYePDSvUG4MH/Ds8pNSFg02jnXy3
         EPLzc+9tubskJxcrPCEzrPF2U7wx1j+E1rPORAkuReV2zv1HhEZNXhJvPRjk2UYN22k6
         pMgRkSkeMJKYozIN5otSW3hNiA2CG60P2x6XaqOvcn568FF0Pbm9OstpvvBpr3AD71C2
         rcg13VsJsqe0FqXE+2QeL9U6Ffckarc26ggX2/pCQ6tSKAT0xw7c7C7kD6CD1FT0obWP
         GciLnXZIRLaVzf6t3aC/jRtijvtEl9YWgzbaK27LJJw+NxC4+ingfVkUX2KG+WDJiThe
         68jw==
X-Gm-Message-State: AA+aEWalf2q43N3o0Vjnp1y78dq5x2KsxxN+CI3ST2p44cj/0Y1y+YIr
        lFuzn1B0PPMVagyOXpQQHRmHbBBM
X-Google-Smtp-Source: AFSGD/VwjjglHfYPcf3F7d/RrDd1SA6rpRQ+5wiTVqqw+F/lyhl9PB57ldAvBwNobV6fs+hQYhZD4A==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr11820503pld.63.1542904520223;
        Thu, 22 Nov 2018 08:35:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 73-v6sm67253165pfl.142.2018.11.22.08.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:35:19 -0800 (PST)
Subject: Re: [PATCH 4.14 00/21] 4.14.83-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181121183422.103826775@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <40f663cf-4acb-ee84-434f-65e299f73c3c@roeck-us.net>
Date:   Thu, 22 Nov 2018 08:35:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 11:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.83 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Nov 23 18:34:13 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 293 pass: 293 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
