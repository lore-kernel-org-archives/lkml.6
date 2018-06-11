Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jQskHkaLHlvLXQAAmS7hNA
	; Mon, 11 Jun 2018 14:46:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66E47607E4; Mon, 11 Jun 2018 14:46:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFORXW3w"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E05A260351;
	Mon, 11 Jun 2018 14:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E05A260351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeFKOqj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:46:39 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33411 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeFKOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:46:37 -0400
Received: by mail-yb0-f196.google.com with SMTP id x36-v6so6781766ybi.0;
        Mon, 11 Jun 2018 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zleleCkuLBW5ex/ibB7LtTF+AS0Mwfj6xxlR08oZJoA=;
        b=uFORXW3wFV1vjB5PN/y3G8nKaX4K2B+EDkoXshbQZyBET1hS6/VKQakymDF0yZMnyO
         5hBseZObcr/ov7z3rMImNSkBEoPBtrejN9oyHqwdzDAZ6ZtZmJWodpzhzqfXt+DuynpI
         S0it/TdEiP46lJmKMWDxwtiZ8ftzoJn8Olhm7Sb49GzAwlV9L/SLG3qaCL826BUvf/L2
         rcgeBHpukZrT9SSS51XHtbQbLlCFBQEE/P0GAG1EmgfnNYZaKlt+kN21ToRvf2XxnSxt
         TCFzLl3YK0FruTCoHLFpQvqXkubWW40ggLGiXU/Ig2CDqYE3Z7+4VrjmofccM/4U/M++
         ir7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zleleCkuLBW5ex/ibB7LtTF+AS0Mwfj6xxlR08oZJoA=;
        b=BZbZ+DbJRGVMCH9EiZf2x0JapVOjyzHuf2sJggzR8bwoBe1FD1KXcQkrjTvwX3bKlO
         G2/aRCObPzntufvB+oPAquDEc33/b3e3phVkn8idp3cLyv+03sukdh+AhucS2c5ZK7gc
         A985RjqaeRa4aSYh31mu6wp6jfHntPf7BNIXKbd2nf2REnBXoE+ahZ+7GkCogUHiGGIS
         tE2Ati4m0vTDln7SuOKUoag1zY1LC2yYNld72zbjAHWdS1ZJGAx+kLLaZWyDXzjJoHk/
         0p98cafc9hYK9kN6Oz9+LRkCzYObbhVcW8MiedznBzfN7o88vc8i5xlwTqfY9F3aA3iJ
         98XA==
X-Gm-Message-State: APt69E1rz8HSGdd0WJNB9cyLgbtrnftEyD+mzTG32MsXtTGSBu9raXqC
        kE39b9J6Lnwsu8GP/XW1R9fcsDAqIg67mCT+9fs=
X-Google-Smtp-Source: ADUXVKIuRFQombLeliWRhVYvHxZy8t5Xaje1Z4pcv5xEfYPMGWoWxFwsbYjnEZ8oDk20gU/MvlUENQOlKV2wtzMVvjY=
X-Received: by 2002:a25:b611:: with SMTP id r17-v6mr10338188ybj.102.1528728396457;
 Mon, 11 Jun 2018 07:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140544.22268-1-peron.clem@gmail.com> <74959a6a-60bb-f854-6ef2-21c3c60d3451@mleia.com>
In-Reply-To: <74959a6a-60bb-f854-6ef2-21c3c60d3451@mleia.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Mon, 11 Jun 2018 16:46:25 +0200
Message-ID: <CAJiuCcdfV4_zqD-DdepkE9hoHSHih66dSJciX2EwBViWM=cu=g@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Reintroduce i.MX EPIT Timer
To: vz@mleia.com
Cc: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,
On Mon, 11 Jun 2018 at 16:39, Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 06/07/2018 05:05 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> >
> > As suggested in the commit message we have added the device tree suppor=
t,
> > proper bindings and we moved the driver into the correct folder.
> >
> > Moreover we made some changes like use of relaxed IO accesor,
> > implement sched_clock, delay_timer and reduce the clockevents min_delta=
.
> >
>
> I reviewed and tested the driver on i.MX31, as expected it works fine,
> and I'll give my tags per a commit, please add them to v7 changes.

Thanks, i will

>
> --
> Best wishes,
> Vladimir
