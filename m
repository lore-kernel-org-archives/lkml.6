Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10507C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B984B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siWXPnY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B984B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeJLTyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:54:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36962 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeJLTyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:54:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so5791095pgq.4;
        Fri, 12 Oct 2018 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4R9ecJYnS9UPL7iseTAbNkPXffhDhUWTtc/W+PDDZM=;
        b=siWXPnY/dNp5K8TfTLAmBLG17PpFAf4iG1Ij58H8Xd4IF+4ExZTVWukcQo+0P6awBO
         3w2IdrgiS2cILU8XRqsWwePjOZR2dLyzGjXSNvjW7gR44mrG7EtG8ySvR8yY+x1WXuDr
         E7x0B0SLwJbAtG7p0lxq5JHTW3VTLELo4vA27tt2Egl+j8D2fIMQPYEncrq4lZan3LNp
         40Fxy+NwamKwFa2QX6ILjRMKg7jYExeF4K0Inkx0ifgg9vy0gvHz0+0k5cy+KgEo5jcb
         VltKtmZGkzumC/shCKEAA1qWSewzgEFxAqFMwOSoq3RZGKAcQ6vIYlrB+I8iZuXxhXyJ
         uTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4R9ecJYnS9UPL7iseTAbNkPXffhDhUWTtc/W+PDDZM=;
        b=sJl4M3bsFNJL6Xzmbqn8y/zEYqbzoBNnpHYPThlP03eMxlHgNye8gzfeqoPtjeYUs0
         WZVMws0taQRj5hn7XMLkKvm6x7GyAfSe0hJQd76gaHsAVjdZ6zbrQxUz7qkdbiDwqS/1
         ZFUpJhD6/o/El8CPEWwlF+iWoRFhGL8vbjrx7kxj5KZNWspPzdOixsogEmBkKbBrrQM4
         5Sf/bHaJBGOrv/YTKKDdsW41pC6AL3/MVZ+1B+Vhl0U+LWu+PTpU0XQANPkQRk0rUywE
         dtKozfTs4/6KinAQOVUqvEA8TIKCZZgXSP+AnsQbajbeHUmmL0X59lMJbg73u3+VatG+
         9fBQ==
X-Gm-Message-State: ABuFfog9k64ComuxDwGOYNbOkPaJYavQ1Ah8I6HWZOQwxHe1tgETKQPb
        XZbNdoptWCo9wDgjgmGIkxBOsMDR
X-Google-Smtp-Source: ACcGV61p7MXXq4hhRMgClXeSlRF0JVlwhO2KHMeTNtX24u6Tqcvo9eu+EdrY+RjJUU60HO495eLAJw==
X-Received: by 2002:a63:2019:: with SMTP id g25-v6mr5367987pgg.235.1539346927070;
        Fri, 12 Oct 2018 05:22:07 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r73-v6sm2289587pfk.157.2018.10.12.05.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:22:06 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/27] 4.4.161-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181011152534.014964888@linuxfoundation.org>
 <5bbfcd13.1c69fb81.477c6.d7d9@mx.google.com>
 <20181012061427.GA19105@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f367e7e-7046-0dd5-83c9-744e0036926a@roeck-us.net>
Date:   Fri, 12 Oct 2018 05:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012061427.GA19105@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 11:14 PM, Greg Kroah-Hartman wrote:
> On Thu, Oct 11, 2018 at 03:22:11PM -0700, kernelci.org bot wrote:
>>
>>
>> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.160-28-gb3522afcec59/
>> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.160-28-gb3522afcec59/
>>
>> Tree: stable-rc
>> Branch: linux-4.4.y
>> Git Describe: v4.4.160-28-gb3522afcec59
>> Git Commit: b3522afcec59a6a8030ebf4397f5b285b3e804d2
>> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> Tested: 39 unique boards, 20 SoC families, 13 builds out of 178
>>
>> Boot Regressions Detected:
>>
>> x86:
>>
>>      x86_64_defconfig:
>>          qemu:
>>              lab-baylibre: new failure (last pass: v4.4.160)
> 
> Should I worry about this?
> 

I didn't see anything useful in the log. My qemu tests all passed.

Guenter

