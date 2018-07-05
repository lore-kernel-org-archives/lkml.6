Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B124065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="cslEVcoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067B124065
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeGEPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:12:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38531 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeGEPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:12:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so11503828wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JUqZAhmQYnDqkewI+PaINspuFIPrjFl7Up5zMaCFsrU=;
        b=cslEVcoiMJBCpPvqlcIEUvUeC50CrQ17OixqSWg5MhgfQIdZNAZCAz3VxdPImLpepq
         m3iZmoSWWVtrLKQfHl3koNqzBBYLfk+K+sPBsW+dONJ5TK/aTOQm3nECF6rOKQAsnwlC
         NH+T/c6c+DeUC74iEOWHczdLv/NA/+WHuaNsxMaQrAzn+9D7X0WZt3ilxPlQxF1+vp1S
         rSAtLccWuI8qX37JlRkH1/mEKdU31nZfFrQn6ys8QJSlGbops/ETi41rx78zUEND4vBB
         wqwJ6fRwJnbCIZBdLkJfGwEnOgjfSbXzsrODv16kmvriHhpofuq68ZblUxCzlBCmF1dS
         RpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JUqZAhmQYnDqkewI+PaINspuFIPrjFl7Up5zMaCFsrU=;
        b=CigXFYjLKArtngAF30D2O31dKMyZ4IiJmfAhzMGoDA8iLAeyH+QGrLlNi52qGMnokq
         tM2BSUG16NU6YFiTw3H8euTbVHys65uABEMyJCfaralMGZlcR+z9cpi+8WmQRpBc6wzi
         ChlFVVjC+mpmtErnPwZ1Ek/UY+NnrXLu231qsLeET8KSSOAZpCHRhMkeJKng1mGDZqL3
         C+TeCAXHvN4Rdrlp75VVim7hdt3yMa2wJhNqTua6yrwAJsBWaEK1DXQPnGyF/rUTX4tR
         cCkdCQfvO2Hb37hNZPSRgY0kJDy1/VP2zbR6hllGX+OoosKh7xwa2DorFh/FbaxjleG/
         bIcg==
X-Gm-Message-State: APt69E1nBVMgWH7xk4l8DwEXleau1zV3lk/vilBs7hFoZYU/LVoo4LRV
        1OcwTYC+Wf1WFkVoDk+1ABaLJn1LrpE=
X-Google-Smtp-Source: AAOMgpfbquZ52LzhCRdyPg0HvZPYe8IVUkH5d7INsETmxj2fdghWBE2xHJk4rQZgyjss4+Dq09EsxQ==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr4676164wri.42.1530803558353;
        Thu, 05 Jul 2018 08:12:38 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm1209870wmc.9.2018.07.05.08.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:12:37 -0700 (PDT)
Subject: Re: [PATCH 2/6] ipc: reorganize initialization of kern_ipc_perm.seq
To:     Dmitry Vyukov <dvyukov@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
 <20180705055920.19611-3-manfred@colorfullife.com>
 <CACT4Y+YyZT+JRyUcYRD83V13M-k91XUp1qkpBCUCkGfamLgDTg@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <7143da44-448b-8beb-7583-1a5516623649@colorfullife.com>
Date:   Thu, 5 Jul 2018 17:12:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YyZT+JRyUcYRD83V13M-k91XUp1qkpBCUCkGfamLgDTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 07/05/2018 10:36 AM, Dmitry Vyukov wrote:
> [...]
> Hi Manfred,
>
> The series looks like a significant improvement to me. Thanks!
>
> I feel that this code can be further simplified (unless I am missing
> something here). Please take a look at this version:
>
> https://github.com/dvyukov/linux/commit/f77aeaf80f3c4ab524db92184d874b03063fea3a?diff=split
>
> This is on top of your patches. It basically does the same as your
> code, but consolidates all id/seq assignment and dealing with next_id,
> and deduplicates code re CONFIG_CHECKPOINT_RESTORE. Currently it's a
> bit tricky to follow e.g. where exactly next_id is consumed and where
> it needs to be left intact.
> The only difference is that my code assigns new->id earlier. Not sure
> if it can lead to anything bad. But if yes, then it seems that
> currently uninitialized new->id is exposed. If necessary (?) we could
> reset new->id in the same place where we set new->deleted.
Everything looks correct for me, it is better than the current code.
Except that you didn't sign off your last patch.

As next step: Who can merge the patches towards linux-next?
The only open point that I see are stress tests of the error codepaths.

And:
I don't think that the patches are relevant for linux-stable, correct?

--
     Manfred
