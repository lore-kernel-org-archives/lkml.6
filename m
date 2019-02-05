Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2802C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAAD2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Pxs1UWNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfBEJxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:53:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42944 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfBEJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:53:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so2125676lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MDQaSgo9RFUC6aKcABQ9zrrA/Y8eMDFicXTCHyOj2Ak=;
        b=Pxs1UWNitC69iwUPhh9mTRzICcrHoC414ovC44wShfd8VBej1ZmbaqMEQFKPK58dOq
         eBSK4yojVpnGtnWO+8pITtVCwSlOW+S4lKbgHyJDAu9UNPFh3BNDCUE4+LXGdxa+hq2k
         CfXM2yZLe9+JZstkHfQqfQhsKCXS3J4ATyf+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MDQaSgo9RFUC6aKcABQ9zrrA/Y8eMDFicXTCHyOj2Ak=;
        b=nhUWoyMs8cAP1se/9143P1h7Pc50wtWA3Gon5UFiOvLv3RvnSketMCyCBzdo4JqMts
         Z8j/kuxTJxIb98p4oIBbvZRz2sRooME5X7467eMCW+2O1eJl34d4mgMCN9zBrfw+EOd9
         pNl9im9z2ju1Lxi7hzKmVHDX1HxpOxbC3DrUPujlqce0q64OEEiuF7cTWm6loatAnut9
         shubRaD9MXaGkePPQHDA6Q45aH7sLQrMzyNw6amz335qmENzEqYKKS5yuaS/cRKIU6yT
         9nzBa2LxpOdw/vOYXsg8G/CKwgOn/a2FA1o+qJ84r8A4rAwSye10SkwpTFw1ZFWCf0XW
         thyA==
X-Gm-Message-State: AHQUAuYVkzomCG5bC1It8TV5AwunuElijp/xgtvivyBjh7SidXWVWEz3
        AEFAFVlTGvBdSSEU/7DZ4CbSUwBaRwOq4mKP
X-Google-Smtp-Source: AHgI3IaEBmxdMmrm2NePZNgu424XKfzyDJcyftG8AGcs//0Iw/uIFKHYlC46R+U1lH3IE1yr8mPjuA==
X-Received: by 2002:a19:a345:: with SMTP id m66mr2577989lfe.84.1549360412961;
        Tue, 05 Feb 2019 01:53:32 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b128sm3689992lfe.91.2019.02.05.01.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:53:32 -0800 (PST)
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <20190204150916.f29d782b27f096e6c4c6d6cf@linux-foundation.org>
 <20190204151209.d6fae2c6466cb5c9c5814fd9@linux-foundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e819dbc8-5d7a-2f7b-35c5-e70754ba28e4@rasmusvillemoes.dk>
Date:   Tue, 5 Feb 2019 10:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204151209.d6fae2c6466cb5c9c5814fd9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 00.12, Andrew Morton wrote:
>>
>> It would be (very) nice to actually use this macro in a few places so
>> it gets its build testing while in -next.
> 
> ie, just about every BUILD_BUG_ON in mm/ could use this.  Let's switch
> a few?
> 

Perhaps, but some make sense where they are, e.g. when iterating over
two arrays using one iterator variable, it's fine to assert they have
the same size just above the loop. And, unfortunately, static_assert()
is not quite a drop-in replacement for BUILD_BUG_ON even when the
argument is an ICE due to -Wdeclaration-after-statement.

I'll fix the two BUILD_BUGs I know I've added over the years (one in
vsprintf.c, one in fs/namei.c).

Rasmus
