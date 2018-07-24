Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA62BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9583B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2jyV40mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9583B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeGXShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388386AbeGXShF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:37:05 -0400
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com [209.85.220.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6296520880
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 17:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532453374;
        bh=1wFtmldxahFaEl+8qaNqOa9p73UPw+Qjsp1QDnrnhF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2jyV40mrsoe6Cm8wWedaE+/xCS0fVfcDRRXgmL8uicqZwpS5hN+Exf3JVPWCu/53x
         j3zbTEXsFXrL1GnZRj2D5Uoovx80cl6l+XEr9GCUpyE3oApodPu0lziEpxmhRjT5X+
         +AnLmSQjiMOpC4gPqaO13a/U7citqZBd2AeC7Zs8=
Received: by mail-qk0-f171.google.com with SMTP id t79-v6so3131851qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:29:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlGKhRDFmC1quoHWNIUS4DZrIMQlUfiGizT6zracDzvnMjMi6LcJ
        gcPmN40/osGX0ytBnpWftoSwGtKUT6C3zx49mA==
X-Google-Smtp-Source: AAOMgpdpTxz4NzQeuJO+8/RI9XPaRtJYuVizwrML56u0uN63+aluU6v9zSWnKBv9098vlqKLuUD5jo6+rIJ0x35nwvY=
X-Received: by 2002:a37:ab14:: with SMTP id u20-v6mr16070254qke.120.1532453373591;
 Tue, 24 Jul 2018 10:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <05b832407b24e0a27e419906187cd863bc1617c7.camel@perches.com>
In-Reply-To: <05b832407b24e0a27e419906187cd863bc1617c7.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Jul 2018 11:29:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAzUCttp_OypgHyb=GjvOafRr_RjQ2Jc48oYDpFx4O_g@mail.gmail.com>
Message-ID: <CAL_JsqLAzUCttp_OypgHyb=GjvOafRr_RjQ2Jc48oYDpFx4O_g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Validate SPDX license with spdxcheck.py
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:04 AM Joe Perches <joe@perches.com> wrote:
>
> Use the existing scripts/spdxcheck.py to validate any
> SPDX-License-Identifier found in line 1 or 2 of patches or files.
>
> Miscellanea:
>
> o Properly indent the existing SPDX-License-Identifier block.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/checkpatch.pl | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
