Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B042175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549563674;
	bh=RNa9sasZ7hVGgEMX1Olz+kRqmPeVvzt4KRlydM+hRJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d/HSFbPJrZMsye4wnkTawk0k4xdn1mGTmG1Ukpx17EqyYXkUBYa0Cqsk1C8YC7Kjs
	 ja44GH4GLjj3EnTctUyPcygZ3o28ze53B5DG/CZKJOTyaxxVCyW/VhZaHqNDWvwJA3
	 WPxXMTuCil9OgE8ohYj8GF/IcwPnbZaum5E/0I78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfBGSVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfBGSVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:21:11 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E62CF21916;
        Thu,  7 Feb 2019 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549563671;
        bh=RNa9sasZ7hVGgEMX1Olz+kRqmPeVvzt4KRlydM+hRJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IXHXFUC6Z1dGxgcheDhikZs4AzRy9Falv2j1ToEoPnzcqcpQAkBqr1MPbKActW2yI
         zkx4qAf0xNowA6fV7V31/DrSAoO9cJxF+6Y0RQ9SzE6BgclKS/VzPML7A03slqjeqy
         5E7FsgFgGZdFT4AbBshZemJ2h68E/TpCF8RH0Olk=
Received: by mail-vs1-f49.google.com with SMTP id e16so521943vsq.6;
        Thu, 07 Feb 2019 10:21:10 -0800 (PST)
X-Gm-Message-State: AHQUAuYFlKVxteVHOLXg6fi4X4iLHKmVihxsgmsS7gjYe8HoMEnXuPfN
        vRjXy6Gw+2Eo/SEwfU8UVypNVTs1dCHpGDfl/0o=
X-Google-Smtp-Source: AHgI3IZYuwyuIhdyRBueDJfzck8FGFzKZnY1JC/5UBZznuMHYLGukZoR3ovxjb1HoCVuLa9RL/EROp8cXFovCYOwgcE=
X-Received: by 2002:a67:f085:: with SMTP id i5mr7117716vsl.198.1549563670029;
 Thu, 07 Feb 2019 10:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127031218.24419-1-dan.rue@linaro.org> <20181127031218.24419-2-dan.rue@linaro.org>
 <20181130023732.GO4922@garbanzo.do-not-panic.com> <20181205204341.7fd4ob5c6pwx375m@xps.therub.org>
In-Reply-To: <20181205204341.7fd4ob5c6pwx375m@xps.therub.org>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 7 Feb 2019 12:20:57 -0600
X-Gmail-Original-Message-ID: <CAB=NE6Wtfe_TafSTU+=0S-n9_vQXaT3FKOrcDrzHBNzj3bY47w@mail.gmail.com>
Message-ID: <CAB=NE6Wtfe_TafSTU+=0S-n9_vQXaT3FKOrcDrzHBNzj3bY47w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: firmware: remove use of non-standard diff
 -Z option
To:     Dan Rue <dan.rue@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:43 PM Dan Rue <dan.rue@linaro.org> wrote:
>
> On Thu, Nov 29, 2018 at 06:37:32PM -0800, Luis Chamberlain wrote:
> > On Mon, Nov 26, 2018 at 09:12:15PM -0600, Dan Rue wrote:
> > > diff -Z is used to trim the trailing whitespace when comparing the
> > > loaded firmware file with the source firmware file. However, per the
> > > comment in the source code, -Z should not be necessary. In testing, the
> > > input and output files are identical.
> > >
> > > Additionally, -Z is not a standard option and is not available in
> > > environments such as busybox. When -Z is not supported, diff fails with
> > > a usage error, which is suppressed, but then causes read_firmwares() to
> > > exit with a false failure message.
> >
> > NACK -- this breaks testing on debian:
> >
> > Testing with the file present...
> > Batched request_firmware() try #1: Files
> > /tmp/tmp.8GWkoSo5jZ/test-firmware.bin and
> > /sys/devices/virtual/misc/test_firmware/read_firmware differ
> > request #0: firmware was not loaded
> >
> > Please add a quirks check, enable it by default, and remove it for
> > Busybox.
>
> Thanks for the review. Shuah, can you please drop this one?

So much for review. This patch was still merged. I'll have to request
this to be reverted now too.

  Luis
