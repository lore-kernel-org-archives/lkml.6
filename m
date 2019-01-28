Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28792147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548689703;
	bh=NZmE/2MZuC2Pg/w/22LZvSE7CCI06iRQKfA1qY1cgu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N5NpsG6DYhEHRPk5Di7KI/eKGzl69maVVT9WhjM7iwVTxhvgGId7QAqBR8Q3OCkCP
	 J/srcg6Fyeq0opG0Sl6dTacphtPq6gHam/bvERdJVOjDK+oL3Gx0Pxy/JYEuTVDosF
	 gbTv5cv056aknHk/kNPTat5hhLyp6ptpH0CeJf6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfA1PfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1PfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:35:01 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7D121741;
        Mon, 28 Jan 2019 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548689700;
        bh=NZmE/2MZuC2Pg/w/22LZvSE7CCI06iRQKfA1qY1cgu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LhayHQp6GYG7uw8Zd5CbicwmBepg9ykEKPLIvCHzl7aD2Qj4WGmPGOukJ1DVG0HRD
         YRb1vyEQz8kVB7eoTVMxP2Rhn4w5kOwkH9g/a6YNTMp0jiygRcaRbVDJCIBMUYxcJ9
         PcJW4pHFFont0kUcymbL9rK4B55h8nKSOKHGpRO4=
Received: by mail-qk1-f182.google.com with SMTP id o125so9602231qkf.3;
        Mon, 28 Jan 2019 07:34:59 -0800 (PST)
X-Gm-Message-State: AJcUukcxPXlIHpg9cMHc+XzBwL2vVKlEOwmYyuiVfSNbeP6+pvVmloW8
        Kmd703sEhjjx5h9zDAQw39kOSD/X67Ib8XEs/Q==
X-Google-Smtp-Source: ALg8bN7/6xUWddlpOWTZGyOMvMZN+9ik8FtdIbA1p+CzxDg9H/QULhFgM1PqM4cJaz5SKqu8x4tT/ivAdUkyr38+528=
X-Received: by 2002:a37:a483:: with SMTP id n125mr19292602qke.184.1548689698974;
 Mon, 28 Jan 2019 07:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org> <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
In-Reply-To: <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Jan 2019 09:34:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
Message-ID: <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 3:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dts files using the binding schema.
> >
> > Check DT binding schema documents:
> > make dt_binding_check
> >
> > Build dts files and check using DT binding schema:
> > make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > use for validation. This makes it easier to find and fix errors
> > generated by a specific schema.
> >
> > Currently, the validation targets are separate from a normal build to
> > avoid a hard dependency on the external DT schema project and because
> > there are lots of warnings generated.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> BTW, what are the CONFIG dependencies for this to work?
> E.g. defconfig on x86_64 fails, even after enabling CONFIG_OF:

I generally use allmodconfig which enables building all DTs.

Yes, there's a dependency on CONFIG_DTC which isn't always enabled
with CONFIG_OF. Maybe it should be. The only other solutions I've
thought of are either always build dtc or make the targets conditional
on CONFIG_DTC. The latter would only change the error message.

Rob
