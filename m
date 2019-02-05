Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A0DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7272083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kON09Amq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfBEPc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:32:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38055 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfBEPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:32:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so1527882pgc.5;
        Tue, 05 Feb 2019 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IriecCk+yyiGkqLtRGk2odOB1sh0oKiiTgjbnEusydA=;
        b=kON09AmqyeM2/mjZ65ovga03BVAq7zPJZ7nR10AYnl9K8tGJeQXeMQfBtya4GueJ3H
         z6Wwsh8WRO290eqFXje7EgBv3+8gcE6go8xPr/3j/tjEVFrV3CibYm+Xv41gO4C8KX0v
         jCxqle8anqeRaxYXEh/GOKDekBo30HCfdWPzjMTGdV7oNj/lUrlSQU8HVBxuPBX+WrQZ
         /rujwBmuy96R/DeaJ6Ym7T2g8tk1mBmgXfTVBFePuK3Atccy4Zqx35u+w61ApCAjNubV
         NRf95VhjNFsC/FtKWi/RfNNn6LMxFYOY+0/riaAGkpFEMk0hjZnkQshyaoKskRsu7OFL
         wKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IriecCk+yyiGkqLtRGk2odOB1sh0oKiiTgjbnEusydA=;
        b=ra/Jceo37EJWRE6WaMjEwgg6EY6xfhdKGgrhLOTyKvbtKbjO8rAjXYXX3I/8kCZyNU
         vg1fNWPyGqn7D4zGuAseMBU1QZu3+UEMOV3p7fg+YFzsKxk/DR2Fv/VWM7sFncshCilp
         YCA8f/W5CujhwumIc3zPZr38BhQQyIeWLeohGYU/YV+6NyO1wHQzs3z4Yj7mNd3r68QT
         WLmWQIqS4c9V+OEYjwDl2dvQ3a+UQU2C6Q/Sa4tWg5fF6aac7AMaEEThOfkSSEc4VU7j
         ewF+A7ZAaPGwASSIIVISTArWAm06TCWxzMY1kCZ3LQxLqWHyu8Nn4E0sWYlJvYuPA+gJ
         +HKA==
X-Gm-Message-State: AHQUAuYj3w0g4p1b19NJEYC/ybMHhQ4O+DVR1+XP4LxrftywC1qhk8A2
        jeY7C6/b42IytwDyHoxv7cVTCg43ES8GKpeMsls4ObRR
X-Google-Smtp-Source: AHgI3IZd0WN+KwS871AmUGpiTvaooaw5zk3zuHtlK6dL5MYGimOc6hMYLbQwYRfMDwdpbhalrV91TMjQJtnYOXdy838=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr5653473pfa.229.1549380775130;
 Tue, 05 Feb 2019 07:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20190204081947.25152-1-ronald@innovation.ch> <20190204081947.25152-3-ronald@innovation.ch>
 <20190205114522.GV9224@smile.fi.intel.com> <20190205131812.GC4225@innovation.ch>
In-Reply-To: <20190205131812.GC4225@innovation.ch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 17:32:44 +0200
Message-ID: <CAHp75Vf-9R=LLQ=AOQ3vA8uoADieOMRh1tpg2hsHTf8imnXofA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 4:21 PM Life is hard, and then you die
<ronald@innovation.ch> wrote:

> > > +config KEYBOARD_APPLESPI
> > > +   tristate "Apple SPI keyboard and trackpad"
> >
> > > +   depends on (X86 && ACPI && SPI) || COMPILE_TEST
> >
> > COMPILE_TEST more or less makes sense in conjunction with architecture selection.
> > It means, your code always dependant to ACPI and SPI frameworks.
> > That's why 0day complained.
>
> Thanks. Yes, looking at this again I realized I somewhat misunderstood
> the uses of COMPILE_TEST. I've changed this now to
>
>         depends on ACPI && SPI && (X86 || COMPILE_TEST)

Better to split like

depends on SPI && ACPI
depends on X86 || COMPILE_TEST

-- 
With Best Regards,
Andy Shevchenko
