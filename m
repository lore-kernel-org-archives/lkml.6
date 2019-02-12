Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEBCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B494222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2fFmqVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfBLThc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:37:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40036 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:37:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so6439011oth.7;
        Tue, 12 Feb 2019 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qh8jXx9ibl84fm0TlhJ9Ot1OoKWuqLrxObimfZxMuQk=;
        b=e2fFmqVTst9k54mscSZoNvZFtyO2UOA4SXGrFUpA6ORORAV+C1v81iu/gjEIClGde6
         Hbfo8P+4CcZJjH3tN9gLQjZIA1+/F3FpajNmKUAGz3HkanvpI2H6UNsC7SJYcOlb/CuG
         gPIjybczMXPAHcoutR2jMt0QBM5N4YHBPwHF82+K5geDnc/fynzmhgeRyCk+QYjmiB71
         yuo7YA2Mp623gIS0IjU/nyGuEiDray7QOrI6w6b6o5N12Be+VF9xvS5J4bffw7O8Jp87
         vg+0B2/1qLNx3HkcYZ4h6nPBZyv0EKF7XiyBWLV9CazBgDvQ21mYsb1FagJfQs8WBcM/
         HtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qh8jXx9ibl84fm0TlhJ9Ot1OoKWuqLrxObimfZxMuQk=;
        b=llLa6+Jzy5bQgvkXv0VNvZGI/2/WHApPAzIXR7GaLrElNq+IOZHy5qG0/CFdVmSeWZ
         pix4IN1n/ggBimBpcg0bCugh9ylbVr6aHeegYo9mR9Z7bBgj0q3PEK4vhCVISg5wg6zr
         D1T2Xg8KV3lRBkcuKHsw/j56gNCLrbgPf5e3wKtBuL0Xscaqczq4AMjAjyqOt/wEHr0A
         po4bF+0Y5n8YyFkKzABpg0ZrwLDvOt/ON2ubgNZR9PglVYbfmffvrTNCdf+W4zfFpVq6
         Q+nbTn8zsj4YMZJxuFaR2WOHpmPj3x1jIhh4+Li2cNPDJv9xCqQc+U8FjEiQGVZdKdJO
         iSEQ==
X-Gm-Message-State: AHQUAuYbUrI441mZwMmeNFQpxqTxTIgCnQnjpelqmICwH3LtHRUONZVT
        2Qehqg8JLEYvPn/nfacSgTddij6PewTxGl+F3F3wdA==
X-Google-Smtp-Source: AHgI3IZg2Tty+buZahU39fVemS7bKOvdrXaVps2KARCkUXOgrYO7IyQYHaP2MOm0efGPapfwkQseadgme6cLNbkJ30o=
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr5692051otl.115.1550000250644;
 Tue, 12 Feb 2019 11:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20190107132226.16216-1-stefan@agner.ch> <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com> <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
 <1549923727.3075.103.camel@impinj.com>
In-Reply-To: <1549923727.3075.103.camel@impinj.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Feb 2019 17:37:18 -0200
Message-ID: <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:22 PM Trent Piepho <tpiepho@impinj.com> wrote:

> > Just trying to understand if the SDMA firmware plays a role on this
> > behavior or not.
>
> The ROM firmware only.

Does the problem also happen if the external SDMA firmware is used?
Just trying to narrow it down.
