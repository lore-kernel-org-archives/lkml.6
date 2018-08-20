Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A76C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492042173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JPJk15Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492042173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeHUCsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:48:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43722 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHUCsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:48:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so6204364pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=O0RieqPuHSYBQviRy4Cb+OmSkpSwzByDgN1bReVfEHQ=;
        b=JPJk15CzQwn0RqHL/wmte4Ur0ZLDQCF5/PVZCyZyNsO8HAXNmI0GcIp8SmPnmZyevO
         WGY2dY/ZvL5SWJ7PtciyoOp/g5CRlzvGrIyzPqUDT6SNiBA9k6MMeD9OeTo4hQBjP7Zy
         Twzn1DHWWrInnJYs2MdwYlo0GyUXhWUQ9r7pxIESjRnfdimw2bSjX9VF6bfjUR908Xz5
         HcSCBdKisdG6c3fjQVGhDmidmv3s8+2yw+UuwGpg5ZvptWlVvg4/0PIueZVNaKIaic6Z
         gA65JYE9XUA1Hh04GCzVNcP3z+gAuTX6tMbiVubChONA17Ky35W4+4UB7QwXVBCgdLIz
         KNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=O0RieqPuHSYBQviRy4Cb+OmSkpSwzByDgN1bReVfEHQ=;
        b=fRBIrH/8snG08N+yBl8UEr0gRGt5ZK0YRNFMdnqcYmXVivz4Yzi3WXx2+asZBBaNn4
         zq2b/2gWE7REJbZ+ItsN6iA4XWO/Me+9/H9Dar2bSBLQfXSfJpu/4MzCkKz3yKzjzt8O
         ncOHHfDP1Ps3UMo5mhnQ/AwHHPu+d2cQSamGmEdCq1j2r/yJr16evTTKCbqNJ3YnfszY
         rOCYnymmDZObTl/fZ4P3K1eU9hkeErAcBGbGwrYdUNlE7BhDwr1jhhC2tzt+U2EQMQB6
         o9oIkGoHGtfI5s2iukhD0guc72cb9Ass5c2Hm/7Bal1iz+lQ2IcMbwjQFq+FBeuoMyko
         yW+g==
X-Gm-Message-State: AOUpUlEpCZ/IB5aaDJKEG/GZAWHIe0EwxYrlpA5c++nUoF6dMgmakMiu
        PY1B/HSSIRyM2Bt9TmZOKInqlw==
X-Google-Smtp-Source: AA+uWPwuZ1GuU8DibklJl0MZgPoJComtZ9dkz+1yCk08V+0xsaSqUvE7i6xdSrtSCkloWKoa9T2LbQ==
X-Received: by 2002:a62:3601:: with SMTP id d1-v6mr50617947pfa.41.1534807843194;
        Mon, 20 Aug 2018 16:30:43 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k64-v6sm18004792pfg.141.2018.08.20.16.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:30:42 -0700 (PDT)
Date:   Mon, 20 Aug 2018 16:30:42 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Aug 2018 16:30:26 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
In-Reply-To: <20180814134027.GD28080@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net,
        aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, marcus@mc.pp.se, tklauser@distanz.ch,
        linux-riscv@lists.infradead.org, dan.carpenter@oracle.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-3e587858-d566-4fea-91ef-4537784358b0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 06:40:27 PDT (-0700), Christoph Hellwig wrote:
>> index 818655b0d535..690beb002d1d 100644
>> --- a/arch/riscv/include/uapi/asm/syscalls.h
>> +++ b/arch/riscv/include/uapi/asm/syscalls.h
>> @@ -1,10 +1,13 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0
>
> /* ... */  is the right style SPDX tag for headers, so please keep it
> as-is.

Thanks, I didn't miss this one so I managed to fix it before the PR!
