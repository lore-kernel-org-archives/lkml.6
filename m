Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A2CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A3E2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="U6SAA6gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfBDWNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:13:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36273 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfBDWNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:13:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id d12so284128edy.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eaf2s4SifFoxjZ9loCqpVzPnBBlKLmFK4nwcN7HHZXI=;
        b=U6SAA6gjHteWdOabKn/7gmeTV8fGQbVHf6Sjjkw8yWRMCSIEaOxi9lq9Em3JmYGiyz
         vnEdknePJuOjqnlCYmjVSyaAcFZAusIx/QIwnGaXRU4nGDxvM4YfJUNMdYcpS44N2CmP
         H8+t4SPr/dmAoZ1PT/a24Sy/ppuo+8QyRgYWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eaf2s4SifFoxjZ9loCqpVzPnBBlKLmFK4nwcN7HHZXI=;
        b=fqiWFMg1Tenr1GC8oObgl8jXvFEAEnruIYI55/pb34+XPtdLnWoovHhwWlNBF11oE9
         0MiwKWFint6+kC0KZ2Z+Cgl2oMvo28WwbKqN0SxiaoaOdEUyCe9lEdTVmrrk3e4Kmjog
         4zsDFauGVNjmdl5yHMjoz2DTBPmHuS/VlFx0RKtH92437hzh+fW8KB737YiZsazWhBZZ
         ULLziUywh3loqABPgV1pONQ5fvi//szAY6PY8SM2yqbL8K705LkbMZR8Zo6nHJPmOlnC
         6ejfxQFr3Rt2AsF5VTQHQsyrl8Ru2g79EoGKE+Ak31yG0akQJawRC4uKVUdOmI7r91HK
         SFjA==
X-Gm-Message-State: AHQUAuauqafW0vNzsxyFQmEqOFUaBArpxp7BZ2POWnuSvNc7C3f812vz
        NAcFYuZnhkr7CyE8dTVRr9pO2aFHwJlEePJy
X-Google-Smtp-Source: AHgI3IaShq0EcdZl+2FePaBWnOYGwjOfeLQlDtxeZbl/uQKxdi8D3wtkjcw8uwdcgPhkZbUDRhA1mw==
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr1184736edy.231.1549318378692;
        Mon, 04 Feb 2019 14:12:58 -0800 (PST)
Received: from [192.168.0.189] (ip-5-186-119-68.cgn.fibianet.dk. [5.186.119.68])
        by smtp.gmail.com with ESMTPSA id l17sm2681350ejz.18.2019.02.04.14.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:12:58 -0800 (PST)
Subject: Re: [PATCH] xfs: allow disabling xfs tracepoints via Kconfig
To:     Dave Chinner <david@fromorbit.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
 <20190204215332.GB14116@dastard>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d66f2c2-bf5c-be47-9ef1-e581c5901823@rasmusvillemoes.dk>
Date:   Mon, 4 Feb 2019 23:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204215332.GB14116@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2019 22.53, Dave Chinner wrote:
> On Mon, Feb 04, 2019 at 10:20:35PM +0100, Rasmus Villemoes wrote:
>> linux/tracepoints.h allows individual subsystems to disable their
>> tracepoints. Add such a knob for xfs. Disabling XFS_TRACEPOINTS
>> reduces the resident size of xfs.ko by about a third, or ~350 KiB.
> 
> Ok, now we can't debug typical problems on live production systems
> if tracepoints are turned off on the user/distro kernels.  So under
> what circumstances would we ever want to turn off tracepoints on
> XFS?

I don't expect any mainstream distros to turn it off. But for embedded
systems that use a hand-tuned .config, being able to shave off 100s of K
of the kernel image is quite valuable. Tracing _is_ useful,
also/especially when doing embedded development, which is why "just turn
off CONFIG_TRACING" isn't really an option.

Would the knob be more acceptable if it was under CONFIG_EXPERT?

Rasmus
