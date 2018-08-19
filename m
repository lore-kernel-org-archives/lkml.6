Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C34EC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C521473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 08:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8C521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHSLcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 07:32:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41380 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeHSLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 07:32:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so6722760edr.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 01:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cP/Tt2+9cJzpLydmihe2xsRKHrM/0fuVyLO3+CY3MEM=;
        b=LHFJKzff2+hw+U0jer6NhuEow491a1rEfcIVGnLczp84k33lM9k/hY5CB8de2PJUhN
         JuelkqQLJ4BI0M8lVFTuoxJYGS2O8JNySm2GmC2Vq80G9u7YQBdZ9bIW7asOwXZeZiHj
         LQuSKq4aXbtwpC+X7ey2+3XVOYRICgeUVIITykybAM5L+/8N+RVVrufSVl1KVRlbVgpi
         WACxyOpaNlDD0qzwx5ODDuQXKzHQNwjBUbK19duZbnGB186Eq0i6sPcxP2WGdei9rcHS
         YeAcyHHBw0vcUkzDAOkCcXlURhHZjL0igM0q1VDD9LAfCosSwRzjAONOSqd6/b6Jbz0/
         QtIg==
X-Gm-Message-State: AOUpUlHZphNLoLv7D805UluazTHmknpRn/ciYOMswca93tHc6pp19v1q
        VCZiAfkXiWJTfisf+e5KO54b2dZmiik=
X-Google-Smtp-Source: AA+uWPzzt0CfK9tfgu2FUacBXVtzT7CouWTJ1nZc6YbYCiwzM5VU+iXV3Bd7Q5B4MTxVoRc/dBApoA==
X-Received: by 2002:aa7:d91a:: with SMTP id a26-v6mr50858926edr.102.1534666902251;
        Sun, 19 Aug 2018 01:21:42 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x33-v6sm6286287eda.81.2018.08.19.01.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 01:21:41 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257 <youling257@gmail.com>
References: <20180819003523.398f06e4@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <737bf0b7-ccec-28e9-1675-555eafb42095@redhat.com>
Date:   Sun, 19 Aug 2018 10:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180819003523.398f06e4@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-08-18 16:35, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    cda5915d15d3 ("platform/x86: touchscreen_dmi: Add info for the Cube KNote i1101 tablet")

For reasons which I do not know youling does not wish to
use his real name.

So as with the "platform/x86: touchscreen_dmi: Add
info for the ONDA V891W Dual OS tablet" patch,
I've given my S-o-b for this, where the intent of my
S-o-b is to certify point c. of the certificate
of origin, quoting from:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

"c. The contribution was provided directly to me by some other person who certified (a), (b) or (c) and I have not modified it."

Regards,

Hans
