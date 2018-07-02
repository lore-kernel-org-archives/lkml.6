Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A3D25316
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="c7FbQ3en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A3D25316
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeGBR20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:28:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43701 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeGBR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:28:24 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so3649695oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bd9PTMEk7HpAhoZLpt3NVQDwe2cIxj/FHiufqLrCzhg=;
        b=c7FbQ3enkuf3E607Ujv88xfxlczqCbo7fWKWh6x162WXz/b+AmY7s9QldNBLIi9gqh
         hRvBOj3TyDFFmOkCkyBL7k1pXqHYeaTg38uTxf0U2h1AQiD4TZZ9OZwB5GyqaOrcu98E
         ydEVSGs+c8xNNZ6ArvZsYmnVdp0NY9l4UwXJdMJ3nE0eUEEMXuwWPZKQ39V+MJnj8dBp
         7vqnaYCZFAVq5RSJo0uOY3kuBIiCfk1nHUWxe5W+BcH/rXfxfV6qp5pP5OF3we4+Tv0/
         5tVOGOF/E4bXsYlfpi0jZxfAKOAwKUygLXXs767usTBuAMskbHuTh+/lZ/zqaXTCS5ay
         2ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bd9PTMEk7HpAhoZLpt3NVQDwe2cIxj/FHiufqLrCzhg=;
        b=cWtdvSqvgpzyj2LLJujiPjYOuxhGPA6FMhndliLa6b9nbsITVtT6IPWIK4APiNeeiW
         EVnaVDZpEBd7TJUkViMHa7e+6xzKDjOrfCRl7ioSWhev4nhGAAqfZVE6zOfnyWs30YP/
         53VGCALn5IDrALBke6t4SPDjFAthFlRpY0GG0cKqnJhNevLDcLyaMmVBryg7Zmj2EQpj
         nuDj6uwbj+k1oIP7EbOjtGBLLexG63EX7nDduEcV2NEEe48lcfTsFayc+VEiz52Zyxuc
         MlA90P/SX/0olp2dM+21D0pJyo5F0rhnVSSJkJ/HfOiFBOsjdmn5SkWdBxIU2qgh8xh/
         c1lA==
X-Gm-Message-State: APt69E2ZUfq/Mw5Hey6USkQIL9D+bGJmW+mgkipiQQOOt6ICppe4x2hx
        81K6n4zpLpa/gnb1AyWv7vUxAXzXJu3ViPpZx3OemA==
X-Google-Smtp-Source: AAOMgpek0LeH/coUSjiTNbrMYyjqDHR0PsHpxQfqLz6fisPME9J5V726BU1Qly42GH2iW5IwyJvDTMnpf2u3Neq+iAw=
X-Received: by 2002:aca:5155:: with SMTP id f82-v6mr10561272oib.272.1530552504159;
 Mon, 02 Jul 2018 10:28:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:28:23 -0700 (PDT)
In-Reply-To: <788aa605-94c7-f730-6ec6-0eac53cb10cf@virtuozzo.com>
References: <20180625170259.30393-1-aryabinin@virtuozzo.com>
 <20180629164932.740-1-aryabinin@virtuozzo.com> <20180629193300.0ae0f25880a800bd27952b15@linux-foundation.org>
 <788aa605-94c7-f730-6ec6-0eac53cb10cf@virtuozzo.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Jul 2018 10:28:23 -0700
Message-ID: <CAPcyv4gN_f0q2a+e2-cXZoDGwKe2DfcMcHMZnf3UmyWp+dekSA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/memremap, kasan: Make ZONE_DEVICE with work
 with KASAN
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>, kasan-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:22 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
[..]
> It could be possible to not unmap kasan_zero_page, just leave it there after devm_memremap_pages_release().
> But we must have some guarantee that after devm_memremap_pages()/devm_memremap_pages_release() the same
> addresses can't be reused for ordinary hotpluggable memory.

While this does not happen today we are looking to support it the
future. I.e. have userspace policy pick whether to access an address
range through a device-file mmap, or treat it as typical memory.
