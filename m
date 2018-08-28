Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B77FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567BF20659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaMBoxKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567BF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeH1VZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:25:56 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:45015 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeH1VZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:25:56 -0400
Received: by mail-oi0-f42.google.com with SMTP id l82-v6so4271178oih.11;
        Tue, 28 Aug 2018 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KHj26thhLWnTnN0kqmNe6Pxj35RlnR0t7bphORu3Po=;
        b=jaMBoxKoDygfIiGKkChECTPhVVFXj37FPwzLfp0auscw9E4bUEJ5FnRly20iHEJv0F
         3l3SoAsw8X6NTHkVnbMJrnfcci+wQogOUEJBvtK1Sc0YZPWIVKyq9piW8RcpoX9FuVTL
         S+IxBgr7IEAptyJeyn1PQs2Jh6CIQbLLp5/ju7hPuPvjtAcB27TGcC+4T619uhBAQdIV
         hdBs4phbZk4rbN1L1LA/ixFyaCBuOehdnUyYRXCdln8Zwi+xUKDtHkd6Jg4KpKmolGJN
         FSoFY2xGx30AolliHs0FC2zl5x6Q7JU2+3VFfYN+lrfsp6Hs1DP6SBMDBHdB/bRBzjKD
         36UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KHj26thhLWnTnN0kqmNe6Pxj35RlnR0t7bphORu3Po=;
        b=P0aIqd/H01IqU5vznU/ZscwMlWUm8S/WPIpAf1BgDg7Zd9vDZoShrgMCIW5jAKYHoN
         ae3lelsXOvx0VD1Hq5vb3szj5zdBsqxtKLGprUS3pOJAphysxJEO9Fs5YCI2XLH8lkBb
         /hZi3GHp19rsS0nQlkNJsVCcYjbi5OSB9d+OvhfEAIon2SmX2rQan2eH+B7Mh+DyZoK+
         2pETBUNjM/Gq9ntgMMnXJT2hfzcHPIN6Ljylm+ruLb41rOwgMAzTdwEEKqLOnP6MtFhz
         M+yiG5sUmG48BrQJ3QvAOzLKvAGhkTL9I9obK+R+qwIAxYk8Dph0dBzHjaBbelHR6a3i
         Pykg==
X-Gm-Message-State: APzg51BzRAayGPNcyddULAGgIiyC3LiuYRXR0g4oNPoqkjGX1tD4Mrrk
        BY+nWKwhbAFPrfhN+Xpv/6+c9hE66u7ssvGZkz+fYA==
X-Google-Smtp-Source: ANB0VdaG28yH+SMzsntH4g0UcCDQ6R4RX7Slq/PLeFLME+76AXWxZRSZnYPZ86qaZ67xVSxkANK8ZadJYLRO3+h5IH8=
X-Received: by 2002:aca:1112:: with SMTP id 18-v6mr2167408oir.79.1535477594349;
 Tue, 28 Aug 2018 10:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <491de4ae-0ba3-0fce-a400-3ebb41e21ac4@mni.thm.de> <e79d43eb-38cb-8975-08c9-c3937a1276c2@infradead.org>
In-Reply-To: <e79d43eb-38cb-8975-08c9-c3937a1276c2@infradead.org>
From:   adam radford <aradford@gmail.com>
Date:   Tue, 28 Aug 2018 10:33:03 -0700
Message-ID: <CAHtARFHovpNRx-hdZCAYD9zjUf0WWdRvQ8PkqPNjNpbUwPRqow@mail.gmail.com>
Subject: Re: Bug in /drivers/scsi/3w-9xxx.h
To:     rdunlap@infradead.org
Cc:     frank.kammer@mni.thm.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank,

host->max_id (max scsi target ID's) is set to TW_MAX_UNITS_9650SE for
your adapter, which is 32.

The firmware srl (spec revision level) for your 9650 adapter doesn't
support luns > (0 .. 16).

You could run in this mode but it hasn't been tested, and I don't
recall what the ramifications may be (if any).

-Adam



On Tue, Aug 28, 2018 at 10:02 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> [add linux-scsi list]
>
> On 08/28/2018 05:23 AM, Frank Kammer wrote:
> > Hello,
> >
> > I have a 3ware 9650SE RAID-Controller with 20 LUNs. Using an unpachted
> > kernel (no matter which version, e.g., 4.12.14) , only 17 LUNs are shown.
> >
> > The problem is that the driver was once written for a 3ware 9550SE
> > RAID-Controlle that supports only 16 LUNs.
> > There are some changes in driver to allow 32 LUNs, but one change is
> > forgotten:
> >
> > In drivers/scsi/3w-9xxx.h, one must replace the following:
> >
> > 467c467
> > < #define TW_MAX_LUNS(srl) (srl < TW_FW_SRL_LUNS_SUPPORTED ? 1 : 16)
> > ---
> >> #define TW_MAX_LUNS(srl) (srl < TW_FW_SRL_LUNS_SUPPORTED ? 1 : 32)
> >
> > Best regards,
> > Frank Kammer
> >
>
>
> --
> ~Randy
