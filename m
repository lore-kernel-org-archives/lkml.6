Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E3C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E362081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJi+QpkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E362081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeKCNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 09:03:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 09:03:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so1891139pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 20:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/FtJpVoKv5A+l0Ca4++G5CdkOOjxDITxQciRPEIwt5Q=;
        b=LJi+QpkK6730jsZ2POMYs0br06gsBjvHNVv5hZidOoyACucVsxee7PbBjp4Rq3mfVy
         mPprS92jKufDRpsEwoneb8tfY1yqw5HurlfSjsNCeOHk+nQVzqKS65R+b7p4Cqj8kXpb
         hiy4DyFX8xcM9rFY4WZt5Jgz2IhW96wXq7+P92+T+wud3/8G5MtsnuTOBgNFRomuuYY5
         Efb5ttUMlRUU5u+RhLqo7zRSdbWN+hrjb9bPHfp5rYkVLtjBI/VRSrKpa5oDu8j7rspf
         kSDuHmA87WnmSu/Ek+sie5Uqxu6ZBEvYuKvpZUweIyFEeTtDSXHa0GHHL3pAsOIEuVBW
         WjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FtJpVoKv5A+l0Ca4++G5CdkOOjxDITxQciRPEIwt5Q=;
        b=t5Uus+uGLN1L5igzrsmxDcXSffZ+UIfvIm/ncsGCLTOJEa4hN3cNIQ+X/YIcPB42oZ
         sWO1sgNeoLjIg8irBNCmrR+mbXZ2PqcCC8kWO//k5QeUtloJ8X1HLJ1R5tL+lDx+ONd1
         T6zUjSWgb1UEkUH+gHgqQY57pjR9493R3hO0CO9bpvE8YHWNnI79DromWr61iwjajMn+
         cCiJlJ/lE5fjZ4cmksUns729CxCcqxUFPal0y9rGgrh2UMdjGS/LhesTLHGRfabQV4n2
         DpLKxNUWMQ7vySP4JB9F6fEqEH6OZ5sYW9ixT3+vkkmuyOyfnwVFVc5EE5LwQzN29Z9G
         J0zA==
X-Gm-Message-State: AGRZ1gIv09iKFUVqWR6uGHs9pDdM61vzc/gVwk63hAQ6v8+jKz7sKLe4
        Uh/jNVmJFvQ5W99G+J1FwqoiXfAA
X-Google-Smtp-Source: AJdET5ftZqR6Ztr9F54fKrJMqfXRwJhYzPhmCf54pd+vItp0y3/4L2xNpOHl7ACtt2Qke5X4j1ZxnQ==
X-Received: by 2002:a62:4681:: with SMTP id o1-v6mr14122577pfi.108.1541217222256;
        Fri, 02 Nov 2018 20:53:42 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:49bd:4cd1:c202:8fdd? ([2601:282:800:fd80:49bd:4cd1:c202:8fdd])
        by smtp.googlemail.com with ESMTPSA id 124-v6sm47947660pfb.132.2018.11.02.20.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 20:53:40 -0700 (PDT)
Subject: Re: [LKP] [net/ipv6] 4ed591c8ab:
 kernel_selftests.net.fib-onlink-tests.sh.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20181102021145.GI24195@shao2-debian>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <57c4c8ec-4a81-bbee-c153-54524b26da11@gmail.com>
Date:   Fri, 2 Nov 2018 21:53:38 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102021145.GI24195@shao2-debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 8:11 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 4ed591c8ab44e711e56b8e021ffaf4f407c045f5 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

our mileage varies.

When I run fib-onlink-tests.sh I get:
Tests passed:  38
Tests failed:   0

The said patch does fix a bug with onlink routes and the test cases were
updated in the same patch. I this case you can not mix and match tests
and kernels -- ie., running new tests on older kernel will generate a
failure. I am guessing that is the case here.
