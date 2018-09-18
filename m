Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD42ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE58120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmVvowpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE58120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeIRKZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:25:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39160 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeIRKZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:25:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id b19-v6so334688qkc.6;
        Mon, 17 Sep 2018 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMtcyMvebLOAYRgnpmtwGMJWV+sa7O0gTCNayeCSQPU=;
        b=EmVvowpX/C+cqTSHoeMgMB+WBJMY+T6eYoTvIAbVoCnsOQXdzWlEyJ0JMiZO35uDbz
         kMRJN6+/M/fQvRTfzHTcLW7/gr95Xz1TEEs5RuuECrIo2CTJFZ1B42vIra7/Aaj4nkjb
         ILqI0VvCiMt11Q4rGZerWcmZf32A4tJ8TnRdtHvU7ojGBORbd+gFLoltlWqFhwpc6Nj5
         6L9CAERoKDjnLDH2FdncL/sFaPF6VIjeGaHU0xMLBXZFrODBWw5mzQ/+iaIBLsehPTFE
         s6CfQV7i+YhUms2qbdyG9YwcnTymcAnENP3taVBkqb8Fe953C4v3CXTXMN81WO0VA/27
         L9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMtcyMvebLOAYRgnpmtwGMJWV+sa7O0gTCNayeCSQPU=;
        b=U0+MjZawptDSpEM/lDwBAE2/KLNZT61H04NY8sL7GWK0utPk+yd/OvqNVPXf10s90A
         GP7k/E1mMs3knoj2nujcSZlg1LqIswZqwcu8uJZYNZfp1Lq//1nwQDBpCtlta5xJMnSA
         ltxilblhqE9/zeZ0JMo9LeZVjbSO6/0amOGyux7eQlGa8gDjkmafi12dv9DrcIT9Ucml
         d5C1I+OiO9rbYGQnEWc9vO4DLSj04ud02Xvqlx9LmAeSejnso+2FPB3xS/04qvn01oEV
         F/nU0vHZkqKeuWJrcZZRHhMLj9cA4URM2qnUYfQRSY9DT2l9kLv4FWwgcwEuENPEyKMn
         KHcw==
X-Gm-Message-State: APzg51BfgOa8APCQ06QLHVSfKh611/a5kQuUGIafQgbmUtIuxEJDE+XJ
        90xgKH9gVkBSdVB2NObeqk555V2QYBDgu+KNviY=
X-Google-Smtp-Source: ANB0VdZ9r2YYdoZ9qTQ2Q9/6WcwZuqRQCPGlGcb+UV59Y+ZpwjD8gJEIX3EBYBAFkqynqSNNx6HheCq26RNkEAVGHb4=
X-Received: by 2002:a37:179e:: with SMTP id 30-v6mr18816136qkx.33.1537246461727;
 Mon, 17 Sep 2018 21:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180911125857.5e5c34f4@canb.auug.org.au> <20180911082534.GA4185@dell>
 <84bafe76-741e-7dc1-d985-62027f4f634a@microchip.com> <20180911084346.GB4185@dell>
In-Reply-To: <20180911084346.GB4185@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Sep 2018 07:54:09 +0300
Message-ID: <CAHp75Ve8ecT4ziJrV9Edq6u0+jg-eQ1Z9wpXn4dvxTqFDHRFrA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:43 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 11 Sep 2018, Nicolas Ferre wrote:

> > Actually it is due to the missing of  <linux/mod_devicetable.h> as Stephen
> > suggested. It is due to the patch ac3167257b9f ("headers: separate
> > linux/mod_devicetable.h from linux/platform_device.h") merged in v4.19-rc1.
>
> Since this set uses Device Tree, it really should include the of.h.

I didn't remember the contents of the driver, but I would disagree on
a statement that
*using* of_device_id table implies necessity of linux/of.h inclusion.

>
> This solves the issue reported above.
>
> I will fix-up and re-send the pull-request.


-- 
With Best Regards,
Andy Shevchenko
