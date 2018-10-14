Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B2C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E820645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpICcwFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7E820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJOBUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:20:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39217 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOBUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:20:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so8047376pgv.6;
        Sun, 14 Oct 2018 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rQ89p49vK2OnicxMYu8Qwa9kcC0lkeE0a25l2ZKCvgA=;
        b=BpICcwFy5nbbVumutvqFPB5WUii9QorGxSqpmmYYiBXnFx+HzmCvCDfgf7MomLBiKs
         RYq1V/RHjFwNc4yT9ZZSKLTjP7jLRDpOcr9gY0XCKF10VTNx/dSL1Cdp/9AogBRXbiVv
         CUk4/NQWsEfhx5VHhTN+QNtIxrhLhMyGSmbBWdxhMF2anKKa3RSUPTCQA0D96NTHZGRo
         29K6zCj2Mtfph+xGNXqEeBY17JykgMw0AAWNLNHLnt5eTbNUse1403w/9JE9gI/A84cT
         9lKirptkit8U6j24DzUgghjhZ891ZL2kiv8aOytaO5pXyrsdgju6kNuTYxEasWDKta/7
         uPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rQ89p49vK2OnicxMYu8Qwa9kcC0lkeE0a25l2ZKCvgA=;
        b=LVowTpyDRz+86zwpcnA20/W316783/mkJPRYZdEyGZJAKHhO5CqaLsZIvWe0L4QIRG
         vqLbHPyMpnAQM6YiRVCjH0l+QMUropVLjt5ioStOlXpfuTqFiGiD8f2uRKFIhfgkY49H
         Ua/YDFvaJ0dT22p/M17oS0BskNLxUFkORSGbwIwj5uNlf7wNPJQTlY8D82FUSN84QC/M
         XxflA7hcdw/mNnxM4Pxfl+cSzTbOVA7Y4xqsvvo/hQrpZM6ueYxkfDxmmBAcQpIKDM6+
         klwp+o/G3oyKthIHmRQ+aBlHprsxw8g3iVx7BxqV4RS77xl3wOkgbU8z7s9AShgL3puG
         lyOg==
X-Gm-Message-State: ABuFfohKc7PZzukk6EmTDKqFWLuLQgwoYp/cGMm4Nzmb+c9odkGyyc2s
        ndpSCYzvsF/mEd3ITngZmNjnFcSR
X-Google-Smtp-Source: ACcGV620Q+G9KEUW38N6gioyI+AbqBENL2kXqWuMU1CBFDOnbalaE6lfKEzPClFwGQVdIJKVAzqZ8Q==
X-Received: by 2002:a63:6d83:: with SMTP id i125-v6mr12671870pgc.215.1539538703417;
        Sun, 14 Oct 2018 10:38:23 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z14-v6sm12939781pfi.4.2018.10.14.10.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 10:38:22 -0700 (PDT)
Subject: Re: [PATCH 3.16 000/366] 3.16.60-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org
References: <lsq.1539530740.755408431@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <46b33bb3-56dd-3dc9-2ca5-ee490f01b665@roeck-us.net>
Date:   Sun, 14 Oct 2018 10:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2018 08:25 AM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.60 release.
> There are 366 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Oct 19 17:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 217 pass: 217 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
