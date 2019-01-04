Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F022AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91FE218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546608451;
	bh=PDUOT9GqHNLgBUUCCinSABv67vhBVK/eeCRUaV6y1bg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PI0DWsBPOp70Y4dAsl/pyiJU4sPMjxzpw9fyVkmu7M2ho5iRjvjg6OEQQFreR3wuJ
	 GGsMcaAKFhqqO1eJuF2Q26eFXPAeQbxsX0ZnL2P2dgUuxcc6MabBE3lpQhwB5u0zjs
	 6Ai8eUGyzJp7BCBbx0Y85wMoJQO4Dk+rtEq4K1ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfADN1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfADN1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:27:30 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8FD208E3;
        Fri,  4 Jan 2019 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546608450;
        bh=PDUOT9GqHNLgBUUCCinSABv67vhBVK/eeCRUaV6y1bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T71C8CJxrdIlcnz1JTmX1ui6Acw+Vfqt5K8EhCxHe1/EeH6P8ruqo7LKF6g35yFg4
         k47mpzHX8ZddoL12vDQ7CLVbEGYB6CTlpG6wZpnHK844aUwSigOCm0ZQS0rqHb1TAc
         2AZXH95idY1X0yi4zsnWqP02EN1yBiTYxamCLK34=
Received: by mail-lf1-f51.google.com with SMTP id c16so25411544lfj.8;
        Fri, 04 Jan 2019 05:27:29 -0800 (PST)
X-Gm-Message-State: AJcUukeKaUDvKh7cU2pKkA+oZi06E/qtv5oJ+XvQ3PmdJSS2R0EpoA11
        kKE57WIeXuJ1AttQD5jAiL0AXArq63RqIEdluM8=
X-Google-Smtp-Source: ALg8bN5HQLbkMfD/IuQ1ZhmsQdSY5/tEDnBNfnxC1PM6G42HUKAJJOSsGvY+9+kSSEbpBrTa2mvoBdPV42q/KXU0TUE=
X-Received: by 2002:ac2:554b:: with SMTP id l11mr1112300lfk.92.1546608447997;
 Fri, 04 Jan 2019 05:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20190103201408.GA27754@embeddedor>
In-Reply-To: <20190103201408.GA27754@embeddedor>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 4 Jan 2019 14:27:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcihzhU+K72p+B83kwXQECYgekSSjy3wZ9eaFi5qTnY_w@mail.gmail.com>
Message-ID: <CAJKOXPcihzhU+K72p+B83kwXQECYgekSSjy3wZ9eaFi5qTnY_w@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in osiris_dvs_notify
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019 at 21:46, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>
> Fix boolean expressions by using logical AND operator '&&'
> instead of bitwise operator '&'.
>
> This issue was detected with the help of Coccinelle.
>
> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> index 058ce73137e8..ccbd7b7965ca 100644
> --- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> +++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> @@ -65,16 +65,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
>
>         switch (val) {
>         case CPUFREQ_PRECHANGE:
> -               if (old_dvs & !new_dvs ||
> -                   cur_dvs & !new_dvs) {
> +               if (old_dvs && !new_dvs ||
> +                   cur_dvs && !new_dvs) {

Technically the old code will work fine because all variables are
bools (so 0 or 1). Therefore I am not sure whether this should be
ported to stable.

Anyway the patch is itself okay and I will take it after merge window. Thanks!

Best regards,
Krzysztof
