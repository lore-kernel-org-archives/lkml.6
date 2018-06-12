Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80319C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298EF208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXs/sPrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298EF208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbeFLIXd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:23:33 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34982 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbeFLIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:23:30 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so11940441uad.2;
        Tue, 12 Jun 2018 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CZTKMGQhaEXUpki4HAcbTgo9Gh8kAYC5Q8V9YpgBhjc=;
        b=TXs/sPrC9jSPuMP2RYBMoRfmrpHBuJyQ7VtfEQ1//6TueUn6WIu4q/E3QtVuzI9tyY
         zlXIImv3lVtig+VlNWwdKn2DDfkJPJKJeX1ZzpTmxBlxBg7Z4YRKAF+gCbnVtLDGsqRm
         qx+kxAaJnzHRKXW2hh1X/rSqUQecl/ZG5vAcEbC7JL/1ZHD40x77SCHTynK91+HJ2JdD
         reNvjVuM4EOQ5qG+Xf8tOks4Aw71EipV/F4zC/4MLGt3aRBM9JrsOeOV+iPajBUqords
         dWfjC/dyr3IMmST11zzjnhSts0pNupCptVOfgAtHd3YT3oQGl4OuhDsVVUT8UAGJATcv
         NRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CZTKMGQhaEXUpki4HAcbTgo9Gh8kAYC5Q8V9YpgBhjc=;
        b=soZTttxZij9KUwTULTWB0G6Cl/8SapDDHZJhgjA7G/IhrsxvEYQtDsBZyViguxXF0W
         WhjiTaCiYuhJ/SdfCSBL918/g7Tq2TNuAnP/pRP+OykHUcyc6fcLa6yN7QqO5t1fghdg
         ol7y5l73eRwGxk0T8MCriggJz1AsxIYjQvcHrQ7caOri1XdECyUAjAsfqSi+EkauFfSi
         G05IhGHu5iBFKxmwsnKs83Tiqp0NWY/CDNX/YONlUGMB50E6/22nneyIwIy0966smzZN
         WHM5SePcTotAyYbzhUXJewCgL3xVoonZFJDniHH7DZU1wzN75Fk9QkJ/FIRw5QCud8OZ
         UaHQ==
X-Gm-Message-State: APt69E0d8j0itsWpbH1R0/LOyw01QDCWtD1JjnjG1J4nnFvLrKhG8k/v
        FlDZ8gtrAgaJ+nBBxT4hdNluu60giuxMbORXt2E=
X-Google-Smtp-Source: ADUXVKIIGYRnhhajjRYG6JSRnl0nAybZc87s+YhSs+fUM+Mi8lAPWp4vm4MThWZWMjLwMZm3/hhHUOmVh7OdiltaNeE=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr1725088uai.122.1528791809496;
 Tue, 12 Jun 2018 01:23:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:23:29
 -0700 (PDT)
In-Reply-To: <1528779046-42341-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528779046-42341-1-git-send-email-jiazhouyang09@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:23:29 +0300
Message-ID: <CAHp75VdtvNsQt16eb_OwGoBVTcDNEF0=E8OzqM-kHV4U6Tka=Q@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: add error handling for try_module_get
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:50 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.

What results? What is recovery approach here?
How printing message change a behaviour?

> This patch adds error-handling code after calling try_module_get.

> +       if (!kgdb_connected) {
> +               if (!try_module_get(THIS_MODULE))
> +                       printk(KERN_ERR "kgdboc: cannot get module.\n");

So, what's wrong with pr_err() ?

> +       }

-- 
With Best Regards,
Andy Shevchenko
