Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3243C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C3E215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmoITsAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C3E215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeHOQGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:06:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35183 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbeHOQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:06:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id g1-v6so466880plo.2;
        Wed, 15 Aug 2018 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwOFVKU0Rg445oIM/XF8flzWTTmKlVkCxDgm+oF14Jc=;
        b=VmoITsAOkwOjwtcsOPbbGru1DFoB3ZpQQgJbPEZ75nPdFKDzTfG0bbbisZUbfQS0A/
         PSNVqKXy6ru9tfctgShk1U27YD+lJopjOtgBDIBL9/83vFZk07tEzcgJeooP3r83rOvr
         QPpITEGbE9yZkHbT58OJ/Fb5zJXpEMM9+8p2N/OybH71rLxTyILZaEaqaGwd6edWCr+V
         04RLaHqvGatX3rriflDwn/eHKhas5Liap+ckahF5fGYTMwOt/q2ihbM88ORhPExaaYtf
         1Ixn62DkrWbpLkpM3p4jUJ+/CFVpwv0sMY2dW2fO7oNZVF7ha/Y/dP2KLQwqpCRD/cQs
         E9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwOFVKU0Rg445oIM/XF8flzWTTmKlVkCxDgm+oF14Jc=;
        b=q8X1SQ08aLpJ2Q9Y21wnBWHHKf5XNf6o7Kl1VLBlM5JewQg5C2681johh5aTWf4hKX
         q0CsSDMgAR+5MoWVfliOQbDB8nFcCVjD6r0oCcjANKbNHrX88nr/Sc+GiiQGNYrIubGs
         n9oSnxw9jZdJ5yAIWPY78n+uIRpYiwqh49JABcjgFaqs2dt4H8D3lzVmUo6lLkhGWWDA
         w5pyUBtqdlnHweGpMCtQGGtlXo7WPZ2jjKLQIzYIhhpLHGPQcfcS5AcvDNtxUe1i3O6T
         vABNwRaVBcjAGpPLlUKqiEjC1rLTY9y3qw6rqSEX9EHehOw4VY8uQuBuE/5R5t1htdlg
         NQ5Q==
X-Gm-Message-State: AOUpUlHZb9ooa6S0ybNW6v76KPdgcny2hzh1uVAGxKFhuHepZ/na8j5Y
        wdLWvUf0ncyKWs0F1itu8ei0s91OUuA=
X-Google-Smtp-Source: AA+uWPx+hufe7FJqti9PljeEGB5pwUxDP75G8WHykK/mv+yRu29/z0tIl+QEiVyfdYTGlov54ijfdA==
X-Received: by 2002:a17:902:708b:: with SMTP id z11-v6mr24009624plk.262.1534338853074;
        Wed, 15 Aug 2018 06:14:13 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n9-v6sm38898864pfg.21.2018.08.15.06.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 06:14:12 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/104] 4.14.63-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171515.270692185@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9dd633c1-41ea-fc2a-a780-d33d1db59474@roeck-us.net>
Date:   Wed, 15 Aug 2018 06:14:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 10:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.63 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:49 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.62-109-g8944b2f:

Build results:
	total: 148 pass: 146 fail: 2
Failed builds:
	i386:allnoconfig
	x86_64:allnoconfig
Qemu test results:
	total: 299 pass: 299 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter

