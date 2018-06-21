Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCFC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E36D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qNAv6jxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E36D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeFULla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:41:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51598 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933140AbeFULl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:41:27 -0400
Received: by mail-it0-f65.google.com with SMTP id n7-v6so4205246itn.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gt6T3ddfTRONAk/LmpYwd8Dl77pznMiBjPVQEt+aMyQ=;
        b=qNAv6jxbTSsNFKT9yZaoCphc2b7FCxpx8P22DmGRSdICPyET8/mEj6WCpPw3ae+A3d
         N+DS3uj+el167SrLFZ+pNHJYSEctDm5tYvC5bWo1VCXF/2MBeSnoQFr2dFc8RuyMR/sz
         7728DcOQMHh6/DSxFvDhQKzejD6DVNOZMwxTbPrC6I/HoM1JYSVd+7qSJDD0Pg+HYuOQ
         Yl+ta1mfyOO/jaN7c8DIj3h/V3Vo5eEZUakjOUC/VVxTiseiqk/tMN/0On30ft4fPsgy
         FLMJQfnLGE3R4kGXgx4nygWpXoZyq3JCqZqwzYQGH+1DdI1EIG+zqovnPLWgNkTsG4Pz
         ljQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gt6T3ddfTRONAk/LmpYwd8Dl77pznMiBjPVQEt+aMyQ=;
        b=pDwQMHGYtdUv0tneSTpktftol7bPWV9BiwEdR3rJ5GSd8MJ6Hke3FeDHDGUvdgvUGc
         9lbmt/DQCIubBB46/GSZluYRxKuT1dhymV7hGofIdPXrZJggt6ymKClQanNjexAkrV6z
         BmZDBpvLS4rVfFlMLSukkgFmKccMUHUoancdACxmlthqfWdNxrqa9rkjkDmBNxbWnNsx
         qFb4x3vtexLA206ZbUTxlUw5706rriEwi/e+ghwHPpyt5OT+pjXv0Wc8He2SzqeGpXmO
         aFQnDOAq80bDFyp4bLS1IELaeBaMwMisX7VZ3YNMD/qBSsIn9WaNG1/1jSdDsZJT/GIn
         QqAQ==
X-Gm-Message-State: APt69E3wENo7V8LgaejDGv6y0jZ/i8ggg4AWIOqkMmoT6JeDWaZP+DHl
        UxMSgdTcIvVdmqrB/iNHEe/5NkfZBZ9hpxXDYT09+A==
X-Google-Smtp-Source: ADUXVKLhWj3szHpFWYO0fUfSxXsV337bwb9vuhyfCM+1l0Wuuj3kyN+wbYLc7OR75wx2gcBC0EoKp/L943ioFVCM374=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr4767206itg.141.1529581287157;
 Thu, 21 Jun 2018 04:41:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 04:41:26
 -0700 (PDT)
In-Reply-To: <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
References: <20180621073706.22812-1-brgl@bgdev.pl> <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 21 Jun 2018 13:41:26 +0200
Message-ID: <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> Hi Bartosz,
>
> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> These are the remaining patches that still need to be merged in order
>> to complete the conversion of the davinci dsp driver to using the reset
>> framework.
>>
>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
>> merged.
>
> Series looks good to me.
>
> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
> and #2 ?
>
> Given the dependencies and to preserve bisect its easiest if I take the
> series with acks from remoteproc and clock maintainers.
>
> Open to other suggestions as well.
>
> Thanks,
> Sekhar

Oops you're right about the order. Do you want me to resend?

Bart
