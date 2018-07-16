Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E8C208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E8C208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeGPRIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:08:34 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45335 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:08:34 -0400
Received: by mail-qt0-f173.google.com with SMTP id y5-v6so33396902qti.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uaM+I1p8fSzVWDIFmUGY1/tR/OjATCKWDFya/OZff7U=;
        b=EndAA3CoDzrL7fxZEjeriLad6vDv5j7EmOy+JOLt0iFxIV2X5ZuREuufSKzlS9bf6D
         3ReG55dWERKqa6WrjXRaRoyn3+oZQ2lCjedLFjs/kR6S9EDDLdTqV9eyfvqGfMM/+lcU
         EwmZ6Tgm9jdZbm2XCKjyCrEKrYeGbah10j7EfKvY9aFuAJzBdOAdw1IztvtII69pigBz
         N8rNArE+4bJxSOMXEstFQh/lNWTAQVSEGgq9eSK9LffsbP9tuw+9cj9Bd65rYuGelmsw
         Ag90nyeJsKFmC1IPmDsm9oQYsJsf2A73uPN/6L11MG2Ulmzxdi8jcSAEXOXDlfvqrWES
         Du6g==
X-Gm-Message-State: AOUpUlEAU0iGWFdDDk8/siF+KTjp90vy961J5qoGch/by+ncOO8EW4vF
        i0ZSXh4XhDT/6R4Z2hn9Ls6W+w==
X-Google-Smtp-Source: AAOMgpekTzvXuZoZkmRrz6d1eS9pJFBTVnLWIP2nlQrAguZ9V+i3nuHXwYauQWCf2FRvfBLBPq5UJg==
X-Received: by 2002:a0c:8d8e:: with SMTP id t14-v6mr19380239qvb.32.1531759222027;
        Mon, 16 Jul 2018 09:40:22 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0? ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5614189qke.92.2018.07.16.09.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:40:20 -0700 (PDT)
To:     Christoph Hellwig <hch@lst.de>
From:   Laura Abbott <labbott@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aio@kvack.org
Subject: compliation error with aio_abi.h
Message-ID: <05018ab0-37ce-37f3-e032-7daf0338a75d@redhat.com>
Date:   Mon, 16 Jul 2018 09:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1601529
with 4.18-rc4:

Steps to Reproduce:
1.echo 'int f;' | gcc -include linux/aio_abi.h -xc -c - -o /dev/null

Actual results:
/usr/include/asm/signal.h:127:2: error: unknown type name ‘size_t’
   size_t ss_size;
   ^~~~~~
In file included from <command-line>:32:
/usr/include/linux/aio_abi.h:115:2: error: unknown type name ‘size_t’
   size_t  sigsetsize;
   ^~~~~~

Expected results:
no errors, as in Fedora 28 kernel-headers-4.17.4-200.fc28.x86_64)


This looks like the structure that was introduced with 7a074e96dee6
("aio: implement io_pgetevents") . is #include <linux/signal.h>
the correct header? This breaks compilation of nginx
https://bugzilla.redhat.com/show_bug.cgi?id=1597674

Thanks,
Laura

