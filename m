Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290BC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDD92146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAi8L278"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDD92146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbeLBIK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:10:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45686 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:10:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so4460355pfd.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fni3qrC1AXhQ4GGshXncahRItgEtCBVS4qUP62eJZ1U=;
        b=fAi8L278AqFyKISjoxMB5Kg2bBjRDo+O3Sfd2q8B1HgcrcomA8/hJJeBoTV0uw8Gxi
         wh1mKOjyBNpqCe35I1zYeJ4aITdw678h9xyEPDGq3sLBa2/K5b08hsLqJ7kiRoeHuHQs
         YjtqVBelJVMnpQNXOWF6XPKHcGPt7XkBUcx50g0wjBE6b7cxixl8mmrS1IhUaBjeJKnr
         3AzlYNqgenIOiwaXMtLZ8Wv2fNDLVX4LzX8m6dGchc2++0U6HuDclyk0KYJ5x1kQ5/gC
         1INJCcktUElX3ZeSiqM+QLZPQwS4Mvz4VKYhKe+9flRlyUuA86ER6pF4qNOnYFKBPO4o
         VsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fni3qrC1AXhQ4GGshXncahRItgEtCBVS4qUP62eJZ1U=;
        b=hXKrRkJ3K17Pp6IQOu0c/9deTVi4W6iVk8JOuFJ29+75nxLMMtxz0S1FUDX2wk/GlV
         b5J58L/hxBudgx9QTRwqM7qBNcVev2lUG2tj/FCCfxAeGCVLPdWiplxTtk6uLzBaiB5+
         iOo9LTlNR9qHqRG4r3blrD2DsWh/DMzEMjEAOftnYXujffilXMHA0M1pAxW6aZZ+dnop
         xdITZxGBb2Zs2zWNulrTf/2sQZA4HsKJ7+1CrOm/eUIE7wRl7QwoVtz+LWNKcP3F7Ymu
         5uLyNYMFRprTDFZNM2qewnOzBaj6gSa3wVnoF8xxucxHlwHmUC1M9pYdFvr+zRK/A5Iu
         GISQ==
X-Gm-Message-State: AA+aEWaSRbprzF2NqIpO01BJRwp4QfgPT2wHdtY6plbfmegTdYRQsXem
        n6mO2mxWOeOMWiZ76F5mIMs=
X-Google-Smtp-Source: AFSGD/U8/kIqc8QjWAeC1QST0auo4FOHPMWYGKbD9MWpsohoDbKJo9aFBFXhU3vESsliuBMZ/Zsepw==
X-Received: by 2002:a62:14d1:: with SMTP id 200mr10557137pfu.103.1543697824426;
        Sat, 01 Dec 2018 12:57:04 -0800 (PST)
Received: from [10.20.1.223] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id m65sm14601772pfg.180.2018.12.01.12.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 12:57:03 -0800 (PST)
Subject: Re: [PATCH] workqueue: remove some duplicated includes
To:     Frank Lee <tiny.windzz@gmail.com>, tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181126143326.31300-1-tiny.windzz@gmail.com>
 <20181130183627.GG2509588@devbig004.ftw2.facebook.com>
 <CAEExFWv57CU=FHWxAKby4HmzZ9+8GAt2SniaUinvDdLgc3TKOQ@mail.gmail.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <7f6d5e82-daf2-a12e-deab-87150d630df1@gmail.com>
Date:   Sat, 1 Dec 2018 22:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWv57CU=FHWxAKby4HmzZ9+8GAt2SniaUinvDdLgc3TKOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.12.18 г. 8:46 ч., Frank Lee wrote:
> It seems that the trivial tree has not been maintained for some time.
> Are there aother tree to choose?


perhaps mmotm, maintained by Andrew (cc'ed)
> 
> MBR,
> Yangtao
> On Sat, Dec 1, 2018 at 2:36 AM Tejun Heo <tj@kernel.org> wrote:
>>
>> On Mon, Nov 26, 2018 at 09:33:26AM -0500, Yangtao Li wrote:
>>> workqueue.h and kthread.h are included twice.It's unnecessary.
>>> hence just remove them.
>>>
>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
>>
>> Can you route this through the trivial tree?
>>
>> Thanks.
>>
>> --
>> tejun
