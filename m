Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A42C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A663A2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raZQD2S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A663A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965060AbeFSFAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:00:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38920 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeFSFAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:00:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so9298286pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fK0wX7gcZStOa7aE87WekXA2BXt0rPP7nOuRIWA5Lj8=;
        b=raZQD2S5xUtPTHygMRwv72YjYxnr0bqGpFIPxDPzh6LMyNKBp8cA+ry/xI2GdtzezX
         N8JIzf6p26/OxJajVBMiMk8kWB9t440OPDwYTZfwgqTDcg358Q0FDvoOuKCUJO/TWGfK
         yf4mqECW1qUABWrpZjid4GO0qgcViMLdIa0ptOP4zKQeI2vSJa4L03hu5cbAgue+Bbvw
         CfUccvDwqxqTBOv07FzrArCc34lNr1tK5CNYGYe6xbpIWrPAt1lW7bEH1CnWdrevqNwQ
         Di+iLbOYSEyvOJqKQaIYPAsciAAB9KemzFoHltWNh1QTSmgtTWql0+lCeL/agB4XnGjq
         cs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fK0wX7gcZStOa7aE87WekXA2BXt0rPP7nOuRIWA5Lj8=;
        b=oIxQguSnLrfJ1y6Z4jPEQplokpuas6x5ub3bfe6kMaO3UjU2E/kOnTc9TNhm++bglb
         T501MZOi6Sy3SaTIHoegrb2eRHnamDLCJLldzkCjADFvjRPzQ7Ste6xwLzAyCrpEmm8g
         XyRit19RGk3HUPM6qRmISyFYnTpl4UYwk4rc7hdGg5Q6hzpDXd1YlU0MSJ0UgAiKu1sW
         MU9Gq2U2JcCTO1ekrlGSDy7JPihDwFFqxJkFBa56fbI6mXM7bqmfUKfIn+fnS+gJBT3+
         ucwWR2CSFQDH90iPX7HTH+VhIYafify0Kvs0YQjEFJggt+KwgXIT3GIQ0gIZVI1BN5d7
         GoYA==
X-Gm-Message-State: APt69E0qFt6+KHuMu7ZUb6FdNThf3uJFU6abYWhtTo40fblvS7JaPxWq
        M/2MXkn7gIO0cIjwnnLO0mFFhrC2
X-Google-Smtp-Source: ADUXVKJOniQYLnrKeS3JdhWOY5Q3YLJCMQjr8NFcComNXG+H8gKsCrxRzt2U7lnigRWpLiTZHdssWw==
X-Received: by 2002:a63:b34e:: with SMTP id x14-v6mr13470786pgt.243.1529384422338;
        Mon, 18 Jun 2018 22:00:22 -0700 (PDT)
Received: from [192.168.1.20] (c-73-158-113-96.hsd1.ca.comcast.net. [73.158.113.96])
        by smtp.gmail.com with ESMTPSA id g78-v6sm28919472pfe.39.2018.06.18.22.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 22:00:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] MAINTAINERS: Add me as an x86 entry code maintainer
From:   Tony Luck <tony.luck@gmail.com>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org>
Date:   Mon, 18 Jun 2018 22:00:19 -0700
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90B4C317-80C6-4B27-8984-58BAFCAB6E14@gmail.com>
References: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the TIP tree was named for =E2=80=9CThomas, Ingo, Peter=E2=80=9D. Need to=
 add an =E2=80=9CA=E2=80=9D for Andy. Maybe it should be the PITA tree :-)

-Tony

> On Jun 18, 2018, at 14:41, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> And update my email address.
>=20
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>=20
> Linus has been saying that I might as well maintain this stuff for years.
> What do you all think?
>=20
> MAINTAINERS | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d5eeff51b5f..624c3fd11d04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15575,6 +15575,13 @@ S:    Maintained
> F:    Documentation/x86/
> F:    arch/x86/
>=20
> +X86 ENTRY CODE
> +M:    Andy Lutomirski <luto@kernel.org>
> +L:    linux-kernel@vger.kernel.org
> +T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/a=
sm
> +S:    Maintained
> +F:    arch/x86/entry/
> +
> X86 MCE INFRASTRUCTURE
> M:    Tony Luck <tony.luck@intel.com>
> M:    Borislav Petkov <bp@alien8.de>
> @@ -15597,7 +15604,7 @@ F:    drivers/platform/x86/
> F:    drivers/platform/olpc/
>=20
> X86 VDSO
> -M:    Andy Lutomirski <luto@amacapital.net>
> +M:    Andy Lutomirski <luto@kernel.org>
> L:    linux-kernel@vger.kernel.org
> T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vd=
so
> S:    Maintained
> --=20
> 2.17.1
>=20
