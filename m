Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D0C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3D22086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="PSy4ti8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfASKmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:42:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34342 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfASKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:42:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so2689572wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEd4cxki9+m4DdvXxjUhMu6h0iHxu0fTOzTyJl5I/AI=;
        b=PSy4ti8VZpNjpHRPHzkf1+JxjlEBG3aYkYrU3Z9ZH8m9k+qlqh/4URa1Q/hk3PhpNB
         0wrofvdIUoMzxIKtJkjo/tXPl89IR6k9KwsG9OEeqq0wUlEuGqHlrbONbjpp4dBvJ5Ps
         8Fad5rKc4/sEro9GhouyzXMRQ1TkGsPmnlr3Mgbs5gfFYAkreTJRUwZo2H7QXvWd6Z68
         oWMUPmDOH1a/eMKF2sLonGxdHCLBYM4lylzxgtP8FeeZjE7j7Z26T+DbonslB4iS98xR
         FXm/dJnImfooepGSmT1rfZeFnRV+UJpJTj1K73aQmRrpnpXrPXnioo6ZWo2M+nsstmvc
         TBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEd4cxki9+m4DdvXxjUhMu6h0iHxu0fTOzTyJl5I/AI=;
        b=R9A3SQlb5WMrcRiYTlTp8BlAgnGL+l1GxokrdFkrFlri0rwXX1AAFduzC4cvYLchlX
         KrCaGQhZ7wD62WhAjq3C1nuSVTXf6YG3bv0700nDsaci67Aph9lBnGhnM+zfePERtx7s
         MIoT4B/XPYgG/p9fqo6y+h+IytpclB3em2zRO4vn38TZpatXlrPKb0bq28BBvr9J8RNA
         dmyul4MIXvSAQzVvYYV+8Y5aHvEQvJ2RMBtAL4cYpriE93jJuSQ7kW+MrxQB9RkHHnB9
         zze2FxBOAPgh6gvEDnsDUiQovNU9pf6FVYha7DOeu+QrE6cOywN4c0KbCz/ISNXzG+WQ
         WPgQ==
X-Gm-Message-State: AJcUukcM05iGz2tSP5l6kMq+uDrsxUcprXzpwu8afK0vKDn4tevesmHV
        coxKac5j4DmueQwvssXpMOXFahE1rz8Iqc8Jpoj4Ww==
X-Google-Smtp-Source: ALg8bN5Viv/FnJkD+dxMigBx/5i2ECzC22YPB2Y24b1H6MQooVFiVfucZtcsn26Oj2cve88oQkQd3Mc+tIUz7sCSOgw=
X-Received: by 2002:a1c:f509:: with SMTP id t9mr19506057wmh.76.1547894553425;
 Sat, 19 Jan 2019 02:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20190107161047.10516-1-anup@brainfault.org> <20190107161047.10516-3-anup@brainfault.org>
 <20190115134410.GC13216@infradead.org>
In-Reply-To: <20190115134410.GC13216@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 16:12:22 +0530
Message-ID: <CAAhSdy1uOVg6R24Wx-g0Z-ejunMfbE9R7yhu8fEGfLzmqE1Bhg@mail.gmail.com>
Subject: Re: [PATCH 2/5] RISC-V: Setup init_mm before parse_early_param()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:14 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 07, 2019 at 09:40:44PM +0530, Anup Patel wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We should setup init_mm before doing parse_early_param()
> > in setup_arch() to be consistent with setup_arch() of
> > other architectures such as x86, ARM, and ARM64.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> Is there any good inherent reason why the order matters?  Not that I
> really care either way..

The parse_early_param() calls param callbacks in variety
of subsystems including MM. Doing init_mm setup before
parse_early_param() ensures that initial MM state is
available when MM param callbacks are called.

My intention was mainly to make boot-up flow similar
to x86, ARM and ARM64 so that it is easy to add
features already present in these arch ports.

Regards,
Anup
