Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0365C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0E20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="btBLGsbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBHNcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:32:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38268 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBHNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:32:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so1709022plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/2FOjdb5DT51wxUvdVz5+XGFiv3LxVwvcKGgtXgyQg=;
        b=btBLGsbsJDcjS6Q5qptg/tsWyMHZuj5rmcw1h1MUcVek99YYTARApGEGGZiIdtdZNu
         +InK/kWgCGSvZ1x5007GOZeMHW/PL4O+xXfZu8KpbobFy6QLEk335AULVgjKYeM5UUdO
         shxpX81tlfULmm99haj2Ex9p/esSg2kv824UPLcW1jmXosE7cFOD+dd/Aequl3TNa90i
         w442fI2jqfZx8HZVof2OZJci/La5QxKo8/kG1v/oPNVzEYr8k72v1lwWvJJlQ5+lvnux
         JSajTVJM548eT0P8WOo/hJcfwEHwCNGTfXIRlNf99pPxqZDhpkfS6m3/8EokpTWYzv0v
         iCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/2FOjdb5DT51wxUvdVz5+XGFiv3LxVwvcKGgtXgyQg=;
        b=HoSafX1+Dlv1eVM8rNOzMka5z3PTXIQ46HSRRAiqH9y1N35ICTSVszvBu/+ylURCQ2
         OQOwtB28m8VEO7cTA4xySQtbWGV6XN9hNeFBoegEcPgp2dcJah33l7rIvmuLykf3hSm8
         Jw1BWxxtEllmMxRKv3ob0XyDc2zoPho+cnG29eFrqTUaqwtVCYXcu/4bRso807lr+7k6
         urNQfy01xa++K7BFPOc5EFOW9qXGXNVQYzrC3yDHAIKL7HjGVtx8i6bPM955AOAhKiHU
         NChV+bgKCuvNPe+j6cvT6JbLLzscFyEaKopSh2jV3dHzA8tps7FEomamYT7CUPSOnCJ2
         6RtQ==
X-Gm-Message-State: AHQUAubTSRml6w7YGU11BeMlDpth52P9jpSUSuuDpxPPBGZMq7XUm6bI
        o42J2odxDWRJRqxMjDHHS1WOqTygOX3W1A==
X-Google-Smtp-Source: AHgI3IZTXz2gXgIVMctukQAwTyrOvsjppQGBCFVRh+Pis4c8G0t4q88vZGbMVgyzRfDjpkcONHmScQ==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr22682126ply.132.1549632768150;
        Fri, 08 Feb 2019 05:32:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a13sm3431510pgq.65.2019.02.08.05.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 05:32:47 -0800 (PST)
Subject: Re: [PATCH v2] ata: add Buddha PATA controller driver
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
References: <CGME20190207122046eucas1p12d098289e0370252d341ccfed66b8295@eucas1p1.samsung.com>
 <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <84b22f87-3301-523e-3966-cff233e740c7@kernel.dk>
Date:   Fri, 8 Feb 2019 06:32:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 5:20 AM, Bartlomiej Zolnierkiewicz wrote:
> Add Buddha PATA controller driver. It enables libata support for
> the Buddha, Catweasel and X-Surf expansion boards on the Zorro
> expansion bus.
> 
> Module removal is currently unsupported (the old IDE's buddha
> driver also doesn't support it).
> 
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied for 5.1 thanks Bart.

-- 
Jens Axboe

