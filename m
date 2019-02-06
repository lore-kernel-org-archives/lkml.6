Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B477C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C740C217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtSHvNbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfBFOiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:38:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46414 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfBFOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:38:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so5460458lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA2GQUTp0DMjGJRBEwjYuxMHf9F68DfEjDyz2vVkcaI=;
        b=mtSHvNbb+I1Iwf7sf0BdBE3jq7ax30DRlAVtIKznI9W9IBfFcWBNlv4PI0vdZw6ttO
         fQdBB9nwLgR54hwKCsbeNvUdEtK3BR957b9rDC88dP4CUm0+rPHWrvgoUKMUaK/xhOe5
         giihhgr3TlU6fKoYypHH1QCFv6G4rU0vEhPWTGEkxkg63jIoe1/w0jxaFbULoaUVZ2Ys
         MKjNeiST5cjnQElWHRPfRfpDiWlp8u9+nscdIvSAT7e4aynW67nye7bGj/PmatNs1GSb
         coBsFIeNbcgGZXt0vkYbUsuG4vbxE6ZrV4E09mfrAqun/ErhN7yNlOk6XFrVMf31OFhh
         TuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA2GQUTp0DMjGJRBEwjYuxMHf9F68DfEjDyz2vVkcaI=;
        b=Eo0Q6IIIz+fQTn2ntcxetJHsUDRpv0mwe/2Lxpgita+jmfQhpb1JPTWMHtyPuNxr7r
         pRpnw6qKdy8SLCRLpHG5Ywo+iHEov9lfqZgbZ22iCQVsxBa+IXit0l6No5mabC9E4FRj
         dHYkLUKN1u+6SfK94FcHn5MiPR++TWiBnKim9dH37SAUMpV6w6l4MGMuj+6jye1g0apS
         9hBDaQgstw7Z4dGluJGsjdP9e+KAPwldr4CVeQGB04EoffjbigJGdTs32i595dzdKnWk
         ZgorDGPs5e2BS0gpQQKMjgsST5SWUn+d7Bu/1axV/02lC9XaP6UPWVCaHv0EQIEpPrYO
         grJA==
X-Gm-Message-State: AHQUAubr5KhBW483SnJY5QEw033bzhtrSib4vlmugM1j4BoPaT0k7PNQ
        51m1qhuLkKYUXcunXwzI8g5ZzmEs2KokNHF+Vo/cXg==
X-Google-Smtp-Source: AHgI3IZeFDKEGY/4kc/Y0rAbgRaAshxeX/eXq23LK77Qa2VJpDKSsfOmQCgP4BM63XaafZ2Kg2/XSwmazU+ShOvfttc=
X-Received: by 2002:a19:9a08:: with SMTP id c8mr6674506lfe.8.1549463878609;
 Wed, 06 Feb 2019 06:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20190125162302.14036-1-masneyb@onstation.org> <20190125162302.14036-4-masneyb@onstation.org>
 <CACRpkdZMe+JEQOa1yBfOoAErrC41Q9rggwxNb=_uwq1m2QKWyw@mail.gmail.com> <20190206141034.GA5833@basecamp>
In-Reply-To: <20190206141034.GA5833@basecamp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 15:37:47 +0100
Message-ID: <CACRpkdYSW0jNEevduPwN_4T8evihh9yEUQyQpAao6fBjEBRVhg@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: pm8xxx: convert to v2 irq interfaces to support
 hierarchical IRQ chips
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 3:10 PM Brian Masney <masneyb@onstation.org> wrote:

> Thank you for testing all of this on actual hardware. You can either
> send out the little issues like this that need corrected and I'll
> collect everything up, and send out a V2 once you are done with testing.
> Or, you can just take my patches, incorporate the fixes, and add me
> with a Co-developed-by tag to the relevant patches. Whatever is easier
> for you. I assume that the latter approach may be easier since you're
> already making the changes in your tree for testing.

Well there are some remarks from Marc you need to address in v2
as well so you better keep the master patch set for now.

I can copy/paste the diff I have though, but there is some bug
I still need to dig into...

Yours,
Linus Walleij
