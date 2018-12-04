Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A599C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D0420672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as8bROXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D0420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLDVk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:40:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:40:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so7962159pgk.10;
        Tue, 04 Dec 2018 13:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zLxW+Mlvu7m0zTLKnZXmM91jTFe7ozK+KV0cMuAOaZw=;
        b=as8bROXP0XVU6cCtCaRsht0Ri0K8rlUttDGV9yJwK+caB9X9VyPnfvFE41wiTHZiNc
         j6VtuoC2nJaqx3jpxIN/PWsPDpI990z+V35jFKWccYHZ8ikLx+3+GbGK/AEKWTlq0buZ
         R+C9LC/hmaHu5yGHfaZwprhY1NUvT+c6Kix7DYy9946fXe6hGqJD0pVsPnjJxHjauMrd
         UGo2k60Qg+A5dKCijOuvjD5h+p7fCIXwV9TXBGKO7zAKhqy3jECi659nQnWn3Xvb5nJP
         3v8sP2EiG4hnMWAS3q8tIOIl2zEmhWEteQfmYhjEheEF51A6GVDc0JVpEhVp+eZFXJQy
         5urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLxW+Mlvu7m0zTLKnZXmM91jTFe7ozK+KV0cMuAOaZw=;
        b=GIoQXFFrkYBwKe75HfM12coyFT3MD5hKRCkKAvQVGzhfv5uV00NSs1boMbcVWCv+B+
         X+I7PUNQg6Lu3s4TZUiIEJ9oZz7OQsOsDxtNN7EtIBKb+ewzv/Yks2xd1bq28mZBCBoe
         j3vl+JDlF37g6wwUMXqxqMj1H9nstAv039cAhaaM7a9txpR+V/whOmz2Q2rxXYfK2hOv
         cM214t5jnd3ofRKwwG0bb6rNyHn9Wi+pQ8CPHNk29vVp5U9B2VBTCWKzaVjnhCHTW9cI
         X91bq+3ChdDXbYOsFP2KAYdexa4iizvlqrDGaz3x96PuzUQHjN2kbgk5w4f3z/aqFX2z
         gW+w==
X-Gm-Message-State: AA+aEWY8HLU5dibZ1AQCgBxu9x3WupopAtRJn5yA8XTJUDmrNMB8Vy6v
        6oMCaVYLGSgy1J1WRhXpaDgYcsFI
X-Google-Smtp-Source: AFSGD/UbBbG2/Rrp9jhM50O5k8g0eP1L0A5vuAQ72G7O0csHhQFH5qiVPdfffTJkNMzjFV7hiIYYwQ==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr18269812pgf.240.1543959655676;
        Tue, 04 Dec 2018 13:40:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm19845310pfz.149.2018.12.04.13.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 13:40:54 -0800 (PST)
Subject: Re: [PATCH 4.9 00/50] 4.9.143-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181204103714.485546262@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <caf4ce70-ce90-1ae6-d7d1-8bde5c29f22b@roeck-us.net>
Date:   Tue, 4 Dec 2018 13:40:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 2:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.143 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:59 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 175 pass: 175 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
