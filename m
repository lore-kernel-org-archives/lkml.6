Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E907C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A4420882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfA3X5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:57:16 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50030 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA3X5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:57:16 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c3001393276cda03; Thu, 31 Jan 2019 00:57:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [for next][PATCH v3 1/2] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date:   Thu, 31 Jan 2019 00:56:08 +0100
Message-ID: <309800316.xPVQqezZ0x@aspire.rjw.lan>
In-Reply-To: <CAHp75VerwCxYqozQmaJZL8tcbfDFLBp+nTheP0Ran4qWPqTcLw@mail.gmail.com>
References: <20190124193101.24519-1-okaya@kernel.org> <CAHp75VerwCxYqozQmaJZL8tcbfDFLBp+nTheP0Ran4qWPqTcLw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 24, 2019 10:32:56 PM CET Andy Shevchenko wrote:
> On Thu, Jan 24, 2019 at 9:31 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
> > warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
> >
> > ACPI_CMPC selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
> > depends on BACKLIGHT_LCD_SUPPORT.
> >
> > Copy BACKLIGHT_LCD_SUPPORT dependency into ACPI_CMPC to fix
> >
> > WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
> >   Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
> >   Selected by [y]:
> >   - ACPI_CMPC [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n)
> >
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> for both patches in case Rafael takes care of them.

So both applied, thanks!

