Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01086C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A779A2098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzw0x2/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A779A2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeHZRrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:47:04 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36958 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeHZRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:47:04 -0400
Received: by mail-pg1-f172.google.com with SMTP id h8-v6so6246890pgs.4;
        Sun, 26 Aug 2018 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJexeKybLaNIsYClLEaQlFXdAxls59p4pI2Vhz54ccY=;
        b=kzw0x2/RUecE5sW9f351hmkhHNtZ3gSbTBxOupDM8OH9YvwES4pWdUEDeUVhYb0xqn
         7OzI23u1E/hEZo65PzY92R8aFR482z/b1IWNDbXWqkZJRy7haVjCkfIps/C1LTomli1X
         m/1T7ByicD7pFfw9AIo7yJyk1CMM04MLvJMSf3DF+M48y0KT7vIwR6+WadTv3Qil7HJ1
         9t7a+n1NjX5v8A2eEBWFABeLgoAEcTmSrKhEjfvPr2hS5ez1UXXK7AVvB9TeBKOc6cVN
         QlinKxksjGWgZB+/j99N/JFafmdhRJxSWlLdXjLVXZQFWb+Y9P7+IuyzRyD0rJSCTNQP
         25JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJexeKybLaNIsYClLEaQlFXdAxls59p4pI2Vhz54ccY=;
        b=QXN3FdGtdK4QPQlPLT0M9UbGGRArq+hfueBHcegSisvLbH5a5zS9zqxBQlEUfcxg3d
         uWKoYpd3hRxg5hq+SFsWZOPi1uONsRe9ttV10YG716Kk0tnDAJIoLKoKpeETr8WtYbVA
         /dLw6wUVTfa0KeK+BvPNkPEEekTq5hHwF8Nj1fatPXvu6uOUmy9kEJVme+7JbuIv3VkR
         7I6HC5AZut6eI4Ay4Dy7R4KrnPfx9QGzas5aA9Pffxxhcxi0//obYUH6BeCUl57XbLbc
         1pIN2EEAg3gvQBqvzKucUU+6Bn2dF6wtpKAG2vhh6l8hrzLgGlFVtUTAyoHyMJvbWDdw
         /NUQ==
X-Gm-Message-State: APzg51A6c8TpV0PbmB82NaQ5gQwGC8Tx1G47Sw3I+ercfPszp5ceaOao
        Z+uYXi70Yn0jST4FVtrzMZVh/8RT
X-Google-Smtp-Source: ANB0VdZNuO72RBumVOLqtOWdjDSjw3k1m7CaRBOk61POdL+9xRUtDQ+gLVdA2+VNG1pqHTC5Extz8g==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr10145517pfa.96.1535292264105;
        Sun, 26 Aug 2018 07:04:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t19-v6sm18340102pfk.182.2018.08.26.07.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 07:04:23 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/56] 3.18.120-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180826064232.320669119@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa2f1a7e-77e9-b2d3-4d4a-47d7cd377455@roeck-us.net>
Date:   Sun, 26 Aug 2018 07:04:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018 11:44 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.120 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Aug 28 06:42:19 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 207 pass: 207 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
