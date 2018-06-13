Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C37BEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A36208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7WShraQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A36208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935732AbeFMNtE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:49:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41962 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934527AbeFMNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:49:01 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so70178ply.8;
        Wed, 13 Jun 2018 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pt+bCDikOJLasVU0fUCkxQdDamQPIrwI5yraM3UT+sg=;
        b=s7WShraQ0cDfg+fnNz1XrkesH7yfk8bjxEbL53HE+PTsoJ9FJh1czkJVc7Z1cBKpXp
         Dtm8xeKoCZZzv+4LRceuc+1g1lIQld+uOVVdFvf8/qvE8Oay0mcWNe8V1aKky3usQohs
         a+Pt36eTxrTnrTo/JKVwqPGg9HLKWNptMJI+oi+XcHi/2SX09MXtVnEqRLYz8RhG9M9m
         hESNRqQi7PKJzt8x0n1TWhQdX2GXTGwX6YvHFtaavt/Lt4DB8A3CuO/5IlDUaJZ5EoRz
         ffIUYIh3pbfScaveBp2wMVPxFHcoj/CmdOIwPhTzFtNnpsrkVUuJAjLdU88Q41QSqPVL
         cDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pt+bCDikOJLasVU0fUCkxQdDamQPIrwI5yraM3UT+sg=;
        b=Fq8+5eUESHInBkDMp49jOLyj1MS7DiOHsl80g3SIKZM0tCXuS0MRCYsRakN7RmYirc
         rzonk5oVp8wqLxNqhb9BMXvd+fekFuUA5sHajiLjDuLuL450z0bGvA4KuBF/JimyyAxJ
         v59Eip96/ej9J8yOXdATKvRGpw0Q0CrlAWUSIz2jR+OtTn3Sq5DQ5/6lWXHywW2m5fEF
         Hrc7b8QDL3+Wj4391UqKPShYrCWaA8oNuu71oAFhT/3TxwEXGYakVSyWNAwMwhFd9PmF
         CFUJ74licvYE8aw2ROw0zSVLINDnOXXwmKfhAq2HX2WPA1nnt8WIoaaI9PoZ9xUmvmxd
         4GPw==
X-Gm-Message-State: APt69E3SKyQZ8IUsQhh9gnnipQgXOR2GButykZXuLU0Ka2BEY2t0GMVJ
        /rwhyde7OQ3ZwKKWmOUTcfc0XA==
X-Google-Smtp-Source: ADUXVKL48qiWQriUyG4M0sbG1h5SEGXPuICNH9+6ld47wpgNRC/68ji9Md/XzNHSP5jetL4IFG5VyA==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4-v6mr5256370plz.139.1528897740428;
        Wed, 13 Jun 2018 06:49:00 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t21-v6sm6360661pfi.22.2018.06.13.06.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 06:48:59 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180612164816.587001852@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <67a2ec43-e382-c464-7dc8-3f445bf544c5@roeck-us.net>
Date:   Wed, 13 Jun 2018 06:48:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 09:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.137 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 16:48:07 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 135 pass: 135 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
