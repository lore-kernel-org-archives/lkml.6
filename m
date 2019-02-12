Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D62DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F87A222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USOYqAlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfBLUAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:00:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38841 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfBLUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:00:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so4132332wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lofy8RA50K+szKa+a3qI2piKtixtV4KDHf5fd6Bgcow=;
        b=USOYqAlFI6o0L4l3yIu9puAZowiipcPLbPCnjdqDtaqbF7UBpPSV5a6wTiQ4iOeEyT
         DSIRRZEc9cp0Qp/sjiZjlKAdqWlz2bKdD9BNmrpjIQ1DjpndSgAg2PZ4iTbl/ZV/ZwsK
         jYDCeY54oNkv8pw1cTk40VI2CKeI8RqDChf4NGnxUiQBifUDb9NZ6J5AmmK3+vInEA7B
         njPhEwxrbmyzJpp5v6lcHMFhY7GDB41g624auJ8E2GszszttRa6TV/L3wtZMVLE5AxUm
         XtDGS8cK7XlCdy45IIwyxyKL+m1v+p2icDw2gkODWQ5Vx3jQ97q4vDJM1OUIIRMYr4AA
         +A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lofy8RA50K+szKa+a3qI2piKtixtV4KDHf5fd6Bgcow=;
        b=FjRAHtHin/qwSWoGHo3YWXUDDlfNMFaFDxrF1Xu/5s5j28XoTMcPfpQoeH6NM8U4hF
         2C8Xe2ZYHuhOd5l38aATpXWW6eP4GX+a/euFW+B1TOz3FWHckuGkQXeI+inn2mUwK0uU
         NKSzKe8K6aCq44gHbEHurVky/A1ZX7cLDu+9/f3AKztIrkmSr5mkSqtWbhJJCCEjv7an
         W9BsEZ6ZSvqW7G4yCgRpZc0Q+Z9cpmU9Ythj6tAam51QCAWgDMVWdDOJ6PXSV2x5DE/V
         +qWEAYIOXLm0KcSlpereddqeGiGcR3eA27Ob5LYoGm2/XOxmf5FjpE8HPk36QFXCTZis
         x4Fw==
X-Gm-Message-State: AHQUAubitdrMfFlHH1OdJgj/yjO/4M1kycYTgQXH5NhNXq/L8S3P0K63
        3HafC7iBqRBB6DWzJ9myTaFltBUgjXSP69pbUY2glw==
X-Google-Smtp-Source: AHgI3IYSTSqAUthWbrQABSgT+w5kpkBrEbysYt9vmH1EtRj+PL+qgaMlvn9dUvquuMciTojfBV6MJTm6aMUbm8XfKtY=
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr4313181wru.177.1550001629193;
 Tue, 12 Feb 2019 12:00:29 -0800 (PST)
MIME-Version: 1.0
References: <1549987525.3173.17.camel@HansenPartnership.com>
 <e9a411a2-49e2-4897-4e02-1cf790465cbd@kernel.dk> <yq1zhr1t028.fsf@oracle.com>
In-Reply-To: <yq1zhr1t028.fsf@oracle.com>
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Tue, 12 Feb 2019 12:00:18 -0800
Message-ID: <CAPtwhKpqggL1k8wsh-ECS6aUr7qThUyHjgx9BGeL84bCbj9Lvw@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: fix entropy gathering for most rotational disks
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Theodore Tso <tytso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix James!

On Tue, Feb 12, 2019 at 8:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Jens,
>
> >> The fix is to set the non-rotational and add-randomness flags
> >> unconditionally early on in the disk initialization path, so they can
> >> be reset only if the device actually reports being non-rotational via
> >> the VPD page.
> >
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Xuewei Zhang <xueweiz@google.com>

>
> Yeah, this looks good to me. I'll queue it up for fixes.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
