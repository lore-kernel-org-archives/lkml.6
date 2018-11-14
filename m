Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB49EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14EE208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syxz4YIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14EE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeKOGwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:52:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40605 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:52:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so14266455edx.7;
        Wed, 14 Nov 2018 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9if5ej5Y4WJAukyqAzi3fXEcjjFsndOTSNgioEyLZOA=;
        b=Syxz4YIG2Feb7eZOmiftTfN7gvp3LutIOPoknDedy8YnKM4r59twe0BndREiUn353u
         345QEQzy9FJNnesQetN9VlnwNvjysGidlELO/5SGFgiYKttFi0oUGXagCJ+RuBfcCeUu
         MwPTBOkGZ/NwbziShbTE9ZX5OODIUptWF4TWF5ZLt36OeGqpYYGd/zOEKJ+y3Pc/rZmg
         TdJ37JaBG0hcC3MZtlml23o0oJiTN4YC8C1cEOY3TyILpjmnn1tZOFDfc8jti3Zia25i
         Xd3sRKrkuCIYf/iX1WzH3U7tVPnalwJ8AajN9omrqjH8XaOAEwOs5n3PyvqRjbupuhbC
         2Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9if5ej5Y4WJAukyqAzi3fXEcjjFsndOTSNgioEyLZOA=;
        b=IYmksoiYw8JYVzkBcTB20tits5vyzIMoO9jgqHD7kzLGZJiUxFUaKdHuEtwPsmql0L
         NX40Ia3ANl4ddSAay/rdffEw3d3P6EVYaNDmTasG+u55BS4kZxrvqdRbDc/P4/c14sS6
         sXA2SA/2YO9ffOWEBvtzCoiDaZBVN8kKJc+o9/4DRH7Q8o3KaMfbAxVGyugOX4iH0e1u
         f/aQw9moJNLzt6suxhog6hj/RTIUD+pAxohHckI9pe36COaR66Da42c8/wqHSRaR7DCb
         FDLu80Hne47VUsTxFlEKX9OVek+eMZQacXYZt67LAGomfWEZCj5RaJvMTDOlTMsFMsBg
         ztWQ==
X-Gm-Message-State: AGRZ1gKn+ib1tlBUBlzD4i00/QINXJuo2VXOBMzENUMU3Xulw5pS+tT9
        dGvNj7L9501U2yekGd4Q5JlAo7PYC72x6RkH2A==
X-Google-Smtp-Source: AJdET5ez2/+gHSgj8Q4iT4ZGireaefYf/y3BZBtlf+gz3yZnzo0W/891OjS1hvMc6RCNwjnp3YpFR5U+GmDDtbS/awI=
X-Received: by 2002:a50:8a05:: with SMTP id i5-v6mr3363019edi.222.1542228445840;
 Wed, 14 Nov 2018 12:47:25 -0800 (PST)
MIME-Version: 1.0
References: <lsq.1541965744.387173642@decadent.org.uk> <20181113015707.GA5984@roeck-us.net>
In-Reply-To: <20181113015707.GA5984@roeck-us.net>
From:   Johannes Pointner <h4nn35.work@gmail.com>
Date:   Wed, 14 Nov 2018 21:47:12 +0100
Message-ID: <CAHvQdo3ysM2xcm_jC17pHiujCNTKSKo55Rnh9UrGAY+HTp8=Wg@mail.gmail.com>
Subject: Re: [PATCH 3.16 000/366] 3.16.61-rc1 review
To:     ben@decadent.org.uk
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 2:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Nov 11, 2018 at 07:49:04PM +0000, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.61 release.
> > There are 366 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri Nov 16 18:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >
> Build results:
>         total: 140 pass: 139 fail: 1
> Failed builds:
>         i386:tools/perf
> Qemu test results:
>         total: 217 pass: 217 fail: 0
>
> Details are available at https://kerneltests.org/builders/.
>
> Guenter

Hello Ben,

could you please include the following patch which makes it possible
to build arm with gcc8
a71ae0513c232c844009738af135a13e5d7e39c ARM: fix put_user() for gcc-8
this is the version which landed in 3.18
and also the following patch
430c3fdb11ec1f0af1eca28460c922b9c1eb2ac5 turn off -Wattribute-alias
this also the version which landed in 3.18

Thx,
Hannes
