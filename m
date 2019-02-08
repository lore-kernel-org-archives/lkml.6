Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20318C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E193920844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qZXQTCeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBHNdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:33:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39664 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:33:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id f132so1680324pfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R//D5hhJAl7Ot//RTtLFQbM0iPV9AIFAuYJrz/swsJs=;
        b=qZXQTCeLTO/PiAw5P4ewu6LUpr4iqvqZ8cFNGAmRP1qQ7WTPrlaBYDPXqjvOpl4hDA
         RzfMdzN5UmrVVr0n2nDGrzqkDqQag+zcvRKmZwRfL6xF5FWlw12y2hPuaoC4z5hw0qxX
         Ptpi0UUJX5dIj4egT7LpsTaG91AxDeu35BqA5bZ2Ix++vE9HtYlPLfx5ROq8/WoUHLTl
         IEUB9wM+R5bvRLk+9ImwLiFFUisXKyJiZ3cvcV4FSNXEom0hQugH60i3iF1oA78GCBxE
         gne2Ws62gTDPDAwjyJcxP52aczwnM8xmFISG84vt+vbPuOl/Pxx5ukACaOYTMKwzigm9
         zdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R//D5hhJAl7Ot//RTtLFQbM0iPV9AIFAuYJrz/swsJs=;
        b=bRerqDxTeRMO4lfa8FpNInrWr4NFrkT2TJtWEsYbc6m5inRbCM9SUcCiQIL/fhuzW0
         HPqCPEFE7ONgV7LVQshFxLXfoCXk6wjavyNWwvDbf9rVw3JWQmylX5GIayvomZrQBWK4
         QC7B9YBuRzAuEzriJTTkA1exqu2pgYJgQR4z3YvJmmaXnZNhf8Sng75pck6PfLy+LW3U
         SUIY5xVzB0IyMIZgcXbD/5VGe6f4Whd5cfPUyqEd9SwmRh3TzVk5TO6JZJIksn0wkUH9
         z9/Q1lMnx7GwhH9+mEE0GJiN+u4baGCEL92LlG+kbsBx8bwV6lCnuLKlvcUF1b9cb6AR
         4BZA==
X-Gm-Message-State: AHQUAuY14DGXUBH9JGtAALqoYtf49x0a1TH4MrTi8o+GnqL+eQQhJe+J
        BDUlJAJ7zeSha1yOnn/XttA5bMdFTlb1Og==
X-Google-Smtp-Source: AHgI3Ib9qd6d4+sHdNPW3EE5S21Cu6sk3DQClzpapsGa6Z0GtU8zCEEeP4Bx4aY+5EOgoXVPu6dSdg==
X-Received: by 2002:a63:4665:: with SMTP id v37mr20707872pgk.425.1549632799104;
        Fri, 08 Feb 2019 05:33:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 125sm2663260pfg.39.2019.02.08.05.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 05:33:18 -0800 (PST)
Subject: Re: [PATCH v2] ata: add Buddha PATA controller driver
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
References: <CGME20190207122046eucas1p12d098289e0370252d341ccfed66b8295@eucas1p1.samsung.com>
 <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
 <420634d6-c14f-8380-0980-548fc4740474@physik.fu-berlin.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5019eaf-6f66-1971-3593-381664b55f65@kernel.dk>
Date:   Fri, 8 Feb 2019 06:33:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <420634d6-c14f-8380-0980-548fc4740474@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 4:38 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 2/7/19 1:20 PM, Bartlomiej Zolnierkiewicz wrote:
>> Add Buddha PATA controller driver. It enables libata support for
>> the Buddha, Catweasel and X-Surf expansion boards on the Zorro
>> expansion bus.
>>
>> Module removal is currently unsupported (the old IDE's buddha
>> driver also doesn't support it).
>>
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: Michael Schmitz <schmitzmic@gmail.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>> v2:
>> - added Tested-by from John
> 
> It's a bit confusing, but my primary name is Adrian, despite being
> the third one. So if this ends in a changelog, please change this
> to "- added Tested-by from Adrian".

The stuff below the --- line will not make it into the git log.

-- 
Jens Axboe

