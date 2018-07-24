Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E48C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA06204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBJtM5vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA06204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbeGXTtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:49:02 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44830 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:49:02 -0400
Received: by mail-qk0-f194.google.com with SMTP id v17-v6so3272732qkb.11;
        Tue, 24 Jul 2018 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XtU6Mz3Hqb4yoYfMJFNyo1ZEMixlhXXISFoj4iKal34=;
        b=EBJtM5vRxdRuFaDfZpoxmjI3hcga/MP3aQSAvhNJNtwG9v430IpwKYLOmktiROBKGX
         azlSiOAXRMi2CTyK5l9M+kKndOuIX/xZ9Jar8H8ExpJD9jPVpdEUYUZKSophC/PY3Ctj
         wy2tzIcI4k/9CGSQq2ts2d/gDp90HWr27mcPSC5k0tzr5ms/djJ4BSlB9O8CX/wM3gqK
         6j0NGdVfM8ipHoFcWugA7jC1UZu0tZ3NDTw+e7eb6jexzNzm1DYNn+SneLVGpgc2oYVx
         jTSOWihI2hKi2htQyK2jwk1y8JUJ4uvweUKFn8BvAJj0Nr0oGa0WJF4USXugX8GQnfYJ
         ok6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XtU6Mz3Hqb4yoYfMJFNyo1ZEMixlhXXISFoj4iKal34=;
        b=VTy3O2NOyFv7JQsS2sMqOqDECxY0By5b5u1SH6J/zf8NZ39RxY1VOnQj/oUax8lJZW
         pCGERCd058vkvNV/3l3h6Ug9a1iHM12XXjUI5pvatv+nmQ1lDTIOIhNWM3fAVKYvmdyM
         cly+KjDn/Nl0gLdQTWuTky2fe4yPRyjEosYFCcjhRXwomS/p3itScf8We+PNAEAc48dF
         TRomZHyTUDFPzBueWqr2K2XABmeg0pEt72gEz2J4P7JqhOs8rSs2xBL10sjvdl9ldiWq
         qx0VCYpnktOUeglpNNIaoDiMluNqAZdxNtdNJ7zrhuALwHlS8tzc/251Sk7OdZwe24FP
         MQMQ==
X-Gm-Message-State: AOUpUlEXxpL67Zg34NLI7IGOFVt+fIRhLGet4vy1J8WjDp0SWDFmDzEr
        9+w7yAYl7LiR6FqggUv/9gLPJ9c=
X-Google-Smtp-Source: AAOMgpeHNQXYPaKAqHVtrIfJ5R6S47EwNdk/IW/cPcLbrkzzXZru172QhZr50aoIJwMAJH4smEH0vw==
X-Received: by 2002:a37:4ed8:: with SMTP id c207-v6mr17031331qkb.164.1532457674973;
        Tue, 24 Jul 2018 11:41:14 -0700 (PDT)
Received: from [10.18.17.172] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i1-v6sm7390590qtj.65.2018.07.24.11.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:41:14 -0700 (PDT)
Subject: Re: [PATCH] EDAC, sb_edac: Fix out of bound in PCI multi segment env
To:     tony.luck@intel.com
Cc:     mchehab@kernel.org, bp@alien8.de, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com
References: <20180719140745.4503-1-msys.mizuma@gmail.com>
 <CA+8MBbJSox7YsfoL=90yiLp8_oHFEjkN3-nk95rGbUmk58R0Gw@mail.gmail.com>
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Message-ID: <b3f2847a-1b31-b291-ba3c-5e2a7c2478c5@gmail.com>
Date:   Tue, 24 Jul 2018 14:41:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+8MBbJSox7YsfoL=90yiLp8_oHFEjkN3-nk95rGbUmk58R0Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Thank you for your review!

On 07/24/2018 01:01 PM, Tony Luck wrote:
> On Thu, Jul 19, 2018 at 7:07 AM, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>
>> KASAN reported the following slab-out-of-bounds when sb_edac
>> module was loaded on Broadwell machine which has two PCI segments.
> 
> Although you found this with KASAN as an out of bounds array reference,
> the real problem is that the sb_edac.c driver didn't know about systems
> with segmented PCI busses.
> 
> So the Subject: for the e-mail (and thus the commit message) should
> be:
> 
> [PATCH] EDAC, sb_edac: Add support for systems with segmented PCI busses

You are right. I will modify the subject and commit message, and resend it.

> 
> Otherwise this looks fine.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks!
Masa

> 
> -Tony
> 
