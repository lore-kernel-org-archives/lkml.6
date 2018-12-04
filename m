Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9380C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB62087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="grGsq47V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EB62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLDM0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:26:24 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37509 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:26:24 -0500
Received: by mail-lj1-f181.google.com with SMTP id e5-v6so14736999lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 04:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Dda4lOs2zW4dx5jVqQc/qfmj9NTXLLKeS8NtINDVmnA=;
        b=grGsq47V9Jfg/ahynXX/Sw9iC2s3/CL+HjmpZtRg/qwSSMRi0db+UmclMmzLKcTzMk
         s5p0KxqOsZlg2jDCIimvnmcKYOrQeMYT7i5hHDkYqJListxIGwhaa6Mtl+XaRNXQmwCf
         faYrYjHLnrbZ1e1WGfFv40U+vnTH/NM6FVOxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Dda4lOs2zW4dx5jVqQc/qfmj9NTXLLKeS8NtINDVmnA=;
        b=sgCRCsHzaqELOeTnZylpBDcxzxFSn0caYd6P8OeMXWD1BRL2ETcdWJ/Jm6fETI0+sF
         bddHN+hu5VsNIwn5ipJTpXIcMn/WOqlle0GDmXVmzljXm6O9wey9nuMoXnn3yf2hJ72H
         ApizXzahZUPVM3SuAwzw3o7isN3qEZhnm/vWKUXWxDnjcqe3drpOk8EEIhM7GYN9q1Ft
         Sbn4VMLnj8s0edZGGotd9ERhBlUqIwghZyi/eubfvAgkeMnRFgswDFTh35+nge1Zsuob
         MwDPnmT1aP+uQQSvZyHHZt8YLmY+44tynPMBzh7e50Rts492DTcQlMUTcBNTDxbZT+Up
         YuaQ==
X-Gm-Message-State: AA+aEWYrnH4IjslsuPQ1x2OpQrABHSPuC2oKvqYb5HrMmxGVCVlLpc3m
        t3HGzmfQptOcK/sO2sDG6EEwgIJxhxBJiYInyLaViA==
X-Google-Smtp-Source: AFSGD/USqL74wVSCxY7vU1LOS34PGG2ZWxMVTIZWi1T4QYsmeeMuaNDnL/bMgIpYmvnOe602O7QMd/A1hwzxc3vSLqc=
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr13660079lji.130.1543926380409;
 Tue, 04 Dec 2018 04:26:20 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Dec 2018 17:56:09 +0530
Message-ID: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
Subject: Linux-next: Build failed
To:     Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

The Linux -next build failed due to below warnings/errors.

include/asm-generic/bitops/atomic.h: In function 'set_bit':
include/asm-generic/bitops/atomic.h:17:2: error: implicit declaration
of function 'atomic_long_or'; did you mean '__atomic_load_n'?
[-Werror=implicit-function-declaration]
  atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
  ^~~~~~~~~~~~~~
  __atomic_load_n
include/asm-generic/bitops/atomic.h: In function 'clear_bit':
include/asm-generic/bitops/atomic.h:23:2: error: implicit declaration
of function 'atomic_long_andnot'; did you mean
'__atomic_test_and_set'? [-Werror=implicit-function-declaration]
  atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
  ^~~~~~~~~~~~~~~~~~
  __atomic_test_and_set
include/asm-generic/bitops/atomic.h: In function 'change_bit':
include/asm-generic/bitops/atomic.h:29:2: error: implicit declaration
of function 'atomic_long_xor'; did you mean '__atomic_load_n'?
[-Werror=implicit-function-declaration]
  atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
  ^~~~~~~~~~~~~~~
  __atomic_load_n
include/asm-generic/bitops/atomic.h: In function 'test_and_set_bit':
include/asm-generic/bitops/atomic.h:41:8: error: implicit declaration
of function 'atomic_long_fetch_or'; did you mean
'__atomic_and_fetch_1'? [-Werror=implicit-function-declaration]
  old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
        ^~~~~~~~~~~~~~~~~~~~
        __atomic_and_fetch_1
include/asm-generic/bitops/atomic.h: In function 'test_and_clear_bit':
include/asm-generic/bitops/atomic.h:54:8: error: implicit declaration
of function 'atomic_long_fetch_andnot'; did you mean
'arch_atomic64_fetch_andnot'? [-Werror=implicit-function-declaration]
  old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
        ^~~~~~~~~~~~~~~~~~~~~~~~
        arch_atomic64_fetch_andnot
include/asm-generic/bitops/atomic.h: In function 'test_and_change_bit':
include/asm-generic/bitops/atomic.h:64:8: error: implicit declaration
of function 'atomic_long_fetch_xor'; did you mean
'__atomic_fetch_xor'? [-Werror=implicit-function-declaration]
  old = atomic_long_fetch_xor(mask, (atomic_long_t *)p);
        ^~~~~~~~~~~~~~~~~~~~~
        __atomic_fetch_xor

cc1: some warnings being treated as errors

full log details,
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=rpb,MACHINE=juno,label=docker-stretch-amd64/407/consoleText

Best regards
Naresh Kamboju
