Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA494C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5A420864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z9nE5BD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5A420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLCUu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeLCUu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:50:29 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E472A2145D;
        Mon,  3 Dec 2018 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543870228;
        bh=KE6Wj1wPe3lbhdhVAfRr/I8RPjDnRMRjOoDqCbQb/Jo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z9nE5BD1ZEa/bKns96M/KYwasWA8docUFx2YXTfpsUUbxpNfIy5dDGzeUBXi8BOOO
         EK/NF9ir+jqofTsAIz6CF7i8yV8/gpJbUFfYvKz70pHWl2plBcEzrsztG7JNYOgryH
         ULz8m8qTAKNO+TsSJ2ZzNTDYUuJTOfwtFp6eaD1A=
Received: by mail-qt1-f169.google.com with SMTP id t13so15518348qtn.3;
        Mon, 03 Dec 2018 12:50:27 -0800 (PST)
X-Gm-Message-State: AA+aEWYOr2uHks+GrsiQ+Kx1F0IaCvN7GLc1OgyLHU0Dz3XLIa7HdtgQ
        LJulqyxJ8OsJRtU/RsEhRB2P676naipTM7G9uQ==
X-Google-Smtp-Source: AFSGD/Xo+MpSJga+Bt3tdZDhsTANu2/tr6Z0XUKK6ziBVdNh9s12YW2xmzL1TmC6QXScN51pKtNvfDWFDXsFkdvTheY=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr17584834qvk.106.1543870227100;
 Mon, 03 Dec 2018 12:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com> <20181127125050.GO1107@kunai>
In-Reply-To: <20181127125050.GO1107@kunai>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Dec 2018 14:50:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
Message-ID: <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 6:50 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The "at," prefix was never correct for Atmel, so fix the few occurrences
> > that got it wrong. Use "atmel," instead.
> >
> > While at it, remove the at,24c08 compatible string from the list of
> > trivial devices because it is already documented in eeprom/at24.txt.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Peter, I'd assume you are okay with me applying the patch directly?

Didn't we agree that I take trivial devices changes? Normally, it
doesn't really matter, but I'll have to delay landing the json-schema
conversion because this will conflict.

Rob
