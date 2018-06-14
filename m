Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCD59C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714BA208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoCz+qjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714BA208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936011AbeFNMDD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:03:03 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37741 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeFNMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:03:02 -0400
Received: by mail-vk0-f67.google.com with SMTP id w8-v6so3497089vkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sg7HKxfXRo/VTbEiu/enFDOPQNn6T2lzzzBKhiAWPIw=;
        b=NoCz+qjBIkRaAt+Pudhi9zCgNSTa5k+OlhQUIWmnjNP5pXu7tcZ62ibdk2hpQHk5Uc
         IrQSMBf8x3la+wSF5gPHS/u9CLggUkt9ER7RPtnXQuuXf93G6QwhUe22E4acRTsS6pDS
         jTijD53KwCg273e6l3OAW3tknknA31yZ+zy6jeAmr9rZsP5QfsQGjeHsaDDVEV1DZ3sY
         fE7mLEXQDdPg0LeOSoFMGO5vzuum299joA6wGRK3T/MMzHRolVcJfC7RHyPzD3Xl6d7E
         vhimKOEW9oMP1Zf77GiDvJalGYR3HMuUsbctuQkPyYIzYLhEFlZQnqUvVT+WQuMZ6nzf
         S9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sg7HKxfXRo/VTbEiu/enFDOPQNn6T2lzzzBKhiAWPIw=;
        b=KWXVIJJuFDp8iYT7g28Lu+27ITwGCIlXepsZI/kXEn0xYY2AVqToJx2Zs5/2oiXbU5
         NLoijk1UzQ/2GtrznfmV1vwDMZw34cLEdVjjlmXfnBszvxlg9ADEXzPCG14+K9uY9RUF
         t4HBv8xffFD144Sx+edBARq1dawd/IV4bEbdeyUokEVsFmfNaiQY9cpZliSidQzvUMYx
         xOSKLw16YmHoJBn4jqKNZjO2FH21CjROe138YYNbf1FBZUJlt2OPsa9vkoZonPIvS9aE
         Vq4Ua5QppzfGkXE/4TKaRpA5iSy/msOLlRutDBZG8tH3xBR5syyTepSigiv1UcwHMlE2
         2dMg==
X-Gm-Message-State: APt69E2sufbrRCKksnI+f2coGWAGIuKVcJWG39s+ivk5jTJhJDFAa9I6
        Ge1ClczT+pB7+X/XeR2xERnCqcDz8xdPdfKg8ojQQw==
X-Google-Smtp-Source: ADUXVKIu+hIwDZ75PQUb1IVIgyE6Xap/PtvRmciY+KEzPa9U8RPHEMCDajduyeTvGU9r/bTRJb66v+qqcIWSKhrW+jU=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr1428365vkd.161.1528977781400;
 Thu, 14 Jun 2018 05:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 05:03:00
 -0700 (PDT)
In-Reply-To: <20180531144749.GA6828@yury-thinkpad>
References: <20180531131914.44352-1-andriy.shevchenko@linux.intel.com> <20180531144749.GA6828@yury-thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 15:03:00 +0300
Message-ID: <CAHp75VfMUVrtRD3t5QP=TjUcF96GPS71+_33_DR9n5pDw1tHMQ@mail.gmail.com>
Subject: Re: [PATCH v1] bitmap: Drop unnecessary 0 check for u32 array operations
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 5:47 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> On Thu, May 31, 2018 at 04:19:14PM +0300, Andy Shevchenko wrote:
>> The nbits == 0 is safe to be supplied to the function body, so,
>> remove unnecessary checks in bitmap_to_arr32() and bitmap_from_arr32().

>> +void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned int nbits)
>
> This line is 81 characters length, and it will trigger checkpatch warning.
> (But I'm OK with it.)

I really don't care about ) at the end potentially not visible on the
screen (who is using nice old hardware terminals? :-) ).

> Acked-by: Yury Norov <ynorov@caviumnetworks.com>

Thanks.

-- 
With Best Regards,
Andy Shevchenko
